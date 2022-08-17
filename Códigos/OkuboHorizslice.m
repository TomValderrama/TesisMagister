close all; clear all; clc
start

FileDirHorizslice= '/home/dexter/Documentos/OpenDrift/opendrift/MOSA_1m_1h/okubo/horizslice2';
hisfile = 'mosa_BGQ_his_M1_1h_WD.nc';
gridfile=hisfile;
nc = netcdf(gridfile,'r');
lon = nc{'lon_rho'}(:);
lat = nc{'lat_rho'}(:);
mask= nc{'mask_rho'}(:);
close(nc)
vname='okubo';
days=721;
cte=0;

var=[];
for i= 1:days
    [latt,lonn,mask,XI]=get_okubo(hisfile,gridfile,i,-1,1);
    var(:,:,i)=XI;
    clc
    
%     xi = cat(4,xi,XI);
    clear XI
end

maxvar=max(max(max(var)));
minvar=min(min(min(var)));

%% PLOTEO


for i=1:days
    h=figure('Position', get(0, 'Screensize'),'Visible','off');
    m_proj('miller','long',[-73.55 -72.4250],'lat',[-42.4611 -41.7191]);
    m_pcolor(lon,lat,var(:,:,i).*mask); shading interp
    hold on
    m_grid('box','fancy','tickdir','in','backcolor',[.6 .6 .6],'xtick',5,'ytick',6,'fontsize',16);
    caxis([-2e-12 2e-12])
    colormap(hot)

    title(['\fontsize{20}' 'Okubo ' sprintf(' - hora %d del mes', i)])
    jpgname =sprintf('CROP_MOSA_-%d_',i);
    saveas(h, fullfile(FileDirHorizslice,[ jpgname vname '.jpg']));
end

for i=722:722
    h=figure('Position', get(0, 'Screensize'),'Visible','off');
    m_proj('miller','long',[-73.55 -72.4250],'lat',[-42.4611 -41.7191]);
    m_pcolor(lon,lat,var(:,:,1).*mask); shading flat
    hold on
    m_grid('box','fancy','tickdir','in','backcolor',[.6 .6 .6],'xtick',5,'ytick',6,'fontsize',16);
    caxis([-2e-12 2e-12])
    colormap(hot)
    fixcolorbar([0.2 0.9 0.6 0.03],[-2e-12 2e-12],vname,13)
    title(['\fontsize{20}' 'Vorticidad ' sprintf(' - hora %d del mes', i)])
    jpgname =sprintf('CROP_MOSA_-%d_',i);
    saveas(h, fullfile(FileDirHorizslice,[ jpgname vname '.jpg']));
end