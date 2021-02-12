
% ESQUEMA DISTRIBUCION DE PRESIONES

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

       
      
