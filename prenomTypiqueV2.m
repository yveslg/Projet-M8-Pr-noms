function [prenoms,frequence] = prenomTypiqueV2 (data,listePrenoms,seuil)
% function [prenoms,frequence] = prenomTypiqueV2 (data,listePrenoms,seuil)

data = data./sum(data,1)*1000; %ramené à 1000 naissances par département
dataNorm = data./sum(data,2,'omitnan')*100; %rapport entre le prénom dans le département
                                        %et le prénom le plus donné
[ind,dpt] = find(dataNorm>=seuil);
% prénoms qui ont été donnés au moins 'seuil'% dans ce département par rapport
% au niveau national (ramené au nombre de naissance dans le département)
prenomTypique = listePrenoms(ind);
freq = data(ind,:);
freq = max(freq,[],2);
[listeDpt,indDpt] = unique(dpt);
indDpt = [indDpt;size(dpt,1)+1]; %pour pouvoir faire la dernière boucle for
frequence = zeros(97,1); %preallocating
ligne = zeros(97,1); %preallocating
for i=1:size(listeDpt)
    [frequence(listeDpt(i)),ligne(listeDpt(i))] = max(freq(indDpt(i):indDpt(i+1)-1));
    ligne(listeDpt(i)) = ligne(listeDpt(i))+indDpt(i)-1;
    prenoms(listeDpt(i),1) = prenomTypique(ligne(listeDpt(i)));
end
end