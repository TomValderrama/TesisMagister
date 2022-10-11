% clear all; 
close all; 
clc;
start

tided='mosa_BGQ_his_M1_1h_WD_2.nc';  
ex_tide='USIPA_BGQ';


nc=netcdf(tided,'nowrite'); 
lon=nc{'lon_v'}(:); 
lat=nc{'lat_v'}(:);
 
zeta=nc{'vbar'}(:); 

%%zeta_m=nc{'zeta'}.scale_factor(:);
%%zeta_n=nc{'zeta'}.add_offset(:);
%%zeta = zeta*zeta_m + zeta_n;

%tim=nc{'scrum_time'}(:);
 
tim=nc{'time'}(:);
tim=tim-tim(1);

% Extraer senal de marea en la posicion,
%        
%            1               2             3            4              5       
%
% staBGQ=['Ancud       ';'Puerto_Montt';'Castro      ';'Melinka     ';'Chacabuco   '];
staBGQ=['CHACA       ';'DARWI       ';'ERRAZ       ';'ERRAZ_darwin';'GARAO       ';...
    'GAVIO       ';'MENIN       ';'PESUR       ';'PULEL       ';'SNAME       ';...
    'VICUN       '];
% lonBGQ=[-73.8171,-72.9268,-73.6981,-73.7188,-72.8457];
lonBGQ=[-73.4887, -74.0819, -73.8121, -73.7192, -73.7882, -73.4183,...
    -73.6753, -73.7950, -73.4921, -73.8544, -74.1281];
% latBGQ=[-41.8564,-41.4998,-42.5821,-43.8396,-45.4215];+
latBGQ=[-41.8702, -45.4060, -45.5968, -45.3967, -44.3873, -44.9287, -45.2407,...
    -44.7430, -41.8533, -44.0142, -45.6527];
%          1        2        3        4        5   



%  Land points - D2
% 
%  3
%


figure('Position', get(0, 'Screensize'))
	pcolor(lon,lat,squeeze(zeta(1,:,:))); shading interp; colormap(jet(64))
	xlabel('Longitude')
	ylabel('Latitude')
	title('Map of tidal stations')
	axis([-76 -72 -47 -40])
	hold on
		plot(lonBGQ,latBGQ,'r*','MarkerSize',12)

		for k=1:size(lonBGQ,2)
			text(lonBGQ(k),latBGQ(k),num2str(k),'FontSize',12)
		end
	hold off

pname=[ex_tide,'_Ubicaciones.png'];
print('-dpng',pname)

skipindx=60;
%keyboard  skip 60 data

ALLTOTAL=[];
for k=1:size(lonBGQ,2)

        ininm=1;
	for nm=skipindx:size(zeta,1)
	    ssh(ininm)=griddata(lon,lat,squeeze(zeta(nm,:,:)),lonBGQ(k),latBGQ(k));
        ininm=ininm+1;
	end


% 	figure('Position', get(0, 'Screensize'))
% 		subplot(3,2,k)
		nivelmar=ssh-nanmean(ssh);
% 		plot(nivelmar)
% 		ylabel('[m]')
% 		title([num2str(k),': ',num2str(lonBGQ(k)),' ',num2str(latBGQ(k))])

	name=staBGQ(k,:);
	fecha=datetime(2004,1,1)+tim(skipindx:end)/(24*3600);



	[tidestruc,XOUT]=t_tide(nivelmar,'output','none');

	   fsig=tidestruc.tidecon(:,1)>tidestruc.tidecon(:,2); % Significant peaks
	   tmp=tidestruc.tidecon(fsig,1);
	   [Atides,Itides]=sort(tmp,'descend'); 
	   Nbtides=length(Atides);
	   tmp=tidestruc.tidecon(fsig,3); Ptides=tmp(Itides);
	   tmp=tidestruc.name(fsig,:); Ttides=tmp(Itides,:);
	   Atides_m=Atides; Ptides_m=Ptides; Ttides_m=Ttides;

	if (k == size(lonBGQ,2))
		pname=[ex_tide,'_SeriesTiempo.png'];
		print('-dpng',pname)
	end

