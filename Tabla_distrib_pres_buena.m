clear all


 
 %% DIbujo distribución de presiones
M1=0.5;
% d_tuberia= 0.076;
d_garganta_tobera=0.07; 
d_salida_tobera=0.14; 

% Ae=0.0045
Ag=0.0038;
% As=pi*(d_salida_tobera)^2/4;
As=0.01;

vrP_1=zeros(113,1);
vMs_1=zeros(113,1);
vrA=zeros(113,1);
vA=zeros(113,1);
vMe=zeros(113,1);
vrPe=zeros(113,1);

n=0;




for A=0.0150:-0.0001:Ag 
    n=n+1;
    vA(n)=vA(n)+A;
    rA=Ag/A;
    vrA(n)=vrA(n)+rA;
    
    
     for Ms_1=0:0.00001:1
     
     rA_=Ms_1*((2+(1.4-1)*Ms_1^2)/(1.4+1))^((-1.4-1)/(2*(1.4-1)));
    
      error = abs(rA - rA_)/rA;
      if error < 10^-4
         break
      end
     end
      vMs_1(n) = vMs_1(n)+ Ms_1;
      
     rP_1= 1/(1+((1.4-1)*Ms_1^2)/2)^(1.4/(1.4-1));
     vrP_1(n)=vrP_1(n)+rP_1;
     
     
     
%% SOlución subsónica (1 > rP > rP_BS)
     
     
     for Me=0:0.00001:1
     
     
        rA_= (Me/M1)*((2+(1.4-1)*M1^2)/(2+(1.4-1)*Me^2))^((1.4+1)/(2*(1.4-1)));
    
        error = abs((rA) - rA_)/(rA);
        if error < 10^-4
         break
        end
         
    
     end
%         n=n+1;
       vMe(n) = vMe(n)+ Me;
      
        rPe= 1/(1+((1.4-1)*Me^2)/2)^(1.4/(1.4-1));
        vrPe(n)=vrPe(n)+rPe;
        
   
     
    
end
  
f=113;
for j=1:112
    f=f-1;
    vA(f)=vA(f)-0.0001*2*j;
end


n=0;
vrP_BS = zeros(63,1);
vrP_AD = zeros(64,1);
vrA_2=zeros(63,1);
vA_2=zeros(63,1);
vA_sup=zeros(64,1);

vMs_sub =zeros(63,1);
vMs_sup=zeros(63,1);


vrP= zeros(63,1);
vMs = zeros(63,1);   
vrP=zeros(63,1);


 vrP_och_oblic=zeros(400,1);
 vrP_ePM =zeros(60,1);
 
     
         prompt = 'Relación presiones onda.ch.normal ';
         rpest_och= input(prompt);
         
     for A= Ag:0.0001:As
        n=n+1;
        vA_2(n)=vA_2(n)+A;
%         prompt = 'Relación de áreas críticas ';
%         rA= input(prompt)
        rA=Ag/A;
        vrA_2(n)=vrA_2(n)+rA;
        
for Ms_sub=0:0.00001:1
     
        rA_=Ms_sub*((2+(1.4-1)*Ms_sub^2)/(1.4+1))^((-1.4-1)/(2*(1.4-1)));
    
        error = abs((rA) - rA_)/(rA);
        if error < 10^-4
         break
        end
        end
        vMs_sub(n) = vMs_sub(n)+ Ms_sub;
      
        rP_BS= 1/(1+((1.4-1)*Ms_sub^2)/2)^(1.4/(1.4-1));
        vrP_BS(n)=vrP_BS(n)+rP_BS;
      
        

for Ms_sup=1:0.00001:3
     
        rA_=Ms_sup*((2+(1.4-1)*Ms_sup^2)/(1.4+1))^((-1.4-1)/(2*(1.4-1)));
    
        error = abs((rA) - rA_)/(rA);
        if error < 10^-4;
         break
        end
end
        vMs_sup(n) = vMs_sup(n)+ Ms_sup;
      
        rP_AD= 1/(1+((1.4-1)*Ms_sup^2)/2)^(1.4/(1.4-1));
        vrP_AD(n)=vrP_AD(n)+rP_AD;
        
        %% ONDA DE CHOQUE NORMAL A LA SALIDA DE LA TOBERA
         vA_sup(n)=vA_sup(n) + A;
         vA_sup(64)= As;
         
         %poner de forma manual
         vrP_AD(64)= rpest_och*vrP_AD(63);
         vP_och_n = vrP_AD(64);
         
        [Ms_och_n,M_sub_n, rP_remanso] = ecs_och_normal(rpest_och);
        
        
        %% ONDA DE CHOQUE NORMAL EN EL INTERIOR DE LA TOBERA (rP_BS > rP > rP_och_n)
        %% ONDA DE CHOQUE OBLICUA TOBERA (rP_Och_n > rP > rP_AD);
