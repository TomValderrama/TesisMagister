% close all; clear all; clc
% start
% 
% FileDirHorizslice= '/home/dexter/Documentos/CodigosTesis/MOSA_EXP1_VER/vort/horizslice/';
% hisfile = 'mosa_BGQ_his_M1_1h_WD_exp1_20210102.nc';
% gridfile=hisfile;
% nc = netcdf(gridfile,'r');
% lon = nc{'lon_rho'}(:);
% lat = nc{'lat_rho'}(:);
% mask= nc{'mask_rho'}(:);
% close(nc)
% vname='vort';
% %%
% time=linspace(738158, 738188,721); % VERANO
% % time=linspace(738340, 738370,721); % INVIERNO
% date=datevec(time);
% 
% var=[];
% for i= 1:721
%     [latt,lonn,mask,XI]=get_vort(hisfile,gridfile,i,-1,1);
%     var(:,:,i)=XI;
%     clc
%     clear XI
% end
% %%
% % maxvar=max(max(max(var)));
% % minvar=min(min(min(var)));
% 
% bluered=[linspace(0,1,8) linspace(1,1,7); linspace(0,0.8571,7) linspace(1,0,8); linspace(1,1,7) linspace(1,0,8)]';
% 
% for i=1:721
%     h=figure('Position', get(0, 'Screensize'),'Visible','off');
%     m_proj('miller','long',[-73.75 -72.3750],'lat',[-42.4058 -41.7191]); 
%     m_pcolor(lon,lat,var(:,:,i).*mask); shading interp
%     hold on
% 
%     m_grid('box','fancy','tickdir','in','backcolor',[.6 .6 .6],'xtick',5,'ytick',6,'fontsize',16);
%     set(findobj('tag','m_grid_color'),'facecolor',[.6 .6 .6])
%     caxis([-1e-4 1e-4])
%     colormap(bluered)
% 
%     m_usercoast('gumby','patch',[.9 .9 .9]);
%     hc=colorbar();
%     w = hc.FontSize;
%     hc.FontSize = 16;
% 
%     title(['\fontsize{20}'  'Vorticidad '   + string(datetime(date(i,:)))])
%     title(hc,'[s^{-1}]      ','fontsize',20);  
%     jpgname =sprintf('Vort_Hor_ver_exp1_%d',i);
%     saveas(h, fullfile(FileDirHorizslice,[ jpgname '.jpg']));
% end

%%


close all; clear all; clc
start;
addpath('/home/dexter/Documentos/croco/croco_tools/Visualization_tools/')

FileDirHorizslice= '/home/dexter/Documentos/CodigosTesis/MOSA_EXP4_INV/vort/horizslice/';
hisfile = 'mosa_BGQ_his_M1_1h_WD_exp4_20210703.nc';
gridfile=hisfile;
nc = netcdf(gridfile,'r');
lon = nc{'lon_rho'}(:);
lat = nc{'lat_rho'}(:);
mask= nc{'mask_rho'}(:);
close(nc)
vname='vort';

% time=linspace(738158, 738188,721); % VERANO
time=linspace(738340, 738370,721); % INVIERNO
date=datevec(time);

var=[];
for i= 1:721
    [latt,lonn,mask,XI]=get_vort(hisfile,gridfile,i,-1,1);
    var(:,:,i)=XI;
    clc
    clear XI
end

bluered=[linspace(0,1,8) linspace(1,1,7); linspace(0,0.8571,7) linspace(1,0,8); linspace(1,1,7) linspace(1,0,8)]';

for i=1:721
    h=figure('Position', get(0, 'Screensize') ,'Visible','off');
    m_proj('miller','long',[-73.75 -72.3750],'lat',[-42.4058 -41.7191]); 
    m_pcolor(lon,lat,var(:,:,i).*mask); shading interp
    hold on

    m_grid('box','fancy','tickdir','in','backcolor',[.6 .6 .6],'xtick',5,'ytick',6,'fontsize',16);
    set(findobj('tag','m_grid_color'),'facecolor',[.6 .6 .6])
    caxis([-1e-4 1e-4])
    colormap(bluered)

    m_usercoast('gumby','patch',[.9 .9 .9]);
    hc=colorbar();
    w = hc.FontSize;
    hc.FontSize = 16;

    title(['\fontsize{20}'  'Vorticidad '   + string(datetime(date(i,:)))])
    title(hc,'[s^{-1}]      ','fontsize',20);  
    jpgname =sprintf('Vort_Hor_exp4_inv_%d',i);
    saveas(h, fullfile(FileDirHorizslice,[ jpgname '.jpg']));
end