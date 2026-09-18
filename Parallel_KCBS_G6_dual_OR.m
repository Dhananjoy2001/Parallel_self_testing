
clc;
clear;
yalmip('clear');


%% PARAMETERS

n = 30;
E = eye(n+1);


%% EXCLUSIVITY LISTS

EX = cell(n,1);

EX{1} = [3 4 6 7 8 9 10 11 12 15 16 18 21 22 24 25 26 27 28 29 30];

EX{2} = [4 5 6 7 8 9 10 11 12 16 17 18 22 23 24 25 26 27 28 29 30];

EX{3} = [5 7 8 9 10 11 12 13 17 19 23 25 26 27 28 29 30];

EX{4} = [6 7 8 9 10 11 12 13 14 18 19 20 24 25 26 27 28 29 30];

EX{5} = [7 8 9 10 11 12 14 15 20 21 25 26 27 28 29 30];

EX{6} = [7 8 9 10 11 12 13 14 16 19 20 22 25 26 27 28 29 30];

EX{7} = [9 10 12 13 14 15 16 17 18 21 22 24 27 28 30];

EX{8} = [10 11 12 13 14 15 16 17 18 22 23 24 28 29 30];

EX{9} = [11 13 14 15 16 17 18 19 23 25 29];

EX{10} = [12 13 14 15 16 17 18 19 20 24 25 26 30];

EX{11} = [13 14 15 16 17 18 20 21 26 27];

EX{12} = [13 14 15 16 17 18 19 20 22 25 26 28];

EX{13} = [15 16 18 19 20 21 22 23 24 27 28 30];

EX{14} = [16 17 18 19 20 21 22 23 24 28 29 30];

EX{15} = [17 19 20 21 22 23 24 25 29];

EX{16} = [18 19 20 21 22 23 24 25 26 30];

EX{17} = [19 20 21 22 23 24 26 27];

EX{18} = [19 20 21 22 23 24 25 26 28];

EX{19} = [21 22 24 25 26 27 28 29 30];

EX{20} = [22 23 24 25 26 27 28 29 30];

EX{21} = [23 25 26 27 28 29 30];

EX{22} = [24 25 26 27 28 29 30];

EX{23} = [25 26 27 28 29 30];

EX{24} = [25 26 27 28 29 30];

EX{25} = [27 28 30];

EX{26} = [28 29 30];

% EX{27} = [29];
% 
% EX{28} = [30];
% 
% EX{29} = [];
% 
% EX{30} = [];


%% SDP VARIABLES

lamda = sdpvar(n,1);
t     = sdpvar(1,1);

muEX = cell(n,1);

for k = 1:26
    muEX{k} = sdpvar(length(EX{k}),1);
end


%% Construction of dual matrix Z


Z1 = t*(E(:,1)*E(:,1)');



Z2 = 0;

for i = 1:n
    Z2 = Z2 + (lamda(i)-1)*E(:,i+1)*E(:,i+1)';
end


Z3 = 0;

for i = 1:n
    Z3 = Z3 + lamda(i) * ...
        (E(:,1)*E(:,i+1)' + E(:,i+1)*E(:,1)')/2;
end



C = 0;

for v = 1:26

    mu_v = muEX{v};

    for k = 1:length(EX{v})

        w = EX{v}(k);

        C = C + mu_v(k) * ...
            (E(:,v+1)*E(:,w+1)' + ...
             E(:,w+1)*E(:,v+1)')/2;

    end
end



Z = Z1 + Z2 - Z3 + C;


%% SDP


Constraints = [Z >= 0, t >= 0];

Objective = t;

opts = sdpsettings( ...
    'solver','mosek', ...
    'verbose',1);

Sol = optimize(Constraints,Objective,opts);

%% Results

if Sol.problem ~= 0
    error(Sol.info);
end

t_opt      = value(t);
Z_opt      = value(Z);
lamda_opt  = value(lamda);

fprintf('\nOptimal objective = %.15f\n\n',t_opt);

disp('Optimal lambda =');
disp(lamda_opt);

disp('Optimal Z =');
disp(Z_opt);

%writematrix(Z_opt,'parallel_Dual_matrix_KCBS_C6_OR.csv')



