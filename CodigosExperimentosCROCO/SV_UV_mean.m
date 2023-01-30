% %% SECCIÓN N-S VELOCIDADES U
% close all; clear all; start
% 
% FileDirVertsliceNS= '/home/dexter/Documentos/CodigosTesis/MOSA_VER/u/vertslice/N-S';
% hisfile ='mosa_BGQ_his_M1_1h_WD_20210102.nc';gridfile=hisfile; 
% 
% sigma=42; prof=-305; 
% 
% % sección N-S 
% latsec_u=[450:469]'; lonsec_u=[279]; 
% 
% time=linspace(738158, 738188,31);
% date=datevec(time);
%  xi=[];
% for i= 1:721
%     for c=1:42
%     [lat,lon,mask,XI(:,:,c)]=get_var(hisfile,[],'u',i,c,1,[263 26 449 152]);
%     end
%     xi = cat(4,xi,XI);
%     clear XI
% end
% 
% u_latsec=xi(:,16,:,:); % (lat,lon,sigma,dias) %find(abs(lon(1,:)--73.05)<0.0125) ans = 16
% latsec_lat_u=lat(:,16);  
% latsec_lon_u=lon(:,16);
% 
% velocity_latsec=squeeze(u_latsec);
% longitude_latsec = repmat(latsec_lon_u,[1 sigma]);
% latitude_latsec = repmat(latsec_lat_u,[1 sigma]);
% 
% bluered=[linspace(0,1,8) linspace(1,1,7); linspace(0,0.8571,7) linspace(1,0,8); linspace(1,1,7) linspace(1,0,8)]';
% 
% z= get_depths(hisfile,gridfile,1,'r');
% Z = permute(z,[2 3 1]);
% zeta = Z(latsec_u,lonsec_u,:);
% zeta = squeeze(zeta);
% 
% % Selecciono el dia  a plotear
% 
% k=0;
% for i=1:721
%     k=k+1;
% xi_do = velocity_latsec(:,:,i);
% xi_d(:,:,i)=xi_do;
% end
% 
% c=0;
% for i=1:30
% uH=xi_d(:,:,(1:24)+24*c);
% uM=mean(uH(:,:,:),3);
% um(:,:,i)=uM;
%     c=c+1;
% end
% %%
% ZETA=zeta';
% clear velocity_latsec; clear Z; clear latsec_lat_u; clear latsec_lon_u; clear u_latsec;
% 
% for i=1:30
%     h=figure('Position', get(0, 'Screensize'),'Visible','off');
%     pcolor(latitude_latsec,zeta,um(:,:,i))
%     shading interp
%     caxis([-0.4 0.4])
%     colormap(bluered)
%     hc = colorbar;
%     xlabel('Latitud','FontSize',34,'FontWeight','bold')
%     ylabel('Profundidad [m]','FontSize',34,'FontWeight','bold')
%     title(['\fontsize{28}' 'Velocidad u, media diaria '  + string(datetime(date(i,:)))])
%     title(hc,'m/s','fontsize',20);     caxis([-0.4 0.4])
%     ax = gca;
%     ax.FontSize = 16; 
%     axis tight
%     ylim([prof,0]);  
%     jpgname =sprintf('SV_u_ver_MD_%d',i);
%     saveas(h, fullfile(FileDirVertsliceNS,[ jpgname '.jpg']));
% end


%% SECCIÓN E-O VELOCIDADES V
close all; clear all; start

FileDirVertsliceEO= '/home/dexter/Documentos/CodigosTesis/MOSA_VER/v/vertslice/E-O';
hisfile ='mosa_BGQ_his_M1_1h_WD_20210102.nc';gridfile=hisfile; 

sigma=42; prof=-305; 

% sección E-O % 
latsec_v=[459]; lonsec_v=[265:295]; 

time=linspace(738158, 738188,31);
date=datevec(time);
 xi=[];
for i= 1:721
    for c=1:42
    [lat,lon,mask,XI(:,:,c)]=get_var(hisfile,[],'v',i,c,1,[264 26 449 152]);
    end
    xi = cat(4,xi,XI);
    clear XI
end

v_lonsec=xi(10,:,:,:); % (lat,lon,sigma,dias) % find(abs(lat(:,1)--42.075)<0.01) % ans= 10
lonsec_lat_v=lat(10,:)';  
lonsec_lon_v=lon(10,:)';

velocity_lonsec=squeeze(v_lonsec);
longitude_lonsec = repmat(lonsec_lon_v,[1 sigma]);
latitude_lonsec = repmat(lonsec_lat_v,[1 sigma]);

bluered=[linspace(0,1,8) linspace(1,1,7); linspace(0,0.8571,7) linspace(1,0,8); linspace(1,1,7) linspace(1,0,8)]';

z= get_depths(hisfile,gridfile,1,'r');
Z = permute(z,[2 3 1]);
zeta = Z(latsec_v,lonsec_v,:);
zeta = squeeze(zeta);

% Selecciono el dia  a plotear

k=0;
for i=1:721
    k=k+1;
xi_do = velocity_lonsec(:,:,i);
xi_d(:,:,i)=xi_do;
end

c=0;
for i=1:30
vH=xi_d(:,:,(1:24)+24*c);
vM=mean(vH(:,:,:),3);
vm(:,:,i)=vM;
    c=c+1;
end

ZETA=zeta';

clear velocity_lonsec; clear Z; clear lonsec_lat_v; clear lonsec_lon_v; clear u_latsec;

for i=1:30
    h=figure('Position', get(0, 'Screensize'),'Visible','off');
    pcolor(longitude_lonsec,zeta,vm(:,:,i))
    shading interp
    caxis([-0.4 0.4])
    colormap(bluered)
    hc = colorbar;
    xlabel('Longitud','FontSize',34,'FontWeight','bold')
    ylabel('Profundidad [m]','FontSize',34,'FontWeight','bold')
    title(['\fontsize{28}' 'Velocidad v '  + string(datetime(date(i,:)))])
    title(hc,'m/s','fontsize',20);     caxis([-0.4 0.4])
    ax = gca;
    ax.FontSize = 16; 
    axis tight
    ylim([prof,0]);  
    jpgname =sprintf('SV_v_ver_MD_%d',i);
    saveas(h, fullfile(FileDirVertsliceEO,[ jpgname '.jpg']));
end