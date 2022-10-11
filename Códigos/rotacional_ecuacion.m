clear all;
close all; clc
start
hisfile='croco_diaM_TV.nc';
gridfile=hisfile;

c=0;
for i=1:4
     c=c+1;
%     [lat_u,lon_u,mask,var]=get_var(hisfile,gridfile,'u_Prsgrd',i,-1,1,[250 15 440 143]);
%     u_Prsgrd(:,:,c)=var;
%     clear var;
% 
%     [~,~,~,var]=get_var(hisfile,gridfile,'u_cor',i,-1,1,[250 15 440 143]);
%     u_cor(:,:,c)=var;
%     clear var;
%         
    [~,~,~,var]=get_var(hisfile,gridfile,'u_hmix',i,-1,1,[250 15 440 143]);
    u_hmix(:,:,c)=var;
    clear var;
        
%     [~,~,~,var]=get_var(hisfile,gridfile,'u_rate',i,-1,1,[250 15 440 143]);
%     u_rate(:,:,c)=var;
%     clear var;
%         
%     [~,~,~,var]=get_var(hisfile,gridfile,'u_vadv',i,-1,1,[250 15 440 143]);
%     u_vadv(:,:,c)=var;
%     clear var;
%         
%     [~,~,~,var]=get_var(hisfile,gridfile,'u_vmix',i,-1,1,[250 15 440 143]);
%     u_vmix(:,:,c)=var;
%     clear var;
%         
%     [~,~,~,var]=get_var(hisfile,gridfile,'u_xadv',i,-1,1,[250 15 440 143]);
%     u_xadv(:,:,c)=var;
%     clear var;
%         
%     [~,~,~,var]=get_var(hisfile,gridfile,'u_yadv',i,-1,1,[250 15 440 143]);
%     u_yadv(:,:,c)=var;
%     clear var;
%     
%     [lat_v,lon_v,mask,var]=get_var(hisfile,gridfile,'v_Prsgrd',i,-1,1,[251 15 439 143]);
%     v_Prsgrd(:,:,c)=var;
%     clear var;
%     
%     [~,~,~,var]=get_var(hisfile,gridfile,'v_cor',i,-1,1,[251 15 439 143]);
%     v_cor(:,:,c)=var;
%     clear var;
%     
%     [~,~,~,var]=get_var(hisfile,gridfile,'v_hmix',i,-1,1,[251 15 439 143]);
%     v_hmix(:,:,c)=var;
%     clear var;
%     
%     [~,~,~,var]=get_var(hisfile,gridfile,'v_rate',i,-1,1,[251 15 439 143]);
%     v_rate(:,:,c)=var;
%     clear var;
%     
%     [~,~,~,var]=get_var(hisfile,gridfile,'v_vadv',i,-1,1,[251 15 439 143]);
%     v_vadv(:,:,c)=var;
%     clear var;
%     
%     [~,~,~,var]=get_var(hisfile,gridfile,'v_vmix',i,-1,1,[251 15 439 143]);
%     v_vmix(:,:,c)=var;
%     clear var;
%     
%     [~,~,~,var]=get_var(hisfile,gridfile,'v_xadv',i,-1,1,[251 15 439 143]);
%     v_xadv(:,:,c)=var;
%     clear var;
%     
%     [~,~,~,var]=get_var(hisfile,gridfile,'v_yadv',i,-1,1,[251 15 439 143]);
%     v_yadv(:,:,c)=var;
%     clear var;
end

%%
c=0;
for i=1:721
    c=c+1;
P=curl(u_Prsgrd(:,:,i), v_Prsgrd(:,:,i));
Prsgrd(:,:,c)=P;

f=curl(u_cor(:,:,i), v_cor(:,:,i));
cor(:,:,c)=f;

h=curl(u_hmix(:,:,i), v_hmix(:,:,i));
hmix(:,:,c)=h;

r=curl(u_rate(:,:,i), v_rate(:,:,i));
rate(:,:,c)=r;

vv=curl(u_vadv(:,:,i), v_vadv(:,:,i));
vadv(:,:,c)=vv;

vx=curl(u_vmix(:,:,i), v_vmix(:,:,i));
vmix(:,:,c)=vx;

xv=curl(u_xadv(:,:,i), v_xadv(:,:,i));
xadv(:,:,c)=xv;

