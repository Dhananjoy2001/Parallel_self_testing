# Parallel Self-Testing of Two Bell-CHSH Inequalities

This repository contains the MATLAB code accompanying the paper:

> **Robust and Parallel Semi-Device-Independent Self-Testing of Distinct Quantum Systems**  
> Dhananjoy Ghosh, Kishor Bharti, and Jaskaran Singh  
> Center for Quantum Science and Technology (CQST), IIT Mandi, India  
> Preprint: [arXiv link to be added]

The code implements the SDP-based self-testing verification for the homogeneous application of Theorem 1 of the paper: two Bell-CHSH inequalities tested in parallel, with the composite exclusivity graph $\mathcal{G} = \mathrm{Ci}_8(1,4) \vee \mathrm{Ci}_8(1,4)$.

---

## Physical and Mathematical Setup

### The Bell-CHSH Inequality and Its Ququart Realization

The Bell-CHSH inequality [Clauser et al., PRL 1969], expressed in the NC/CSW framework [Cabello, Severini, Winter, PRL 2014], is defined over eight projective measurements $\lbrace \Pi_{i_j} \rbrace_{i_j=1}^8$ whose exclusivity graph is the eight-vertex circulant graph $\mathrm{Ci}_8(1,4)$:

$$\beta_j = \sum_{i_j=1}^8 p(1|i_j) \leq 3 = \beta_\mathrm{NCHV}^{(j)}, \qquad j = 1, 2,$$

with maximum quantum value $\beta_\mathrm{QT}^{(j)} = \vartheta(\mathrm{Ci}_8(1,4)) = 2 + \sqrt{2}$, achieved by the ideal **ququart** realization $\mathcal{S}_j = \lbrace |v_{0_j}\rangle\langle v_{0_j}|,\, (|v_{i_j}\rangle\langle v_{i_j}|)_{i_j=1}^8 \rbrace$ where

$$|v_{0_j}\rangle = \tfrac{1}{\sqrt{2}}(1,0,0,1)^\top, \qquad |v_{i_j}\rangle = |A_{a,x}\rangle \otimes |B_{b,y}\rangle,$$

with basis vectors

$$|A_{0,0}\rangle = (1,0)^\top, \quad |A_{0,1}\rangle = (0,-1)^\top, \quad |A_{1,0}\rangle = a(1,1)^\top, \quad |A_{1,1}\rangle = a(1,-1)^\top,$$

$$|B_{0,0}\rangle = (c,d)^\top, \quad |B_{0,1}\rangle = (d,-c)^\top, \quad |B_{1,0}\rangle = (c,-d)^\top, \quad |B_{1,1}\rangle = (-d,-c)^\top,$$

and parameters $a = 1/\sqrt{2}$, $c = \cos(\pi/8)$, $d = \sin(\pi/8)$.

The exclusivity graph $\mathrm{Ci}_8(1,4)$ has independence number $\alpha(\mathrm{Ci}_8(1,4)) = 2$ and Lovász theta number $\vartheta(\mathrm{Ci}_8(1,4)) = \sqrt{5}$. The Bell-CHSH inequality self-tests $\mathcal{S}_j$ individually for each $j$.

### Parallel Composition via the OR Graph Product

Two independent Bell-CHSH tests run in parallel are encoded by the **OR graph product** $\mathcal{G} = \mathrm{Ci}_8(1,4) \vee \mathrm{Ci}_8(1,4)$ (Eq. (6) of the paper). Two composite vertices $(v_{i_1}, v_{i_2})$ and $(v_{j_1}, v_{j_2})$ are adjacent in $\mathcal{G}$ if and only if

$$v_{i_1} \sim v_{j_1} \quad \text{in } \mathrm{Ci}_8(1,4) \quad \mathbf{or} \quad v_{i_2} \sim v_{j_2} \quad \text{in } \mathrm{Ci}_8(1,4).$$

The graph $\mathcal{G} = \mathrm{Ci}_8(1,4) \vee \mathrm{Ci}_8(1,4)$ has:

