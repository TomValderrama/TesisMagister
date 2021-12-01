#!/usr/bin/env python

# Inicialización
import matplotlib
matplotlib.use('Agg')

# Módulos
import sys
sys.path.append('/home/dexter/Documentos/OpenDrift/opendrift')
import os
from datetime import datetime, timedelta
import numpy as np

# Readers
from opendrift.readers import reader_ROMS_native
from opendrift.models.oceandrift import OceanDrift

# Adjuntando el archivo
o = OceanDrift(loglevel=0)
filename_nc = '../DailyMean_2014.01.01-31.nc';
mosa_native = reader_ROMS_native.Reader(filename=filename_nc)
mosa_native.interpolation='linearND'
o.add_reader([mosa_native])
time = mosa_native.start_time

# Posición inicial
lon_chacao = -73.555417; lat_chacao = -41.782929;
lon_reloncavi  = -72.939642; lat_reloncavi= -41.829285;
lon_desertores  = -72.895354; lat_desertores = -42.695478;

# Liberacion en el tiempo
initime = 0
num_steps = 720
time_step = timedelta(hours=1)
time_step0 = timedelta(hours=1)

# Sembrando elementos
#for i in range(num_steps+1):
z = -100
o.seed_elements(lon_chacao, lat_chacao, z=z, radius=0, number=200,time=time)
o.seed_elements(lon_reloncavi, lat_reloncavi, z=z, radius=0, number=200,time=time)
o.seed_elements(lon_desertores, lat_desertores, z=z, radius=0, number=200,time=time)


# Varada
o.set_config('general:coastline_action', 'previous') # Las partículas quedarán pegadas en la costa y luego se las llevará el mar

# Simulacion
o.run(time_step=3600, outfile ='../Resultados/NetCDF/100m_prof_ColumnasRelDesCha.01-31.nc')
o.plot(fast=False,linecolor='z', buffer=.1, show_trajectories=True,filename='../Resultados/Graficos/100m_prof_ColumnasRelDesCha.1-31.jpg')
o.animation(color='z', buffer=.1,fast=False, filename='../Resultados/Animaciones/100m_prof_ColumnasRelDesCha.mp4')
o.animation_profile(color='z', filename='../Resultados/Animaciones/100m_prof_ColumnasRelDesCha.1-31_vert.mp4')
