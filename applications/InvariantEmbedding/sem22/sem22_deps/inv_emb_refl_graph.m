function [G,real_leafNodes,dead_leafNodes,p] = inv_emb_refl_graph()
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
    edges = [edges,...
                ["8:"+bs,"10:"+rl,"10:"+rl,"10:"+rl;
                "10:"+rl,"11:"+ns,bs+"3end",fs+"3end"]];
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
    end
    dead_leafNodes = G.Nodes(deadLeaf_inds,1);
    real_leafNodes = G.Nodes(leafNodes_inds,1);

    highlight(p, table2cell(real_leafNodes), 'NodeColor','g')
    highlight(p, table2cell(dead_leafNodes), 'NodeColor','r')
    highlight(p, "0", 'Marker','square','NodeColor','g')
end