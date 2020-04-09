%
clear all
close all

DAT.LINEWIDTH=2;
DAT.MARKERSIZE=5;
DAT.FONTSIZE=12;

OUTPUTDIR='output'

ENABLE_PLOT_INTERPOLATE=false;

addpath(genpath('lib-mcode/variograma'))

[fname, fpath, fltidx] = uigetfile ({'*.dat','Select *.dat files with curves'},'MultiSelect','on');

N=length(fname);
VARS=cell(N,1);
LEN_VARS=zeros(N,1);

mkdir(OUTPUTDIR);

for II=1:N
    DATOS=load(fullfile(fpath,fname{II}));
    X=DATOS(:,1);
    Z=DATOS(:,3);


    XX=[min(X):1:max(X)];
    ZZ = interp1 (X,Z,XX);

    if(ENABLE_PLOT_INTERPOLATE==true)
        figure(1)
	plot_interpolate_lines(X,Z,XX,ZZ,II,fname,OUTPUTDIR,DAT);
    endif

    [V DIFF]=funcvariograma(ZZ);
    VARS{II}=V;
    
    LEN_VARS(II)=length(V);

    fprintf(stdout,"Working sample:%4d of %4d\r",II,N);
end
disp('');


MALL=min(LEN_VARS);
M=round(MALL/3); %%% quanto vou a variacionar 1/3 del ancho de la foto
VARS_MAT=zeros(N,M);
for II=1:N
    VARS_MAT(II,:)=VARS{II}(1:M);
endfor


figure
plot_variogram_curves(VARS_MAT,OUTPUTDIR,DAT);


[curves1, curves2, IDG,c1,c2]=func_kmeans2(VARS_MAT);

figure
plot_2_curve_blocks(curves1,curves2,c1,c2,OUTPUTDIR,DAT);

Vvalue=mean(max(VARS_MAT))
save (fullfile(OUTPUTDIR,'Vvalue.txt'), "Vvalue")

