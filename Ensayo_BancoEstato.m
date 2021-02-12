%En primer lugar hay que definir las constantes que queremos introducir
%como R,el di�metro de la tuberia y esas cosas.

clear all 

Dtub = 76.2*10^-3 %m
Rtub6 =Dtub
Atub6 = pi*(Rtub6)^2
Atub = pi*(Dtub/2)^2
R = 287 %J/(Kg*K)
Mu = 170*10^-7 %(Pa*s)
Ka= 0.024 %W/(m*K)
Tdep= 300
Pdep=120
Cte = 0.6847 %corresponde con la funci�n de gamma 1,4
i=0

T=75
vGasto = zeros(T,1)
% vM_valvula = zeros(T,1)
%

Datos = xlsread('10_02_21'); %Aqui meteremos los datos de nuestro ensayo,en este caso coge los valores del excel de ejemplo de un antiguo ensayo
[m,n]=size(Datos);

%Datos (asociar los valores a las columnas)

PT02 = Datos(:,3);
PT04 = Datos(:,21);
PT13 = Datos(:,11);
PT14 = Datos(:,12);
PT07 = Datos(:,9);
PT22 = Datos(:,13);
PT26 = Datos(:,17);
TT02 = Datos(:,26);
TT22 = Datos(:,25);
PT30 = Datos(:,18);
TT04 = Datos(:,24);
TT08 = Datos(:,27);
TT09 = Datos(:,28);

%% relaci�n Gasto con la presi�n de consigna-caso ideal 
for Pvalvula=1:1:75 %Ser�a la correspondiente a PT04
    i=i+1;
     Gasto = (Pvalvula*Atub*Cte)/sqrt(R*Tdep)*10^5; %En el caso de que estuviese bloqueada
     
     vGasto(i)= vGasto(i) + Gasto;

    end
        
plot(vGasto,[1:1:75])
grid on
title(['Gasto en funci�n de Pconsigna']) 
ylabel('P_{consigna} (bar)')
xlabel('Gasto')
      
close all
%%

W=8
M_valvula = zeros(W,1)
M3 = zeros(W,1)
M6p = zeros(W,1)
d_star_=zeros(W,1)
% PresionMP1= zeros(W,1)
% PT02=zeros(W,1)
% PT0=zeros(W,1)
M_salida_tobera2=zeros(W,1)
% M_despuesMP = zeros(W,1)
d_star= zeros(W,1)
% vPT04es=zeros(W,1)
n=0
PT02es_=zeros(W,1)
for j=398:1:405

 n=n+1;
fprintf('--------DEPOSITO----------') 
 PT02es= Datos(j,3);
 PT02es_(n)= PT02es_(n) + PT02es
 TT02es= Datos(j,26)+273;
 
 %Toma de datos en la v�lvula
 
fprintf('---DETRAS CAUDALIMETRO Y ANTES DE CODO---') %metemos la caida de presi�n de la v�lvula
 PT04es= Datos(j,21);
 TT04es= Datos(j,24)+273;
 
 
fprintf('---------DETRAS DOS CODOS, ANTES DE LAS 6 PULGADAS--------') %metemos la caida de presi�n de la v�lvula y de los codos
 PT13es= Datos(j,11);
 TT08es= Datos(j,27)+273;
 
fprintf('----DETRAS CODO, ANTES MEDIO POROSO, YA 6 PULGADAS') %metemos caida de presion de la v�lvula y de los dos codos   
 PT26es= Datos(j,12);
 TT22es= Datos(j,25)+273; %temperatura antes tobera

fprintf('----DETRAS MEDIO POROSO Y DELANTE DE LA BRIDA DE LA TOBERA----') %metemos caida de presion de la v�lvula y de los dos codos
 PT22es= Datos(j,13); %remanso antes tobera
 PT30es = Datos(j,18); %est�tica antes tobera (NO MIDE VALORES BUENOS) 



 %% N�mero de Mach detras de la v�lvula (3 pulgadas)
  caida_valvula=0.17;%caida Premanso en la valvula
     rP1=PT02es*(1-caida_valvula)/PT04es  %%La presi�n de remanso hace referencia a la Presi�n de la v�lvula en estacionario
     salida=compressible(rP1,1,'P',1.4); 
     M1=salida(1)
     M_valvula(n)= salida(1)



%% N�mero de Mach detr�s de los dos codos (3 pulgadas)
% caida_codo=0.1 %ejemplo
%      rP2=PT02es*(1-caida_valvula)*(1-2*caida_codo)/PT13es  
%      salida=compressible(rP2,1,'P',1.4); 
%      M2=salida(1)
%      M_antes6p(n)= salida(1)
     
     
%% N�mero de Mach detr�s del medio poroso (6 pulgadas)
%Introducimos Darcy

%PT_0= 5*10^5  % seria PT26 + PT14 (din�mica+est�tica)

%Gasto1 = (PT_0*Atub6*Cte)/sqrt(R*(TT09es))

%L=3*10^-3 %longitud medio poroso
%Presion_tras_MP=sqrt(((PT14es*10^5)^2)-((2*Mu*L*R*(TT09es)*Gasto1)/(pi*Rtub6^2*Ka))) %presi�n estatica a la salida de medio poroso

 %    PT_01=1*10^5 % ser�a PT30es+PresionMP1 (dinamica+estatica)
  %   rP3=(PT_01)/Presion_tras_MP %nos falta medio la PT02
   %  salida=compressible(rP3,1,'P',1.4); 
   % M3=salida(1)
    % M_despuesMP(n)= salida(1)
     
%% Secci�n subs�nica delante de la tobera 


 rP4=PT22es/PT30es; %como PT30 no mide valores buenos los resultados no son correctos
 salida=compressible(rP4,1,'P',1.4);
 M3=salida(1)
 M6p(n)= salida(1)
 rA=salida(end)
 A_star=Atub6/rA % en m2
 d_star=sqrt(A_star*4/pi) % en m
 d_star_(n) = d_star_(n) + d_star;
 
 
  Gasto = ((PT22es*Atub6)/sqrt(R*(TT22es)))*(sqrt(1.4).*M6p.*(1+(0.2*M6p.^2)).^((-2.4)/0.8)) * 10^5 %Para tener Kg/s
  Gasto_bloq = ((PT22es*Atub6)/sqrt(R*(TT22es))) * 10^5;
  

%% Secci�n de salida de la tobera
    d_garganta_tobera=0.07 %m
    d_salida_tobera=0.14; % m
    
    
    As=pi*(d_salida_tobera)^2/4; % Area salida tobera en mm2
    A_salida=As/A_star;
    if d_star<d_garganta_tobera
        salida=compressible(A_salida,1,'AB',1.4); %si la d0 es menos significa que ya se ha alcanzado el bloqueo y por lo tanto a la salida de la tobera el flujo va a ser subsonico.
    else
        salida=compressible(A_salida,1,'AA',1.4); %si la d0 es mayor significa que el flujo aun es subsonico por lo que se blooqueara en la tobera y el flujo a la salida sera supersonico con sus correspondientes ondas de choque o expansion.
    end
%     cprintf('------------------------')
    M_salida_tobera(n) = salida(1)
end






