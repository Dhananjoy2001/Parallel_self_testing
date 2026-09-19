clc;
clear;


%% Number of vertices
n = 25;


%% KCBS edges
KCBS_edges = [
    1 2;
    2 3;
    3 4;
    4 5;
    5 1
];

% KCBS adjacency checker
isAdj_KCBS = @(x,y) any((KCBS_edges(:,1)==x & KCBS_edges(:,2)==y) | ...
                        (KCBS_edges(:,1)==y & KCBS_edges(:,2)==x));


%% Numbering rule: (a,b) -> v = 5(a-1)+b
index = @(a,b) 5*(a-1)+b;


%% Generate OR-product exclusive pairs
pairs = [];

for a = 1:5
    for b = 1:5

        v1 = index(a,b);

        for c = 1:5
            for d = 1:5

                v2 = index(c,d);

                if v1 == v2
                    continue;
                end

                % OR-product adjacency
                if isAdj_KCBS(a,c) || isAdj_KCBS(b,d)
                    pairs = [pairs; v1 v2];
                end

            end
        end
    end
end


%% Remove duplicate undirected pairs
pairs = unique(sort(pairs,2),'rows');


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