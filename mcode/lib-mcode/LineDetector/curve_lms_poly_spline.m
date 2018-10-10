% Dado Una imagen binaria calcula un conjunto de polinomios con menor error LMS, 
% por tramos usando polinomios de grado L dividiento la curva en partes de tamanho STEP. retorna 
% dos vectores optimos XOPT e YOPT.
        function [XOPT YOPT] = curve_lms_poly_spline(IMG_BIN,L,STEP)

            XOPT=0; 
            YOPT=0;
            NCOL=size(IMG_BIN,2);

            if(STEP<=0)
                STEP=1;
            end

            %% obtenndo unos (XS,YS)
            [YS,XS] = find(IMG_BIN);

            %% obtend pesos de uns WS
            C = Cumulus(IMG_BIN);
            [MAP ID WID]= C.calculate_cumulus();
            MAXWID=max(WID(2:end));
            WS=zeros(size(XS));
            N=length(WS);
            for II=1:N
                WS(II)=WID(MAP(YS(II),XS(II))+1)/MAXWID;
            endfor

            
            col_init=1;
            col_end=1;
            FIRSTBLOCK=1;
            while col_end< NCOL


                %% escolhendo intervalo de analisis
                col_end=col_init+STEP-1;
                if(col_end>NCOL)
                    col_end=NCOL;
                end

                %% que pnts pertencem ao intervalo
                id=find( (XS>=col_init) & (XS<=col_end) );

                %% Agrego 1/4 de los puntos obtenidos en el tramo anterior
                X=XS(id); Y=YS(id); W=WS(id);
                if (FIRSTBLOCK~=1)
                    T=round((DATX(end)-DATX(1)+1)/4);
                    if T==0
                        T=1;
                    end
                    
                    for II=1:T
                    X(end+1)=DATX(end-II+1);
                    Y(end+1)=DATY(end-II+1);
                    W(end+1)=1.0;
                    endfor
                endif

                %% si existem pontos no intervalo
                if((length(id)>(L+1))&&((max(X)-min(X)+1)>=(L+1)))

                    %% calculo  erro quaratico medio
                    [DATX DATY a OFFSETX FACTORX]=calculates_lms_poly(X,Y,W,L,[col_init:col_end]);                    

                    %% Agrupo los rsultaos
                    if (FIRSTBLOCK==1)
                        XOPT=[DATX];
                        YOPT=[DATY];
                        FIRSTBLOCK=0;
                    else
                        XOPT=[XOPT; DATX];
                        YOPT=[YOPT; DATY];
                    end
                else
                    warning([   'Quantity of elements in the part (' ...
                                num2str(col_init) ',' num2str(col_end) ...
                                ') is too low, the minimum is ' ...
                                num2str(L+2) ...
                                '. You need change the number of parts with the method:' ...
                                ' set_reconstruction_parts(' num2str(abs(round(NCOL/STEP)-1)) ');']);
                end

                %% passo al siguint eintrvalo
                col_init=col_end+1;
            end


            YMAX=size(IMG_BIN,1);
            id=find(YOPT>YMAX);
            YOPT(id)=0*id+YMAX;


            id=find(YOPT<1);
            YOPT(id)=0*id+1;
        
        end

function imagesc_part(a,OFFSETX,FACTORX,col_init,col_end,IMG_BIN)


    REALX=[col_init:col_end];

    X=(REALX-OFFSETX)/FACTORX;

    disp(['Y(' num2str(col_init) ',' num2str(col_end) ') value: ' mat2str(polyval(a,X))])
    disp('')

    figure;
    imagesc(IMG_BIN)
    hold on
        plot(REALX,polyval(a,X),'-s');
    hold off
    %colormap(gray)

endfunction

% Dado Un grupo de puntos X e Y calcula el polinomio con menor error LMS, usando
% un polinomio de grado L, retorna dos cetores optimos XOPT e YOPT,
%   Si existe 4to parametro XOPT es igual al 4to parametro.
%   Si no existe 4to parametro XOPT=[min(X):max(X)]';
        function [XOPT YOPT a OFFSETX FACTORX]=calculates_lms_poly(REALX,Y,W,L,varargin)


    


            if(nargin>3)
                XOPT=varargin{1};
                if(size(XOPT,1)<size(XOPT,2))
                    XOPT=XOPT';
                end
            else
                XOPT=[min(REALX):max(REALX)]';
            end

            OFFSETX= min(XOPT)-1;
            FACTORX=(max(XOPT)-OFFSETX);


            XOPT=(XOPT -OFFSETX)/FACTORX;
            X   =(REALX-OFFSETX)/FACTORX;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            N=length(X);

            P=ones(N,1);
            for lid=1:L
               P=[ X.^lid P];
            end
        
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            WW=diag(W.^2);

            a=inv(P'*WW*P)*P'*WW*Y;

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            YOPT=polyval(a,XOPT);

            XOPT=XOPT*FACTORX+OFFSETX;
        end
