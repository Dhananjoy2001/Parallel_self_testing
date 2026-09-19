clc;
clear;

%% Number of vertices
n = 40;

%% KCBS edges
KCBS_edges = [1 2; 2 3; 3 4; 4 5; 5 1];

% KCBS adjacency checker
isAdj_KCBS = @(x,y) any((KCBS_edges(:,1)==x & KCBS_edges(:,2)==y) | ...
                        (KCBS_edges(:,1)==y & KCBS_edges(:,2)==x));

%% CHSH exclusivity edges (standard 8-vertex graph)
CHSH_edges = [
    1 2; 2 3; 3 4; 4 5;   % Alice cycle
    5 6; 6 7; 7 8; 8 1;   % Bob cycle
    1 5; 2 6; 3 7; 4 8    % cross edges
];

% CHSH adjacency checker
isAdj_CHSH = @(x,y) any((CHSH_edges(:,1)==x & CHSH_edges(:,2)==y) | ...
                        (CHSH_edges(:,1)==y & CHSH_edges(:,2)==x));

%% Numbering rule: (a,b) → v = 8(a-1) + b
index = @(a,b) 8*(a-1) + b;

%% Generate OR-product exclusive pairs
ex_list = [];

for a = 1:5           % KCBS vertex
    for b = 1:8       % CHSH vertex
        v1 = index(a,b);

        for c = 1:5
            for d = 1:8
                v2 = index(c,d);

                if v1 == v2
                    continue;
                end

                % OR-product adjacency:
                % (a ~ c in KCBS)  OR  (b ~ d in CHSH)
                if isAdj_KCBS(a,c) || isAdj_CHSH(b,d)
                    ex_list = [ex_list; v1, v2];
                end

            end
        end
    end
end

% Remove duplicate undirected pairs
pairs = unique(sort(ex_list,2),'rows');

%% Print exclusive pairs
fprintf('pairs = [\n');
for k = 1:size(pairs,1)
    fprintf('%d %d;\n',pairs(k,1),pairs(k,2));
end
fprintf('];\n\n');

fprintf('Total exclusive pairs = %d\n\n',size(pairs,1));


%% Print adjacency list
for i = 1:n

    EX = pairs(pairs(:,1)==i,2)';

    str = sprintf('%d ', EX);
    str = strtrim(str);   % remove trailing space

    fprintf('EX{%d} = [%s];\n\n', i, str);

end


%% For python

% fprintf('pairs = [\n');
% for k = 1:size(pairs,1)
%     fprintf('    [%d, %d],\n', pairs(k,1), pairs(k,2));
% end
% fprintf(']\n');