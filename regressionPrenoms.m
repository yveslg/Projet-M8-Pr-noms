clearvars;
load dataINSEE;
load prenoms1992-2016.mat;
libelle(1:2) = []; %code + nom dpt
libelle([1:2,5,12]) = []; %variables supprimées au cours du projet
data(:,[1:2,5,12]) = [];
%% Statistiques rapides sur les données
[vmin,indmin] = min(data);
[vmax,indmax] = max(data);
statData = [vmin' indmin' mean(data)' median(data)' vmax' indmax'];
statDataDpt = [dpt.Libell(indmin) dpt.Libell(indmax)];

%% Calcul des fréquences des prénoms par département
garcons = garcons_5./sum(garcons_5,1)*1000;
filles = filles_5./sum(filles_5,1)*1000;
% nombre de départements dans lesquels un prénom n'a pas été donné
[indG,~] = find(garcons==0);
[indF,~] = find(filles==0);
indG = sort(indG);
indF = sort(indF);
[indGu,nbIndG] = unique(indG,'last');
[indFu,nbIndF] = unique(indF,'last');
nbIndG = [0;nbIndG];
nbIndF = [0;nbIndF];
nbIndG0 = zeros(length(nbIndG)-1,1);
nbIndF0 = zeros(length(nbIndF)-1,1);
for i=2:length(nbIndG)
   nbIndG0(i-1) = nbIndG(i) - nbIndG(i-1); 
end
for i=2:length(nbIndF)
   nbIndF0(i-1) = nbIndF(i) - nbIndF(i-1); 
end  

indPrG = find(nbIndG0>20);
indPrF = find(nbIndF0>20); %prénoms qui n'ont pas été donnés dans plus de 20 départements

indPrG = indGu(indPrG); % on récupère les indices du tableau complet
indPrF = indFu(indPrF);

garcons(indPrG,:) = [];
filles(indPrF,:) = [];

%et la liste des prénoms correspondants
prG = listePrenomsGarcons(setdiff(1:size(listePrenomsGarcons),indPrG)); 
prF = listePrenomsFilles(setdiff(1:size(listePrenomsFilles),indPrF));

%% Régression garçons
nbPrG = size(prG,1);
alpha = zeros(2,nbPrG);
%e = zeros(95,nbPrG);
R2 = zeros(nbPrG,1);
maxR2 = zeros(33,1);
ind = zeros(33,1);
alphaG = zeros(33,2);


for j=1:length(libelle)
    for i=1:nbPrG
        clear e;
        [dpt0]=find(garcons(i,:)==0); %départements qui n'ont pas donné ce prénom
        y = garcons(i,setdiff(1:95,dpt0))';
        X = [ones(length(setdiff(1:95,dpt0)),1) data(setdiff(1:95,dpt0),j)];
        alpha(:,i) = (X'*X)\(X'*y);
        e(:,i) = y-X*alpha(:,i);
        R2(i) = 1 - e(:,i)'*e(:,i)/sum((y-mean(y)).^2);
    end
    [maxR2(j),ind(j)] = max(R2);
    alphaG(j,:) = alpha(:,ind(j))';
    prG_reg(j,1) = prG(ind(j));
end


