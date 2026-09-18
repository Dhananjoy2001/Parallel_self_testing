# Parallel KCBS and Non-Self-Testing NC Inequality: A Negative Example

This repository contains the MATLAB code accompanying the paper:

> **Robust and Parallel Semi-Device-Independent Self-Testing of Distinct Quantum Systems**  
> Dhananjoy Ghosh, Kishor Bharti, and Jaskaran Singh  
> Center for Quantum Science and Technology (CQST), IIT Mandi, India  
> Preprint: [arXiv link to be added]

This code implements the SDP-based verification for an **intersting example**: a KCBS inequality composed in parallel with a six-vertex NC inequality $\beta_3$ whose exclusivity graph $\mathcal{G}_6$ exhibits a quantum violation but does **not** self-test. The composite exclusivity graph is $\mathcal{G} = C_5 \vee \mathcal{G}_6$.

The purpose of this example is to numerically confirm the necessity of the individual self-testing condition in Theorem 1: since $\mathcal{G}_6$ does not self-test, the composite inequality also fails to self-test, even though $\vartheta(\mathcal{G}) > \alpha(\mathcal{G})$.

---

## Physical and Mathematical Setup

### The Individual Inequalities

**KCBS inequality** [Klyachko et al., PRL 2008]: defined over five projective measurements $\lbrace \Pi_{i_1} \rbrace_{i_1=1}^5$ whose exclusivity graph is the five-cycle $C_5$:

$$\beta_1 = \sum_{i_1=1}^5 p(1|i_1) \leq 2 = \beta_\mathrm{NCHV}^{(1)},$$

with $\beta_\mathrm{QT}^{(1)} = \vartheta(C_5) = \sqrt{5}$. The KCBS inequality **self-tests** its ideal qutrit realization $\mathcal{S}_1$.

**Non-self-testing NC inequality $\beta_3$**: defined over six projective measurements $\lbrace \Pi_{i_3} \rbrace_{i_3=1}^6$ whose exclusivity graph is $\mathcal{G}_6$:

$$\beta_3 = \sum_{i_3=1}^6 p(1|i_3) \leq 2 = \beta_\mathrm{NCHV}^{(3)},$$

with $\beta_\mathrm{QT}^{(3)} = \vartheta(\mathcal{G}_6) = \sqrt{5}$. The graph $\mathcal{G}_6$ has independence number $\alpha(\mathcal{G}_6) = 2$ and Lovász theta number $\vartheta(\mathcal{G}_6) = \sqrt{5}$, so $\beta_3$ exhibits a quantum violation. However, the linear system $MZ^* = 0$ for $\mathcal{G}_6$ admits nontrivial solutions $M \neq 0$, so $\beta_3$ does **not** self-test its optimal quantum realization [Bharti et al., arXiv:1911.09448].

### The Exclusivity Graph $\mathcal{G}_6$

The six vertices of $\mathcal{G}_6$ are connected by the following 8 edges (used in `Parallel_KCBS_G6_exclusive_pairs.m`):

$$\lbrace 1\text{-}3,\; 1\text{-}4,\; 1\text{-}6,\; 2\text{-}4,\; 2\text{-}5,\; 2\text{-}6,\; 3\text{-}5,\; 4\text{-}6 \rbrace.$$

### Parallel Composition via the OR Graph Product

The parallel test of the two inequalities is encoded by the **OR graph product** $\mathcal{G} = C_5 \vee \mathcal{G}_6$. Two composite vertices $(v_{i_1}, v_{i_3})$ and $(v_{j_1}, v_{j_3})$ are adjacent in $\mathcal{G}$ if and only if

$$v_{i_1} \sim v_{j_1} \quad \text{in } C_5 \quad \mathbf{or} \quad v_{i_3} \sim v_{j_3} \quad \text{in } \mathcal{G}_6.$$

The graph $\mathcal{G} = C_5 \vee \mathcal{G}_6$ has:

| Property | Value |
|---|---|
| Vertices $N$ | $5 \times 6 = 30$ |
| Edges | $300$ |
| Independence number $\alpha(\mathcal{G})$ | 4 |
| Lovász theta number $\vartheta(\mathcal{G})$ | 5 |

Although $\vartheta(\mathcal{G}) = 5 > 4 = \alpha(\mathcal{G})$, the condition of Theorem 1 is **not fully satisfied** because $\mathcal{G}_6$ does not self-test. The code confirms numerically that the composite inequality also fails to self-test: the linear system $MZ^* = 0$ admits nontrivial solutions $M \neq 0$.

### Vertex Labelling

Composite vertices are labelled by the map

$$(a,b) \;\mapsto\; v = 6(a-1)+b, \qquad a \in \lbrace 1,\ldots,5\rbrace,\; b \in \lbrace 1,\ldots,6\rbrace,$$

so vertex $v$ corresponds to KCBS vertex $a$ and $\mathcal{G}_6$ vertex $b$.

### Self-Testing Criterion 
The maximum quantum value $\vartheta(\mathcal{G})$ is computed via the **primal Lovász theta SDP**:

$$\vartheta(\mathcal{G}) = \max \sum_{i=1}^{30} X_{ii}$$

