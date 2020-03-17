%
clear all
addpath(genpath('mfiles'))

FILE_DIR='../mcode/output3dpoint/';
FILENAME='dataxyz.dat';
OUTPUTDIR='output';
FATOR=[5.0/150 1 0.1];
D=1.5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DATARAW=load(fullfile(FILE_DIR,FILENAME));
DATA=DATARAW.*FATOR;


LINE=func_separar_linha(DATA);
M=length(LINE);

RUGOSIDADE=cell(size(LINE));
T=0;

for LIN=1:M
    fprintf(stdout,"*** Analizing line %5d of %d\n",LIN,M);
    L=size(LINE{LIN},1);
    RUGOSIDADE{LIN}=zeros(L,1);
    tic
    for COL=1:L

        POINTS=func_find_points(LINE,LIN,COL,D);
        %POINTS=func_find_points_2(LINE,LIN,COL,D);

        if size(POINTS,1)==0
            printf(stdout,'POINTS size 0\n');
        endif

        PLANE=func_get_plane(POINTS);
        Pa=LINE{LIN}(COL,:);

        %plot_points(POINTS,Pa,PLANE); refresh();
        %input('******************************')

        RUGOSIDADE{LIN}(COL)=func_dist_with_plane(Pa,PLANE);
    endfor

    NT=toc;
    if(LIN==1)
        T=NT;
    else
        T=(T+NT)/2;
    endif
    fprintf(stdout,"Process time:%6.2f mins\n",NT/60.0);
    fprintf(stdout,"Remaining time: %6.2f mins\n",T*(M-LIN)/60.0);

endfor
fprintf(stdout,"\n");

RR=RUGOSIDADE{1};
for LIN=2:M
    RR=[RR;RUGOSIDADE{LIN}];
endfor

mkdir(OUTPUTDIR);
outdatafile=fullfile(OUTPUTDIR,'rugosidade.dat');

plot_teste_multiple([DATA(:,1) DATA(:,2) RR],OUTPUTDIR,FATOR)
save('-ascii',outdatafile,'RR');

SUM=mean(RR)
