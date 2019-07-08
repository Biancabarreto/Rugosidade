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

OUTPUTDIR='output3dpoint';
outdatafile=fullfile(OUTPUTDIR,'dataxyz.dat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
R = PointsDetector(IMG_REF);      %% Crio um line detector R
figure(1);
[XREF YREF P]=R.calculates_line_ref_automatically([1:size(IMG_REF,2)],true);
print(gcf,fullfile(OUTPUTDIR,'img_ref.png'),'-dpng');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% STEP 3

for II=(INITN+[0:(N-1)])

    fprintf(stdout,'\nWorking file:%s\n',imagefilename{II-INITN+1});

    R = PointsDetector(IMG_OBJ{II-INITN+1});      %% Crio um line detector R
    R.set_reconstruction_cumulus_on(true);
    R.set_reconstruction_umbral(32);

    figure(2);
    [X Z]=R.calculates_points();
    print(gcf,fullfile(OUTPUTDIR,['img_' num2str(II) '.png']),'-dpng');

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

    DATAPART=[X',Y',Z'-polyval(P,X')];
    datafile=fullfile(OUTPUTDIR,['dataxyz' num2str(II) '.dat']);
    fprintf(stdout,'\nSaving DATA in:%s\n',datafile);
    save ('-ascii',datafile, 'DATAPART');
    fprintf(stdout,'DATA saved [OK]\n',datafile);

end

fprintf(stdout,'\nSaving DATA in:%s\n',outdatafile);
DATA=[XX,YY,ZZ];
save ('-ascii',outdatafile, 'DATA');
fprintf(stdout,'DATA saved [OK]\n',outdatafile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% dados :
%% outdatafile
%% OUTPUTDIR
DATA=load(outdatafile);

xi =[min(DATA(:,1)):max(DATA(:,1))];
yi =[min(DATA(:,2)):max(DATA(:,2))];
[xxi, yyi] = meshgrid ( xi,yi);
zzi = griddata(DATA(:,1), DATA(:,2), DATA(:,3), xxi, yyi);

figure(1)
mesh(xxi,yyi,zzi)
print(gcf,fullfile(OUTPUTDIR,['img_all_mesh.png']),'-dpng');

figure(2)
scatter3(DATA(:,1), DATA(:,2), DATA(:,3))
print(gcf,fullfile(OUTPUTDIR,['img_all_scatter3.png']),'-dpng');

