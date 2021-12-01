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
#lo  = -73; la=-42;
lo  = -72.993; la=-42.1043;  #Centro Remolino
#lo  = -73.45; la=-41.95;    # Semi remolino cerca canal chacao

# Liberacion en el tiempo
initime = 0
num_steps = 744
time_step = timedelta(hours=1)
time_step0 = timedelta(hours=1)

# Sembrando elementos
z = -np.random.rand(100)*250
for i in range(num_steps+1):
    o.seed_elements(lo, la, radius = 1500, number=100, z=z, time=time)#i*time_step + initime*time_step0)

# Varada
o.set_config('general:coastline_action', 'previous') # Las partículas quedarán pegadas en la costa y luego se las llevará el mar

# Simulacion
o.run(steps=744, time_step=-3600, time_step_output=3600, outfile ='../Resultados/NetCDF/2ReversaCentro.nc')
o.plot(fast=True,linecolor='z', buffer=.1, show_trajectories=True,filename='../Resultados/Graficos/2ReversaCentro.01-31.jpg')
o.animation(color='z', buffer=.1,fast=True, filename='../Resultados/Animaciones/2ReversaCentro.01-31.mp4')
o.animation_profile(color='z', filename='../Resultados/Animaciones/2ReversaCentro.01-31_vert.mp4')
