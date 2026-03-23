# Tesis de Magíster — Remolino del Golfo de Ancud

Análisis del remolino semipermanente del Golfo de Ancud (sur de Chile) mediante salidas del modelo oceánico CROCO-ROMS y simulaciones de partículas con OpenDrift.

Tesis de Magíster en Geofísica — Universidad de Concepción, 2021–2025.

## Contexto

El Golfo de Ancud, ubicado en el mar interior de Chiloé (Región de Los Lagos, ~42°S), presenta una circulación ciclónica semipermanente cuya dinámica y variabilidad no está completamente caracterizada. Esta tesis analiza los mecanismos que la fuerzan, su respuesta a las mareas y el transporte de partículas asociado.

## Metodología

### Modelo oceánico — CROCO-ROMS
- Análisis de salidas del modelo MOSA-CROCO (sucesor de MOSA-ROMS, operado por IFOP)
- Campos de velocidad, temperatura y salinidad en múltiples niveles de profundidad (0, 50, 100, 150, 200, 250 m)
- Comparación de experimentos con y sin forzamiento de mareas
- Análisis de rotacional del viento (`WindCurl.m`) y gradientes de temperatura (`GradTemp.m`)
- Análisis de mareas con MATLAB (`Analisis_Mareas.m`)

### Transporte lagrangiano — OpenDrift
- Simulaciones de seguimiento de partículas en 3D sobre campos de velocidad de CROCO
- Scripts por profundidad y ubicación (`0m_prof_Centro.py`, `50m_prof_RelDesCha_SinMareas.py`, etc.)
- Experimentos con y sin mareas para aislar su efecto en el transporte

## Estructura del repositorio

```
Códigos/                    # Scripts principales de análisis
CodigosExperimentosCROCO/   # Configuración de experimentos del modelo
Animaciones/                # Animaciones .mp4 y .gif de la circulación
Gráficos/
  Matllab/GeoDensity/       # Figuras de densidad geográfica (MATLAB)
  OpenDrift/                # Figuras de trayectorias de partículas
Analisis_Mareas.m           # Análisis armónico de mareas
GradTemp.m                  # Gradientes horizontales de temperatura
WindCurl.m                  # Rotacional del viento
```

## Herramientas

| Herramienta | Uso |
|---|---|
| Python (numpy, matplotlib) | Análisis y visualización de salidas CROCO y OpenDrift |
| MATLAB | Análisis de mareas, gradientes, figuras de densidad |
| OpenDrift | Simulación lagrangiana de partículas en 3D |
| CROCO-ROMS | Modelo oceánico de circulación regional |

## Resultados principales

- Caracterización de la estructura vertical y temporal del remolino del Golfo de Ancud
- Cuantificación del efecto de las mareas en la circulación y el transporte de partículas
- Animaciones de la evolución temporal del remolino a distintas profundidades
- Análisis de trayectorias de partículas liberadas en distintos puntos del golfo
