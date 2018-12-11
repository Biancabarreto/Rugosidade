%
pkg load image
clear all
close all
addpath(genpath('lib-mcode'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Só modifica aquí
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

IMAGEPATH='../images/8 bits/4cd.bmp';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% STEP 0
IMG = imread(IMAGEPATH);

if(length(size(IMG))==3)
    error('The image should be a binary image. The image has > 1 layers');
endif

IMG = IMG/max(max(IMG));
if(max(max(IMG))>1)
    error('The image should be a binary image. max pixel value > 1');
endif

if(min(min(IMG))<0)
    error('The image should be a binary image. max pixel value <0');
endif

IMG_BIN=IMG>0.5;

%% STEP 1
R = LineDetector(IMG_BIN);

%% STEP 2
R.set_reconstruction_parts(14);
R.set_reconstruction_level(0);
[X Y]=R.calculates_curve();

%% STEP 3 (FINAL)
[XREF YREF]=R.calculates_curve_ref(X);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
msgbox ('End');
plot_all_results(IMAGEPATH,IMG_BIN,XREF,YREF,X,Y);
