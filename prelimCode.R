#new pakage#

install.packages('BioCircos')

if (!require('devtools')){install.packages('devtools')}

devtools::install_github('lvulliard/BioCircos.R', build_vignettes = TRUE)



#get circle#

library(BioCircos)

BioCircos()


BioCircos(
  BioCircosCNVTrack('BarTrack', 
                    chromosomes = 1:3, 
                    starts = 1e+7*2:4, 
                    ends = 2.5e+7*2:4,
                    values = 1:3, 
                    color = "#BB0000", 
                    maxRadius = 0.85, 
                    minRadius = 0.55) 
  + BioCircosBackgroundTrack('BGTrack'))




BioCircosArcTrack(trackname, 
                  chromosomes, 
                  starts, 
                  ends,
                  colors = "#40B9D4", 
                  labels = "", 
                  opacities = 1, 
                  maxRadius = 0.9,
                  minRadius = 0.5)





BioCircos(
  BioCircosSNPTrack('SNPTrack', 
                    chromosomes = 1:3,
                    positions = 1e+7*2:4, 
                    values = 1:3, 
                    colors = "Accent", 
                    labels = c('A to G', 'B', 'C'))
  + BioCircosArcTrack('ArcTrack', 
                      chromosomes = 1:5, 
                      starts = 2e+7*1:5, 
                      ends = 2.5e+7*2:6))









