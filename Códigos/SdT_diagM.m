% Extracción serie de tiempo u lat=-42.072647094726560, lon=-72.962497711181640
% Extracción serie de tiempo v lat=-42.081922531127930, lon=-72.949996948242190
close all; clear all
start
hisfile='croco_diaM_TV.nc';
gridfile=hisfile;
%%
for i=1:721
    c=0;
    c=c+1;

    [lat_u,lon_u,mask,var]=get_var(hisfile,gridfile,'u_Prsgrd',i,-1,1,[281 38 458 162]);
    u_Prsgrd(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'u_cor',i,-1,1,[281 38 458 162]);
    u_cor(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_hmix',i,-1,1,[281 38 458 162]);
    u_hmix(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_rate',i,-1,1,[281 38 458 162]);
    u_rate(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_vadv',i,-1,1,[281 38 458 162]);
    u_vadv(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_vmix',i,-1,1,[281 38 458 162]);
    u_vmix(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_xadv',i,-1,1,[281 38 458 162]);
    u_xadv(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_yadv',i,-1,1,[281 38 458 162]);
    u_yadv(:,:,c)=var;
    clear var;
    
    [lat_v,lon_v,mask,var]=get_var(hisfile,gridfile,'v_Prsgrd',i,-1,1,[282 38 457 162]);
    v_Prsgrd(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_cor',i,-1,1,[282 38 457 162]);
    v_cor(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_hmix',i,-1,1,[282 38 457 162]);
    v_hmix(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_rate',i,-1,1,[282 38 457 162]);
    v_rate(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_vadv',i,-1,1,[282 38 457 162]);
    v_vadv(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_vmix',i,-1,1,[282 38 457 162]);
    v_vmix(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_xadv',i,-1,1,[282 38 457 162]);
    v_xadv(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_yadv',i,-1,1,[282 38 457 162]);
    v_yadv(:,:,c)=var;
    clear var;
end

%%
close all
u_Prsgrd=reshape(u_Prsgrd,721,1); u_cor=reshape(u_cor,721,1);
u_hmix=reshape(u_hmix,721,1); u_rate=reshape(u_rate,721,1);
u_vadv=reshape(u_vadv,721,1); u_vmix=reshape(u_vmix,721,1);
u_xadv=reshape(u_xadv,721,1); u_yadv=reshape(u_yadv,721,1);
    
% figure()
% plot(1:721,u_Prsgrd)
% hold on
% plot(1:721,u_cor)
% plot(1:721,u_hmix)
% plot(1:721,u_rate)
% plot(1:721,u_vadv)
% plot(1:721,u_vmix)
% plot(1:721,u_xadv)
% plot(1:721,u_yadv)
% title('Serie de tiempo variables ecuación de momento, u')
% legend('Pressure gradient term',...
%     'Coriolis term','Horizontal mixing term','Time rate of change','Vertical advection term',...
%     'Vertical mixing term','Horizontal (xi) advection term',...
%     'Horizontal (eta) advection term','Location','best')
% v_Prsgrd=reshape(v_Prsgrd,721,1); v_cor=reshape(v_cor,721,1);
% v_hmix=reshape(v_hmix,721,1); v_rate=reshape(v_rate,721,1);
% v_vadv=reshape(v_vadv,721,1); v_vmix=reshape(v_vmix,721,1);
% v_xadv=reshape(v_xadv,721,1); v_yadv=reshape(v_yadv,721,1);
%     
% figure()
% plot(1:721,v_Prsgrd)
% hold on
% plot(1:721,v_cor)
% plot(1:721,v_hmix)
% plot(1:721,v_rate)
% plot(1:721,v_vadv)
% plot(1:721,v_vmix)
% plot(1:721,v_xadv)
% plot(1:721,v_yadv)
% title('Serie de tiempo variables ecuación de momento, v')
% legend('Pressure gradient term',...
%     'Coriolis term','Horizontal mixing term','Time rate of change','Vertical advection term',...
%     'Vertical mixing term','Horizontal (xi) advection term',...
%     'Horizontal (eta) advection term','Location','best')
%% MEDIA DIARIA U
for k = 1:24:numel(u_cor)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(u_cor)));
    u_cor_DailyMean(k2) = mean(u_cor(idx));
end

for k = 1:24:numel(u_hmix)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(u_hmix)));
    u_hmix_DailyMean(k2) = mean(u_hmix(idx));
end

for k = 1:24:numel(u_Prsgrd)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(u_Prsgrd)));
    u_Prsgrd_DailyMean(k2) = mean(u_Prsgrd(idx));
end

for k = 1:24:numel(u_rate)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(u_rate)));
    u_rate_DailyMean(k2) = mean(u_rate(idx));
end

for k = 1:24:numel(u_vadv)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(u_vadv)));
    u_vadv_DailyMean(k2) = mean(u_vadv(idx));
end

for k = 1:24:numel(u_vmix)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(u_vmix)));
    u_vmix_DailyMean(k2) = mean(u_vmix(idx));
end

for k = 1:24:numel(u_xadv)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(u_xadv)));
    u_xadv_DailyMean(k2) = mean(u_xadv(idx));
