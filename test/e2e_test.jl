# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# E2E pipeline tests for JuliaKids.jl (JuliaForChildren package).
# Tests the full learning session lifecycle: mission setup → exercise validation →
# automation rules → robot movement → accessibility.

using Test
using JuliaForChildren

@testset "E2E Pipeline Tests" begin

    @testset "Full pipeline: mission creation → check → feedback" begin
        # Step 1: define an exercise with a passing validator.
        validator = (state) -> (true, "Circles drawn correctly!")
        ex = Exercise("e2e_ex1", "Draw 3 circles", "3 circles required",
                      "draw_circle(50)", validator)
        @test ex.id == "e2e_ex1"

        # Step 2: assemble into a mission.
        mission = Mission("e2e_m1", "Circle Drawing", "Loops", [ex])
        @test mission.id == "e2e_m1"
        @test length(mission.exercises) == 1

        # Step 3: check the mission — should pass.
        result = check_mission(mission, 1)
        @test occursin("GREAT JOB", result)
        @test occursin("Circles drawn correctly!", result)
    end

    @testset "Full pipeline: mission failure feedback" begin
        validator = (state) -> (false, "Try again — only 1 circle drawn.")
        ex = Exercise("e2e_ex2", "Draw 5 circles", "5 circles required", "", validator)
        mission = Mission("e2e_m2", "Advanced Circles", "Loops", [ex])
        result = check_mission(mission, 1)
        @test occursin("Keep trying", result)
        @test occursin("Try again", result)
    end

    @testset "Full pipeline: automation rule → event fire → action" begin
        empty!(JuliaForChildren.Automation.ACTIVE_RULES)
        result_holder = Ref("")

        # Register a rule.
        when(:level_complete, (args...) -> (result_holder[] = "level done!"))
        @test length(JuliaForChildren.Automation.ACTIVE_RULES) == 1

        # Fire the event.
        JuliaForChildren.Automation.trigger_event(:level_complete)
        @test result_holder[] == "level done!"
    end

    @testset "Full pipeline: robot state manipulations" begin
        # Control robot through a sequence of state changes.
        pen_down()
        @test JuliaForChildren.JulietRobot.JULIET.drawing == true

        set_robot_color(:blue)
        @test JuliaForChildren.JulietRobot.JULIET.color == :blue

        pen_up()
        @test JuliaForChildren.JulietRobot.JULIET.drawing == false
    end

    @testset "Full pipeline: classroom state reset" begin
        # Dirty the state, then reset and verify clean.
        state = JuliaForChildren.Missions.GLOBAL_STATE
        state.circles_drawn = 99
        state.squares_drawn = 42
        state.robot_x = 500.0

        JuliaForChildren.Missions.reset_state!()
        @test state.circles_drawn == 0
        @test state.squares_drawn == 0
        @test state.robot_x == 0.0
        @test state.last_feedback == "Started!"
    end

    @testset "Error handling: ask_buddy always returns non-empty string" begin
        result = ask_buddy("What is a loop?")
        @test result isa String
        @test !isempty(result)
    end

    @testset "Error handling: FactCheck never crashes" begin
        @test is_true("A whale is a fish") == false
        @test is_true("The sky is blue") == true
        @test is_true("") isa Bool
    end

    @testset "Round-trip consistency: BibTools add then export" begin
        empty!(JuliaForChildren.BibTools.MY_LIBRARY)
        add_reference("Test Book", "Test Author", 2026, "https://example.com")
        @test length(JuliaForChildren.BibTools.MY_LIBRARY) == 1
        @test JuliaForChildren.BibTools.MY_LIBRARY[1].title == "Test Book"
        # Export should not throw.
        @test export_to_zotero("test_library") === nothing
    end

    @testset "Round-trip consistency: accessibility functions are stable" begin
        @test speak("Hello, student!") === nothing
        @test high_contrast_mode(true) === nothing
        @test high_contrast_mode(false) === nothing
        desc = describe_image("a robot drawing")
        @test desc isa String
        @test !isempty(desc)
    end

end
