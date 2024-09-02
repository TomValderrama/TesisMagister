% Load your wind stress data here or generate sample data
% For example, if you have sustr and svstr data:
% Load your data or generate sample data, for example:
% sustr = rand(38, 56, 721); % Replace with your actual data
% svstr = rand(37, 56, 721); % Replace with your actual data

% close all,clear all; clc,start
addpath('D:\OneDrive\Documents\AAMagister\Ancud\20210102');
addpath('D:\OneDrive\Documents\AAMagister\PRODIGY\Week 1\data_sets\github_repo\')
start
hisfile = 'ancud_exp2_inv.nc';
gridfile=hisfile;


for i=73:721
    [lat1,lon1,mask,var1]=get_var(hisfile,[],['zeta'],i,-1,1,[0 0 0 0]); %   USAR ESTA EXTRACCIÓN DE VARIABLES
    zeta(:,:,i)=var1;
    [latu,lonu,masku,var2]=get_var(hisfile,[],['sustr'],i,-1,1,[0 0 0 0]); 
    sustr_u(:,:,i-72)=var2;
    [latv,lonv,maskv,var3]=get_var(hisfile,[],['svstr'],i,-1,1,[0 0 0 0]); 
    svstr_v(:,:,i-72)=var3;
end
%%
[u_r]=u2rho_3d(permute(sustr_u,[3,1,2]));
sustr=permute(u_r,[2,3,1]);
[v_r]=v2rho_3d(permute(svstr_v,[3,1,2]));
svstr=permute(v_r,[2,3,1]);

% Define grid spacing and size
dx = 1; % Horizontal grid spacing (in meters)
dy = 1; % Vertical grid spacing (in meters)
[ny, nx, nt] = size(sustr); % Size of the grid and time steps

% Initialize arrays for wind stress curl components
sustr_curl = zeros(ny, nx, nt);
svstr_curl = zeros(ny, nx, nt);

% Loop through time steps
for t = 1:nt
    % Loop through the grid points (excluding the boundaries)
    for i = 2:nx-1
        for j = 2:ny-1
            % Calculate the derivatives using central differences for sustr
            dSustr_dx = (sustr(j, i+1, t) - sustr(j, i-1, t)) / (2 * dx);
            dSustr_dy = (sustr(j+1, i, t) - sustr(j-1, i, t)) / (2 * dy);
            
            % Calculate the derivatives using central differences for svstr
            dSvstr_dx = (svstr(j, i+1, t) - svstr(j, i-1, t)) / (2 * dx);
            dSvstr_dy = (svstr(j+1, i, t) - svstr(j-1, i, t)) / (2 * dy);
            
            % Calculate the wind stress curl components
            sustr_curl(j, i, t) = dSvstr_dx - dSustr_dy;
            svstr_curl(j, i, t) = dSustr_dx - dSvstr_dy;
        end
    end
end

% Now, sustr_curl and svstr_curl contain the wind stress curl components.
% You can combine them to get the total wind stress curl.
%%
wind_stress_curl = sustr_curl + svstr_curl;
wscm=nanmean(wind_stress_curl(:,:,:),3);
sustrMM=nanmean(sustr(:,:,:),3);
svstrMM=nanmean(svstr(:,:,:),3);
% Now, wind_stress_curl contains the total wind stress curl for each grid point and time step.
% You can use this data for further analysis or visualization.

%%
close all
h=figure('Units','characters','Position',[-2.666000000000000e+02,-0.923076923076923,266,77.461538461538470])%('Position', get(0, 'Screensize'))%,'Visible','off');
m_proj('miller','long',[-73.55 -72.4250],'lat',[-42.4611 -41.7191]);
m_pcolor(lon1,lat1,wscm); shading interp
hold on
% m_grid('box','fancy','tickdir','in','backcolor',[1 1 1],'xtick',8,'ytick',10,'xticklabel',[],'fontsize',50);
% m_grid('box','fancy','tickdir','in','backcolor',[1 1 1],'xtick',8,'ytick',10,'yticklabel',[],'fontsize',50);
% m_grid('box','fancy','tickdir','in','backcolor',[1 1 1],'xtick',8,'ytick',10,'xticklabel',[],'yticklabel',[],'fontsize',40);
m_grid('box','fancy','tickdir','in','backcolor',[1 1 1],'xtick',8,'ytick',10,'fontsize',40);

set(gca, 'xticklabels', {});    
% caxis([-2.4634e-04    2.4634e-04])
caxis([-5.4966e-04    5.4966e-04])
m_gshhs_f('patch',[.8 .8 .8]);
colorbar
cmocean('balance',27)

[hpv5, htv5]=m_vec(0.2,lon1(31,47),lat1(31,47), 0.1 ,0,'k','shaftwidth',2,'headlength',6,'key',{'10 [cm/s]'}); % ese 0.1 es equivalente a que un vector sea de 10 cm/s

m_vec(0.2,lon1,lat1,sustrMM,svstrMM,'k','headangle',30,'headwidth',4,'headlength',7,'shaftwidth', 1,'centered', 'yes');

set(htv5,'FontSize',12,'FontWeight','bold');

%%

h=figure('Units','characters','Position',[-2.666000000000000e+02,-0.923076923076923,266,77.461538461538470])%('Position', get(0, 'Screensize'))%,'Visible','off');
m_proj('miller','long',[-73.55 -72.4250],'lat',[-42.4611 -41.7191]);
m_pcolor(lon1,lat1, wind_stress_curl(:,:,571)); shading interp
hold on
% m_grid('box','fancy','tickdir','in','backcolor',[1 1 1],'xtick',8,'ytick',10,'xticklabel',[],'fontsize',50);
% m_grid('box','fancy','tickdir','in','backcolor',[1 1 1],'xtick',8,'ytick',10,'yticklabel',[],'fontsize',50);
% m_grid('box','fancy','tickdir','in','backcolor',[1 1 1],'xtick',8,'ytick',10,'xticklabel',[],'yticklabel',[],'fontsize',40);
m_grid('box','fancy','tickdir','in','backcolor',[1 1 1],'xtick',8,'ytick',10,'fontsize',40);

set(gca, 'xticklabels', {});    
% caxis([-2.4634e-04    2.4634e-04])
caxis([-5.4966e-04    5.4966e-04])
m_gshhs_f('patch',[.8 .8 .8]);
% colorbar
cmocean('balance',27)

[hpv5, htv5]=m_vec(0.2,lon1(31,47),lat1(31,47),-0.1,0,'k','shaftwidth',2,'headlength',6,'key',{'10 [cm/s]'});
set(htv5,'FontSize',12,'FontWeight','bold');
m_vec(0.2,lon1(1:end,1:end),lat1(1:end,1:end),sustr(1:end,1:end,571),svstr(1:end,1:end,571),'k', ...
    'centered','yes','shaftwidth',2,'headlength',6,'edgeclip','on','EdgeColor','w');

%% colorbar

h=figure('Units','characters','Position',[-2.666000000000000e+02,-0.923076923076923,266,77.461538461538470])
hold on
caxis([-5.4966e-04    5.4966e-04])
colormap(cmocean('balance',27))
c=colorbar('north')
set(c,'Position',[0.2 0.7 0.6 0.03])
c.Label.String = 'meters [m]';
c.Label.FontSize=16;
c.Label.FontWeight="bold";
c.LineWidth=1.5;
c.FontSize=30;