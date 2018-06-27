function [prenoms,frequence] = prenomTypiqueV1 (data,listePrenoms)
% function [prenoms,frequence] = prenomTypiqueV1 (data,listePrenoms)

data = data./sum(data,1)*1000; %ramené à 1000 naissances par département

data = [zeros(1,97);data];
listePrenoms = ['';listePrenoms];
% si aucun prénom typique n'est trouvé -> renvoit <undefined>

[maxi,dpt] = max(data,[],2);
typique = zeros(size(data)); %preallocating
for i=1:size(data,1)
    typique(i,dpt(i))=maxi(i);
end 
[frequence,ligneTypique] = max(typique);
frequence = frequence';
prenoms = listePrenoms(ligneTypique);
end