close all; clear all; start

hisfile ='mosa_BGQ_his_M1_1h_WD_20210102.nc';gridfile=hisfile;
FileDir='/home/dexter/Documentos/CodigosTesis/PRODIGY/SV/u';
addpath('/home/dexter/Documentos/OpenDrift/opendrift/')


% sección N-S 

time=linspace(738158, 738188,721);
date=datevec(time);
 xi=[];
for i= 1:721
    for c=1:42
    [lat,lon,mask,XI(:,:,c)]=get_var(hisfile,[],'v',i,c,1,[300 20 449 170]);
    end
    xi = cat(4,xi,XI);
    clear XI
end
%%
latsec_u=[449]'; lonsec_u=[301]; 

z= get_depths(hisfile,gridfile,1,'r');
Z = permute(z,[2 3 1]);
zeta = Z(latsec_u,lonsec_u,:);
zeta = squeeze(zeta);

%%
% bluered=[linspace(0,1,8) linspace(1,1,7); linspace(0,0.8571,7) linspace(1,0,8); linspace(1,1,7) linspace(1,0,8)]';
% close all
% AA=reshape(xi,42,145)
% h=figure('Position', get(0, 'Screensize'))
% pcolor(time(1:96),zeta,AA(:,1:96))
% datetick('x','dd/mmm hh','keepticks')
% shading interp
% caxis([-0.4 0.4])
% colormap(bluered)
% hc = colorbar;
% ax = gca;
% ax.FontSize = 12; 
% xlabel('Time [hours]','FontSize',30,'FontWeight','bold')
% ylabel('Depth [m]','FontSize',30,'FontWeight','bold')
% title(['\fontsize{28}' 'v Velocity Hovmoller, (-72.5,-42.2302)'])
% title(hc,'m/s','fontsize',20);
% % grid on
% xl=xline(time(1));
% xl.LineWidth = 2;
% xl=xline(time(7),'y');
% xl.LineWidth = 2;
% xl=xline(time(13));
% xl.LineWidth = 2;
% xl=xline(time(19),'y');
% xl.LineWidth = 2;
% xl=xline(time(25));
% xl.LineWidth = 2;
% xl=xline(time(31),'y');
% xl.LineWidth = 2;
% xl=xline(time(37));
% xl.LineWidth = 2;
% xl=xline(time(43),'y');
% xl.LineWidth = 2;
% xl=xline(time(49));
% xl.LineWidth = 2;
% xl=xline(time(55),'y');
% xl.LineWidth = 2;
% xl=xline(time(61));
% xl.LineWidth = 2;
% xl=xline(time(67),'y');
% xl.LineWidth = 2;
% xl=xline(time(73));
% xl.LineWidth = 2;
% xl=xline(time(79),'y');
% xl.LineWidth = 2;
% xl=xline(time(85));
% xl.LineWidth = 2;
% xl=xline(time(91),'y');
% xl.LineWidth = 2;
% xl=xline(time(97));
% xl.LineWidth = 2;
% set(gca,'layer','top')

%%

c=0;
for i=1:30
slaH=xi(:,:,:,(1:24)+24*c);
slaM=mean(slaH(:,:,:,:),4);
slam(:,:,:,i)=slaM;
c=c+1
end

%%
bluered=[linspace(0,1,17) linspace(1,1,16); linspace(0,0.8571,16) linspace(1,0,17); linspace(1,1,16) linspace(1,0,17)]';
close all
AA=reshape(slam,42,30)
h=figure('Position', get(0, 'Screensize'))
pcolor(time(1:24:720),zeta,AA(:,1:end))
datetick('x','dd/mmm hh','keepticks')
shading interp
caxis([-0.4 0.4])
colormap(bluered)
% cmocean('balance')
hc = colorbar;
ax = gca;
ax.FontSize = 12; 
xlabel('Time [hours]','FontSize',30,'FontWeight','bold')
ylabel('Depth [m]','FontSize',30,'FontWeight','bold')
title(['\fontsize{28}' 'v Velocity Hovmoller, Daily mean, (-72.5,-42.2302)'])
title(hc,'m/s','fontsize',20);
% % grid on
% xl=xline(time(1));
% xl.LineWidth = 2;
% xl=xline(time(7),'y');
% xl.LineWidth = 2;
% xl=xline(time(13));
% xl.LineWidth = 2;
% xl=xline(time(19),'y');
% xl.LineWidth = 2;
% xl=xline(time(25));
% xl.LineWidth = 2;
% xl=xline(time(31),'y');
% xl.LineWidth = 2;
% xl=xline(time(37));
% xl.LineWidth = 2;
% xl=xline(time(43),'y');
% xl.LineWidth = 2;
% xl=xline(time(49));
% xl.LineWidth = 2;
% xl=xline(time(55),'y');
% xl.LineWidth = 2;
% xl=xline(time(61));
% xl.LineWidth = 2;
% xl=xline(time(67),'y');
% xl.LineWidth = 2;
% xl=xline(time(73));
% xl.LineWidth = 2;
% xl=xline(time(79),'y');
% xl.LineWidth = 2;
% xl=xline(time(85));
% xl.LineWidth = 2;
% xl=xline(time(91),'y');
% xl.LineWidth = 2;
% xl=xline(time(97));
% xl.LineWidth = 2;
set(gca,'layer','top')
