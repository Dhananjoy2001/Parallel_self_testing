
clc;
clear;
yalmip('clear');


%% PARAMETERS

n = 25;
E = eye(n+1);


%% EXCLUSIVITY LISTS

EX = cell(n,1);

EX{1} = [2 5 6 7 8 9 10 12 15 17 20 21 22 23 24 25];

EX{2} = [3 6 7 8 9 10 11 13 16 18 21 22 23 24 25];

EX{3} = [4 6 7 8 9 10 12 14 17 19 21 22 23 24 25];

EX{4} = [5 6 7 8 9 10 13 15 18 20 21 22 23 24 25];

EX{5} = [6 7 8 9 10 11 14 16 19 21 22 23 24 25];

EX{6} = [7 10 11 12 13 14 15 17 20 22 25];

EX{7} = [8 11 12 13 14 15 16 18 21 23];

EX{8} = [9 11 12 13 14 15 17 19 22 24];

EX{9} = [10 11 12 13 14 15 18 20 23 25];

EX{10} = [11 12 13 14 15 16 19 21 24];

EX{11} = [12 15 16 17 18 19 20 22 25];

EX{12} = [13 16 17 18 19 20 21 23];

EX{13} = [14 16 17 18 19 20 22 24];

EX{14} = [15 16 17 18 19 20 23 25];

EX{15} = [16 17 18 19 20 21 24];

EX{16} = [17 20 21 22 23 24 25];

EX{17} = [18 21 22 23 24 25];

EX{18} = [19 21 22 23 24 25];

EX{19} = [20 21 22 23 24 25];

EX{20} = [21 22 23 24 25];

EX{21} = [22 25];

% EX22 = [23];
% EX23 = [24];
% EX24 = [25];
% EX25 = [];


%% SDP VARIABLES

lamda = sdpvar(n,1);
mu    = sdpvar(n,1);
t     = sdpvar(1,1);

muEX = cell(n,1);

for k = 1:21
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



Z4 = 0;

for i = 1:(n-1)

    Z4 = Z4 + mu(i) * ...
        (E(:,i+1)*E(:,i+2)' + E(:,i+2)*E(:,i+1)')/2;

end

Z4 = Z4 + mu(n) * ...
    (E(:,n+1)*E(:,2)' + E(:,2)*E(:,n+1)')/2;



C = 0;

for v = 1:21

    mu_v = muEX{v};

    for k = 1:length(EX{v})

        w = EX{v}(k);

        C = C + mu_v(k) * ...
            (E(:,v+1)*E(:,w+1)' + ...
             E(:,w+1)*E(:,v+1)')/2;

    end
end



Z = Z1 + Z2 - Z3 + Z4 + C;


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
mu_opt     = value(mu);

fprintf('\nOptimal objective = %.15f\n\n',t_opt);

disp('Optimal lambda =');
disp(lamda_opt);

disp('Optimal mu =');
disp(mu_opt);

disp('Optimal Z =');
disp(Z_opt);

% writematrix(Z_opt,'parallel_matrix_DG.csv')