%% Graphes régression garçons (si R2>0.45)
for j=1:length(libelle)
    if maxR2(j)>0.45
        figure(j);
        plot(data(:,j),garcons(ind(j),1:95),'o');hold on
        plot(data(:,j),[ones(95,1) data(:,j)]*alphaG(j,:)','g-');
        xc = (min(data(:,j))+max(data(:,j)))/2;
        yc = max(garcons(ind(j),1:95));
        tx = text(xc,yc,'R2 = '+string(maxR2(j)));
        tx.HorizontalAlignment = 'center';
        xlabel(libelle(j));
        ylabel('Fréquence du prénom '+string(prG_reg(j))+' dans le département (‰)');
        hold off
    end
end

%% Régression filles
nbPrF = size(prF,1);
alpha = zeros(2,nbPrF);
R2 = zeros(nbPrF,1);
maxR2 = zeros(33,1);
ind = zeros(33,1);
alphaF = zeros(33,2);


for j=1:length(libelle)
    for i=1:nbPrF
        clear e;
        [dpt0]=find(filles(i,:)==0); %départements qui n'ont pas donné ce prénom
        y = filles(i,setdiff(1:95,dpt0))';
        X = [ones(length(setdiff(1:95,dpt0)),1) data(setdiff(1:95,dpt0),j)];
        alpha(:,i) = (X'*X)\(X'*y);
        e(:,i) = y-X*alpha(:,i);
        R2(i) = 1 - e(:,i)'*e(:,i)/sum((y-mean(y)).^2);
    end
    [maxR2(j),ind(j)] = max(R2);
    alphaF(j,:) = alpha(:,ind(j))';
    prF_reg(j,1) = prF(ind(j));
end


%% Graphes régression filles (si R2>0.45)
for j=1:length(libelle)
    if maxR2(j)>0.45
        figure(j);
        plot(data(:,j),filles(ind(j),1:95),'o');hold on
        plot(data(:,j),[ones(95,1) data(:,j)]*alphaF(j,:)','g-');
        xc = (min(data(:,j))+max(data(:,j)))/2;
        yc = max(filles(ind(j),1:95));
        tx = text(xc,yc,'R2 = '+string(maxR2(j)));
        tx.HorizontalAlignment = 'center';
        xlabel(libelle(j));
        ylabel('Fréquence du prénom '+string(prF_reg(j))+' dans le département (‰)');
        hold off
    end
end

%% régression multiple pour le prénom DIANE
[n,p] = size(data);
ind = find(listePrenomsFilles=='DIANE');
filles = filles_5(ind,:)./sum(filles_5,1)*1000;
y = filles(1:95)';
X = [data ones(95,1)];
alpha = (X'*X)\(X'*y);
e = y-X*alpha;
R2 = 1 - e'*e/sum((y-mean(y)).^2);
h = diag(X*((X'*X)\(X')));
c = h./(1-h).^2/p.*e.^2/(e'*e);
%plot(1:95,e,'o');
%plot(1:95,c,'o');
histogram(e,20);
title('Régression multiple DIANE');

%% régression multiple pour le prénom TIMOTHÉE
[~,p] = size(data);
ind = find(listePrenomsGarcons=='TIMOTHÉE');
garcons = garcons_5(ind,:)./sum(garcons_5,1)*1000;
y = garcons(1:95)';
X = [data ones(95,1)];
alpha = (X'*X)\(X'*y);
e = y-X*alpha;
R2 = 1 - e'*e/sum((y-mean(y)).^2);
h = diag(X*((X'*X)\(X')));
c = h./(1-h).^2/p.*e.^2/(e'*e);
%plot(1:95,e,'o');
%plot(1:95,c,'o');
histogram(e,20);
title('Régression multiple TIMOTHÉE');

%% Tests statistiques garçons
% Y a t'il un lien entre la fréquence du prénom 'XXX' et la variable 12;
% H0 : indépendance -> alpha(1)=0
% H1 : lien entre les deux
var = 12;	%modifiez la variable ici
ind = find(listePrenomsGarcons=='XXXX'); %modifier le prénom ici
garcons = garcons_5(ind,:)./sum(garcons_5,1)*1000; 
y = garcons(1:95)';
X = [data(:,var) ones(95,1)];
[n,p] = size(X);
alpha = (X'*X)\(X'*y);
e = y-X*alpha;
R2 = 1 - e'*e/sum((y-mean(y)).^2);
s2 = e'*e/(n-p);
x = data(:,var);
mx = mean(x);
s2x = (x-mx)'*(x-mx);
T = alpha(1)/sqrt(s2/s2x);
ddl = n-2;
pval = 2*(1-cdf('t',abs(T),ddl));
ahat = alpha(1);
[ahat R2 T pval]
plot(x,y,'o')

%% Tests statistiques filles
% Y a t'il un lien entre la fréquence du prénom 'XXXX' et la variable 12
% H0 : indépendance -> alpha(1)=0
% H1 : lien entre les deux
var = 12; %modifier la variable ici
ind = find(listePrenomsFilles=='XXXX'); %modifier le prénom ici
filles = filles_5(ind,:)./sum(filles_5,1)*1000;
y = filles(1:95)';
X = [data(:,var) ones(95,1)];
[n,p] = size(X);
alpha = (X'*X)\(X'*y);
e = y-X*alpha;
R2 = 1 - e'*e/sum((y-mean(y)).^2);
s2 = e'*e/(n-p);
x = data(:,var);
mx = mean(x);
s2x = (x-mx)'*(x-mx);
T = alpha(1)/sqrt(s2/s2x);
ddl = n-2;
pval = 2*(1-cdf('t',abs(T),ddl));
ahat = alpha(1);
[ahat R2 T pval]
plot(x,y,'o')
