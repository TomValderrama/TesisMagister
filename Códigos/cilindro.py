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
filename_nc = 'croco4.nc';
mosa_native = reader_ROMS_native.Reader(filename=filename_nc)
mosa_native.interpolation='linearND'
o.add_reader([mosa_native])
time = mosa_native.start_time

# Posición inicial
latstart = -41.81
lonstart = -73.5
latend = -42.2
lonend = -73

# Liberacion en el tiempo
initime = 0
num_steps = 720
time_step = timedelta(hours=1)
time_step0 = timedelta(hours=1)

# Sembrando elementos
o.seed_cone(lon=[lonstart, lonend], lat=[latstart, latend], radius=[200, 200], number=2000, time=[time])
# Varada
o.set_config('general:coastline_action', 'previous') # Las partículas quedarán pegadas en la costa y luego se las llevará el mar

# Simulacion
o.run(time_step=3600, outfile ='cilindro.nc')
#o.plot(filename='cilindro.jpg')
##o.animation(linecolor='z', fast=True,filename='cilindro.gif')


