# Criando gráfico e vídeo

base_final = read.csv2('base_final.csv')
base_final = base_final %>% separate(Municipio, sep = 6, 
                                     c('CO_MUN', 'NM_MUN'))
library(geobr)
library(ggplot2)
library(gganimate)
library(av)

municipios = read_municipality() %>% select(c(1, 4))
municipios$code_muni = substr(municipios$code_muni, 1, nchar(municipios$code_muni) - 1)

base_para_video = inner_join(base_final, municipios, by = c('CO_MUN' = 'code_muni'))
base_para_video = base_para_video %>% group_by(abbrev_state, Ano) %>% 
  summarise(taxa = mean(Taxa_mortalidade), apgar1 = mean(apgar_1))

grafico = base_para_video %>% 
  ggplot(aes(x = log(taxa), y = apgar1, color = abbrev_state)) +
  geom_point(show.legend = F, size = 2) + 
  geom_smooth(method = 'lm', color = 'black')
grafico

anim = grafico + transition_time(Ano) +
  labs(title = "Ano: {frame_time}")
video = animate(anim, renderer = av_renderer())
video
anim_save("video_seminario.mp4")
