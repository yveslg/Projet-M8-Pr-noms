load dpt2016-brut.mat
%% Préparation des données
nbLignes = size(nombre,1);
nbPrenoms = sum(nombre);
lignesASupprimer = find(isnan(dpt)); % suppression des lignes dpt = XX 
nbDptXX = sum(nombre(lignesASupprimer));
lignesASupprimerPR = find(preusuel=='_PRENOMS_RARES');  % suppression des lignes _PRENOMS_RARES
nbPrenomsRares = sum(nombre(lignesASupprimerPR));
lignesASupprimer = [lignesASupprimer; lignesASupprimerPR]; 

sexe(lignesASupprimer)=[]; 
preusuel(lignesASupprimer)=[]; 
annais(lignesASupprimer)=[];
dpt(lignesASupprimer)=[];
nombre(lignesASupprimer)=[];
%%
fg = find(sexe=='1',1,'last'); %dernière ligne de garçons
[listePrenomsGarcons,indGarcons] = unique(preusuel(1:fg),'stable');
[listePrenomsFilles,indFilles] = unique(preusuel(fg+1:end),'stable');
indFilles=indFilles+fg; %pour que les indices correspondent aux indices du tableau entier
%%
nbPrenomsGarcons = size(listePrenomsGarcons,1);
nbPrenomsFilles = size(listePrenomsFilles,1);
nbDepart = max(dpt)-min(dpt)+1;
nbAnnees = max(annais)-min(annais)+1;

%%
indGarcons = [indGarcons;fg+1];
indFilles = [indFilles;size(preusuel,1)+1];
% on rajoute l'indice suivant la dernière valeur dans le tableau
%%
annais2 = annais-1899; %1->1900, pour correspondre aux indices du tableau

%%
garcons3D = zeros(nbPrenomsGarcons,nbDepart,nbAnnees); %preallocating
for i=1:nbPrenomsGarcons
    for j=indGarcons(i):indGarcons(i+1)-1
        garcons3D(i,dpt(j),annais2(j))=nombre(j);
    end
end    

%%
filles3D = zeros(nbPrenomsFilles,nbDepart,nbAnnees); %preallocating
for i=1:nbPrenomsFilles
    for j=indFilles(i):indFilles(i+1)-1
        filles3D(i,dpt(j),annais2(j))=nombre(j);
    end
end     

%% Regroupement des années en 5 périodes
% 1. 1900 - 1922 (23 ans)
% 2. 1923 - 1945 (23 ans)
% 3. 1946 - 1967 (22 ans)
% 1968 : réorganisation de la région parisienne
% 4. 1968 - 1991 (24 ans)
% 5. 1992 - 2016 (25 ans)

garcons_0 = sum(garcons3D,3);
garcons_1 = sum(garcons3D(:,:,1:23),3);
garcons_2 = sum(garcons3D(:,:,24:46),3);
garcons_3 = sum(garcons3D(:,:,47:68),3);
garcons_4 = sum(garcons3D(:,:,69:92),3);
garcons_5 = sum(garcons3D(:,:,93:117),3);

filles_0 = sum(filles3D,3);
filles_1 = sum(filles3D(:,:,1:23),3);
filles_2 = sum(filles3D(:,:,24:46),3);
filles_3 = sum(filles3D(:,:,47:68),3);
filles_4 = sum(filles3D(:,:,69:92),3);
filles_5 = sum(filles3D(:,:,93:117),3);

%% Prénoms masculins les plus donnés
[~,ind] = max(garcons_1);
prenomsGarconsMax_1 = listePrenomsGarcons(ind);
prenomsGarconsMax_1(91:96)='';

[~,ind] = max(garcons_2);
prenomsGarconsMax_2 = listePrenomsGarcons(ind);
prenomsGarconsMax_2(91:96)='';

[~,ind] = max(garcons_3);
prenomsGarconsMax_3 = listePrenomsGarcons(ind);
prenomsGarconsMax_3(91:96)='';

[~,ind] = max(garcons_4);
prenomsGarconsMax_4 = listePrenomsGarcons(ind);
prenomsGarconsMax_4(96)='';

[~,ind] = max(garcons_5);
prenomsGarconsMax_5 = listePrenomsGarcons(ind);
prenomsGarconsMax_5(96)='';

prenomsGarconsMax = [prenomsGarconsMax_1,prenomsGarconsMax_2,prenomsGarconsMax_3,prenomsGarconsMax_4,prenomsGarconsMax_5];

%% Prénoms féminins les plus données
[~,ind] = max(filles_1);
prenomsFillesMax_1 = listePrenomsFilles(ind);
prenomsFillesMax_1(91:96)='';

[~,ind] = max(filles_2);
prenomsFillesMax_2 = listePrenomsFilles(ind);
prenomsFillesMax_2(91:96)='';

[~,ind] = max(filles_3);
prenomsFillesMax_3 = listePrenomsFilles(ind);
prenomsFillesMax_3(91:96)='';

[~,ind] = max(filles_4);
prenomsFillesMax_4 = listePrenomsFilles(ind);
prenomsFillesMax_4(96)='';

[~,ind] = max(filles_5);
prenomsFillesMax_5 = listePrenomsFilles(ind);
prenomsFillesMax_5(96)='';

prenomsFillesMax = [prenomsFillesMax_1,prenomsFillesMax_2,prenomsFillesMax_3,prenomsFillesMax_4,prenomsFillesMax_5];

%% Rendu sous forme de carte
[~, centreDpt, dpt] = initDpt;
for i=1:5
    figure(i);
    carteDpt2(centreDpt, dpt,prenomsGarconsMax(:,i),prenomsFillesMax(:,i));
end