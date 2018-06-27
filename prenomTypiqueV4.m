function [prenoms,frequence] = prenomTypiqueV4 (data,listePrenoms,rapport)
% function [prenoms,frequence] = prenomTypiqueV4 (data,listePrenoms,rapport)
% rapport : le prénom doit être donné 'rapport' fois plus que la moyenne nationale
% pour être considéré comme typique de ce département

data = [zeros(1,97);data];
listePrenoms = ['';listePrenoms];
% si aucun prénom typique n'est trouvé -> renvoit <undefined>

sumPrenom = sum(data,2,'omitnan');
moy = sumPrenom./(sum(sumPrenom)/1000);
data = data./(sum(data,1)/1000); %ramené à 1000 naissances par département

[ind,dpt] = find(data>=rapport*moy & data~=0);
% prénoms qui ont été donnés au moins 'rapport' fois plus que la moyenne
% nationale dans ce département
prenomTypique = listePrenoms(ind);
freq = data(ind,:);
[listeDpt,indDpt] = unique(dpt);
indDpt = [indDpt;size(dpt,1)+1]; %pour pouvoir faire la dernière boucle for
frequence = zeros(97,1); %preallocating
ligne = zeros(97,1); %preallocating
for i=1:size(listeDpt)
    [frequence(listeDpt(i)),ligne(listeDpt(i))] = max(freq(indDpt(i):indDpt(i+1)-1,listeDpt(i)));
    ligne(listeDpt(i)) = ligne(listeDpt(i))+indDpt(i)-1;
    prenoms(listeDpt(i),1) = prenomTypique(ligne(listeDpt(i)));
end
end