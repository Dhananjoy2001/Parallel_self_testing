
clc;
clear;

n = 64;


%% CHSH exclusivity edges (8-vertex graph)
CHSH_edges = [
    1 2;
    2 3;
    3 4;
    4 5;
    5 6;
    6 7;
    7 8;
    8 1;
    1 5;
    2 6;
    3 7;
    4 8
];

% CHSH adjacency checker
isAdj = @(x,y) any((CHSH_edges(:,1)==x & CHSH_edges(:,2)==y) | ...
                   (CHSH_edges(:,1)==y & CHSH_edges(:,2)==x));


%% Numbering rule: (a,b) -> v = 8(a-1)+b
index = @(a,b) 8*(a-1) + b;


%% Generate OR-product exclusive pairs
ex_list = [];

for a = 1:8
    for b = 1:8

        v1 = index(a,b);

        for c = 1:8
            for d = 1:8

                v2 = index(c,d);

                if v1 == v2
                    continue;
                end

                % OR-product adjacency
                if isAdj(a,c) || isAdj(b,d)
                    ex_list = [ex_list; v1, v2];
                end

            end
        end
    end
end


%% Remove duplicate undirected pairs
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