
%ECUACIONES ONDA DE CHOQUE NORMALES

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