j=0;
 
 for rP_och_oblic= vrP_AD(63) : 0.001 : vP_och_n
j=j+1;
     vrP_och_oblic(j)= vrP_och_oblic(j)+ rP_och_oblic;
        
 end
     
 
       %% ONDA DE EXPANSION TOBERA (0 < rP < rP_AD)
 l=0;
 
 for rP_ePM= 0 : 0.001 : vrP_AD(63)
     l=l+1;
     vrP_ePM(l)= vrP_ePM(l)+rP_ePM;
        
 end
         
      
%% SOlución subsónica (1 > rP > rP_BS)
     
     
     for Ms=0:0.00001:1
     
     
        rA_= (Ms/M1)*((2+(1.4-1)*M1^2)/(2+(1.4-1)*Ms^2))^((1.4+1)/(2*(1.4-1)));
    
        error = abs((rA) - rA_)/(rA);
        if error < 10^-4
         break
        end
         
    
     end
%         n=n+1;
        vMs(n) = vMs(n)+ Ms;
      
        rP= 1/(1+((1.4-1)*Ms^2)/2)^(1.4/(1.4-1));
        vrP(n)=vrP(n)+rP;
        
       
 
 
 
     end     
     
     
fprintf(['La tobera se bloquea(M=1) con rP= ' num2str(vrP_1(113))])

rP_Mach_1=vrP_1(113)

fprintf(['La tobera se bloquea(M=1)- BLOQUEO SÓNICO con rP= ' num2str(vrP_BS(63))])

rP_bloqueoS=vrP_BS(63)

fprintf(['La tobera se bloquea(M=1)- ADAPTADA con rP= ' num2str(vrP_AD(63))])

rP_adap=vrP_AD(63)

fprintf(['Onda de choque normal con rP= ' num2str(rP_och_oblic)])

rP_och_oblic

fprintf(['Onda de choque oblicuas con rP= ' ]) 

rP_och_oblic
rP_adap
 
fprintf(['Onda de choque normales dentro con rP= ' ]) 

rP_bloqueoS
rP_och_oblic

fprintf(['Ondas de expansión PM entre ='])

rP_adap
0
       
fprintf(['Solución subsónica entre ='])

rP_bloqueoS
1


       figure; plot(vA_sup , vrP_AD)
       grid on
       ylim([0 1])
       xlim([-0.0074 0.01])
       xticks([-0.0074 0.0038 0.01])
       xticklabels({'A','Ag','As'})
       title('Distribucion de presiones');
       ylabel('Relación de presiones');
       xlabel('Area');
       
        hold on;
        plot(vA_2, vrP_BS);   
        plot(vA(:) , vrP_1(:))
        plot(vA(:) , vrPe(:))
        plot(vA_2, vrP(:)) 
        
        hold off; 

       
      
function [Ms_och_n,M_sub_n, rP_remanso] = ecs_och_normal(rpest_och)

gamma =1.4;

for Ms_och_n=1:10^-4:4
   rpest_och_ = (((2*gamma*Ms_och_n^2)-(gamma-1))/(gamma+1));

    
    error = abs(rpest_och - rpest_och_)/rpest_och;
    if error< 10^-3
        break
    end
end

 M_sub_n =sqrt((2+(gamma-1)*Ms_och_n^2)/((2*gamma*Ms_och_n^2)- (gamma-1)));
 rP_remanso = 1/((((2*gamma*Ms_och_n^2)-(gamma-1))/(gamma+1))*((2+(gamma-1)*Ms_och_n^2)/((gamma+1)*Ms_och_n^2))^gamma)^(1/(gamma-1));

end

function[rpest_och, rP_remanso, Ms_och_n] = ecs_och_normal_2(Ms_sub_n)

gamma = 1.4;
for Ms_och_n=1:10^-4:4
   M_sub_n_ =sqrt((2+(gamma-1)*Ms_och_n^2)/((2*gamma*Ms_och_n^2)- (gamma-1)));

    
    error = abs(M_sub_n - M_sub_n_ )/M_sub_n;
    if error< 10^-3
        break
    end
end

rpest_och = ((2*gamma*Ms_och_n^2)-(gamma-1))/(gamma+1);

rP_remanso = 1/((((2*gamma*Ms_och_n^2)-(gamma-1))/(gamma+1))*((2+(gamma-1)*Ms_och_n^2)/((gamma+1)*Ms_och_n^2))^gamma)^(1/(gamma-1));

end