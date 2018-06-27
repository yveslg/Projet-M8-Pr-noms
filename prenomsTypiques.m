clearvars
load prenoms1992-2016.mat
[listeDpt, centreDpt, dpt] = initDpt;
%% Première version - Le prénom a été donné le plus dans ce département
clear typique* frequence*
[typiqueG,frequenceG] = prenomTypiqueV1 (garcons_5,listePrenomsGarcons);
[typiqueF,frequenceF] = prenomTypiqueV1 (filles_5,listePrenomsFilles);
prTypiqueV1 = [typiqueG,typiqueF];
freq1 = [frequenceG, frequenceF];
mean(freq1)
figure(11);
carteDpt(listeDpt, centreDpt, dpt,prTypiqueV1(:,1),freq1(:,1));
figure(12);
carteDpt(listeDpt, centreDpt, dpt,prTypiqueV1(:,2),freq1(:,2));
clear typique* frequence*

%% Deuxième version - Le prénom a été donné à 50% dans ce département
clear typique* frequence*
[typiqueG,frequenceG] = prenomTypiqueV2 (garcons_5,listePrenomsGarcons,50);
[typiqueF,frequenceF] = prenomTypiqueV2 (filles_5,listePrenomsFilles,50);
prTypiqueV2 = [typiqueG,typiqueF];
freq2 = [frequenceG,frequenceF];
mean(freq2)
figure(2);
carteDpt(listeDpt, centreDpt, dpt,prTypiqueV2(:,1),freq2(:,1));
clear typique* frequence*

%% Troisième version - Le prénom a été donné 2 fois plus dans ce département que dans les autres
clear typique* frequence*
[typiqueG,frequenceG] = prenomTypiqueV3 (garcons_5,listePrenomsGarcons,2);
[typiqueF,frequenceF] = prenomTypiqueV3 (filles_5,listePrenomsFilles,2);
prTypiqueV3 = [typiqueG,typiqueF];
freq3 = [frequenceG,frequenceF];
mean(freq3)
figure(31);
carteDpt(listeDpt, centreDpt, dpt,prTypiqueV3(:,1),freq3(:,1));
figure(32);
carteDpt(listeDpt, centreDpt, dpt,prTypiqueV3(:,2),freq3(:,2));
clear typique* frequence*

%% Quatrième version - Le prénom a été donné 2 fois plus dans ce département que la moyenne nationale
clear typique* frequence*
[typiqueG,frequenceG] = prenomTypiqueV4 (garcons_5,listePrenomsGarcons,2);
[typiqueF,frequenceF] = prenomTypiqueV4 (filles_5,listePrenomsFilles,2);
prTypiqueV4 = [typiqueG,typiqueF];
freq4 = [frequenceG,frequenceF];
mean(freq4)
figure(41);
carteDpt(listeDpt, centreDpt, dpt,prTypiqueV4(:,1),freq4(:,1));
figure(42);
carteDpt(listeDpt, centreDpt, dpt,prTypiqueV4(:,2),freq4(:,2));
clear typique* frequence*
