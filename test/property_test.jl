# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# Property-based invariant tests for JuliaKids.jl (JuliaForChildren package).

using Test
using JuliaForChildren

@testset "Property-Based Tests" begin

    @testset "check_mission: validator result always matches feedback message" begin
        for i in 1:50
            should_pass = rand(Bool)
            msg = "feedback_$(i)"
            validator = (state) -> (should_pass, msg)
            ex = Exercise("prop_ex_$(i)", "Prompt", "Goal", "", validator)
            mission = Mission("prop_m_$(i)", "Mission $(i)", "Concept", [ex])
            result = check_mission(mission, 1)
            if should_pass
                @test occursin("GREAT JOB", result)
            else
                @test occursin("Keep trying", result)
            end
            @test occursin(msg, result)
        end
    end

    @testset "is_true: always returns Bool" begin
        inputs = ["The sky is blue", "A whale is a fish", "", "Julia is fast",
                  "A cat is a dog", "2 + 2 = 5"]
        for _ in 1:50
            inp = rand(inputs)
            result = is_true(inp)
            @test result isa Bool
        end
    end

    @testset "describe_image: always returns non-empty String" begin
        images = ["a circle", "robot drawing", "stars", "school", "game screen"]
        for _ in 1:50
            img = rand(images)
            desc = describe_image(img)
            @test desc isa String
            @test !isempty(desc)
        end
    end

    @testset "ask_buddy: always returns non-empty String" begin
        questions = ["What is a loop?", "How do I draw?",
                     "What is a variable?", "How do functions work?"]
        for _ in 1:50
            q = rand(questions)
            answer = ask_buddy(q)
            @test answer isa String
            @test !isempty(answer)
        end
    end

    @testset "Automation: active rules count grows with each `when` call" begin
        for trial in 1:10
            empty!(JuliaForChildren.Automation.ACTIVE_RULES)
            n = rand(1:8)
            for i in 1:n
                when(Symbol("event_$(i)"), (args...) -> nothing)
            end
            @test length(JuliaForChildren.Automation.ACTIVE_RULES) == n
        end
    end

    @testset "BibTools: library grows monotonically with add_reference" begin
        for trial in 1:10
            empty!(JuliaForChildren.BibTools.MY_LIBRARY)
            n = rand(1:10)
            for i in 1:n
                add_reference("Book $(i)", "Author", 2024 + i)
            end
            @test length(JuliaForChildren.BibTools.MY_LIBRARY) == n
        end
    end

    @testset "pen_up and pen_down toggle drawing state correctly" begin
        for _ in 1:50
            pen_down()
            @test JuliaForChildren.JulietRobot.JULIET.drawing == true
            pen_up()
            @test JuliaForChildren.JulietRobot.JULIET.drawing == false
        end
    end

    @testset "GLOBAL_STATE reset is idempotent" begin
        for _ in 1:20
            state = JuliaForChildren.Missions.GLOBAL_STATE
            state.circles_drawn = rand(1:100)
            state.robot_x = rand() * 500
            JuliaForChildren.Missions.reset_state!()
            @test state.circles_drawn == 0
            @test state.robot_x == 0.0
            @test state.last_feedback == "Started!"
        end
    end

end
