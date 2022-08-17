close all
clear all
start
  ssfname='/home/dexter/Documentos/OpenDrift/opendrift/batimetria/topo_23.1.img';
% hisfile = 'mosa_BGQ_his_M1_1h_WD_2.nc';
% nc = netcdf(hisfile,'r');
% lon = nc{'lon_rho'}(:);
% lat = nc{'lat_rho'}(:);
% z = nc{'h'}(:);
% mask= nc{'mask_rho'}(:);
 
  
% Extract data
  [elevations,lat,lon]=mygrid_sand2([-85. -30 -63 0 ],ssfname);
  [elevations,lat,lon]=mygrid_sand2([-73.974826 -72.219374 -42.562278 -41.410082],ssfname);
elevations(elevations > 1)=NaN;

%   lat=lat';
%   lat=repmat(lat,1,68);
%   lon=repmat(lon,61,1);
lon=lon-360;
  %% 
  close all
  % Use in M_Map command
  figure('Position', get(0, 'Screensize'))% ,'Visible','off');

  m_proj('mercator','long',[-73.974826 -72.219374],'lat',[-42.562278 -41.410082]);
colormap([m_colmap('blues',64)])%;m_colmap('gland',128)])
% m_pcolor(lon,lat,-z); shading interp
m_pcolor(lon,lat,elevations); shading interp

    hold on

    m_grid('box','fancy','tickdir','in','backcolor',[.6 .6 .6],'xtick',5,'ytick',5,'fontsize',16);
    set(findobj('tag','m_grid_color'),'facecolor',[.6 .6 .6]);
    colorbar
%     caxis([-1e-4 1e-4])
%     colormap(bluered)
%     cptcmap('jet', 'mapping', 'scaled');
    m_usercoast('gumby2','patch',[.9 .9 .9]);

%     m_line([-73.4:0.025:-72.66],-42.075,'marker','o','color',[0 .5 0],...
%           'linest','none','markerfacecolor','w','clip','point');
     
m_line(-72.962497711181640,-42.072647094726560,'marker','p','color',[0 0. 0],...
          'linest','none','markerfacecolor','w','clip','point'); % SdT diags u
      
% m_line(-72.949996948242190,-42.081922531127930,'marker','p','color',[1 0 0],...
%           'linest','none','markerfacecolor','w','clip','point'); % SdT diags v

%     m_line(-72.95, [-42.3:0.02:-41.88683],'marker','o','color',[1 0. 0],...
%           'linest','none','markerfacecolor','w','clip','point');

    title('\fontsize{20} Punto de análisis SdT de variables diagnósticas (u)')
%   m_grid('linestyle','none','tickdir','out','linewidth',3);

%     m_pcolor(lon,lat,elevations);
%     pcolor(lon,lat,elevations);

  