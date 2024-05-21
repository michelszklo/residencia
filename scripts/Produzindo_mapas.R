# Mapa da taxa de mortalidade
library(dplyr)
library(tidyverse)
library(geobr)
library(ggplot2)

taxa_de_mortalidade = read.csv2("03_taxa_mortalidade_geral.csv", sep = ',')

taxa_de_mortalidade = taxa_de_mortalidade %>% 
  separate(Municipio, sep = ' ', into = c('COD_MUN', 'NM_MUN')) %>% 
  mutate(Taxa_Mortalidade_Geral = as.numeric(Taxa_Mortalidade_Geral),
         COD_MUN = as.numeric(COD_MUN))

# Para produzir o mapa, preciso do ShapeFile do país

mapa = read_municipality()

mapa$code_muni = as.numeric(substr(mapa$code_muni,  # Apagando o último caractere do codigo
                        start = 1, 
                        stop = nchar(mapa$code_muni) - 1))

base_mapas = inner_join(mapa, taxa_de_mortalidade, by = c('code_muni' = 'COD_MUN'))
base_mapas_comparativa = base_mapas %>% filter(Ano %in% c(2010, 2020)) 

grafico = base_mapas_comparativa %>% 
  ggplot() + 
  facet_wrap(~Ano) + 
  geom_sf(aes(fill=Taxa_Mortalidade_Geral), size=.15, color = NA) +
  scale_fill_distiller(palette = "Greens", limits = c(1, 21), 
                       name = '') + 
  ggtitle('Taxa de Mortalidade')
grafico

ggsave('Mapa_mortalide.png')
