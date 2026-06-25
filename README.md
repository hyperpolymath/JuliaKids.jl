<!--
SPDX-License-Identifier: CC-BY-SA-4.0
SPDX-FileCopyrightText: 2025-2026 Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->

[![Topology](https://img.shields.io/badge/Project-Topology-9558B2)](TOPOLOGY.md)
[![70](https://img.shields.io/badge/Completion-70%25-yellow)](TOPOLOGY.md) [![OpenSSF Best Practices](https://img.shields.io/badge/OpenSSF-Best_Practices-green?logo=opensourcesecurity)](https://www.bestpractices.dev/en/projects/new?repo_url=https://github.com/hyperpolymath/JuliaKids.jl)
[![License: PMPL-1.0](https://img.shields.io/badge/License-MPL--2.0-blue.svg)](https://github.com/hyperpolymath/palimpsest-license) <embed
src="https://api.thegreenwebfoundation.org/greencheckimage/github.com"
data-link="https://www.thegreenwebfoundation.org/green-web-check/?url=github.com" />
image:<a href="https://img.shields.io/badge/Julia-1.10+-9558B2?logo=julia"
data-link="https://julialang.org/">Julia</a>

**Joyful, Playful, and Visual Coding for Kids**

*Building strong computational thinking foundations through real Julia.*

<div id="toc">

</div>

# Overview

JuliaForChildren.jl is designed to make the first steps into programming
a joyful and confidence-building experience. By focusing on visual
feedback, simple games, and "playable" coding activities, it teaches
real Julia fundamentals (variables, loops, functions) without the
overwhelming syntax load typically found in adult-focused libraries.

# Core Capabilities

- **Guided Lessons**: Small checkpoints with instant, friendly feedback.

- **Coding Sandbox**: A safe environment for drawing, simulations, and
  basic game dev.

- **Concept Ladder**: A structured curriculum moving from basic
  variables to data science basics.

- **Achievement Tracking**: Earn skill badges and track streaks to
  maintain momentum.

- **Instructor Mode**: Specialized dashboards for parents and teachers
  to monitor classroom progress.

# Quick Start

```julia
using JuliaForChildren

# Load a fun lesson on loops
lesson = load_lesson("shapes-and-loops")

# Kids write simple code to draw
# Exercise: "Draw 5 blue circles!"
run_exercise(lesson, code="""
for i in 1:5
    draw_circle(color=:blue, x=i*10)
end
""")

# Check progress and badges
report = build_progress_report(learner)
```

# Suggested Tech Stack

- **Notebooks**: `Pluto.jl` for reactive, interactive learning.

- **Visuals**: `CairoMakie.jl` or `Luxor.jl` for drawing and art.

- **Data**: `DataFrames.jl` for simple record-keeping.

# Pedagogy & Safety

- **Feedback First**: Strong positive reinforcement before any
  corrective guidance.

- **Air-Gapped by Design**: No external network dependencies required
  for core lessons.

- **Real Skills**: No "toy" languages—kids learn actual Julia syntax
  used in research.

# License

Palimpsest-MPL-1.0 License - see [LICENSE](LICENSE) for details.
