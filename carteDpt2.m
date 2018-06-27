function map = carteDpt2(centreDpt, dpt,prenomM,prenomF)
% carteDpt2(centreDpt, dpt,prenomM,prenomF)
% génère une carte des départements français avec les prénoms masculins et féminins
% indiqués respectivement dans 'prenomM' et 'prenomF'.
% /!\ Nécessite "Mapping Toolbox"
% listeDpt, centreDpt, dpt doivent avoir été générés par la fonction
% initDpt

set(0,'DefaultFigureRenderer','painters'); %pour forcer rendu vectoriel

clf;
map = mapshow(dpt, 'DefaultEdgeColor', 'cyan', 'DefaultFaceColor','white');
% carte des départements français
axis square; %même échelle sur les 2 axes
axis tight;
axis off;

for i=1:95
    if ~ismissing(prenomM(i)) %le prénom n'est pas vide
        tx = text(centreDpt(i,1),centreDpt(i,2),string(prenomM(i)),'Color','blue','FontSize',10);
        tx.VerticalAlignment = 'bottom';
        tx.HorizontalAlignment = 'center';
        tx = text(centreDpt(i,1),centreDpt(i,2),string(prenomF(i)),'Color','red','FontSize',10);
        tx.VerticalAlignment = 'top';
        tx.HorizontalAlignment = 'center';
    else
        tx = text(centreDpt(i,1),centreDpt(i,2),'-','Color','black','FontSize',10);
        tx.HorizontalAlignment = 'center';
    end 
end

end
