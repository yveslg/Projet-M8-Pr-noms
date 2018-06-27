function [listeDpt, centreDpt, dpt] = initDpt

warning('off','all');
listeDpt=['01';'02';'03';'04';'05';'06';'07';'08';'09';'10';...
          '11';'12';'13';'14';'15';'16';'17';'18';'19';'2A';...
          '21';'22';'23';'24';'25';'26';'27';'28';'29';'30';...
          '31';'32';'33';'34';'35';'36';'37';'38';'39';'40';...
          '41';'42';'43';'44';'45';'46';'47';'48';'49';'50';...
          '51';'52';'53';'54';'55';'56';'57';'58';'59';'60';...
          '61';'62';'63';'64';'65';'66';'67';'68';'69';'70';...
          '71';'72';'73';'74';'75';'76';'77';'78';'79';'80';...
          '81';'82';'83';'84';'85';'86';'87';'88';'89';'90';...
          '91';'92';'93';'94';'95']; %pour être identique à code_insee

bbox = [-4   41.5 ; 9.5 51]; %France Métropolitaine + Corse
dpt = shaperead('dptFr','BoundingBox',bbox);

% réalignement départements - indices
% correction pour la Corse (2A et 2B, classé après 29))
corseA = dpt(29);
corseB = dpt(30);
dpt(21:29) = dpt(20:28,:);
dpt(20) = corseA;
dpt(30:95) = dpt(31:96);
dpt(96) = corseB;

% calcul du centre de chaque département pour placer le prénom
centreDpt = zeros(95,2); %preallocating, coordonnées x,y du centre de chaque département
for i=1:96
    [centreDpt(i,1),centreDpt(i,2)] = centroid(polyshape(dpt(i).X,dpt(i).Y));  
end
centreDpt(20,:) = mean([centreDpt(20,:);centreDpt(96,:)]); %centre Corse
centreDpt(96,:) = [];

% agrandissement de la région Île-de-France
% dptIDF = [75 77 78 91 92 93 94 95]';
% for i=1:length(dptIDF)
%     dpt(dptIDF(i)).X = dpt(dptIDF(i)).X+5;
%     dpt(dptIDF(i)).Y = dpt(dptIDF(i)).Y*3;
%     centre(i,1) = (min(dpt(dptIDF(i)).X)+max(dpt(dptIDF(i)).X))/2;
%     centre(i,2) = (min(dpt(dptIDF(i)).Y)+max(dpt(dptIDF(i)).Y))/2;
%end

% recentrage Paris
%     diff75 = centre(1,:)-centreDpt(i,:);
%     dpt(dptIDF(1)).X = dpt(dptIDF(1)).X-diff75(1);
%     dpt(dptIDF(1)).Y = dpt(dptIDF(1)).Y-diff75(2);
%     
% % calcul du décalage des autres départements par rapport à Paris
% for i=2:length(dptIDF)
%    decalage = centreDpt(dptIDF(i,:))-centreDpt(75,:);
%    dpt(dptIDF(i)).X = dpt(dptIDF(i)).X-diff75(1)-3*decalage(1);
%    dpt(dptIDF(i)).Y = dpt(dptIDF(i)).Y-diff75(2)-3*decalage(2);
% end    

    
% calcul des nouvelles BoundingBox
% for i=1:length(dptIDF)
%     dpt(dptIDF(i)).BoundingBox = [min(dpt(dptIDF(i)).X),min(dpt(dptIDF(i)).Y);...
%                                 max(dpt(dptIDF(i)).X),max(dpt(dptIDF(i)).Y)];
% end
end