yv=curl(u_yadv(:,:,i), v_yadv(:,:,i));
yadv(:,:,c)=yv;
end
                                                                                           
clear u_*; clear v_*; clear yv xv vx vv r h f P
%% Ahora estoy haciendo el primer día, hacer una transecta de la media y
% la mediana

close all

figure()
plot(lon_u(19,:),nanmean(Prsgrd(19,:,:),3)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('P')
ylim([-3.532442538634432e-05 3.759084486287266e-05])

figure()
plot(lat_u(:,32),nanmean(Prsgrd(:,32,:),3)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('P')
ylim([-3.532442538634432e-05 3.759084486287266e-05])
 

figure()
plot(lon_u(19,:),cor(19,:,1)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('c')
ylim([-3.532442538634432e-05 3.759084486287266e-05])
 

figure()
plot(lat_u(:,32),cor(:,32,1)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('c')
ylim([-3.532442538634432e-05 3.759084486287266e-05])
 

figure()
plot(lon_u(19,:),hmix(19,:,1)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('h')
ylim([-3.532442538634432e-05 3.759084486287266e-05])

figure()
plot(lat_u(:,32),hmix(:,32,1)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('h')
ylim([-6.886400023583502e-04  5.002652961423142e-04])

%% 

figure()
plot(lon_u(19,:),rate(19,:,1)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('r')
ylim([-3.532442538634432e-05 3.759084486287266e-05])

figure()
plot(lat_u(:,32),rate(:,32,1)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('r')
ylim([-3.532442538634432e-05 3.759084486287266e-05])
%% 

figure()
plot(lon_u(19,:),vadv(19,:,1)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('vadv')
ylim([-3.532442538634432e-05 3.759084486287266e-05])

figure()
plot(lat_u(:,32),vadv(:,32,1)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('vadv')
ylim([-3.532442538634432e-05 3.759084486287266e-05])

figure()
plot(lon_u(19,:),vmix(19,:,1)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('vmix')
ylim([-3.532442538634432e-05 3.759084486287266e-05])

figure()
plot(lat_u(:,32),vmix(:,32,1)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('vmix')
ylim([-3.532442538634432e-05 3.759084486287266e-05])

figure()
plot(lon_u(19,:),nanmean(xadv(19,:,:),3)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('xadv')
ylim([-3.532442538634432e-05 3.759084486287266e-05])

figure()
plot(lat_u(:,32),xadv(:,32,1)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('xadv')
ylim([-3.532442538634432e-05 3.759084486287266e-05])


figure()
plot(lon_u(19,:),yadv(19,:,1)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('yadv')
ylim([-3.532442538634432e-05 3.759084486287266e-05])

figure()
plot(lat_u(:,32),yadv(:,32,1)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('yadv')
ylim([-3.532442538634432e-05 3.759084486287266e-05])

%% PROFUNDIDAD 25m
c=0;
for i=1:721
     c=c+1;
    [~,~,~,var]=get_var(hisfile,gridfile,'u_Prsgrd',i,-25,1,[250 15 440 143]);
    u_Prsgrd25(:,:,c)=var;
    clear var;

    [~,~,~,var]=get_var(hisfile,gridfile,'u_cor',i,-25,1,[250 15 440 143]);
    u_cor25(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_hmix',i,-25,1,[250 15 440 143]);
    u_hmix25(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_rate',i,-25,1,[250 15 440 143]);
    u_rate25(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_vadv',i,-25,1,[250 15 440 143]);
    u_vadv25(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_vmix',i,-25,1,[250 15 440 143]);
    u_vmix25(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_xadv',i,-25,1,[250 15 440 143]);
    u_xadv25(:,:,c)=var;
    clear var;
        
    [~,~,~,var]=get_var(hisfile,gridfile,'u_yadv',i,-25,1,[250 15 440 143]);
    u_yadv25(:,:,c)=var;
    clear var;
    
    [lat_v,lon_v,mask,var]=get_var(hisfile,gridfile,'v_Prsgrd',i,-25,1,[251 15 439 143]);
    v_Prsgrd25(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_cor',i,-25,1,[251 15 439 143]);
    v_cor25(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_hmix',i,-25,1,[251 15 439 143]);
    v_hmix25(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_rate',i,-25,1,[251 15 439 143]);
    v_rate25(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_vadv',i,-25,1,[251 15 439 143]);
    v_vadv25(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_vmix',i,-25,1,[251 15 439 143]);
    v_vmix25(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_xadv',i,-25,1,[251 15 439 143]);
    v_xadv25(:,:,c)=var;
    clear var;
    
    [~,~,~,var]=get_var(hisfile,gridfile,'v_yadv',i,-25,1,[251 15 439 143]);
    v_yadv25(:,:,c)=var;
    clear var;
end

c=0;
for i=1:721
    c=c+1;
P=curl(u_Prsgrd25(:,:,i), v_Prsgrd25(:,:,i));
Prsgrd25(:,:,c)=P;

f=curl(u_cor25(:,:,i), v_cor25(:,:,i));
cor25(:,:,c)=f;

h=curl(u_hmix25(:,:,i), v_hmix25(:,:,i));
hmix25(:,:,c)=h;

r=curl(u_rate25(:,:,i), v_rate25(:,:,i));
rate25(:,:,c)=r;

vv=curl(u_vadv25(:,:,i), v_vadv25(:,:,i));
vadv25(:,:,c)=vv;

vx=curl(u_vmix25(:,:,i), v_vmix25(:,:,i));
vmix25(:,:,c)=vx;

xv=curl(u_xadv25(:,:,i), v_xadv25(:,:,i));
xadv25(:,:,c)=xv;

yv=curl(u_yadv25(:,:,i), v_yadv25(:,:,i));
yadv25(:,:,c)=yv;
end
                                                                                           
clear u_*; clear v_*; clear yv xv vx vv r h f P
%% Ahora estoy haciendo el primer día, hacer una transecta de la media y
% la mediana

close all
% for i=1:721
    
%   h=figure('Position', get(0, 'Screensize'),'Visible','off');
plot(lon_u(19,:),Prsgrd25(19,:,60)) % ST centrada en lat=-42.075
hline = refline([0 0]); 
hline.Color = 'r';
% ylim([-6.886400023583502e-04  5.002652961423142e-04])

%   title(['\fontsize{20}' 'Variable ' vname sprintf(' - hora %d del mes', i)])
% jpgname =sprintf('CROP_MOSA_-%d_',i);
%   saveas(h, fullfile(FileDirVertsliceEO,[ jpgname vname '.jpg']));

figure()
plot(lat_u(:,32),Prsgrd25(:,32,60)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('P')
% ylim([-6.886400023583502e-04  5.002652961423142e-04])
axis tight

figure()
plot(lon_u(19,:),cor25(19,:,60)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('c')
% ylim([-6.886400023583502e-04  5.002652961423142e-04])
axis tight

figure()
plot(lat_u(:,32),cor25(:,32,60)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('c')
% ylim([-6.886400023583502e-04  5.002652961423142e-04])
axis tight

% figure()
% plot(lon_u(19,:),hmix25(19,:,1)) % ST centrada en lat=-42.075
% hline = refline([0 0]);
% hline.Color = 'r';
% legend('h')
% ylim([-6.886400023583502e-04  5.002652961423142e-04])

% figure()
% plot(lat_u(:,32),hmix25(:,32,1)) % ST centrada en lon=-72.95
% hline = refline([0 0]);
% hline.Color = 'r';
% legend('h')
% ylim([-6.886400023583502e-04  5.002652961423142e-04])

figure()
plot(lon_u(19,:),rate25(19,:,60)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('r')
% ylim([-6.886400023583502e-04  5.002652961423142e-04])
axis tight

figure()
plot(lat_u(:,32),rate25(:,32,60)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('r')
% ylim([-6.886400023583502e-04  5.002652961423142e-04])
axis tight

figure()
plot(lon_u(19,:),vadv25(19,:,60)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('vadv')
% ylim([-6.886400023583502e-04  5.002652961423142e-04])
axis tight

figure()
plot(lat_u(:,32),vadv25(:,32,60)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('vadv')
% ylim([-6.886400023583502e-04  5.002652961423142e-04])
axis tight

figure()
plot(lon_u(19,:),vmix25(19,:,60)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('vmix')
% ylim([-6.886400023583502e-04  5.002652961423142e-04])
axis tight

figure()
plot(lat_u(:,32),vmix25(:,32,60)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('vmix')
axis tight
% ylim([-6.886400023583502e-04  5.002652961423142e-04])

figure()
plot(lon_u(19,:),xadv25(19,:,60)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('xadv')
% ylim([-6.886400023583502e-04  5.002652961423142e-04])
axis tight

figure()
plot(lat_u(:,32),xadv25(:,32,60)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('xadv')
axis tight

figure()
plot(lon_u(19,:),yadv25(19,:,60)) % ST centrada en lat=-42.075
hline = refline([0 0]);
hline.Color = 'r';
legend('yadv')
axis tight

figure()
plot(lat_u(:,32),yadv25(:,32,60)) % ST centrada en lon=-72.95
hline = refline([0 0]);
hline.Color = 'r';
legend('yadv')
axis tight
% end


cor1p= cor(19,32,:);
Prsgrd1p= Prsgrd(19,32,:);
rate1p= rate(19,32,:);
vadv1p= vadv(19,32,:);
vmix1p= vmix(19,32,:); 
xadv1p= xadv(19,32,:);
yadv1p= yadv(19,32,:);

% cor1p=reshape(cor1p,721,1);
% Prsgrd1p= reshape(Prsgrd1p,721,1);
% rate1p= reshape(rate1p,721,1);
% vadv1p= reshape(vadv1p,721,1);
% vmix1p= reshape(vmix1p,721,1); 
% xadv1p= reshape(xadv1p,721,1);
% yadv1p= reshape(yadv1p,721,1);

for k = 1:24:numel(cor1p)
    k2 = ceil(k/24);
    idx = k:(min(k+23,numel(cor1p)));
    
    corDM(k2) = mean(cor1p(idx));
    PrsgrdDM(k2) = mean(Prsgrd1p(idx));
    rateDM(k2) = mean(rate1p(idx));
    vadvDM(k2) = mean(vadv1p(idx));  
    vmixDM(k2) = mean(vmix1p(idx));
    xadvDM(k2) = mean(xadv1p(idx));
    yadvDM(k2) = mean(yadv1p(idx));
end

std_Prsgrd=std(PrsgrdDM)+zeros(1,31);
Pp=PrsgrdDM + std_Prsgrd;
Pn=PrsgrdDM - std_Prsgrd;

std_cor=std(corDM)+zeros(1,31);
Corp=corDM + std_cor;
Corn=corDM - std_cor;

std_mix=std(vmixDM)+zeros(1,31);
vmixp=vmixDM + std_mix;
vmixn=vmixDM - std_mix;

std_xadv=std(xadvDM)+zeros(1,31);
xadvp=xadvDM + std_xadv;
xadvn=xadvDM - std_xadv;

std_yadv=std(yadvDM)+zeros(1,31);
yadvp=yadvDM + std_yadv;
yadvn=yadvDM - std_yadv;

std_vadv=std(vadvDM)+zeros(1,31);
vadvp=vadvDM + std_vadv;
vadvn=vadvDM - std_vadv;

std_rate=std(rateDM)+zeros(1,31);
ratep=rateDM + std_rate;
raten=rateDM - std_rate;

x=1:31;
x2 = [x, fliplr(x)];
%% 
FileDir='/home/dexter/Documentos/OpenDrift/opendrift/MOSA_1m_1h/Balance diagM'
close all

h=figure('Position', get(0, 'Screensize'))
inBetweenP = [Pn, fliplr(Pp)];
h=fill(x2, inBetweenP, [0.960784313725490 0.776470588235294...
     0.996078431372549],'FaceAlpha',0.5);
hold on;
plot(1:31,PrsgrdDM, 'r', 'LineWidth',0.51);
plot(1:31, zeros(1,31),'k','linewidth',2)
ylim([-3.165758924516252e-06 2.058749001055146e-06])
title(['\fontsize{20}' 'Rotor del Gradiente de Presión'])
xlabel('Tiempo [días]','FontSize',14)
% ylabel('[v/s^2]','FontSize',14)
xlim([1 31])
jpgname =sprintf('SdT_RotGradP');
saveas(h, fullfile(FileDir,[ jpgname '.jpg']));

%% 


h=figure('Position', get(0, 'Screensize'))
inBetweenCor = [Corn, fliplr(Corp)];
h=fill(x2, inBetweenCor, [0.960784313725490 0.776470588235294...
     0.996078431372549],'FaceAlpha',0.5);
 hold on;
plot(1:31,corDM, 'r', 'LineWidth',0.51);
plot(1:31, zeros(1,31),'k','linewidth',2)
ylim([-3.165758924516252e-06 2.058749001055146e-06])
title(['\fontsize{20}' 'Rotor del término de Coriolis'])
xlabel('Tiempo [días]','FontSize',14)
xlim([1 31])
jpgname =sprintf('SdT_RotCor');
saveas(h, fullfile(FileDir,[ jpgname '.jpg']));

%% 

h=figure('Position', get(0, 'Screensize'))
inBetweenVmix = [vmixn, fliplr(vmixp)];
h=fill(x2, inBetweenVmix, [0.960784313725490 0.776470588235294...
     0.996078431372549],'FaceAlpha',0.5);
hold on;
plot(1:31,vmixDM, 'r', 'LineWidth',0.51);
plot(1:31, zeros(1,31),'k','linewidth',2)
ylim([-3.165758924516252e-06 2.058749001055146e-06])
title(['\fontsize{20}' 'Rotor del término de mezcla vertical'])
xlabel('Tiempo [días]','FontSize',14)
xlim([1 31])
jpgname =sprintf('SdT_RotVmix');
saveas(h, fullfile(FileDir,[ jpgname '.jpg']));

h=figure('Position', get(0, 'Screensize'))
inBetweenxadv = [xadvn, fliplr(xadvp)];
h=fill(x2, inBetweenxadv, [0.960784313725490 0.776470588235294...
     0.996078431372549],'FaceAlpha',0.5);
hold on;
plot(1:31,xadvDM, 'r', 'LineWidth',0.51);
plot(1:31, zeros(1,31),'k','linewidth',2)
ylim([-3.165758924516252e-06 2.058749001055146e-06])
title(['\fontsize{20}' 'Rotor del término de advección horizontal xi'])
xlabel('Tiempo [días]','FontSize',14)
xlim([1 31])
jpgname =sprintf('SdT_RotXadv');
saveas(h, fullfile(FileDir,[ jpgname '.jpg']));

h=figure('Position', get(0, 'Screensize'))
inBetweenyadv = [yadvn, fliplr(yadvp)];
h=fill(x2, inBetweenyadv, [0.960784313725490 0.776470588235294...
     0.996078431372549],'FaceAlpha',0.5);
hold on;
plot(1:31,yadvDM, 'r', 'LineWidth',0.51);
plot(1:31, zeros(1,31),'k','linewidth',2)
ylim([-3.165758924516252e-06 2.058749001055146e-06])
title(['\fontsize{20}' 'Rotor del término advectivo horizontal eta'])
xlabel('Tiempo [días]','FontSize',14)
xlim([1 31])
jpgname =sprintf('SdT_RotYadv');
saveas(h, fullfile(FileDir,[ jpgname '.jpg']));

h=figure('Position', get(0, 'Screensize'))
inBetweenvadv = [vadvn, fliplr(vadvp)];
h=fill(x2, inBetweenvadv, [0.960784313725490 0.776470588235294...
     0.996078431372549],'FaceAlpha',0.5);
hold on;
plot(1:31,vadvDM, 'r', 'LineWidth',0.51);
plot(1:31, zeros(1,31),'k','linewidth',2)
ylim([-3.165758924516252e-06 2.058749001055146e-06])
title(['\fontsize{20}' 'Rotor del término de advección vertical'])
xlabel('Tiempo [días]','FontSize',14)
xlim([1 31])
jpgname =sprintf('SdT_RotVadv');
saveas(h, fullfile(FileDir,[ jpgname '.jpg']));

h=figure('Position', get(0, 'Screensize'))
inBetweenrate = [raten, fliplr(ratep)];
h=fill(x2, inBetweenrate, [0.960784313725490 0.776470588235294...
     0.996078431372549],'FaceAlpha',0.5);
hold on;
plot(1:31,rateDM, 'r', 'LineWidth',0.51);
plot(1:31, zeros(1,31),'k','linewidth',2)
ylim([-3.165758924516252e-06 2.058749001055146e-06])
title(['\fontsize{20}' 'Rotor del término tasa de cambio de tiempo'])
xlabel('Tiempo [días]','FontSize',14)
xlim([1 31])
jpgname =sprintf('SdT_RotRate');
saveas(h, fullfile(FileDir,[ jpgname '.jpg']));
%%
close all
figure('Position', get(0, 'Screensize'))
plot(x,corDM)
hold on
plot(x,PrsgrdDM)
plot(1:32, zeros(1,32),'k','linewidth',2)
axis tight
xlim([0.7 31.5])
legend('cor','GP')

figure('Position', get(0, 'Screensize'))
plot(x,rateDM)
hold on
plot(x,vmixDM)
plot(1:32, zeros(1,32),'k','linewidth',2)
axis tight
xlim([0.7 31.5])
legend('rate','vmix')

figure('Position', get(0, 'Screensize'))
plot(x,vadvDM)
hold on
plot(x,xadvDM)
plot(x,yadvDM)
plot(1:32, zeros(1,32),'k','linewidth',2)
axis tight
xlim([0.7 31.5])
legend('vadv','xadv','yadv')
% legend('cor','GP','rate','vadv','vmix','xadv','yadv')
%%
close all
figure('Position', get(0, 'Screensize'))
plot(lon_u(19,14:46),cor(19,14:46,60),'b', 'LineWidth',2)
hold on
% plot(lon_u(19,:), zeros(1,55),'k','linewidth',2)
plot(lon_u(19,14:46),Prsgrd(19,14:46,60),'r', 'LineWidth',2)
hline = refline([0 0]); 
hline.Color = 'k';
hline.LineWidth=2;
axis tight
legend('Cor','GP')
title('Balance términos Ecuación vorticidad','FontSize',20)
xlabel('Longitud [°E]','FontSize',14)

 

figure('Position', get(0, 'Screensize'))
plot(lon_u(19,14:46),rate(19,14:46,60),'color',[0. 0.7 0.7], 'LineWidth',2)
hold on
plot(lon_u(19,14:46),vmix(19,14:46,60),'m', 'LineWidth',2)
hline = refline([0 0]); 
hline.Color = 'k';
hline.LineWidth=2;
axis tight
legend('rate','vmix')
title('Balance términos Ecuación vorticidad','FontSize',20)
xlabel('Longitud [°E]','FontSize',14)

figure('Position', get(0, 'Screensize'))
plot(lon_u(19,14:46),xadv(19,14:46,60),'color',[0.4940 0.1840 0.5560], 'LineWidth',2)
hold on
plot(lon_u(19,14:46),yadv(19,14:46,60), 'color',[0.8500 0.3250 0.0980], 'LineWidth',2)
plot(lon_u(19,14:46),vadv(19,14:46,60),'g', 'LineWidth',2)
hline = refline([0 0]); 
hline.Color = 'k';
hline.LineWidth=2;
axis tight
legend('vadv','xadv','yadv')
title('Balance términos Ecuación vorticidad','FontSize',20)
xlabel('Longitud [°E]','FontSize',14)
%%

close all
figure('Position', get(0, 'Screensize'))
plot(lat_u(:,32),cor(:,32,60),'b', 'LineWidth',2)
hold on
% plot(lon_u(19,:), zeros(1,55),'k','linewidth',2)
plot(lat_u(:,32),Prsgrd(:,32,60),'r', 'LineWidth',2)
hline = refline([0 0]); 
hline.Color = 'k';
hline.LineWidth=2;
axis tight
legend('cor','GP')
title('Balance términos Ecuación vorticidad','FontSize',20)
xlabel('Latitud [°N]','FontSize',14)

figure('Position', get(0, 'Screensize'))
plot(lat_u(:,32),rate(:,32,60),'color',[0. 0.7 0.7], 'LineWidth',2)
hold on
plot(lat_u(:,32),vmix(:,32,60),'m', 'LineWidth',2)
hline = refline([0 0]); 
hline.Color = 'k';
hline.LineWidth=2;
axis tight
legend('rate','vmix')
title('Balance términos Ecuación vorticidad','FontSize',20)
xlabel('Latitud [°N]','FontSize',14)

figure('Position', get(0, 'Screensize'))
plot(lat_u(:,32),xadv(:,32,60),'color',[0.4940 0.1840 0.5560], 'LineWidth',2)
hold on
plot(lat_u(:,32),yadv(:,32,60), 'color',[0.8500 0.3250 0.0980], 'LineWidth',2)
plot(lat_u(:,32),vadv(:,32,60),'g', 'LineWidth',2)
hline = refline([0 0]); 
hline.Color = 'k';
hline.LineWidth=2;
axis tight
legend('vadv','xadv','yadv')
title('Balance términos Ecuación vorticidad','FontSize',20)
xlabel('Latitud [°N]','FontSize',14)
