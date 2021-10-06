#!/usr/bin/env python
"""
Fish Eggs and Larvae
====================
"""

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
from opendrift.readers.reader_constant import Reader as ConstantReader
from opendrift.models.larvalfish import LarvalFish
from opendrift.readers import reader_ROMS_native

o = LarvalFish(loglevel=50)

# Adjuntando el archivo
filename_nc = 'croco4.nc';
mosa_native = reader_ROMS_native.Reader(filename=filename_nc)
mosa_native.interpolation='linearND'
o.add_reader([mosa_native])
time = mosa_native.start_time

# Posición inicial
#lo  = -73; la=-42;
#lo  = -73.15; la=-42.1;     # Centro Remolino
lo  = -73.45; la=-41.95;    # Semi remolino cerca canal chacao

# Liberacion en el tiempo
initime = 0
num_steps = 720
time_step = timedelta(hours=1)
time_step0 = timedelta(hours=1)

# Sembrando elementos
for i in range(num_steps+1):
    o.seed_elements(lo, la, radius = 1500, number=100, z=0, time=time + i*time_step + initime*time_step0)

#%%
# No horizontal movement, here only investigating vertical mixing and swimming
r = ConstantReader(
        {'x_sea_water_velocity': 0, 'y_sea_water_velocity': 0, 'x_wind': 0, 'y_wind': 0,
         'sea_water_temperature': 10,
         'land_binary_mask': 0, 'ocean_vertical_diffusivity': .02})
o.add_reader(r)

o.set_config('general:use_auto_landmask', False)
o.set_config('general:coastline_action', 'previous') # Las partículas quedarán pegadas en la costa y luego se las llevará el mar
o.run(duration=timedelta(days=40))

#%%
# After 20 days eggs are hatched as Larvae, and starting to grow
o.plot_property('weight')
o.plot_property('length')

#%%
# We see that larvae (after hatching) avoid the upper meters at daytime, to avoid predators.
# Vertical motion is a combination of vertical mixing, buoyancy and swimming.
o.plot_property('z')

#%%
# Mean daily depth shows more clearly the diurnal migration of larvae
o.plot_property('z', mean=True)

# Simulacion
o.run(time_step=3600, outfile ='larvasAncud.nc')