subject to

$$X_{00} = 1,\quad X \succeq 0,\quad X_{i0} = X_{ii}\; (1 \leq i \leq 30),\quad X_{ij} = 0\;\;\forall\, v_i \sim v_j.$$

The NC inequality self-tests if and only if the linear system

$$M_{00} = 0,\quad M_{i0} = M_{ii},\quad M_{ij} = 0\;\;\forall\, v_i \sim v_j,\quad MZ^* = 0$$

admits only $M = 0$. A near-zero singular value of the coefficient matrix $\mathbf{A}$ signals a nontrivial solution, i.e., no self-test.

### Dual SDP Structure

A key structural difference from the KCBS-KCBS and KCBS-CHSH cases is that the dual matrix $Z$ here has **no cyclic-neighbour $\mu$ term** (no $Z_4$ block). This is because $\mathcal{G}_6$ has no regular cyclic structure like $C_5$ or $\mathrm{Ci}_8(1,4)$. The dual matrix is instead parameterised as

$$Z = t\,\mathbf{e}_0\mathbf{e}_0^\top + \sum_{i=1}^{30}(\lambda_i-1)\,\mathbf{e}_i\mathbf{e}_i^\top - \sum_{i=1}^{30}\lambda_i\,\frac{\mathbf{e}_0\mathbf{e}_i^\top + \mathbf{e}_i\mathbf{e}_0^\top}{2} + \sum_{\langle i,j\rangle}\mu_{ij}\,\frac{\mathbf{e}_i\mathbf{e}_j^\top + \mathbf{e}_j\mathbf{e}_i^\top}{2},$$

where the last sum runs directly over all exclusive pairs of $\mathcal{G}$, with no separate cyclic-neighbour block.

---

## File Descriptions

### `Parallel_KCBS_G6_exclusive_pairs.m`

Generates the complete list of **exclusivity pairs** for $C_5 \vee \mathcal{G}_6$.

- Encodes the KCBS adjacency (5 edges of $C_5$) and the $\mathcal{G}_6$ adjacency (8 edges) separately.
- Applies the OR-product rule: vertex pair $((a,b),(c,d))$ is exclusive iff $(a,c)$ is an edge in $C_5$ **or** $(b,d)$ is an edge in $\mathcal{G}_6$.
- Removes duplicate undirected pairs and prints the full edge list and per-vertex adjacency list `EX{1}` through `EX{30}` to the console.

**Run this first** to verify or regenerate the exclusivity structure.

---

### `Parallel_KCBS_G6_primal_OR.m`

Solves the **primal Lovász theta SDP** for $C_5 \vee \mathcal{G}_6$.

- Decision variable: symmetric matrix $X \in \mathbb{S}^{31}_+$ (MATLAB indices $1,\ldots,31$, where index 1 corresponds to the base vertex 0).
- Constraints: $X_{11} = 1$; $X_{i+1,i+1} = X_{1,i+1}$ for $i = 1,\ldots,30$; $X_{i+1,j+1} = 0$ for each exclusive pair $(i,j)$.
- Objective: maximize $\sum_{i=2}^{31} X_{ii}$.
- Solver: YALMIP + MOSEK.

**Expected output:** Optimal value $= 5 = \vartheta(C_5 \vee \mathcal{G}_6)$ and the optimal Gram matrix $X^*$.

---

### `Parallel_KCBS_G6_dual_OR.m`

Solves the **dual SDP** for $C_5 \vee \mathcal{G}_6$ to obtain the dual optimal matrix $Z^*$ numerically.

> **Note:** Unlike the other dual scripts in this repository, there is **no** cyclic-neighbour $\mu$ block ($Z_4$ term) in the dual matrix construction. All off-diagonal dual variables $\mu_{ij}$ are associated directly with the exclusive pairs via the `muEX` cell array.

- Solver: YALMIP + MOSEK.
- **Important:** Before running, uncomment the final line of the script:

  ```matlab
  writematrix(Z_opt,'parallel_Dual_matrix_KCBS_C6_OR.csv')
  ```

  to save $Z^*$ to disk. This CSV file is required by `Parallel_KCBS_G6_self_testing.m`.

**Expected output:** Optimal dual value $t^* = 5$ and the $31 \times 31$ dual optimal matrix $Z^*$.

---

### `Parallel_KCBS_G6_self_testing.m`

Performs the **self-testing verification** (expected to confirm failure of self-testing) by checking whether the linear system $MZ^* = 0$ has a unique solution.

**Step 1 — Build $M$ symbolically.**  
Construct a $31 \times 31$ symbolic symmetric matrix subject to:
- $M_{00} = 0$ (index 1 in MATLAB)
- $M_{i0} = M_{ii}$ and $M_{0i} = M_{ii}$ for $i = 1,\ldots,30$
- $M_{ij} = 0$ for all exclusive pairs $(i,j)$
- All remaining upper-triangular entries are independent symbolic variables

**Step 2 — Load $Z^*$ numerically.**  
Read the dual optimal matrix from the CSV file:

