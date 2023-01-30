close all; clear all
start
hisfile='mosa_BGQ_his_M1_1h_WD_20210102.nc';
gridfile=hisfile;%%
c=0;
for i=1:721
    c=c+1;
% 
    [lat,lon,mask,var]=get_var(hisfile,gridfile,'u',i,-1,1,[284 35 454 166]); % lon= -72.8875, lat= -42.1468
    u(:,:,c)=var;
    clear var;
    
    [lat2,lon2,mask,var]=get_var(hisfile,gridfile,'v',i,-1,1,[284 36 453 166]); %  lon= -72.9000, lat= -42.1561
    v(:,:,c)=var;
end

c=0;
for i=1:30
uH=u(:,:,(1:24)+24*c);
uM=mean(uH(:,:,:),3);
um(:,:,i)=uM;

vH=v(:,:,(1:24)+24*c);
vM=mean(vH(:,:,:),3);
vm(:,:,i)=vM;

    c=c+1;
end
% dlmwrite('u_mosa_exp1_ver.txt',u,'-append');
% % u=dlmread('u_mosa_2_ver.txt');
% dlmwrite('v_mosa_exp1_ver.txt',v,'-append');
% % v=dlmread('v_mosa_2_ver.txt');

time=linspace(738158, 738188,721);
date=datevec(time);

u=squeeze(u); v=squeeze(v);
um=squeeze(um); vm=squeeze(vm);
%% 
close all
 figure() 
 subplot(211)
 plot(time(1:721),u,'LineWidth',2) 
 yline(min(u),'r','LineWidth',2)
 yline(max(u),'r','LineWidth',2)
 title('SDT verano, vel(u), lon= -72.8875, lat= -42.1468',FontSize=20) 
  ylim([-0.5 0.5])
  xlim([time(1) time(721)])
 yline(0)
 ylabel('[m/s]',FontSize=20) 
 datetick('x','dd/mmm hh','keepticks')

 subplot(212)
 plot(time(1:721),v,'LineWidth',2)
 yline(min(v),'r','LineWidth',2)
 yline(max(v),'r','LineWidth',2)
 title(['SDT verano, vel(v), lon= -72.9000, lat= -42.1561'],FontSize=20) 
 ylim([-0.5 0.5])
  xlim([time(1) time(721)])
 yline(0)
 ylabel('[m/s]',FontSize=20) 
 xlabel('Tiempo [horas]',FontSize=20)
  datetick('x','dd/mmm hh','keepticks')

 %%
 close all
  figure() 
 subplot(211)
 plot(time(1:121),u(1:121),'LineWidth',2) 
 yline(min(u),'r','LineWidth',2)
 yline(max(u),'r','LineWidth',2)
 title('SDT verano, vel(u), lon= -72.8875, lat= -42.1468',FontSize=20) 
  ylim([-0.5 0.5])
 yline(0)
 ylabel('[m/s]',FontSize=20) 
 datetick('x','dd/mmm hh','keepticks')

 xl=xline(time(13));
 xl.LineWidth = 2;
% xl=xline(time(25));
%  xl.LineWidth = 2;
xl=xline(time(37));
 xl.LineWidth = 2;
%  xl=xline(time(49));
%   xl.LineWidth = 2;
 xl=xline(time(61));
 xl.LineWidth = 2;
%  xl=xline(time(73));
%  xl.LineWidth = 2;
 xl=xline(time(85));
 xl.LineWidth = 2;
%  xl=xline(time(97));
%  xl.LineWidth = 2;
 xl=xline(time(109));
 xl.LineWidth = 2;
%  xl=xline(time(121));
%  xl.LineWidth = 2;

 subplot(212)
 plot(time(1:121),v(1:121),'LineWidth',2)
 yline(min(v),'r','LineWidth',2)
 yline(max(v),'r','LineWidth',2)
 title(['SDT verano, vel(v), lon= -72.9000, lat= -42.1561'],FontSize=20) 
 ylim([-0.5 0.5])
 yline(0)
 datetick('x','dd/mmm hh','keepticks')

 xl=xline(time(13));
 xl.LineWidth = 2;
% xl=xline(time(25));
%  xl.LineWidth = 2;
xl=xline(time(37));
 xl.LineWidth = 2;
%  xl=xline(time(49));
%   xl.LineWidth = 2;
 xl=xline(time(61));
 xl.LineWidth = 2;
%  xl=xline(time(73));
%  xl.LineWidth = 2;
 xl=xline(time(85));
 xl.LineWidth = 2;
%  xl=xline(time(97));
%  xl.LineWidth = 2;
 xl=xline(time(109));
 xl.LineWidth = 2;
%  xl=xline(time(121));
%  xl.LineWidth = 2;
 
 subplot(212)
 ylabel('[m/s]',FontSize=20) 
 xlabel('Tiempo [horas]',FontSize=20)
%%

timeM=linspace(738158, 738188,31);
dateM=datevec(time);
 figure() 
 subplot(211)
 plot(timeM(1:30),um,'LineWidth',2) 
 yline(min(um),'r','LineWidth',2)
 yline(max(um),'r','LineWidth',2)
 title('SDT verano, vel(u), lon= -72.8875, lat= -42.1468',FontSize=20) 
  ylim([-0.5 0.5])
   xlim([timeM(1) timeM(30)])
 yline(0)
 ylabel('[m/s]',FontSize=20) 
 datetick('x','dd/mmm hh','keepticks')

 subplot(212)
 plot(timeM(1:30),vm,'LineWidth',2)
 yline(min(vm),'r','LineWidth',2)
 yline(max(vm),'r','LineWidth',2)
 title(['SDT verano, vel(v), lon= -72.9000, lat= -42.1561'],FontSize=20) 
 ylim([-0.5 0.5])
 xlim([timeM(1) timeM(30)])
 yline(0)
 ylabel('[m/s]',FontSize=20) 
 xlabel('Tiempo [días]',FontSize=20)
 datetick('x','dd/mmm','keepticks')
