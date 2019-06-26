% Dado Una imagen binaria calcula un conjunto de polinomios con menor error LMS, 
% por tramos usando polinomios de grado L dividiento la curva en partes NPARTS. retorna 
% dos vectores optimos XOPT e YOPT.
        function [XOPT YOPT] = curve_lms_poly_spline(   IMG_BIN, ...         %% Imagen binaria
                                                        %L, ...               %% polinomies order
                                                        NPARTS, ...          %% Parts of curve
                                                        CUMULUSON=false, ... %% Active cumulus algorithm 
                                                        LEVEL=1, ...         %% Level o analysis 
                                                        UMBRAL)            %% 

            XOPT=0; 
            YOPT=0;
            NCOL=size(IMG_BIN,2);



            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% obtenndo unos (XS,YS), todos os pixels brancos
            %% retorna um vetor coluna para XS e YS.
            disp('Obtendo unos (XS,YS) ...');
            [YS,XS] = find(IMG_BIN);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Obtendo pesos de uns WS, 
            %% o peso de todos os pixels brancos.
            %% retorna um vetor coluna para WS.
            WS=zeros(size(XS));
            N=length(WS);
            if(CUMULUSON==true)
                disp('Obtendo cumulos (WS) ...');
                C = Cumulus(IMG_BIN);
                [MAP ID WID]= C.calculate_cumulus();
                MAXWID=max(WID(2:end));
                for II=1:N
                    WS(II)=WID(MAP(YS(II),XS(II))+1)/MAXWID;
                endfor
            else
                for II=1:N
                    MAXWID=1.0;
                    WS(II)=1.0;
                endfor
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Elimino los cumulos pequenos
            TMP=(WS*MAXWID)>=UMBRAL;
            XS=XS(TMP);
            YS=YS(TMP);
            WS=WS(TMP);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% obtenndo polinomio P(II,:) para o intervalos XINT
            disp('Obtendo Splines 3r ordem (P,XINT) ...');
            [P XINT]=lms_splines3(XS/NCOL,YS,NPARTS,WS,LEVEL);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            plot_polinomios(IMG_BIN,P,XINT);
   
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Avaliando polinomios no intervalos
            disp('Avaliando Splines 3r ordem (P,XINT) ...');
            XOPT=[min(XS):max(XS)];
            YOPT = eval_splines(P,XINT,XOPT/NCOL);
            
            disp('Solved LMS [OK]');
        
        endfunction

        function plot_polinomios(IMG_BIN,P,XINT)
            M=size(XINT,1);
            WW=size(IMG_BIN,2);

            L=10;
            XVAR=zeros(M,L);
            YVAR=zeros(M,L);

            for II=1:M
                XVAR(II,:)=linspace( XINT(II,1),XINT(II,2),L);
                YVAR(II,:)=polyval(P(II,:),XVAR(II,:));
            endfor

            imagesc(IMG_BIN);
            colormap(gray)
            daspect([1 1 1])
            hold on;
            plot((XVAR*WW)',YVAR');%,'-o');
            hold off;
        endfunction



