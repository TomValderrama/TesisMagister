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
#lo  = -73; la=-42;
#lo  = -73.15; la=-42.1;     # Centro Remolino
lo  = -73.45; la=-41.95;    # Semi remolino cerca canal chacao

# Liberación en el tiempo
initime = 0
num_steps = 720
time_step = timedelta(hours=1)
time_step0 = timedelta(hours=1)

# Sembrando elementos
for i in range(num_steps+1):
    o.seed_elements(lo, la, radius = 1500, number=100, z=0, time=time + i*time_step + initime*time_step0)

# Varada
o.set_config('general:coastline_action', 'previous') # Las partículas quedarán pegadas en la costa y luego se las llevará el mar

# Simulación
o.run(time_step=3600, outfile ='1supAncud3.nc')
