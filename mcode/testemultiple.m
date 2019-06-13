%
pkg load image
clear all
close all
addpath(genpath('lib-mcode'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Só modifica aquí
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=20;
INITN=14;

OUTPUTDIR='output3d';
mkdir(OUTPUTDIR);

IMG_REF = imread('../images/placa1/0.jpg (green).bmp');
IMG_REF =function_check_binary_image(IMG_REF);

for II=(INITN+[0:(N-1)])
    imagefilename{II-INITN+1}=['../images/placa1/' num2str(II) '.jpg (green).bmp'];
    IMG_OBJ{II-INITN+1}=imread(imagefilename{II-INITN+1});
    IMG_OBJ{II-INITN+1}=function_check_binary_image(IMG_OBJ{II-INITN+1});
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
%% STEP 2
R = LineDetector(IMG_REF);      %% Crio um line detector R
figure(1);
[XREF YREF P]=R.calculates_line_ref_automatically([1:size(IMG_REF,2)],true);
print(gcf,fullfile(OUTPUTDIR,'img_ref.png'),'-dpng');



for II=(INITN+[0:(N-1)])
    
    fprintf(stdout,'\nWorking file:%s\n',imagefilename{II-INITN+1});

    R = LineDetector(IMG_OBJ{II-INITN+1});  %% Crio um line detector R
    R.set_reconstruction_parts(14); %% Estabelecer em quantas partes será reconstruido
    R.set_reconstruction_level(0);  %% Estabelecer o nivel de reconstrução
    figure;
    [X Z]=R.calculates_curve();     %% detetar pontos da curva
    Y=(II-INITN)*ones(size(X));

    if(II==INITN)
        XX=X';
        ZZ=Z'-polyval(P,X');
        YY=Y';
    else
        XX=[XX;X'];
        ZZ=[ZZ;Z'-polyval(P,X')];
        YY=[YY;Y'];
    endif
    print(gcf,fullfile(OUTPUTDIR,['img_' num2str(II) '.png']),'-dpng');

    DATAPART=[X',Y',Z'-polyval(P,X')];
    outdatafile=fullfile(OUTPUTDIR,['dataxyz' num2str(II) '.dat']);
    save ('-ascii',outdatafile, 'DATAPART');
end


DATA=[XX,YY,ZZ];
outdatafile=fullfile(OUTPUTDIR,'dataxyz.dat');
save ('-ascii',outdatafile, 'DATA');

%% datos :
%% outdatafile
%% N
DATA=load(outdatafile);

xi =[min(DATA(:,1)):max(DATA(:,1))];
yi =[min(DATA(:,2)):max(DATA(:,2))];
[xxi, yyi] = meshgrid ( xi,yi);
zzi = griddata(DATA(:,1), DATA(:,2), DATA(:,3), xxi, yyi);

figure(1)
mesh(xxi,yyi,zzi)
print(gcf,fullfile(OUTPUTDIR,['img_all_mesh.png']),'-dpng');

figure(2)
scatter3(xxi,yyi,zzi)
print(gcf,fullfile(OUTPUTDIR,['img_all_scatter3.png']),'-dpng');

