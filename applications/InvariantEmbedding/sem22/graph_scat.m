ns = "1-\sigma\Delta";fs = "f\sigma\Delta";
bs = "b\sigma\Delta";rl = "R";

edges = ["0","0","0";
    "3:"+ns,"2:"+fs,"1:"+bs];
edges = [edges,...
            ["3:"+ns,"2:"+fs;
             "5:"+rl,"4:"+rl]];
edges = [edges,...
            ["5:"+rl,"5:"+rl,"5:"+rl;
            "9:"+ns,"8:"+bs,"7:"+fs]];
edges = [edges,...
            ["4:"+rl,"4:"+rl,"4:"+rl;
            "6:"+ns,bs+"2end",fs+"2end"]];
dead_nodes = [bs+"2end",fs+"2end",bs+"3end",fs+"3end"];
% собираем граф
G = digraph(edges(1,:),edges(2,:));
p = plot(G,NodeFontSize=16,MarkerSize=10);
% делаем маркеры для листьев
all_leaf = find(outdegree(G) == 0);
deadLeaf_inds  = [];
leafNodes_inds = [];
for n = transpose(all_leaf)
    cnd = G.Nodes{n,1}{1};
    if contains(cnd,dead_nodes)
        deadLeaf_inds(end+1)= n;
    else
        leafNodes_inds(end+1)=n;
    end
"S"
end
dead_leafNodes = G.Nodes(deadLeaf_inds,1);
real_leafNodes = G.Nodes(leafNodes_inds,1);

highlight(p, table2cell(leafNodes), 'NodeColor','g')



%{
allNodes = 1:numnodes(G);

% Set all nodes marker to circle
p.Marker = 'o';
p.MarkerSize = 14;

% Set non-leaf nodes to unfilled markers: markerfacecolor = 'none'
nonLeafNodes = setdiff(allNodes, leafNodes);
highlight(p, nonLeafNodes, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'b');

% Set leaf nodes to filled markers: markerfacecolor = some color (e.g., red)


leafNodes = find(outdegree(G) == 0); % находим индексы всех 
% узлов которые являются листьями

shortestpath(G,"0","5:R")
%}