
clear all; close all;
start;
pwd='/home/dexter/Documentos/OpenDrift/opendrift';
FileDirHorizslice= '/home/dexter/Documentos/OpenDrift/opendrift/Resultados/Horizslice';
FileDirVertslice= '/home/dexter/Documentos/OpenDrift/opendrift/Resultados/Vertslice';
filename='DailyMean_2014.01.1-31.nc';
gridfile='roms_MIC_grd_v9g.nc';
for k=1:4;
    if k==1;
        vname= 'temp';
    end
    if k==2;
        vname='rho';
    end
    if k==3;
        vname='salt';
    end
    if k==4;
        vname='w';             
    end
  
d_ini=1;
d_fin=31;

%% Análisis Variables Simulación

% Manipulación Datos

% Extraemos algunas variables para revisar el Archivo
% [lat,lon,mask,var]=get_var('croco_his_201401.01-14.nc','roms_MIC_grd_v9g.nc','u',1,-10,1,[1 1 1 1])  

% Previamente hicimos un horislice y vimos que el área es mayor que la que
% queremos graficar, definimos un lat2 y lon2 con los límites a los que
% queremos reajustar el dominio
% lat2=lat(find(lat<=-41.7 & lat>=-42.4))

% [a b]=find(lat== max(lat2))
% b % Este es el valor donde deberemos cortar
% 
% [c d]=find(lat== min(lat2))
% c % Este es el valor donde deberemos cortar

% Las dimensiones originales eran 601x502, y los resultados nos dicen en
% este caso que el lon se cortará entre 374 a 474 y lat de 467 534

% En la terminal poner 
% ncks -d xi_rho,374,474 -d eta_rho,467,534 croco_his_201401.01-14.nc out.nc