| Property | Value |
|---|---|
| Vertices $N$ | $8 \times 8 = 64$ |
| Independence number $\alpha(\mathcal{G})$ | 9 |
| Lovász theta number $\vartheta(\mathcal{G})$ | $(2+\sqrt{2})^2 \approx 11.66$ |

Since $\vartheta(\mathcal{G}) > \alpha(\mathcal{G})$, the composite NC inequality exhibits a genuine quantum advantage. The composite ideal quantum realization is the **ququart-ququart** product state

$$\mathcal{S} = \lbrace |v_0\rangle\langle v_0|,\; (|v_i\rangle\langle v_i|)_{i=1}^{64} \rbrace,$$

where $|v_0\rangle\langle v_0| = |v_{0_1}\rangle\langle v_{0_1}| \otimes |v_{0_2}\rangle\langle v_{0_2}|$ and $|v_i\rangle\langle v_i| = |v_{i_1}\rangle\langle v_{i_1}| \otimes |v_{i_2}\rangle\langle v_{i_2}|$.

### Vertex Labelling

Composite vertices are labelled by the map

$$(a,b) \;\mapsto\; v = 8(a-1)+b, \qquad a, b \in \lbrace 1,\ldots,8\rbrace,$$

so vertex $v$ corresponds to CHSH vertex $a$ in the first copy and CHSH vertex $b$ in the second copy.

### The CHSH Exclusivity Graph $\mathrm{Ci}_8(1,4)$

The eight vertices of $\mathrm{Ci}_8(1,4)$ are connected by the following 12 edges:

$$\lbrace 1\text{-}2,\; 2\text{-}3,\; 3\text{-}4,\; 4\text{-}5,\; 5\text{-}6,\; 6\text{-}7,\; 7\text{-}8,\; 8\text{-}1,\; 1\text{-}5,\; 2\text{-}6,\; 3\text{-}7,\; 4\text{-}8 \rbrace.$$

### Self-Testing Criterion (Eqs. (2)–(3) of the paper)

The maximum quantum value $\vartheta(\mathcal{G})$ is computed via the **primal Lovász theta SDP**:

$$\vartheta(\mathcal{G}) = \max \sum_{i=1}^{64} X_{ii}$$

subject to

$$X_{00} = 1,\quad X \succeq 0,\quad X_{i0} = X_{ii}\; (1 \leq i \leq 64),\quad X_{ij} = 0\;\;\forall\, v_i \sim v_j.$$

The NC inequality self-tests $\mathcal{S}$ if and only if the linear system

$$M_{00} = 0,\quad M_{i0} = M_{ii},\quad M_{ij} = 0\;\;\forall\, v_i \sim v_j,\quad MZ^* = 0$$

admits only the trivial solution $M = 0$, where $Z^*$ is the dual optimal solution and $M$ is a free $(65\times 65)$ symmetric matrix subject to the same structural constraints as $X$.

### The Dual Optimal Solution

For $\mathcal{G} = \mathrm{Ci}_8(1,4) \vee \mathrm{Ci}_8(1,4)$, the dual optimal solution is obtained **numerically** from `Parallel_CHSH_dual_OR.m` and saved to `parallel_dual_matrix_2_CHSH_OR.csv`, which is then read by the self-testing script.

---

## File Descriptions

### `Parallel_CHSH_exclusive_pairs_OR.m`

Generates the complete list of **exclusivity pairs** for $\mathrm{Ci}_8(1,4) \vee \mathrm{Ci}_8(1,4)$.

- Encodes the CHSH adjacency (12 edges of $\mathrm{Ci}_8(1,4)$) and applies the OR-product rule: vertex pair $((a,b),(c,d))$ is exclusive iff $(a,c)$ is an edge in $\mathrm{Ci}_8(1,4)$ **or** $(b,d)$ is an edge in $\mathrm{Ci}_8(1,4)$.
- Removes duplicate undirected pairs and prints the full edge list and per-vertex adjacency list `EX{1}` through `EX{64}` to the console.

**Run this first** to verify or regenerate the exclusivity structure.

---

### `Parallel_CHSH_primal_OR.m`

Solves the **primal Lovász theta SDP** for $\mathrm{Ci}_8(1,4) \vee \mathrm{Ci}_8(1,4)$.