% 	f=figure('Position', get(0, 'Screensize'))
% 		subplot(3,2,k)	
% 	        set(f,'Units','normalized','Position',[0. 0. 0.4 0.4]);
% %
% 		  fsig=tidestruc.tidecon(:,1)>tidestruc.tidecon(:,2); % Significant peaks
%   			semilogy([tidestruc.freq(~fsig),tidestruc.freq(~fsig)]', ...
% 		       [.0005*ones(sum(~fsig),1),tidestruc.tidecon(~fsig,1)]','.-r');
% 		  line([tidestruc.freq(fsig),tidestruc.freq(fsig)]', ...
%  		      [.0005*ones(sum(fsig),1),tidestruc.tidecon(fsig,1)]','marker','.','color','b');
% 		  line(tidestruc.freq,tidestruc.tidecon(:,2),'linestyle',':','color',[0 .5 0]);
% 		  set(gca,'ylim',[.0005 1],'xlim',[0 .5]);
%  		 xlabel('Frecuencia (cph)');
%  		 text(tidestruc.freq,tidestruc.tidecon(:,1),tidestruc.name,'rotation',45,'vertical','base');
% 		  ylabel('Amplitud (m)');
%  		 text(.25,.2,'Constituyentes Significativos','color','b');
%  		 text(.25,.1,'Constituyentes No Significativos','color','r');
%  		 text(.25,.05,'Nivel Significancia 95%','color',[0 .5 0]);
%  		 %title(['Datos ' name])
%   		 title([num2str(k),': ',num2str(lonBGQ(k)),' ',num2str(latBGQ(k))])

 		 [NAME,FREQ,TIDECON,XOUT]=t_tide(nivelmar,'output','none');

% En NAME se guarda el nombre del armónico
% En FREQ se guarda la frecuencia
% En TIDECON se guarda la amplitud y fase con sus respectivos errores
% En XOUT se guarda la serie temporal de marea meteorológica

% Tras T_TIDE especificamos: (1) variable del nivel del mar 
%                            (2) 'output' especificamos que es una salida
%                            (3) nombre del fichero de salida
 

% 5. Calculamos la marea meteorológica

	meteo = nivelmar-XOUT; 

% 6. Representación gráfica

	if (k == size(lonBGQ,2))
		pname=[ex_tide,'_Componentes.png'];
		print('-dpng',pname)
	end

% 	figure('Position', get(0, 'Screensize'),'Visible','off')
% 
% 		subplot(3,2,k)
% 		subplot(3,1,1) %Nivel del mar
% %		plot(fecha,nivelmar,'k')
% 		plot(nivelmar,'k')
% 		title (['Nivel del Mar (m) ', num2str(k), ': ', name ]);
% 		%xlabel('Julian Time (days)')
% 		ylabel('NMM (m)')
% %		datetick('x','yyyy-mm')
% %		axis([min(datenum(fecha)) max(datenum(fecha)) -1 1])
% 
% 		subplot(3,1,2) %Marea astronómica
% %		plot(fecha,XOUT,'b')
% 		plot(XOUT,'b')
% 		title('Marea Astronomica (m)')
% 		%xlabel('Julian Time (days)')
% 		ylabel('NMM_a (m)')
% %		datetick('x','yyyy-mm')
% %		axis([min(datenum(fecha)) max(datenum(fecha)) -1 1])
% 
% 		subplot(3,1,3) %Marea meteorológica
% %		plot(fecha,meteo,'r')
% 		plot(meteo,'r')
% 		title('Marea Meteorologica (m)')
% 		xlabel('Tiempo Juliano (dias)')
% 		ylabel('NMM_m (m)')
% %		datetick('x','yyyy-mm')
% %		axis([min(datenum(fecha)) max(datenum(fecha)) -.25 .25])
% 	
% 		pname=[ex_tide,'u_',strtrim(name),'.png'];
% 		print('-dpng',pname)

% 7. Selección componentes más significativas

	media = mean(TIDECON(:,1)); %Calculamos la media de la amplitud
	isig = find(TIDECON(:,1) > media); %Busca la posición de valores superiores a la media

	TIDECON=round(TIDECON*1000)/1000;
	[aux indx]=sort(TIDECON(isig,1));

	indx=flipud(indx);   % Orden Decreciente

	harm_isig = [TIDECON(isig(indx),1) TIDECON(isig(indx),3)]; %Identifica los valores buscados
	name_isig = NAME(isig(indx),:); %Identifica los valores buscados
	freq_isig = FREQ(isig(indx)); %Identifica los valores buscados

	freq_isig=round(freq_isig*10000)/10000;
	
	%name	
	TOTAL = [name_isig num2str(freq_isig) name_isig(:,4)  num2str(harm_isig)]
        ALLTOTAL=[ALLTOTAL; TOTAL];
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

end % k -Tidal stations 

fname=['Resultadosv_',ex_tide,'.txt'];
dlmwrite(fname,ALLTOTAL,'delimiter','');

