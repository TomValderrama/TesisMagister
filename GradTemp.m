close all; clear all; clc
start

FileDirHorizslice= '/home/dexter/Documentos/OpenDrift/opendrift/MOSA_EXP1/grad/horizslice2';
hisfile = 'mosa_BGQ_his_M1_1h_WD_exp1.nc';
gridfile=hisfile;
vname='temp';
days=504;
dx=2.7; % km
ini=336;
c=0;

for i=1:days
    c=c+1;
[lat,lon,mask,variable]=get_var(hisfile,[],vname,i,-1,1,[4 12 11 10]);
var(:,:,c)=variable;
end 

% temp01 = squeeze(mean(temp01)).*mask;
[gtx01,gty01] = gradient(var,dx);
G01 = sqrt(gtx01.^2+gty01.^2);
min=min(min(min(G01)));
max=max(max(max(G01)));
% max=max-0.2;
% gradred=[linspace(0,1,8) linspace(1,0,7); linspace(0,0.8571,7) linspace(1,0,8); linspace(1,1,7) linspace(1,0,8)]';
gradred=[linspace(1,1,15);linspace(1,0,15);linspace(1,0,15)]';
clear vname
vname='Grad Temp';


%%
for i=ini:days
    h=figure('Position', get(0, 'Screensize'),'Visible','off');
    m_proj('miller','long',[-73.55 -72.4250],'lat',[-42.4611 -41.7191]);
    m_pcolor(lon,lat,G01(:,:,i).*mask); shading interp
    hold on
    m_grid('box','fancy','tickdir','in','backcolor',[.6 .6 .6],'xtick',5,'ytick',6,'fontsize',16);
    caxis([0 0.3])
    colormap(gradred)

    title(['\fontsize{20}' 'Gradiente T ' sprintf(' - hora %d del mes', i)])
    jpgname =sprintf('CROP_MOSA_-%d_',i);
    saveas(h, fullfile(FileDirHorizslice,[ jpgname vname '.jpg']));
end

for i=722:722
    h=figure('Position', get(0, 'Screensize'),'Visible','off');
    m_proj('miller','long',[-73.55 -72.4250],'lat',[-42.4611 -41.7191]);
    m_pcolor(lon,lat,G01(:,:,1).*mask); shading interp
    hold on
    m_grid('box','fancy','tickdir','in','backcolor',[.6 .6 .6],'xtick',5,'ytick',6,'fontsize',16);
    caxis([0 0.3])
    colormap(gradred)
    fixcolorbar([0.2 0.9 0.6 0.03],[0 0.3],vname,13)
    title(['\fontsize{20}' 'Gradiente T ' sprintf(' - hora %d del mes', i)])
    jpgname =sprintf('CROP_MOSA_-%d_',i);
    saveas(h, fullfile(FileDirHorizslice,[ jpgname vname '.jpg']));
end
