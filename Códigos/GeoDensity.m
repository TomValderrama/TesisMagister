close all; clear all
start
path= '/home/dexter/Documentos/OpenDrift/opendrift/Resultados/GeoDensityPlot';

for i=15:15
    close all
    if i==1
        file='Resultados/NetCDF/0m_prof_ColumnaCentro.01-31.nc';
        filename='0m_prof_ColumnaCentro.01-31.nc';
    end
    if i==2
        file='Resultados/NetCDF/0m_prof_ColumnaCentro_SM.01-31.nc';
        filename='0m_prof_ColumnaCentro_SM.01-31.nc';
    end
    if i==3
        file='Resultados/NetCDF/100m_prof_ColumnaCentro.01-31.nc';
        filename='100m_prof_ColumnaCentro.01-31.nc';
    end
    if i==4
        file='Resultados/NetCDF/100m_prof_ColumnaCentro_SM.01-31.nc';
        filename='100m_prof_ColumnaCentro_SM.01-31.nc';
    end
    if i==5
        file='Resultados/NetCDF/150m_prof_ColumnaCentro.01-31.nc';
        filename='150m_prof_ColumnaCentro.01-31.nc';
    end
    if i==6
        file='Resultados/NetCDF/150m_prof_ColumnasRelDesCha.01-31.nc';
        filename='150m_prof_ColumnasRelDesCha.01-31.nc';
    end
    if i==7
        file='Resultados/NetCDF/150m_prof_ColumnasRelDesCha_SM.01-31.nc';
        filename='150m_prof_ColumnasRelDesCha_SM.01-31.nc';
    end
    if i==8
        file='Resultados/NetCDF/200m_prof_ColumnaCentro.01-31.nc';
        filename='200m_prof_ColumnaCentro.01-31.nc';
    end
    if i==9
        file='Resultados/NetCDF/250m_prof_ColumnaCentro.01-31.nc';
        filename='250m_prof_ColumnaCentro.01-31.nc';
    end
    if i==10
        file='Resultados/NetCDF/250m_prof_ColumnasRelDesCha.01-31.nc';
        filename='250m_prof_ColumnasRelDesCha.01-31.nc';
    end
    if i==11
        file='Resultados/NetCDF/250m_prof_ColumnasRelDesCha_SM.01-31.nc';
        filename='250m_prof_ColumnasRelDesCha_SM.01-31.nc';
    end
%     if i==12;
%       file='Resultados/NetCDF/2ReversaCentro.nc';
%        filename='2ReversaCentro.nc';
%     end
    if i==12
        file='Resultados/NetCDF/50m_prof_ColumnaCentro.01-31.nc';
        filename='50m_prof_ColumnaCentro.01-31.nc';
    end
    if i==13
        file='Resultados/NetCDF/50m_prof_ColumnaCentro_SM.01-31.nc';
        filename='50m_prof_ColumnaCentro_SM.01-31.nc';
    end
    if i==14
        file='Resultados/NetCDF/50m_prof_ColumnasRelDesCha_SM.01-31.nc';
        filename='50m_prof_ColumnasRelDesCha_SM.01-31.nc';
    end
    if i==15
        file='Resultados/NetCDF/ColumnasRelDesCha.01-31.nc';
        filename='ColumnasRelDesCha.01-31.nc';
    end
    if i==16
        file='Resultados/NetCDF/ColumnasRelDesCha.01-31_SinMareas.nc';
        filename='ColumnasRelDesCha.01-31_SinMareas.nc';
    end
    if i==17
        file='Resultados/NetCDF/ColumnasRelDesCha_SM.01-31.nc';
        filename='ColumnasRelDesCha_SM.01-31.nc';
    end
    if i==18
        file='Resultados/NetCDF/prof.01.01-31.nc';
        filename='prof.01.01-31.nc';
    end
    if i==19
        file='Resultados/NetCDF/prof.01.01-31_SinMareas.nc';
        filename='prof.01.01-31_SinMareas.nc';
    end
%     if i==21;
%         file='Resultados/NetCDF/ReversaCentro.nc';
%         filename='ReversaCentro.nc';
%     end
   
    lon=ncread(file,'lon');
    lat=ncread(file,'lat');
    
    dimA=length(lon(:,1));
    dimB=length(lon(1,:));
    dimTotal=dimA*dimB;
    
    lon2=reshape(lon,dimTotal,1);
    lat2=reshape(lat,dimTotal,1);

    h=figure('Position', get(0, 'Screensize'));
    geodensityplot(lat2, lon2);

    jpgname =sprintf('geodensity_');
    saveas(h, fullfile(path, [jpgname filename '.jpg']));
end
