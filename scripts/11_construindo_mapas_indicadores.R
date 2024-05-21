library(geobr)
library(dplyr)
library(ggplot2)

##########################################################################

# Carregar o arquivo CSV
dados_mapa_municipio <- read.csv2("base_com_indicadores.csv")

# Separar a coluna em duas partes
nova_coluna_municipio <- strsplit(as.character(dados_mapa_municipio$Municipio), " ", fixed = TRUE)

# Extrair o código e o nome da cidade
dados_mapa_municipio$codigo <- sapply(nova_coluna_municipio, `[`, 1)
dados_mapa_municipio$cidade <- sapply(nova_coluna_municipio, `[`, 2)

# Renomeando colunas
dados_mapa_municipio <- dados_mapa_municipio %>% rename(code_muni = codigo)
#dados_limpos <- na.omit(dados_mapa)

# Transformando em numerico
dados_mapa_municipio$code_muni <- as.numeric(dados_mapa_municipio$code_muni)
str(dados_mapa_municipio)


mapa_municipio <- geobr::read_municipality()
mapa_municipio$code_muni <- substr(mapa_municipio$code_muni, 1, nchar(mapa_municipio$code_muni) - 1)
str(mapa_municipio)
mapa_municipio$code_muni <- as.numeric(mapa_municipio$code_muni)


base_mapa_municipio <- mapa_municipio %>% full_join(dados_mapa_municipio)


# Plotando os gráficos


# Gráfico para APGAR 1
ggplot(base_mapa_municipio %>% filter(Ano %in% c(2010, 2021))) +
  geom_sf(aes(fill = apgar_1)) +
  scale_fill_distiller(palette = "Reds", direction = 1, name = "APGAR 1", 
                       limits = c(0, 10)) +
  facet_wrap(~ Ano) +
  ggtitle("APGAR 1 - Anos 2010 e 2021")



# Gráfico para APGAR 5
ggplot(base_mapa_municipio %>% filter(Ano %in% c(2010, 2021))) +
  geom_sf(aes(fill = apgar_5)) +
  scale_fill_distiller(palette = "Reds", direction = 1, name = "APGAR 5", 
                       limits = c(0, 10)) +
  facet_wrap(~ Ano) +
  ggtitle("APGAR 5 - Anos 2010 e 2021")



# Gráfico para Peso
ggplot(base_mapa_municipio %>% filter(Ano %in% c(2010, 2021))) +
  geom_sf(aes(fill = Peso)) +
  scale_fill_distiller(palette = "Reds", direction = 1, name = "Peso", 
                       limits = c(1, 5)) +
  facet_wrap(~ Ano) +
  ggtitle("Peso - Anos 2010 e 2021")


#######################################################################


# Carregar o arquivo CSV
dados_mapa_estado <- read.csv2("base_com_indicadores.csv")


# Filtrando os dois primeiros caracteres 
dados_mapa_estado$Municipio <- substr(dados_mapa_estado$Municipio, 1, 2)

# Renomeando colunas
dados_mapa_estado <- dados_mapa_estado %>% rename(code_state = Municipio)
#dados_limpos <- na.omit(dados_mapa)

# Transformando em numerico
dados_mapa_estado$code_state <- as.numeric(dados_mapa_estado$code_state)
str(dados_mapa_estado)


mapa_estado <- geobr::read_state()
str(mapa_estado)
mapa_estado$code_state <- as.numeric(mapa_estado$code_state)


base_mapa_estado <- mapa_estado %>% left_join(dados_mapa_estado)


# Plotando os gráficos

# Gráfico para APGAR 1
ggplot(base_mapa_estado %>% filter(Ano %in% c(2010, 2021))) +
  geom_sf(aes(fill = apgar_1)) +
  scale_fill_distiller(palette = "Reds", direction = 1, name = "APGAR 1", 
                       limits = c(0, 10)) +
  facet_wrap(~ Ano) +
  ggtitle("APGAR 1 - Anos 2010 e 2021")



# Gráfico para Peso
ggplot(base_mapa_estado %>% filter(Ano %in% c(2010, 2021))) +
  geom_sf(aes(fill = Peso)) +
  scale_fill_distiller(palette = "Reds", direction = 1, name = "Peso", 
                       limits = c(1, 5)) +
  facet_wrap(~ Ano) +
  ggtitle("Peso - Anos 2010 e 2021")