- Decision variable: symmetric matrix $X \in \mathbb{S}^{65}_+$ (MATLAB indices $1,\ldots,65$, where index 1 corresponds to the base vertex 0).
- Constraints: $X_{11} = 1$; $X_{i+1,i+1} = X_{1,i+1}$ for $i = 1,\ldots,64$; $X_{i+1,j+1} = 0$ for each exclusive pair $(i,j)$.
- Objective: maximize $\sum_{i=2}^{65} X_{ii}$.
- Solver: YALMIP + MOSEK.

**Expected output:** Optimal value $\approx 11.66 = (2+\sqrt{2})^2$ and the optimal Gram matrix $X^*$.

---

### `Parallel_CHSH_dual_OR.m`

Solves the **dual SDP** for $\mathrm{Ci}_8(1,4) \vee \mathrm{Ci}_8(1,4)$ to obtain the dual optimal matrix $Z^*$ numerically.

The dual matrix is parameterised as

$$Z = t\,\mathbf{e}_0\mathbf{e}_0^\top + \sum_{i=1}^{64}(\lambda_i-1)\,\mathbf{e}_i\mathbf{e}_i^\top - \sum_{i=1}^{64}\lambda_i\,\frac{\mathbf{e}_0\mathbf{e}_i^\top + \mathbf{e}_i\mathbf{e}_0^\top}{2} + \sum_{\langle i,j\rangle}\mu_{ij}\,\frac{\mathbf{e}_i\mathbf{e}_j^\top + \mathbf{e}_j\mathbf{e}_i^\top}{2},$$

where the last sum runs over all exclusive pairs of $\mathcal{G}$. The dual SDP minimises $t$ subject to $Z \succeq 0$, $t \geq 0$.

- Solver: YALMIP + MOSEK.
- **Important:** Before running, uncomment the final line of the script:

  ```matlab
  writematrix(Z_opt,'parallel_dual_matrix_2_CHSH_OR.csv')
  ```

  to save $Z^*$ to disk. This CSV file is required by `Parallel_CHSH_self_testing_OR.m`.

**Expected output:** Optimal dual value $t^* \approx (2+\sqrt{2})^2$ and the $65 \times 65$ dual optimal matrix $Z^*$.

---

### `Parallel_CHSH_self_testing_OR.m`

Performs the **self-testing verification** by checking whether the linear system $MZ^* = 0$ has a unique solution.

**Step 1 — Build $M$ symbolically.**  
Construct a $65 \times 65$ symbolic symmetric matrix subject to:
- $M_{00} = 0$ (index 1 in MATLAB)
- $M_{i0} = M_{ii}$ and $M_{0i} = M_{ii}$ for $i = 1,\ldots,64$
- $M_{ij} = 0$ for all exclusive pairs $(i,j)$
- All remaining upper-triangular entries are independent symbolic variables

**Step 2 — Load $Z^*$ numerically.**  
Read the dual optimal matrix from the CSV file saved by the dual SDP script:

```matlab
Z = readmatrix('parallel_dual_matrix_2_CHSH_OR.csv');
```

> **Note:** `parallel_dual_matrix_2_CHSH_OR.csv` must be present in the MATLAB working directory before running this script.

**Step 3 — Form and convert the linear system.**  
Set up $M \cdot Z^* = 0$ (a $65 \times 65$ matrix equation) and convert to the matrix form $\mathbf{A}\mathbf{x} = \mathbf{0}$ via `equationsToMatrix`, where $\mathbf{x}$ is the vector of free symbolic variables in $M$.

**Step 4 — SVD of the coefficient matrix.**  
Compute `S = svd(double(A))`. The interpretation is:
- All singular values well-separated from zero $\Rightarrow$ $\mathbf{A}$ is numerically full rank $\Rightarrow$ $M = 0$ is the **unique** solution $\Rightarrow$ the composite NC inequality **self-tests** $\mathcal{S}$ (Theorem 1 confirmed).
- One or more near-zero singular values $\Rightarrow$ nontrivial solutions exist $\Rightarrow$ no self-test.

**Expected output:** All singular values are nonzero and well-separated from zero, confirming that the composite ququart-ququart realization $\mathcal{S}$ is robustly self-tested with robustness $O(\sqrt{\epsilon})$.

