# Parallel Self-Testing of Two KCBS Inequalities

This repository contains the MATLAB code accompanying the paper:

> **Robust and Parallel Semi-Device-Independent Self-Testing of Distinct Quantum Systems**  
> Dhananjoy Ghosh, Kishor Bharti, and Jaskaran Singh  
> Center for Quantum Science and Technology (CQST), IIT Mandi, India  
> Preprint: [arXiv link to be added]

The code implements the SDP-based self-testing verification for the primary application of Theorem 1 of the paper: two KCBS inequalities tested in parallel, with the composite exclusivity graph $\mathcal{G} = C_5 \vee C_5$.

---

## Physical and Mathematical Setup

### The KCBS Inequality and Its Qutrit Realization

The KCBS inequality [Klyachko et al., PRL 2008] is the simplest NC inequality certifying quantum contextuality in a qutrit system. It is defined over five projective measurements $\{\Pi_{i_j}\}_{i_j=1}^5$ whose exclusivity graph is the five-cycle $C_5$:

$$\beta_j = \sum_{i_j=1}^5 p(1|i_j) \leq 2 = \beta_\mathrm{NCHV},$$

with maximum quantum value $\beta_\mathrm{QT} = \vartheta(C_5) = \sqrt{5}$, achieved by the ideal qutrit realization $\mathcal{S}_j = \{|v_{0_j}\rangle\langle v_{0_j}|,\, \{|v_{i_j}\rangle\langle v_{i_j}|\}_{i_j=1}^5\}$ where

$$|v_{0_j}\rangle = (1,0,0)^\top, \qquad |v_{i_j}\rangle = \bigl(\cos\theta,\; \sin\theta\sin\phi_{i_j},\; \sin\theta\cos\phi_{i_j}\bigr)^\top,$$

with $\cos^2\theta = \frac{\cos(\pi/5)}{1+\cos(\pi/5)}$ and $\phi_{i_j} = \frac{4\pi i_j}{5}$, for $j = 1, 2$.

### Parallel Composition via the OR Graph Product

Two independent KCBS tests run in parallel are encoded by the **OR graph product** $\mathcal{G} = C_5 \vee C_5$ (see Eq. (6) of the paper). Two composite vertices $(v_{i_1}, v_{i_2})$ and $(v_{j_1}, v_{j_2})$ are adjacent in $\mathcal{G}$ if and only if

$$v_{i_1} \sim v_{j_1} \quad \text{in } C_5 \quad \mathbf{or} \quad v_{i_2} \sim v_{j_2} \quad \text{in } C_5.$$

The graph $\mathcal{G} = C_5 \vee C_5$ has:

| Property | Value |
|---|---|
| Vertices $N$ | 25 |
| Exclusive pairs | 200 |
| Independence number $\alpha(\mathcal{G})$ | 4 |
| Lovász theta number $\vartheta(\mathcal{G})$ | 5 |

Since $\vartheta(\mathcal{G}) = 5 > 4 = \alpha(\mathcal{G})$, the composite NC inequality exhibits a genuine quantum advantage. The composite ideal quantum realization is the two-qutrit product state

$$\mathcal{S} = \Bigl\{|v_0\rangle\langle v_0|,\; \{|v_i\rangle\langle v_i|\}_{i=1}^{25}\Bigr\},$$

where $|v_0\rangle\langle v_0| = |v_{0_1}\rangle\langle v_{0_1}| \otimes |v_{0_2}\rangle\langle v_{0_2}|$ and $|v_i\rangle\langle v_i| = |v_{i_1}\rangle\langle v_{i_1}| \otimes |v_{i_2}\rangle\langle v_{i_2}|$.

### Vertex Labelling

Composite vertices are labelled by the map

$$(a,b) \;\mapsto\; v = 5(a-1)+b, \qquad a,b \in \{1,\ldots,5\},$$

so vertex $v$ corresponds to the pair (row $a$, column $b$) of the $5\times 5$ product grid.

### Self-Testing Criterion (Eqs. (2)–(3) of the paper)

The maximum quantum value $\vartheta(\mathcal{G})$ is computed via the **primal Lovász theta SDP**:

$$\vartheta(\mathcal{G}) = \max \sum_{i=1}^{25} X_{ii}$$

