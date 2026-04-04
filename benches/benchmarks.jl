# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# BenchmarkTools benchmarks for JuliaKids.jl (JuliaForChildren package).

using BenchmarkTools
using JuliaForChildren

println("=== JuliaKids.jl Benchmarks ===")

# --- Mission construction ---

println("\n-- Mission construction --")

validator = (state) -> (true, "Done!")
ex = Exercise("bench_ex", "Draw", "Goal", "", validator)

b_mission_small = @benchmark Mission("m", "Title", "Loops", [$ex])
println("Mission(1 exercise): ", median(b_mission_small))

exercises_10 = [Exercise("ex_$(i)", "P", "G", "", validator) for i in 1:10]
b_mission_medium = @benchmark Mission("m", "Title", "Loops", $exercises_10)
println("Mission(10 exercises): ", median(b_mission_medium))

# --- check_mission ---

println("\n-- check_mission --")

mission_pass = Mission("pass", "Pass", "C", [Exercise("e", "P", "G", "", (s) -> (true, "Good!"))])
mission_fail = Mission("fail", "Fail", "C", [Exercise("e", "P", "G", "", (s) -> (false, "Try again"))])

b_check_pass = @benchmark check_mission($mission_pass, 1)
b_check_fail = @benchmark check_mission($mission_fail, 1)
println("check_mission (pass): ", median(b_check_pass))
println("check_mission (fail): ", median(b_check_fail))

# --- Automation ---

println("\n-- Automation rule registration and dispatch --")

b_when = @benchmark when(:bench_event, (args...) -> nothing)
println("when (register rule): ", median(b_when))

empty!(JuliaForChildren.Automation.ACTIVE_RULES)
when(:bench_fire, (args...) -> nothing)
b_trigger = @benchmark JuliaForChildren.Automation.trigger_event(:bench_fire)
println("trigger_event (1 matching rule): ", median(b_trigger))

# --- FactCheck ---

println("\n-- FactCheck --")

b_factcheck_true  = @benchmark is_true("The sky is blue")
b_factcheck_false = @benchmark is_true("A whale is a fish")
println("is_true (returns true):  ", median(b_factcheck_true))
println("is_true (returns false): ", median(b_factcheck_false))

# --- State reset ---

println("\n-- GLOBAL_STATE reset --")

b_reset = @benchmark JuliaForChildren.Missions.reset_state!()
println("reset_state!: ", median(b_reset))