---

## Dependencies

| Dependency | Purpose |
|---|---|
| [MATLAB](https://www.mathworks.com/products/matlab.html) | Core computational environment |
| [YALMIP](https://yalmip.github.io/) | SDP modelling layer |
| [MOSEK](https://www.mosek.com/) | Interior-point SDP solver (free academic license available) |
| Symbolic Math Toolbox | Required by `Parallel_CHSH_self_testing_OR.m` |

---

## Usage

```matlab
% Step 1: Generate and verify the exclusivity structure of Ci_8(1,4) v Ci_8(1,4)
Parallel_CHSH_exclusive_pairs_OR

% Step 2: Solve the primal SDP — compute vartheta(Ci_8(1,4) v Ci_8(1,4))
Parallel_CHSH_primal_OR

% Step 3: Solve the dual SDP — obtain Z* numerically and save to CSV
% (Uncomment the writematrix line in the script before running)
Parallel_CHSH_dual_OR

% Step 4: Verify self-testing via SVD of M Z* = 0
% (Requires parallel_dual_matrix_2_CHSH_OR.csv in the working directory)
Parallel_CHSH_self_testing_OR
```

> **Important:** Steps 3 and 4 are coupled. The dual script must be run with the `writematrix` line uncommented before the self-testing script can load $Z^*$.

---

## Summary of Results

| Quantity | Value |
|---|---|
| Composite graph | $\mathrm{Ci}_8(1,4) \vee \mathrm{Ci}_8(1,4)$ |
| Vertices $N$ | 64 |
| $\alpha(\mathcal{G})$ | 9 |
| $\vartheta(\mathcal{G})$ | $(2+\sqrt{2})^2 \approx 11.66$ |
| Primal SDP optimum | $\approx 11.66$ |
| Dual SDP optimum | $\approx 11.66$ |
| $Z^*$ | Numerical; stored in `parallel_dual_matrix_2_CHSH_OR.csv` |
| Null space of $\mathbf{A}$ | Trivial ($M = 0$ only) |
| Self-testing verdict | ✅ Composite ququart-ququart realization is self-tested |
| Robustness | $O(\sqrt{\epsilon})$ |

---

## Comparison Across All Three Scenarios

| Feature | KCBS $\vee$ KCBS | KCBS $\vee$ Bell-CHSH | Bell-CHSH $\vee$ Bell-CHSH |
|---|---|---|---|
| Composite graph | $C_5 \vee C_5$ | $C_5 \vee \mathrm{Ci}_8(1,4)$ | $\mathrm{Ci}_8(1,4) \vee \mathrm{Ci}_8(1,4)$ |
| Vertices $N$ | 25 | 40 | 64 |
| Systems certified | Two qutrits | Qutrit + ququart | Two ququarts |
| $\vartheta(\mathcal{G})$ | 5 | $\sqrt{5}(2+\sqrt{2}) \approx 7.63$ | $(2+\sqrt{2})^2 \approx 11.66$ |
| $Z^*$ | Analytic (Eq. (9)) | Numerical (CSV) | Numerical (CSV) |
| Scenario type | Homogeneous | Heterogeneous | Homogeneous |

---

## Citation

If you use this code, please cite:

```bibtex
@article{ghosh2026parallel,
  title  = {Robust and parallel semi-device-independent self-testing of distinct quantum systems},
  author = {Ghosh, Dhananjoy and Bharti, Kishor and Singh, Jaskaran},
  year   = {2026},
  note   = {Preprint}
}
```

---

## Acknowledgements

D.G. acknowledges financial support from the IIT Mandi HTRA fellowship. J.S. acknowledges financial support from the IIT Mandi seed grant project No. IITM/SG/JSN/168. K.B. is supported by a Hartree fellowship from QuICS, University of Maryland.

---

## Contact

- **Dhananjoy Ghosh** — d25062@students.iitmandi.ac.in  
- **Jaskaran Singh** — jaskaran@iitmandi.ac.in  
- Center for Quantum Science and Technology (CQST), IIT Mandi, Himachal Pradesh 175075, India
