%
classdef PointsDetector  < handle
    properties
        IMG_BIN

        CUMULUSON
        UMBRAL
    end


    methods (Access = public)
        %%%%%%%%%%%%%%%%%%%%%% CONSTRUCTOR %%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor carrega IMG e cria IMG_BIN desde IMG
        function obj = PointsDetector(IMG_BIN)

            obj.IMG_BIN=IMG_BIN;

            %% gaussian blur para eliminar cumuls pequenhos
            %obj.IMG_BIN = imsmooth(1.0*obj.IMG_BIN,'Gaussian',1.1);
            obj.IMG_BIN=(obj.IMG_BIN>0.5);

            %% Spline reconstruction
            obj.CUMULUSON=true;

            %% Spline reconstruction

            obj.UMBRAL=32;

        end

        %% Calcula la curva provocada por el objeto
        function [XOPT YOPT]=calculates_points(obj,CUMULUSON=false)
            

            [XS YS WS IMG_BIN_TEMP MAP ID WID]=obj.private_function(CUMULUSON);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            L=size(IMG_BIN_TEMP,2);
            
            JJ=1;
            XOPT=0; YOPT=0;
            for II=1:L
                IDV=MAP(:,II);
                WV =WID(IDV+1)';

                TMP=WV(IDV>0);
                if(length(TMP)>0)
                    WMAX=max(TMP);
                    if(WMAX>obj.UMBRAL)
                        LINPOS=obj.get_lin_pos(WV,WMAX);
                        if JJ==1
                            XOPT=II; 
                            YOPT=LINPOS;
                        else
                            XOPT=[XOPT,II]; 
                            YOPT=[YOPT,LINPOS];
                        end
                        JJ=JJ+1;
                    end
                end
            endfor

            imagesc(IMG_BIN_TEMP);
            colormap(gray);
            daspect([1 1 1])
            hold on;
            plot(XOPT,YOPT,'-o');%,'-o');
            hold off;
        end

        %% Intenta deduzir uma linha reta desde pontos isolados
        %% XREF == EIXO X COMLETO desde 1
        function [XREF YREF PP]=calculates_line_ref_automatically(obj,XX,CUMULUSON=false)

            [XS YS WS IMG_BIN_TEMP]=obj.private_function(CUMULUSON);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            At=[XS,ones(size(XS))];
            WW=diag(WS);
            PP=inv(At'*WW*At+0.00001*eye(2))*At'*WW*YS;
            
            XREF=XX;
            YREF=polyval(PP,XREF);


            imagesc(IMG_BIN_TEMP);
            colormap(gray);
            daspect([1 1 1])
            hold on;
            plot(XREF,YREF);%,'-o');
            hold off;

        end




        %%%%%%%%%%%%%%%%%%%%%% SET %%%%%%%%%%%%%%%%%%%%%%%%%
        %% Establee 
        function set_reconstruction_cumulus_on(obj,CUMULUSON)
            obj.CUMULUSON=CUMULUSON;
        end

        %%%%%%%%%%%%%%%%%%%%%% SET %%%%%%%%%%%%%%%%%%%%%%%%%
        %% Establee 
        function set_reconstruction_umbral(obj,UMBRAL)
            obj.UMBRAL=UMBRAL;
        end


        %%%%%%%%%%%%%%%%%%%%%% GET %%%%%%%%%%%%%%%%%%%%%%%%%
        %% retorna el 
        function CUMULUSON=get_reconstruction_cumulus_on(obj)
            CUMULUSON=obj.CUMULUSON;
        end

        %%%%%%%%%%%%%%%%%%%%%% GET %%%%%%%%%%%%%%%%%%%%%%%%%
        %% retorna el 
        function UMBRAL=get_reconstruction_umbral(obj)
            UMBRAL=obj.UMBRAL;
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function LINPOS=get_lin_pos(obj,WV,WMAX)
            
            
            LINPOS=0;
            N=0;
            for II=1:length(WV)
                if(WV(II)==WMAX)
                    LINPOS=LINPOS+II;
                    N=N+1;
                endif
            endfor
            if(N>0)
                LINPOS=round(LINPOS/N);
            endif            
            %%disp('ok');
        endfunction
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function [XS YS WS IMG_BIN_TEMP MAP ID WID]=private_function(obj,CUMULUSON=false)
            XOPT=0; 
            YOPT=0;

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% obtenndo unos (XS,YS), todos os pixels brancos
            %% retorna um vetor coluna para XS e YS.
            disp('Obtendo unos (XS,YS) ...');
            [YS,XS] = find(obj.IMG_BIN);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            NUM_OF_POINTS=sum(sum(obj.IMG_BIN));

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Obtendo pesos de uns WS, 
            %% o peso de todos os pixels brancos.
            %% retorna um vetor coluna para WS.
            WS=zeros(size(XS));
            N=length(WS);
            if(CUMULUSON==true)
                disp('Obtendo cumulos (WS) ...');
                C = Cumulus(obj.IMG_BIN);

                %% MAP: É o mapa de com o ID para cada pixel.
                %% ID : É a lista de ID=[0 1 2 ID_MAX] %% cumulos formados por 0s tienen ID=0.
                %% WID: É o peso que tem cada ID.
                [MAP ID WID]= C.calculate_cumulus();
                MAXWID=max(WID(2:end));
                for II=1:N
                    WS(II)=WID(MAP(YS(II),XS(II))+1);
                endfor
            else
                for II=1:N
                    WS(II)=NUM_OF_POINTS;
                endfor
            end

            fprintf(stdout,'\n');

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Eliminar elementos con valor de cumulos menor 
            %% a un valor.
            POS=find(WS>=obj.UMBRAL);
            XS=XS(POS);
            YS=YS(POS);
            WS=WS(POS);

            if(length(XS)<obj.UMBRAL)
                error('Number of points it is too low.');
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            IMG_BIN_TEMP=zeros(size(obj.IMG_BIN));
            for II=1:length(XS)
                IMG_BIN_TEMP(YS(II),XS(II))=1;
            endfor
        end

    end

end
