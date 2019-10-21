%
pkg load image
clear all
close all
addpath(genpath('lib-mcode'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Só modifica aquí
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ENDN=77;
INITN=0;
REFIMAGE='0a.bmp';
DIRIMAGES='../images/test';

OUTPUTDIR='output3d';
outdatafile=fullfile(OUTPUTDIR,'dataxyz.dat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mkdir(OUTPUTDIR);
N=ENDN-INITN+1;
IMG_REF = imread(fullfile(DIRIMAGES,REFIMAGE));
IMG_REF =function_check_binary_image(IMG_REF);

for II=(INITN+[0:(N-1)])
    imagefilename{II-INITN+1}=fullfile(DIRIMAGES,[ num2str(II) '.bmp']);
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
    R.set_reconstruction_parts(12); %% Estabelecer em quantas partes será reconstruido
    R.set_reconstruction_level(0);  %% Estabelecer o nivel de reconstrução
    R.set_reconstruction_umbral(32); %% para aceptar cumulos

    figure;
    [X Z]=R.calculates_curve();     %% detetar pontos da curva
    if(min(Z)<1)
        error('ERROR obtaining the curve. min(Z)<1');
    endif
    if(max(Z)>size(IMG_REF,1))
        error('ERROR obtaining the curve. min(Z)>size(IMG_OBJ,1)');
    endif

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
    datafile=fullfile(OUTPUTDIR,['dataxyz' num2str(II) '.dat']);
    fprintf(stdout,'\nSaving DATA in:%s\n',datafile);
    save ('-ascii',datafile, 'DATAPART');
    fprintf(stdout,'DATA saved [OK]\n',datafile);

    close all;
end

for II=[INITN:ENDN]
    datafile=fullfile(OUTPUTDIR,['dataxyz' num2str(II) '.dat']);
    if(II==INITN)
        DATA=load(datafile);
    else
        DATA=[DATA;load(datafile)];
    endif
endfor

save ('-ascii',outdatafile, 'DATA');
fprintf(stdout,'DATA saved [OK]\n',outdatafile);

close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% dados :
%% outdatafile
%% OUTPUTDIR
DATA=load(outdatafile);

FATOR=[5.0/150 5/10 0.1];
plot_teste_multiple(DATA,OUTPUTDIR,FATOR);