```matlab
Z = readmatrix('parallel_Dual_matrix_KCBS_C6_OR.csv');
```

> **Note:** `parallel_Dual_matrix_KCBS_C6_OR.csv` must be present in the MATLAB working directory before running this script. Note also that the script calls `Z = value(Z)` after `readmatrix` — this is a no-op on a plain numeric matrix but is harmless.

**Step 3 — Form and convert the linear system.**  
Set up $M \cdot Z^* = 0$ and convert to $\mathbf{A}\mathbf{x} = \mathbf{0}$ via `equationsToMatrix`.

**Step 4 — SVD of the coefficient matrix.**  
Compute `S = svd(double(A))`. The interpretation is:
- One or more near-zero singular values $\Rightarrow$ $\mathbf{A}$ is rank-deficient $\Rightarrow$ nontrivial solutions $M \neq 0$ exist $\Rightarrow$ the composite NC inequality **does not self-test** (confirmed).
- All singular values well-separated from zero $\Rightarrow$ $M = 0$ unique $\Rightarrow$ self-test (not expected here).

**Expected output:** One or more singular values near zero, confirming that the composite inequality $C_5 \vee \mathcal{G}_6$ does **not** self-test its optimal quantum realization. This is consistent with Theorem 1: because $\mathcal{G}_6$ individually does not self-test, the composite cannot self-test either.

---

## Dependencies

| Dependency | Purpose |
|---|---|
| [MATLAB](https://www.mathworks.com/products/matlab.html) | Core computational environment |
| [YALMIP](https://yalmip.github.io/) | SDP modelling layer |
| [MOSEK](https://www.mosek.com/) | Interior-point SDP solver (free academic license available) |
| Symbolic Math Toolbox | Required by `Parallel_KCBS_G6_self_testing.m` |

---

## Usage

```matlab
% Step 1: Generate and verify the exclusivity structure of C_5 v G_6
Parallel_KCBS_G6_exclusive_pairs

% Step 2: Solve the primal SDP — compute vartheta(C_5 v G_6)
Parallel_KCBS_G6_primal_OR

% Step 3: Solve the dual SDP — obtain Z* numerically and save to CSV
% (Uncomment the writematrix line in the script before running)
Parallel_KCBS_G6_dual_OR

% Step 4: Check self-testing via SVD of M Z* = 0
% (Requires parallel_Dual_matrix_KCBS_C6_OR.csv in the working directory)
Parallel_KCBS_G6_self_testing
```

> **Important:** Steps 3 and 4 are coupled. The dual script must be run with the `writematrix` line uncommented before the self-testing script can load $Z^*$.

---

## Summary of Results

| Quantity | Value |
|---|---|
| Composite graph | $C_5 \vee \mathcal{G}_6$ |
| Vertices $N$ | 30 |
| $\alpha(\mathcal{G})$ | 4 |
| $\vartheta(\mathcal{G})$ | 5 |
| Primal SDP optimum | 5 |
| Dual SDP optimum | 5 |
| $Z^*$ | Numerical; stored in `parallel_Dual_matrix_KCBS_C6_OR.csv` |
| Null space of $\mathbf{A}$ | Non-trivial ($M \neq 0$ solutions exist) |
| Self-testing verdict | ❌ Does **not** self-test |
| Reason | $\mathcal{G}_6$ individually does not self-test |

---

## Role in the Paper

This example illustrates that the condition $\vartheta(\mathcal{G}) > \alpha(\mathcal{G})$ alone is **not sufficient** for self-testing. The composite graph $C_5 \vee \mathcal{G}_6$ satisfies this condition ($5 > 4$), yet the composite inequality fails to self-test because one of its constituents ($\mathcal{G}_6$) does not self-test individually. This directly demonstrates the necessity of the individual self-testing hypothesis in Theorem 1.

Together with the positive examples (KCBS $\vee$ KCBS, KCBS $\vee$ Bell-CHSH, Bell-CHSH $\vee$ Bell-CHSH), this negative example completes the numerical verification of the framework developed in the paper.

---

## Comparison Across All Scenarios

| Scenario | Graph | $N$ | $\alpha$ | $\vartheta$ | Self-test? |
|---|---|---|---|---|---|
| KCBS $\vee$ KCBS | $C_5 \vee C_5$ | 25 | 4 | 5 | ✅ |
| KCBS $\vee$ Bell-CHSH | $C_5 \vee \mathrm{Ci}_8(1,4)$ | 40 | 6 | $\approx 7.63$ | ✅ |
| Bell-CHSH $\vee$ Bell-CHSH | $\mathrm{Ci}_8(1,4) \vee \mathrm{Ci}_8(1,4)$ | 64 | 9 | $\approx 11.66$ | ✅ |
| KCBS $\vee$ $\mathcal{G}_6$ | $C_5 \vee \mathcal{G}_6$ | 30 | 4 | 5 | ❌ |


## Contact

- **Dhananjoy Ghosh** — d25062@students.iitmandi.ac.in  
- **Jaskaran Singh** — jaskaran@iitmandi.ac.in  
- Center for Quantum Science and Technology (CQST), IIT Mandi, Himachal Pradesh 175075, India
