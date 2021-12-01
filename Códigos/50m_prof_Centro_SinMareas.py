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
filename_nc = '../DailyMean_sm_2014.01.01-31.nc';
mosa_native = reader_ROMS_native.Reader(filename=filename_nc)
mosa_native.interpolation='linearND'
o.add_reader([mosa_native])
time = mosa_native.start_time

# Posición inicial
lo  = -72.993; la=-42.1043;  #Centro Remolino

# Liberacion en el tiempo
initime = 0
num_steps = 720
time_step = timedelta(hours=1)
time_step0 = timedelta(hours=1)

# Sembrando elementos
#for i in range(num_steps+1):
z = -50
o.seed_elements(lo, la, z=z, radius=100, number=200,time=time)


# Varada
o.set_config('general:coastline_action', 'previous') # Las partículas quedarán pegadas en la costa y luego se las llevará el mar

# Simulacion
o.run(time_step=3600, outfile ='../Resultados/NetCDF/50m_prof_ColumnaCentro_SM.01-31.nc')
o.plot(fast=False,linecolor='z', buffer=.1, show_trajectories=True,filename='../Resultados/Graficos/50m_prof_ColumnaCentro_SM.1-31.jpg')
o.animation(color='z', buffer=.1,fast=False, filename='../Resultados/Animaciones/50m_prof_ColumnaCentro_SM.mp4')
o.animation_profile(color='z', filename='../Resultados/Animaciones/50m_prof_ColumnaCentro_SM.1-31_vert.mp4')