subject to

$$X_{00} = 1, \quad X \succeq 0, \quad X_{i0} = X_{ii} \; (1 \leq i \leq 25), \quad X_{ij} = 0 \;\; \forall\, v_i \sim v_j.$$

The NC inequality self-tests $\mathcal{S}$ if and only if the linear system

$$M_{00} = 0, \quad M_{i0} = M_{ii}, \quad M_{ij} = 0 \;\; \forall\, v_i \sim v_j, \quad M Z^* = 0$$

admits only the trivial solution $M = 0$, where $Z^*$ is the dual optimal solution and $M$ is a free $(26\times 26)$ symmetric matrix subject to the same structural constraints as $X$.

### The Dual Optimal Solution (Eq. (9) of the paper)

For $\mathcal{G} = C_5 \vee C_5$ the dual optimal solution has an analytic closed form:

$$Z^* = \begin{pmatrix} 5 & -J^\top \\ -J & z \end{pmatrix},$$

where $J = (1,\ldots,1)^\top \in \mathbb{R}^{25}$ and

$$z = \mathbf{1}_5 \otimes \mathbf{1}_5 + b_3(A_5 \otimes \mathbf{1}_5 + \mathbf{1}_5 \otimes A_5) + b_1(A_5 \otimes A_5) + b_2(\bar{A}_5 \otimes A_5 + A_5 \otimes \bar{A}_5),$$

with $b_1 = c\, b_3$, $\; b_2 = \tfrac{1}{2} - \tfrac{b_3}{2c}$, $\; c = \tfrac{5-\sqrt{5}}{2\sqrt{5}}$. Here $A_5$ is the adjacency matrix of $C_5$, $\bar{A}_5 = J_5 - I_5 - A_5$ is its complement adjacency matrix, and $b_3$ is a free parameter. The code uses $b_3 = \pi/10 + 1/5675$, extracted from the numerical SDP dual optimum, which keeps $Z^* \succeq 0$.

---

## File Descriptions

### `Parallel_KCBS_exclusive_pairs_OR.m`

Generates the complete list of **exclusivity pairs** for $C_5 \vee C_5$.

- Implements the OR-product adjacency rule for all $\binom{25}{2} = 300$ vertex pairs.
- Removes duplicate undirected pairs, yielding 200 exclusive pairs.
- Prints the edge list and the per-vertex adjacency list `EX{1}` through `EX{25}` to the console.

**Run this first** to verify or regenerate the exclusivity structure used by the remaining scripts.

---

### `Parallel_KCBS_Primal_OR.m`

Solves the **primal Lovász theta SDP** for $C_5 \vee C_5$.

- Decision variable: symmetric matrix $X \in \mathbb{S}^{26}_+$ (MATLAB indices $1,\ldots,26$, where index 1 corresponds to the base vertex 0).
- Constraints: $X_{11} = 1$; $X_{i+1,i+1} = X_{1,i+1}$ for $i = 1,\ldots,25$; $X_{i+1,j+1} = 0$ for each exclusive pair $(i,j)$.
- Objective: maximize $\sum_{i=2}^{26} X_{ii}$.
- Solver: YALMIP + MOSEK.

**Expected output:** Optimal value $= 5 = \vartheta(C_5 \vee C_5)$ and the optimal Gram matrix $X^*$.

---

### `Parallel_KCBS_dual_OR.m`

Solves the **dual SDP** for $C_5 \vee C_5$ to obtain $Z^*$ numerically, for cross-verification with the analytic form.

The dual matrix is parameterised as

$$Z = t\,\mathbf{e}_0\mathbf{e}_0^\top \;+\; \sum_{i=1}^{25}(\lambda_i-1)\,\mathbf{e}_i\mathbf{e}_i^\top \;-\; \sum_{i=1}^{25}\lambda_i\,\frac{\mathbf{e}_0\mathbf{e}_i^\top + \mathbf{e}_i\mathbf{e}_0^\top}{2} \;+\; \sum_{\langle i,j\rangle}\mu_{ij}\,\frac{\mathbf{e}_i\mathbf{e}_j^\top + \mathbf{e}_j\mathbf{e}_i^\top}{2},$$

