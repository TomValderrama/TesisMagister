clear all,close all
start
addpath('/home/dexter/Documentos/OpenDrift/opendrift/')
hisfile =['mosa_BGQ_his_M1_1h_WD_exp4_20210703.nc'];gridfile=hisfile;
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

if abs(min(min(min(sla2))))< abs(max(max(max(sla2))))
    cmax=(max(max(max(sla2))));
    cmin=-(max(max(max(sla2))));
else abs(min(min(min(sla2))))> abs(max(max(max(sla2))))
     cmax=abs(min(min(min(sla2))));
     cmin=min(min(min(sla2)));
end
%%
% time=linspace(738158, 738188,721); %VERANO
time=linspace(738340, 738370,721); % INVIERNO
date=datevec(time);

for i=1:721
h=figure('Position', get(0, 'Screensize'),'Visible','off');
m_proj('miller','long',[-73.75 -72.3750],'lat',[-42.4058 -41.7191]);
m_pcolor(lon,lat,sla(:,:,i));shading interp; hold on
m_quiver(lon,lat,u(:,:,i),v(:,:,i),10,'k')

m_grid('box','fancy','tickdir','in','backcolor',[.6 .6 .6],'xtick',5,'ytick',6,'fontsize',16);
set(findobj('tag','m_grid_color'),'facecolor',[1. 1. 1.]); 
caxis([-0.2 0.2]);
cmocean('balance'), hc=colorbar;
legend('','vel [m/s]')
hc=colorbar; legend('','','vel [m/s]')

    xlabel('Longitud','FontSize',34,'FontWeight','bold')
    ylabel('Latitud','FontSize',34,'FontWeight','bold')
    title(['\fontsize{28}' 'SLA + Velocity, '  + string(datetime(date(i,:)))])
    title(hc,'[m]','fontsize',20);  
    ax = gca;
    ax.FontSize = 16; 
    jpgname =sprintf('SLA_V_exp4_INV_%d',i);
    saveas(h, fullfile(FileDir,[ jpgname '.jpg']));
end