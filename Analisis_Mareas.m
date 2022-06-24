clear all; 
close all; 
clc;
start

%
%
%   Leer serie de tiempo aca e ingresar como variable "nivelmar"
%


	[tidestruc,XOUT]=t_tide(nivelmar,'output','none');

	   fsig=tidestruc.tidecon(:,1)>tidestruc.tidecon(:,2); % Significant peaks
	   tmp=tidestruc.tidecon(fsig,1);
	   [Atides,Itides]=sort(tmp,'descend'); 
	   Nbtides=length(Atides);
	   tmp=tidestruc.tidecon(fsig,3); Ptides=tmp(Itides);
	   tmp=tidestruc.name(fsig,:); Ttides=tmp(Itides,:);
	   Atides_m=Atides; Ptides_m=Ptides; Ttides_m=Ttides;

	f=figure(3);

set(f,'Units','normalized','Position',[0. 0. 0.4 0.4]);
%
		  fsig=tidestruc.tidecon(:,1)>tidestruc.tidecon(:,2); % Significant peaks
  			semilogy([tidestruc.freq(~fsig),tidestruc.freq(~fsig)]', ...
		       [.0005*ones(sum(~fsig),1),tidestruc.tidecon(~fsig,1)]','.-r');
		  line([tidestruc.freq(fsig),tidestruc.freq(fsig)]', ...
 		      [.0005*ones(sum(fsig),1),tidestruc.tidecon(fsig,1)]','marker','.','color','b');
		  line(tidestruc.freq,tidestruc.tidecon(:,2),'linestyle',':','color',[0 .5 0]);
		  set(gca,'ylim',[.0005 1],'xlim',[0 .5]);
 		 xlabel('Frecuencia (cph)');
 		 text(tidestruc.freq,tidestruc.tidecon(:,1),tidestruc.name,'rotation',45,'vertical','base');
		  ylabel('Amplitud (m)');
 		 text(.25,.2,'Constituyentes Significativos','color','b');
 		 text(.25,.1,'Constituyentes No Significativos','color','r');
 		 text(.25,.05,'Nivel Significancia 95%','color',[0 .5 0]);
 		 %title(['Datos ' name])
  		 title([num2str(k),': ',num2str(lonGabes(k)),' ',num2str(latGabes(k))])

 		 [NAME,FREQ,TIDECON,XOUT]=t_tide(nivelmar,'output','none');

% En NAME se guarda el nombre del armónico
% En FREQ se guarda la frecuencia
% En TIDECON se guarda la amplitud y fase con sus respectivos errores
% En XOUT se guarda la serie temporal de marea meteorológica

	media = mean(TIDECON(:,1)); %Calculamos la media de la amplitud
	isig = find(TIDECON(:,1) > media); %Busca la posición de valores superiores a la media

	TIDECON=round(TIDECON*1000)/1000;
	[aux indx]=sort(TIDECON(isig,1));

	indx=flipud(indx);   % Orden Decreciente

	harm_isig = [TIDECON(isig(indx),1) TIDECON(isig(indx),3)]; %Identifica los valores buscados
	name_isig = NAME(isig(indx),:); %Identifica los valores buscados
	freq_isig = FREQ(isig(indx)); %Identifica los valores buscados

	freq_isig=round(freq_isig*10000)/10000;
	
	name	
	TOTAL = [name_isig num2str(freq_isig) name_isig(:,4)  num2str(harm_isig)]
	disp(' Nombre Frecuencia Amplitud Fase ')
  
	aux=ismember(NAME,'K1  ','rows');
	indxK1=find(aux==1);
	aux=ismember(NAME,'O1  ','rows');
	indxO1=find(aux==1);
	aux=ismember(NAME,'M2  ','rows');
	indxM2=find(aux==1);
	aux=ismember(NAME,'S2  ','rows');
	indxS2=find(aux==1);

	aK1=TIDECON(indxK1,1);
	aO1=TIDECON(indxO1,1);
	aM2=TIDECON(indxM2,1);
	aS2=TIDECON(indxS2,1);

	disp('Factor de Forma (F)')

	F=(aK1+aO1)/(aM2+aS2)
	if F <0.26 
	    disp('Marea Semidiurna')
  	elseif 0.25 < F  & F < 1.5
    	    disp('Marea mixta con predominio semidiurno')
	elseif 1.50 < F  & F < 3
	    disp('Marea mixta con predominio diurno')
	else
	    disp('Marea Diurna')
	end    