end

for k = 1:24:numel(u_yadv)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(u_yadv)));
    u_yadv_DailyMean(k2) = mean(u_yadv(idx));
end
%%
figure()
plot(1:31,u_Prsgrd_DailyMean)
hold on
plot(1:31,u_cor_DailyMean)
plot(1:31,u_hmix_DailyMean)
plot(1:31,u_rate_DailyMean)
plot(1:31,u_vadv_DailyMean)
plot(1:31,u_vmix_DailyMean)
plot(1:31,u_xadv_DailyMean)
plot(1:31,u_yadv_DailyMean)
title('Serie de tiempo, media diaria, variables ecuación de momento, u')
legend('Pressure gradient term',...
    'Coriolis term','Horizontal mixing term','Time rate of change','Vertical advection term',...
    'Vertical mixing term','Horizontal (xi) advection term',...
    'Horizontal (eta) advection term','Location','best')
%% MEDIA DIARIA V
for k = 1:24:numel(v_cor)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(v_cor)));
    v_cor_DailyMean(k2) = mean(v_cor(idx));
end

for k = 1:24:numel(v_hmix)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(v_hmix)));
    v_hmix_DailyMean(k2) = mean(v_hmix(idx));
end

for k = 1:24:numel(v_Prsgrd)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(v_Prsgrd)));
    v_Prsgrd_DailyMean(k2) = mean(v_Prsgrd(idx));
end

for k = 1:24:numel(v_rate)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(v_rate)));
    v_rate_DailyMean(k2) = mean(v_rate(idx));
end

for k = 1:24:numel(v_vadv)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(v_vadv)));
    v_vadv_DailyMean(k2) = mean(v_vadv(idx));
end

for k = 1:24:numel(v_vmix)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(v_vmix)));
    v_vmix_DailyMean(k2) = mean(v_vmix(idx));
end

for k = 1:24:numel(v_xadv)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(v_xadv)));
    v_xadv_DailyMean(k2) = mean(v_xadv(idx));
end

for k = 1:24:numel(v_yadv)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(v_yadv)));
    v_yadv_DailyMean(k2) = mean(v_yadv(idx));
end

figure()
plot(1:31,v_Prsgrd_DailyMean)
hold on
plot(1:31,v_cor_DailyMean)
plot(1:31,v_hmix_DailyMean)
plot(1:31,v_rate_DailyMean)
plot(1:31,v_vadv_DailyMean)
plot(1:31,v_vmix_DailyMean)
plot(1:31,v_xadv_DailyMean)
plot(1:31,v_yadv_DailyMean)
title('Serie de tiempo, media diaria, variables ecuación de momento, v')
legend('Pressure gradient term',...
    'Coriolis term','Horizontal mixing term','Time rate of change','Vertical advection term',...
    'Vertical mixing term','Horizontal (xi) advection term',...
    'Horizontal (eta) advection term','Location','best')