%% Sección de revisión de pasos horarios
% Extraemos la latitud. longitud, mask y la temperatura, a nivel
% superficial (-1), para cada paso de tiempo (i). [374 30 467 67] son los
% puntos removidos desde los bordes, es decir cortamos el dominio 
% 
% c=0;
% for i=1:319
%     c=c+1;
% [lat,lon,mask,var]=get_var(filename,gridfile,varname,i,-1,1,[374 30 467 67]);
% temp(:,:,c)=var;
% end
%  
% Tmax=max(max(max(temp)));
% 
% % como hay datos malos y son NaN o T=0 buscamos la temperatura m{as baja
% % que no sea 0
% 
% temp2=temp;
% temp2(temp==0)=[];
% Tmin=min(min(min(temp2)));
%%
% poner una a una todas las variables del horizslice permite poner la fecha
% (aunque deba poner "2006" para que aparezca 2014 y no lo entienda),
% permite delimitar el dominio sin tener que cortar como en el item
% anterior, así no duplicamos archivos
% for i=d_ini:d_fin
% horizsliceTESIS_Msc(filename,varname,i,-1,[0 0 0 0],1,0,[],[],-73.8, -72.5,...
%     -42.35,-41.75,1,1,'100 100',0,1,0.1,[],[],gridfile,[],[],2006);
% colorbar, caxis([Tmin Tmax])
% end

%% Promedios Diarios 
% ncra --mro -d time,,,24,24 croco_his_201401.01-14.nc DailyMean_2014.01.01-14.nc

c=0;
for i=d_ini:d_fin
    c=c+1;
[lat,lon,mask,variable]=get_var(filename,gridfile,vname,i,-1,1,[374 30 467 67]);
var(:,:,c)=variable;
end

%%
c=0;
for i=d_ini:d_fin
    c=c+1;
[lat,lon,mask,variable]=get_var(filename,gridfile,vname,i,-285.329,1,[374 30 467 67]);
var_fondo(:,:,c)=variable;
end
%%
Vmax=max(max(max(var)));
% como hay datos malos y son NaN o T=0 buscamos la temperatura m{as baja
% que no sea 0

var2=var;
var2(var==0)=[];
Vmin=min(min(min(var2)));
Vmin_fondo=min(min(min(var_fondo)));
Vmax_fondo=max(max(max(var_fondo)));
%%
% poner una a una todas las variables del horizslice permite poner la fecha
% (aunque deba poner "2006" para que aparezca 2014 y no lo entienda),
% permite delimitar el dominio sin tener que cortar como en el item
% anterior, así no duplicamos archivos
for i=d_ini:d_fin
    h=figure('Position', get(0, 'Screensize'));
horizsliceTESIS_Msc(filename,vname,i,-1,[0 0 0 0],1,0,Vmin*1.1,Vmax*0.95,-73.8, -72.5,...
    -42.35,-41.75,1,1,'100 100',0,1,0.1,[],[],gridfile,[],[],2006);
if k==1;
    cmocean('thermal',11)
    colorbar 
end
if k==2;
    cmocean('dense',11)
    colorbar 
end
if k==3;
   cmocean('haline',11)
   colorbar % caxis([Tmin Tmax])
end
if k==4;
    cmocean('speed',11)
    colorbar 
end
jpgname =sprintf('H.Enero2014-%d_',i);
saveas(h, fullfile(FileDirHorizslice,[jpgname vname '.jpg']));
end
close all
%% Vertslice

for i=d_ini:d_fin
    h=figure('Position', get(0, 'Screensize'));
    vertslice(filename,gridfile,[-73.4 -72.75],[-42.2 -41.8],vname,i,1,Vmin,...
    Vmax,10,[],[],[],[],1,[],[],2006);
if k==1;
    cmocean('thermal',11)
    colorbar
end
if k==2;
    cmocean('dense',11)
    colorbar 
end
if k==3;
   cmocean('haline',11)
   colorbar % caxis([Tmin Tmax])
end
if k==4;
    cmocean('speed',11)
    colorbar 
end
jpgname =sprintf('V.Enero2014-%d_',i);
saveas(h, fullfile(FileDirVertslice,[ jpgname vname '.jpg']));
end
close all
end


%%
% for k=1:2;
%     if k==1;
%         vname='u';
%         c=0;
%         for i=d_ini:d_fin
%             c=c+1;
%             [lat,lon,mask,variable]=get_var(filename,gridfile,vname,i,-1,1,[374 30 467 67]);
%             var(:,1:100,c)=variable;
%             c=0;
%             for i=d_ini:d_fin
%                 c=c+1;
%                 [lat,lon,mask,variable]=get_var(filename,gridfile,vname,i,-285.329,1,[374 30 467 67]);
%                 var_fondo(:,1:100,c)=variable;
%             end
%             Vmax=max(max(max(var)));
%             var2=var;
%             var2(var==0)=[];
%             Vmin=min(min(min(var2)));
%             Vmin_fondo=min(min(min(var_fondo)));
%             Vmax_fondo=max(max(max(var_fondo)));
%             for i=d_ini:d_fin
%                 h=figure('Position', get(0, 'Screensize'));
%                 horizslice(filename,vname,i,-1,[0 0 0 0],1,0,Vmin,Vmax,-73.8, -72.5,...
%                     -42.35,-41.75,1,1,'100 100',0,1,0.1,[],[],gridfile,[],[],2006);
%                 % colorbar, caxis([Tmin Tmax])
%                 jpgname =sprintf('H.Enero2014-%d_',i);
%                 saveas(h, fullfile(FileDirHorizslice,[jpgname vname '.jpg']));
%             end
%             close all
%             % Vertslice
%             for i=d_ini:d_fin
%                 h=figure('Position', get(0, 'Screensize'));
%                 vertslice(filename,gridfile,[-73.4 -72.75],[-42.2 -41.8],vname,i,1,Vmin,...
%                     Vmax,10,[],[],[],[],1,[],[],2006);
%                 jpgname =sprintf('V.Enero2014-%d_',i);
%                 saveas(h, fullfile(FileDirVertslice,[ jpgname vname '.jpg']));
%             end
%             close all
%         end
%     end
%     
%     
%     %
%     if k==2;
%         vname='v';
%          c=0;
%         for i=d_ini:d_fin
%             c=c+1;
%             [lat,lon,mask,variable]=get_var(filename,gridfile,vname,i,-1,1,[374 30 467 67]);
%             var(1:68,:,c)=variable;
%             c=0;
%             for i=d_ini:d_fin
%                 c=c+1;
%                 [lat,lon,mask,variable]=get_var(filename,gridfile,vname,i,-285.329,1,[374 30 467 67]);
%                 var_fondo(1:68,:,c)=variable;
%             end
%             Vmax=max(max(max(var)));
%             var2=var;
%             var2(var==0)=[];
%             Vmin=min(min(min(var2)));
%             Vmin_fondo=min(min(min(var_fondo)));
%             Vmax_fondo=max(max(max(var_fondo)));
%             for i=d_ini:d_fin
%                 h=figure('Position', get(0, 'Screensize'));
%                 horizslice(filename,vname,i,-1,[0 0 0 0],1,0,Vmin,Vmax,-73.8, -72.5,...
%                     -42.35,-41.75,1,1,'100 100',0,1,0.1,[],[],gridfile,[],[],2006);
%                 % colorbar, caxis([Tmin Tmax])
%                 jpgname =sprintf('H.Enero2014-%d_',i);
%                 saveas(h, fullfile(FileDirHorizslice,[jpgname vname '.jpg']));
%             end
%             close all
%             % Vertslice
%             for i=d_ini:d_fin
%                 h=figure('Position', get(0, 'Screensize'));
%                 vertslice(filename,gridfile,[-73.4 -72.75],[-42.2 -41.8],vname,i,1,Vmin,...
%                     Vmax,10,[],[],[],[],1,[],[],2006);
%                 jpgname =sprintf('V.Enero2014-%d_',i);
%                 saveas(h, fullfile(FileDirVertslice,[ jpgname vname '.jpg']));
%             end
%             close all
%         end
%     end
% end

%% VELOCIDADES 

% [lat,lon,mask,speed]=get_speed(filename,gridfile,1,-1,1);
    
