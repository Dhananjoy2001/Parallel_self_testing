# Robust and Parallel Semi-Device-Independent Self-Testing of Distinct Quantum Systems

**Authors:** Dhananjoy Ghosh, Kishor Bharti, Jaskaran Singh  
**Affiliation:** Centre for Quantum Science and Technology (CQST), IIT Mandi  
**arXiv:** [arxiv link]  

---

## Overview

This repository contains the MATLAB code accompanying the paper:

> **"Robust and Parallel Semi-Device-Independent Self-Testing of Distinct Quantum Systems"**

The paper introduces a framework for **parallel self-testing** of quantum systems using **non-contextuality (NC) inequalities** in the Consistent Exclusivity (CSW) framework. The central idea is to test multiple quantum systems simultaneously by composing their exclusivity graphs via the **OR graph product**, and to certify the underlying quantum state and measurements from the statistics alone — in a semi-device-independent manner.

### Main Results

**Theorem 1 (Parallel Self-Testing).**  
If an NC inequality $\beta \leq \alpha(G)$ self-tests individual systems $\mathcal{S}_1, \mathcal{S}_2, \ldots, \mathcal{S}_m$, then the $m$-fold OR product graph $G^{\vee m}$ yields an NC inequality that simultaneously self-tests all $m$ systems in parallel.

**Theorem 2 (Robustness).**  
The parallel self-test is robust: if the observed NC value is $\varepsilon$-close to the quantum maximum $\vartheta(G^{\vee m})$, then the realisation is $O(\sqrt{\varepsilon})$-close (in trace distance / operator norm) to the ideal tensor-product realisation.

---

## Key Concepts

| Concept | Description |
|---|---|
| **Exclusivity graph** $G$ | Vertices = projective measurements; edges connect mutually exclusive events |
| **OR product** $G_1 \vee G_2$ | $(u_1, u_2) \sim (v_1, v_2)$ iff $u_1 \sim v_1$ in $G_1$ **or** $u_2 \sim v_2$ in $G_2$ |
| **Independence number** $\alpha(G)$ | Classical NC bound (maximum independent set) |
| **Lovász theta** $\vartheta(G)$ | Quantum NC bound; computed via the Lovász theta SDP |
| **Self-testing criterion** | The linear system $MZ^* = 0$ (with exclusivity constraints on $M$) admits only the trivial solution $M = 0$, verified by SVD |
| **Robustness** | $O(\sqrt{\varepsilon})$ bound on distance from the ideal realisation |

---

## Repository Structure

```
.
├── README.md                        ← You are here (main overview)
│
├── Parallel_KCBS_KCBS/              ← KCBS ∨ KCBS scenario (positive example)
│   ├── README.md
│   ├── Parallel_KCBS_exclusive_pairs_OR.m
│   ├── Parallel_KCBS_Primal_OR.m
│   ├── Parallel_KCBS_dual_OR.m
│   └── Parallel_KCBS_self_testing_OR.m
│
├── Parallel_KCBS_CHSH/              ← KCBS ∨ CHSH scenario (positive example)
│   ├── README.md
│   ├── Parallel_KCBS_CHSH_exclusive_pairs_OR.m
│   ├── Parallel_KCBS_CHSH_primal_OR.m
│   ├── Parallel_KCBS_CHSH_dual_OR.m
│   └── Parallel_KCBS_CHSH_self_testing_OR.m
│
├── Parallel_CHSH_CHSH/              ← CHSH ∨ CHSH scenario (positive example)
│   ├── README.md
│   ├── Parallel_CHSH_exclusive_pairs_OR.m
│   ├── Parallel_CHSH_primal_OR.m
│   ├── Parallel_CHSH_dual_OR.m
│   └── Parallel_CHSH_self_testing_OR.m
│
└── Parallel_KCBS_G6/                ← KCBS ∨ G6 scenario (negative example)
    ├── README.md
    ├── Parallel_KCBS_G6_exclusive_pairs.m
    ├── Parallel_KCBS_G6_primal_OR.m
    ├── Parallel_KCBS_G6_dual_OR.m
    └── Parallel_KCBS_G6_self_testing.m
```

---

## Scenarios at a Glance

| Scenario | Graph | Vertices | $\alpha$ | $\vartheta$ | Quantum Realisation | Self-Tests? |
|---|---|---|---|---|---|---|
| **KCBS ∨ KCBS** | $C_5 \vee C_5$ | $25$ | $4$ | $5$ | Two qutrits | ✅ Yes |
| **KCBS ∨ CHSH** | $C_5 \vee \mathrm{Ci}_8(1,4)$ | $40$ | $6$ | $\sqrt{5}(2+\sqrt{2})$ | Qutrit + ququart | ✅ Yes |
| **CHSH ∨ CHSH** | $\mathrm{Ci}_8(1,4) \vee \mathrm{Ci}_8(1,4)$ | $64$ | $9$ | $(2+\sqrt{2})^2$ | Two ququarts | ✅ Yes |
| **KCBS ∨ G6** | $C_5 \vee G_6$ | $30$ | $4$ | $5$ | — | ❌ No (negative example) |

The KCBS ∨ G6 case demonstrates that the OR product of a self-testing graph ($C_5$) with a non-self-testing graph ($G_6$) does **not** yield a self-test — the SVD check shows that $MZ^* = 0$ admits non-trivial solutions.

---

## How to Navigate

Each sub-folder contains a dedicated `README.md` with full details of that scenario:

- 📁 [`Parallel_KCBS_KCBS/README.md`](./Parallel_KCBS_KCBS/README.md) — KCBS parallel self-test; analytic dual certificate; two-qutrit realisation
- 📁 [`Parallel_KCBS_CHSH/README.md`](./Parallel_KCBS_CHSH/README.md) — KCBS ∨ CHSH self-test; numerical dual certificate; qutrit + ququart realisation
- 📁 [`Parallel_CHSH_CHSH/README.md`](./Parallel_CHSH_CHSH/README.md) — CHSH parallel self-test; numerical dual certificate; two-ququart realisation
- 📁 [`Parallel_KCBS_G6/README.md`](./Parallel_KCBS_G6/README.md) — Negative example

---

## Common Workflow

Each scenario follows the same four-step pipeline:

```
Step 1  exclusive_pairs.m   →  Generate OR-product exclusivity graph
Step 2  primal_OR.m         →  Solve Lovász theta SDP (quantum bound ϑ)
Step 3  dual_OR.m           →  Solve dual SDP → obtain certificate Z*
Step 4  self_testing.m      →  SVD check of MZ* = 0
```

> **Note:** Before running `self_testing.m`, uncomment the `writematrix(...)` line in `dual_OR.m` and run it once to save `Z*` as a CSV file. The self-testing script loads this file via `readmatrix(...)`.

---

## Dependencies

| Software | Purpose |
|---|---|
| MATLAB (R2020a or later) | Core computational environment |
| [YALMIP](https://yalmip.github.io/) | SDP modelling |
| [MOSEK](https://www.mosek.com/) | SDP solver (free academic licence) |
| Symbolic Math Toolbox | Required for `Parallel_KCBS_self_testing_OR.m` (analytic Z* construction) |

---

## Contact

**Dhananjoy Ghosh**  
Centre for Quantum Science and Technology (CQST), IIT Mandi  
✉ [d25062@students.iitmandi.ac.in](mailto:d25062@students.iitmandi.ac.in)