where the last sum runs over all 200 exclusive pairs. The dual SDP minimises $t$ subject to $Z \succeq 0$, $t \geq 0$.

- Solver: YALMIP + MOSEK.

**Expected output:** Optimal dual value $t^* = 5$ and the $26 \times 26$ dual optimal matrix $Z^*_\mathrm{num}$.

---

### `Parallel_KCBS_self_testing_OR.m`

Performs the **self-testing verification** by checking whether the linear system $MZ^* = 0$ has a unique solution.

**Step 1 — Build $M$ symbolically.**  
Construct a $26 \times 26$ symbolic symmetric matrix subject to:
- $M_{00} = 0$ (index 1 in MATLAB)
- $M_{i0} = M_{ii}$ and $M_{0i} = M_{ii}$ for $i = 1,\ldots,25$
- $M_{ij} = 0$ for all 200 exclusive pairs $(i,j)$
- All remaining upper-triangular entries are independent symbolic variables

**Step 2 — Construct $Z^*$ analytically.**  
Assemble $Z^*$ using the tensor-product formula (Eq. (9) of the paper) with $b_3 = \pi/10 + 1/5675$:

```matlab
Z = kron(I5,I5) + b3*(kron(A5,I5)+kron(I5,A5)) ...
                + b1*kron(A5,A5) ...
                + b2*(kron(AA5,A5)+kron(A5,AA5));

Z26 = [sym(5), -J'; -J, Z];
```

**Step 3 — Form and convert the linear system.**  
Set up $M \cdot Z^* = 0$ (a $26\times 26$ matrix equation, giving up to $676$ scalar equations) and convert to the matrix form $\mathbf{A}\mathbf{x} = \mathbf{0}$ via `equationsToMatrix`, where $\mathbf{x}$ is the vector of free symbolic variables in $M$.

**Step 4 — SVD of the coefficient matrix.**  
Compute `S = svd(double(A))`. The interpretation is:
- All singular values well-separated from zero $\Rightarrow$ $\mathbf{A}$ is numerically full rank $\Rightarrow$ $M = 0$ is the **unique** solution $\Rightarrow$ the composite NC inequality **self-tests** $\mathcal{S}$ (Theorem 1 confirmed).
- One or more near-zero singular values $\Rightarrow$ nontrivial solutions exist $\Rightarrow$ no self-test.

**Expected output:** All singular values are nonzero and well-separated from zero, confirming that the composite two-qutrit realization $\mathcal{S}$ is robustly self-tested with robustness $O(\sqrt{\epsilon})$.

---

## Dependencies

| Dependency | Purpose |
|---|---|
| [MATLAB](https://www.mathworks.com/products/matlab.html) | Core computational environment |
| [YALMIP](https://yalmip.github.io/) | SDP modelling layer |
| [MOSEK](https://www.mosek.com/) | Interior-point SDP solver (free academic license available) |
| Symbolic Math Toolbox | Required by `Parallel_KCBS_self_testing_OR.m` |

---

## Usage

```matlab
% Step 1: Generate and verify the exclusivity structure of C_5 v C_5
Parallel_KCBS_exclusive_pairs_OR

% Step 2: Solve the primal SDP — compute vartheta(C_5 v C_5)
Parallel_KCBS_Primal_OR

% Step 3: Solve the dual SDP — obtain Z* numerically
Parallel_KCBS_dual_OR

% Step 4: Verify self-testing via SVD of M Z* = 0
Parallel_KCBS_self_testing_OR
```

Each script is self-contained and can be run independently, provided YALMIP and MOSEK are on the MATLAB path.

---

## Summary of Results

| Quantity | Value |
|---|---|
| Composite graph | $C_5 \vee C_5$ |
| Vertices $N$ | 25 |
| Exclusive pairs | 200 |
| $\alpha(\mathcal{G})$ | 4 |
| $\vartheta(\mathcal{G})$ | 5 |
| Primal SDP optimum | 5 |
| Dual SDP optimum | 5 |
| Null space of $\mathbf{A}$ | Trivial ($M = 0$ only) |
| Self-testing verdict | ✅ Composite two-qutrit realization is self-tested |
| Robustness | $O(\sqrt{\epsilon})$ |

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
