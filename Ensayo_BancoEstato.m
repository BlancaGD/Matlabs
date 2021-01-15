%En primer lugar hay que definir las constantes que queremos introducir
%como R,el diámetro de la tuberia y esas cosas.

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
Cte = 0.6847 %corresponde con la función de gamma 1,4
i=0

T=75
vGasto = zeros(T,1)
% vM_valvula = zeros(T,1)


Datos = xlsread('20180124-1'); %Aqui meteremos los datos de nuestro ensayo,en este caso coge los valores del excel de ejemplo de un antiguo ensayo
[m,n]=size(Datos);

%Datos (asociar los valores a las columnas)

PT02 = Datos(:,2);
PT04 = Datos(:,3);
TT04 = Datos(:,4);
TT08 = Datos(:,5);
TT09 = Datos(:,6);
PT13 = Datos(:,7);
PT14 = Datos(:,8);
PT07 = Datos(:,9);
TT02 = Datos(:,10);

%% relación Gasto con la presión de consigna-caso ideal 
for Pvalvula=1:1:75 %Sería la correspondiente a PT04
    i=i+1;
     Gasto = (Pvalvula*Atub*Cte)/sqrt(R*Tdep)*10^5; %En el caso de que estuviese bloqueada
     
     vGasto(i)= vGasto(i) + Gasto;

    end
        
plot(vGasto,[1:1:75])
grid on
title(['Gasto en función de Pconsigna']) 
ylabel('P_{consigna} (bar)')
xlabel('Gasto')
      
close all

W=57 
M_valvula = zeros(W,1)
M_antes6p = zeros(W,1)
% PresionMP1= zeros(W,1)
% PT02=zeros(W,1)
% PT0=zeros(W,1)
M_salida_tobera2=zeros(W,1)
M_despuesMP = zeros(W,1)
d_star= zeros(W,1)
vPT04es=zeros(W,1)
n=0

for j=164:1:220

 n=n+1;
fprintf('--------DEPOSITO----------') 
 PT02es= Datos(j,2)
 TT02es= Datos(j,10)+273;
 
 %Toma de datos en la válvula
 
fprintf('---DETRAS CAUDALIMETRO Y ANTES DE CODO---') %metemos la caida de presión de la válvula
 PT04es= Datos(j,3);
 TT04es= Datos(j,4)+273;
 
 %Alomejor nuevos sensores entre codos
 
fprintf('---------DETRAS DOS CODOS, ANTES DE LAS 6 PULGADAS--------') %metemos la caida de presión de la válvula y de los codos
 PT13es= Datos(j,7);
 TT08es= Datos(j,5)+273;
 
fprintf('----DETRAS CODO, ANTES MEDIO POROSO, YA 6 PULGADAS') %metemos caida de presion de la válvula y de los dos codos   
 PT14es= Datos(j,8);
 TT09es= Datos(j,6)+273;
% PT26es = Toma dinamica antes del medio poroso
% PT_0es= PT26es+PT14es (toma dinamica+toma estatica) da lugar a la presion
% de remanso antes del medio 

fprintf('----DETRAS MEDIO POROSO Y DELANTE DE LA BRIDA DE LA TOBERA----') %metemos caida de presion de la válvula y de los dos codos
 PT07es= Datos(j,9);
 TT05es=TT09es %NO TENEMOS VALORES AUN pero he supuesto que son iguales
% PT30es = toma dinamica detras medio poroso
% PT02es= PT30es+PT07es (toma dinamica+toma estatica) da lugar a la presion
% de remanso despues del medio- medida con sensores
 %% Número de Mach detras de la válvula (3 pulgadas)
 caida_valvula=0.17;%caida Premanso en la valvula
     rP1=PT02es*(1-caida_valvula)/PT04es  %%La presión de remanso hace referencia a la Presión de la válvula en estacionario
     salida=compressible(rP1,1,'P',1.4); 
     M1=salida(1)
     M_valvula(n)= salida(1)





%Para medir la caida de presión resultante de las ondas de choque
%producidas por los codos habria que meter una toma dinamica y estatica
%entre ambos

%% Número de Mach detrás de los dos codos (3 pulgadas)
caida_codo=0.1 %ejemplo
     rP2=PT02es*(1-caida_valvula)*(1-2*caida_codo)/PT13es  
     salida=compressible(rP2,1,'P',1.4); 
     M2=salida(1)
     M_antes6p(n)= salida(1)
     
     
%Aqui habría un ensanchamiento de 3-6 pulgadas pero no lo vamos a estudiar
%% Número de Mach detrás del medio poroso (6 pulgadas)
%Introducimos Darcy

PT_0= 5*10^5  % seria PT26 + PT14 (dinámica+estática)

Gasto1 = (PT_0*Atub6*Cte)/sqrt(R*(TT09es))

L=3*10^-3 %longitud medio poroso
Presion_tras_MP=sqrt(((PT14es*10^5)^2)-((2*Mu*L*R*(TT09es)*Gasto1)/(pi*Rtub6^2*Ka))) %presión estatica a la salida de medio poroso

     PT_01=1*10^5 % sería PT30es+PresionMP1 (dinamica+estatica)
     rP3=(PT_01)/Presion_tras_MP %nos falta medio la PT02
     salida=compressible(rP3,1,'P',1.4); 
     M3=salida(1)
     M_despuesMP(n)= salida(1)
     
%% Sección subsónica delante de la tobera 


 rP4=PT_01/Presion_tras_MP;
 salida=compressible(rP4,1,'P',1.4);
 rA=salida(end)
 A_star=Atub6/rA % en m2
 d_star=sqrt(A_star*4/pi) % en m

%% Sección de salida de la tobera
    d_garganta_tobera=0.1 %m
    d_salida_tobera=0.16; % m
    
    
    As=pi*(d_salida_tobera)^2/4; % Area salida tobera en mm2
    A_salida=As/A_star;
    if d_star<d_garganta_tobera
        salida=compressible(A_salida,1,'AB',1.4); %si la d0 es menos significa que ya se ha alcanzado el bloqueo y por lo tanto a la salida de la tobera el flujo va a ser subsonico.
    else
        salida=compressible(A_salida,1,'AA',1.4); %si la d0 es mayor significa que el flujo aun es subsonico por lo que se blooqueara en la tobera y el flujo a la salida sera supersonico con sus correspondientes ondas de choque o expansion.
    end
%     cprintf('------------------------')
    M_salida_tobera(n) = salida(1);
end

%FALTARIA METER DATOS : caidas de presion valvulas y codos, tomas dinámicas
%medio pososo, medidas tobera y medio poroso.





