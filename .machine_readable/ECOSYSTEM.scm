;; SPDX-License-Identifier: MPL-2.0
;; (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
;; ECOSYSTEM.scm for JuliaKids.jl
;; Media Type: application/vnd.ecosystem+scm

(ecosystem
  (version "1.0")
  (name "JuliaKids.jl")
  (type "julia-package")
  (purpose "Joyful visual programming for children teaching real Julia")
  (position-in-ecosystem
    (domain "education")
    (role "Child-friendly Julia programming environment with visual blocks")
    (maturity "alpha"))
  (related-projects
    ((name . "hyperpolymath ecosystem")
     (relationship . part-of)
     (nature . "Julia packages for interdisciplinary computing"))))
