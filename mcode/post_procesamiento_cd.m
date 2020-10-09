%
pkg load image
clear all
close all
page_screen_output(0)
page_output_immediately(1)
addpath(genpath('lib-mcode'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Só modifica aquí
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DATAFILE='/home/fernando/Downloads/CD1/output3dpoint/dataxyz.dat'
OUTPUTDIR='/home/fernando/Downloads/CD1/output_postprocesamento';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mkdir(OUTPUTDIR);
DATA=load(DATAFILE);

FATOR=[5.0/150 1 0.1];
plot_teste_multiple_cd(DATA,OUTPUTDIR,FATOR,[-1,1]);

