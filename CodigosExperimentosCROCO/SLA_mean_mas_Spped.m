clear all,close all
start
addpath('/home/dexter/Documentos/OpenDrift/opendrift/')
hisfile ='mosa_BGQ_his_M1_1h_WD_exp4_20210703.nc';gridfile=hisfile;
FileDir='/home/dexter/Documentos/CodigosTesis/MOSA_INV_EXP4/SLA/';

c=0;
for i=1:721
    c=c+1;
[lat,lon,mask,var]=get_var(hisfile,[],['zeta'],i,1,1,[250 15 440 143]);
zeta(:,:,c)=var;
res=var-nanmean(var);
sla(:,:,c)=res;

[~,~,~,u(:,:,c)]=get_var(hisfile,[],'u',i,1,1,[249 15 440 143]);
[~,~,~,v(:,:,c)]=get_var(hisfile,[],'v',i,1,1,[250 15 439 143]);

[~,~,~,var2]=get_var(hisfile,[],['zeta'],i,1,1,[260 25 450 153]);
zeta2(:,:,c)=var2;
res2=var2-nanmean(var2);
sla2(:,:,c)=res2;
end

%%
c=0;
for i=1:30
zetaH=zeta(:,:,(1:24)+24*c);
zetaM=mean(zetaH(:,:,:),3);
zm(:,:,i)=zetaM;

zeta2H=zeta2(:,:,(1:24)+24*c);
zeta2M=mean(zeta2H(:,:,:),3);
zm2(:,:,i)=zeta2M;

uH=u(:,:,(1:24)+24*c);
uM=mean(uH(:,:,:),3);
um(:,:,i)=uM;

vH=v(:,:,(1:24)+24*c);
vM=mean(vH(:,:,:),3);
vm(:,:,i)=vM;

slaH=sla(:,:,(1:24)+24*c);
slaM=mean(slaH(:,:,:),3);
slam(:,:,i)=slaM;

sla2H=sla2(:,:,(1:24)+24*c);
sla2M=mean(sla2H(:,:,:),3);
sla2m(:,:,i)=sla2M;

    c=c+1;
end
%%
clear zeta zeta2 sla sla2 res res2 u v 
%%
clc
if abs(min(min(min(sla2m))))< abs(max(max(max(sla2m))))
    cmax=(max(max(max(sla2m))));
    cmin=-(max(max(max(sla2m))));
else abs(min(min(min(sla2m))))> abs(max(max(max(sla2m))))
     cmax=abs(min(min(min(sla2m))));
     cmin=min(min(min(sla2m)));
end
%%
close all
% time=linspace(738158, 738188,31); %VERANO
time=linspace(738340, 738370,31); % INVIERNO
date=datevec(time);

for i=1:30
h=figure('Position', get(0, 'Screensize'),'Visible','off');
m_proj('miller','long',[-73.75 -72.3750],'lat',[-42.4058 -41.7191]);
m_pcolor(lon,lat,slam(:,:,i));shading interp; hold on
m_quiver(lon,lat,um(:,:,i),vm(:,:,i),10,'k')

m_grid('box','fancy','tickdir','in','backcolor',[.6 .6 .6],'xtick',5,'ytick',6,'fontsize',16);
set(findobj('tag','m_grid_color'),'facecolor',[1. 1. 1.]); 
% caxis([-0.2 0.2]);
caxis([cmin cmax]);
cmocean('balance'), hc=colorbar;
legend('','vel [m/s]')
hc=colorbar; legend('','','vel [m/s]')

    xlabel('Longitud','FontSize',34,'FontWeight','bold')
    ylabel('Latitud','FontSize',34,'FontWeight','bold')
    title(['\fontsize{28}' 'Daily mean SLA + Velocity, '  + string(datetime(date(i,:)))])
    title(hc,'[m]','fontsize',20);  
    ax = gca;
    ax.FontSize = 16; 
    jpgname =sprintf('SLA_MD_V_INV_EXP4_%d',i);
    saveas(h, fullfile(FileDir,[ jpgname '.jpg']));
end

msla=mean(slam,3);
msla2=mean(sla2m,3);
mu=mean(um,3);
mv=mean(vm,3);

if abs(min(min(min(msla2))))< abs(max(max(max(msla2))))
    cmax=(max(max(max(msla2))));
    cmin=-(max(max(max(msla2))));
else abs(min(min(min(msla2))))> abs(max(max(max(msla2))))
     cmax=abs(min(min(min(msla2))));
     cmin=min(min(min(msla2)));
end
%%


h=figure('Position', get(0, 'Screensize') ...
    ,'Visible','off');
m_proj('miller','long',[-73.75 -72.3750],'lat',[-42.4058 -41.7191]);
m_pcolor(lon,lat,msla);shading interp; hold on
m_quiver(lon,lat,mu,mv,10,'k')

m_grid('box','fancy','tickdir','in','backcolor',[.6 .6 .6],'xtick',5,'ytick',6,'fontsize',16);
set(findobj('tag','m_grid_color'),'facecolor',[1. 1. 1.]); 
% caxis([-0.2 0.2]);
caxis([cmin cmax]);
cmocean('balance'), hc=colorbar;
legend('','vel [m/s]')
hc=colorbar; legend('','','vel [m/s]')

    xlabel('Longitud','FontSize',34,'FontWeight','bold')
    ylabel('Latitud','FontSize',34,'FontWeight','bold')
    title(['\fontsize{28}' 'SLA + Velocity, July Monthly mean'])
    title(hc,'[m]','fontsize',20);  
    ax = gca;
    ax.FontSize = 16; 
    jpgname =sprintf('SLA_MM_V_INV_exp4');
    saveas(h, fullfile(FileDir,[ jpgname '.jpg']));
