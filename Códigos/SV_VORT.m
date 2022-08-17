close all
clear all

start

%%
FileDirVertsliceNS= '/home/dexter/Documentos/OpenDrift/opendrift/MOSA_1m_1h/vort/vertslice/E-O';
hisfile ='mosa_BGQ_his_M1_1h_WD.nc';
gridfile=hisfile;
sigma=42 ;
days=722;
dayplot=1;
ini=600;
dif=days-ini;
prof=-305;
% % sección N-S
% latsec=[450:469];
% lonsec=[279];
% cte=1;
% sección E-O
latsec=[459];
lonsec=[265:301];
cte=0;
vname='vort';
vname2='s^-^1';
%%
 xi=[];
for i= ini:days
    for c=1:sigma
    [latt,lonn,mask,XI(:,:,c)]=get_vort(hisfile,gridfile,i,c,1);
    end
    xi = cat(4,xi,XI);
    clear XI
end
%%
vort=xi(latsec,lonsec,:,:); % (lat,lon,sigma,dias)
lat_vortices=latt(latsec,lonsec);  
lon_vortices=lonn(latsec,lonsec);

clear xi;
vorticity=squeeze(vort);


if (cte == 0)
    lon_vortices=lon_vortices';
    longitude = repmat(lon_vortices,[1 sigma]);
    
    lat_vortices=lat_vortices';
    latitude = repmat(lat_vortices,[1 sigma]);
else
    longitude = repmat(lon_vortices,[1 sigma]);
    latitude = repmat(lat_vortices,[1 sigma]);
end

bluered=[linspace(0,1,8) linspace(1,1,7); linspace(0,0.8571,7) linspace(1,0,8); linspace(1,1,7) linspace(1,0,8)]';


z= get_depths(hisfile,gridfile,dayplot,'r');
Z = permute(z,[2 3 1]);
zeta = Z(latsec,lonsec,:);
zeta = squeeze(zeta);


%% Selecciono el dia  a plotear

k=ini-1;
for i=1:dif
    k=k+1;
xi_do = vorticity(:,:,i);
xi_d(:,:,i)=xi_do;
end
%%
 ZETA=zeta';

 
 clear zeta;
 clear vorticity;
 clear Z;
 clear lat_vortices;
 clear lon_vortices;
 clear vort;
 k=ini-1;
 for i=1:dif
     k=k+1;
 if (cte== 0)
     
     %ploteo
     h=figure('Position', get(0, 'Screensize'),'Visible','off');
     pcolor(longitude',ZETA,xi_d(:,:,i)')
     shading interp
     %caxis([-6e-5 6e-5])
     caxis([-1e-4 1e-4])
     colormap(bluered)
%      c = colorbar;
%      c.Label.String = 's-1';
     xlabel('Longitud')
     ylabel('Profundidad [m]')
     title(['\fontsize{20}' 'Vorticidad ' sprintf(' - hora %d del mes', k)])
     axis tight
     ylim([prof,0]);
     jpgname =sprintf('CROP_MOSA_-%d_',k);
     saveas(h, fullfile(FileDirVertsliceNS,[ jpgname vname '.jpg']));
 else
     %ploteo
     h=figure('Position', get(0, 'Screensize'),'Visible','off');
     pcolor(latitude',ZETA,xi_d(:,:,i)')
     shading interp
     %caxis([-6e-5 6e-5])
     colormap(bluered)
%      c = colorbar;
%      c.Label.String = 's-1';
     xlabel('Latitud')
     ylabel('Profundidad [m]')
     title(['\fontsize{20}' 'Vorticidad ' sprintf(' - hora %d del mes', k)])
     caxis([-1e-4 1e-4])
     axis tight
     ylim([prof,0]);  
     jpgname =sprintf('CROP_MOSA_-%d_',k);
     saveas(h, fullfile(FileDirVertsliceNS,[ jpgname vname '.jpg']));
 end
 end
 %%
%  for i=722:722
%  if (cte== 0)
%      
%      %ploteo
%      h=figure('Position', get(0, 'Screensize'),'Visible','off');
% %      pcolor(longitude',ZETA,xi_d(:,:,1)')
%      shading interp
%      %caxis([-6e-5 6e-5])
%      caxis([-1e-4 1e-4])
%      colormap(bluered)
% %      c = colorbar;
% %      c.Label.String = 's-1';
%      xlabel('Longitud')
%      ylabel('Profundidad [m]')
% %      title(['\fontsize{20}' 'Vorticidad ' sprintf(' - hora %d del mes', i)])
%      axis tight
%      ylim([prof,0]);
%      fixcolorbar([0.2 0.06 0.6 0.03],[-1e-4 1e-4],vname,13)
%      jpgname =sprintf('CROP_MOSA_-%d_',i);
%      saveas(h, fullfile(FileDirVertsliceNS,[ jpgname vname '.jpg']));
%  else
%      %ploteo
%      h=figure('Position', get(0, 'Screensize'),'Visible','off');
% %      pcolor(latitude',ZETA,xi_d(:,:,1)')
%      shading interp
%      %caxis([-6e-5 6e-5])
%      colormap(bluered)
% %      c = colorbar;
% %      c.Label.String = 's-1';
%      xlabel('Latitud')
%      ylabel('Profundidad [m]')
%      caxis([-1e-4 1e-4])
%      axis tight
%      ylim([prof,0]);  
%      colormap(bluered(11))
%      fixcolorbar([0.2 0.26 0.6 0.03],[-1e-4 1e-4],vname,13)
%      jpgname =sprintf('CROP_MOSA_-%d_',i);
%      saveas(h, fullfile(FileDirVertsliceNS,[ jpgname vname '.jpg']));
%  end
% end
