# Criando gráfico e vídeo
library(geobr)
library(ggplot2)
library(gganimate)
library(av)
library(dplyr)
library(tidyverse)
base_final = read.csv2('05_base_final.csv')
base_final = base_final %>% separate(Municipio, sep = 6, 
                                     c('CO_MUN', 'NM_MUN'))

municipios = read_municipality() %>% select(c(1, 4))
municipios$code_muni = substr(municipios$code_muni, 1, nchar(municipios$code_muni) - 1)

base_para_video = inner_join(base_final, municipios, by = c('CO_MUN' = 'code_muni'))
base_para_video = base_para_video %>% group_by(abbrev_state, Ano) %>% 
  summarise(taxa = mean(Taxa_mortalidade), apgar1 = mean(apgar_1),
            apgar5 = mean(apgar_5), Peso = mean(Peso))

grafico = base_para_video %>% 
  ggplot(aes(x = log(taxa), y = apgar1, color = abbrev_state)) +
  geom_point(show.legend = F, size = 2) + 
  xlab('Taxa de mortalidade') + ylab('Apgar 1') +
  geom_smooth(method = 'lm', color = 'black') + 
  theme_bw()
grafico

anim = grafico + transition_time(Ano) +
  labs(title = "Ano: {frame_time}")
video = animate(anim, renderer = av_renderer())
video
anim_save("video_seminario_apgar1.mp4")

grafico_apgar5 = base_para_video %>% 
  ggplot(aes(x = log(taxa), y = apgar5, color = abbrev_state)) +
  geom_point(show.legend = F, size = 2) + 
  xlab('Taxa de mortalidade') + ylab('Apgar 5') +
  geom_smooth(method = 'lm', color = 'black') + 
  theme_bw()
grafico_apgar5

anim = grafico_apgar5 + transition_time(Ano) +
  labs(title = "Ano: {frame_time}")
video = animate(anim, renderer = av_renderer())
video
anim_save("video_seminario_apgar5.mp4")

grafico_peso = base_para_video %>% 
  ggplot(aes(x = log(taxa), y = Peso, color = abbrev_state)) +
  geom_point(show.legend = F, size = 2) + 
  xlab('Taxa de mortalidade') + ylab('Peso ao nascer') +
  geom_smooth(method = 'lm', color = 'black') + 
  theme_bw()
grafico_peso

anim = grafico_peso + transition_time(Ano) +
  labs(title = "Ano: {frame_time}")
video = animate(anim, renderer = av_renderer())
video
anim_save("video_seminario_peso.mp4")
