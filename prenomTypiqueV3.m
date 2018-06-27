function [prenoms,frequence] = prenomTypiqueV3 (data,listePrenoms,rapport)
% function [prenoms,frequence] = prenomTypiqueV3 (data,listePrenoms,rapport)
% rapport : le prénom doit être donné 'rapport' fois plus dans un
% département que dans les autres pour être considéré comme typique de ce
% département

data = [zeros(1,97);data];
listePrenoms = ['';listePrenoms];
% si aucun prénom typique n'est trouvé -> renvoit <undefined>

data = data./(sum(data,1)/1000); %ramené à 1000 naissances par département
dataNorm = data./max(data,[],2)*100; %rapport entre le prénom dans le département
                                        %et le prénom le plus donné
[ind,~] = find(dataNorm>=1/rapport*100 & dataNorm ~= 100 | sum(dataNorm,2,'omitnan')==0);
%prenoms qui ne répondent pas au critère (prénom doté plus de fois dans un
%autre département que le rapport voulu, ou prénom non donné sur la période
%étudiée.
ind = setdiff(1:length(listePrenoms),ind); %on inverse -> prénoms qui répondent au critère
freq = data(ind,:);
[freq,dpt] = max(freq,[],2);

typique=zeros(size(data));
for i=1:length(ind)
    typique(ind(i),dpt(i))=freq(i);
end

[frequence,ligne] = max(typique);
frequence = frequence';
prenoms = listePrenoms(ligne);
end