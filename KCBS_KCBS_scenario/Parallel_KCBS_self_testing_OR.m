
clc;
yalmip('clear')

%% Number of vertex

N = 25;

%% Exclusivity pairs

pairs = [
1 2;
1 5;
1 6;
1 7;
1 8;
1 9;
1 10;
1 12;
1 15;
1 17;
1 20;
1 21;
1 22;
1 23;
1 24;
1 25;
2 3;
2 6;
2 7;
2 8;
2 9;
2 10;
2 11;
2 13;
2 16;
2 18;
2 21;
2 22;
2 23;
2 24;
2 25;
3 4;
3 6;
3 7;
3 8;
3 9;
3 10;
3 12;
3 14;
3 17;
3 19;
3 21;
3 22;
3 23;
3 24;
3 25;
4 5;
4 6;
4 7;
4 8;
4 9;
4 10;
4 13;
4 15;
4 18;
4 20;
4 21;
4 22;
4 23;
4 24;
4 25;
5 6;
5 7;
5 8;
5 9;
5 10;
5 11;
5 14;
5 16;
5 19;
5 21;
5 22;
5 23;
5 24;
5 25;
6 7;
6 10;
6 11;
6 12;
6 13;
6 14;
6 15;
6 17;
6 20;
6 22;
6 25;
7 8;
7 11;
7 12;
7 13;
7 14;
7 15;
7 16;
7 18;
7 21;
7 23;
8 9;
8 11;
8 12;
8 13;
8 14;
8 15;
8 17;
8 19;
8 22;
8 24;
9 10;
9 11;
9 12;
9 13;
9 14;
9 15;
9 18;
9 20;
9 23;
9 25;
10 11;
10 12;
10 13;
10 14;
10 15;
10 16;
10 19;
10 21;
10 24;
11 12;
11 15;
11 16;
11 17;
11 18;
11 19;
11 20;
11 22;
11 25;
12 13;
12 16;
12 17;
12 18;
12 19;
12 20;
12 21;
12 23;
13 14;
13 16;
13 17;
13 18;
13 19;
13 20;
13 22;
13 24;
14 15;
14 16;
14 17;
14 18;
14 19;
14 20;
14 23;
14 25;
15 16;
15 17;
15 18;
15 19;
15 20;
15 21;
15 24;
16 17;
16 20;
16 21;
16 22;
16 23;
16 24;
16 25;
17 18;
17 21;
17 22;
17 23;
17 24;
17 25;
18 19;
18 21;
18 22;
18 23;
18 24;
18 25;
19 20;
19 21;
19 22;
19 23;
19 24;
19 25;
20 21;
20 22;
20 23;
20 24;
20 25;
21 22;
21 25;
22 23;
23 24;
24 25;
];



%% Structure of M

% Start with all zeros
M = sym(zeros(N+1));

% M_{00} = 0 (already satisfied)

% Create independent symbolic variables only where needed
for i = 2:N+1
    % Diagonal variable
    M(i,i) = sym(sprintf('m%d_%d',i,i));

    % Constraint: M_{i0} = M_{ii}
    M(i,1) = M(i,i);
    M(1,i) = M(i,i);      % symmetry
end

% Fill the remaining upper-triangular entries
for i = 2:N+1
    for j = i+1:N+1
        M(i,j) = sym(sprintf('m%d_%d',i,j));
        M(j,i) = M(i,j);  % symmetry
    end
end

% Impose M_{ij}=0 for exclusive pairs
for k = 1:size(pairs,1)
    i = pairs(k,1) + 1;   % shift because vertex 0 is MATLAB index 1
    j = pairs(k,2) + 1;

    M(i,j) = sym(0);
    M(j,i) = sym(0);
end





%% Adjacency Matrix

A5 = sym([

0 1 0 0 1
1 0 1 0 0
0 1 0 1 0
0 0 1 0 1
1 0 0 1 0

]);

I5 = sym(eye(5));
J5 = sym(ones(5));

AA5 = J5-I5-A5;


%% CONSTANTS

phi = (1+sqrt(sym(5)))/2;

% Numerical value extracted from the SDP dual optimum
b3 = sym(pi)/10 + sym(1)/5675;

b1 = b3/phi;

b2 = sym(1)/2 - phi*b3/2;

%% Dual optimal solution

Z = kron(I5,I5) ...
    + b3*(kron(A5,I5)+kron(I5,A5)) ...
    + b1*kron(A5,A5) ...
    + b2*(kron(AA5,A5)+kron(A5,AA5));

J = sym(ones(25,1));

Z26 = [sym(5)   -J';
       -J        Z];



%% Form equations

eqns = M*Z26 == 0;

%% Unknown variables

vars = symvar(M);

%% Convert to matrix form A*x = 0

[A,b] = equationsToMatrix(eqns(:),vars);


%% Singular Value Decomposition (SVD)

% Since Z26 is obtained numerically from the SDP solver, the coefficient
% matrix A is also numerical. Therefore, instead of using the exact rank,
% we analyze the singular values of A. If one or more singular values are
% close to zero (within the numerical tolerance), then A is effectively
% rank deficient and admits nontrivial solutions to A*x = 0. Conversely,
% if all singular values are well separated from zero, A is numerically
% full rank and the trivial solution 'M=0' is unique.


A_num = double(A);

S = svd(A_num);

fprintf('SVD = %d\n', S);






