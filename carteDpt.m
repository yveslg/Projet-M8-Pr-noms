function map = carteDpt(listeDpt, centreDpt, dpt,prenom,frequence)
% function carteDpt(prenom,frequence)
% génère une carte des départements français avec les prénoms indiqués par
% département dans 'prenom' et colore les départements en fonction de la
% fréquence donnée dans 'frequence'
% /!\ Nécessite "Mapping Toolbox"
% listeDpt, centreDpt, dpt doivent avoir été générés par la fonction
% initDpt

set(0,'DefaultFigureRenderer','painters'); %pour forcer rendu vectoriel

%fréquence entre 0 et 1 pour coloriser les départements
%1->très peu donné (blanc)  0->fréquemment donné dans ce département (noir)
frequence = 1-(frequence./max(frequence));

clf;
for i=1:95
    if i~=20
        symbols = makesymbolspec('Polygon',{'code_insee', listeDpt(i,:), 'FaceColor', [frequence(i) frequence(i) frequence(i)]});   
        map = mapshow(dpt(i), 'SymbolSpec', symbols, 'DefaultEdgeColor', 'cyan');
    else
       symbols = makesymbolspec('Polygon',{'code_insee', '2A','FaceColor', [frequence(i) frequence(i) frequence(i)]});
       map = mapshow(dpt(i), 'SymbolSpec', symbols, 'DefaultEdgeColor', 'cyan');
       symbols = makesymbolspec('Polygon',{'code_insee', '2B','FaceColor', [frequence(i) frequence(i) frequence(i)]});
       map = mapshow(dpt(96), 'SymbolSpec', symbols, 'DefaultEdgeColor', 'cyan');
    end 
end
axis square; %même échelle sur les 2 axes
axis tight;
axis off;

for i=1:95
    if i~=[75,77,78,91,92,93,94,95] %région parisienne, pour plus de lisibilité
        if ~ismissing(prenom(i)) %le prénom n'est pas vide
            tx = text(centreDpt(i,1),centreDpt(i,2),string(prenom(i)),'Color','black','FontSize',9);
        else
            tx = text(centreDpt(i,1),centreDpt(i,2),'-','Color','black','FontSize',9);
        end
        tx.HorizontalAlignment = 'center';
    end;
end

end
