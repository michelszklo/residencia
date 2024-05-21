library(geobr)
library(dplyr)
library(ggplot2)

# Carregar o arquivo CSV
dados_mapa_estado <- read.csv2("base_com_indicadores.csv")

# Separar a coluna em duas partes
nova_coluna <- strsplit(as.character(dados_mapa_estado$Municipio), " ", fixed = TRUE)

# Extrair o código e o nome da cidade
dados_mapa_estado$codigo <- sapply(nova_coluna, `[`, 1)
dados_mapa_estado$cidade <- sapply(nova_coluna, function(x) paste(x[-1], collapse = " "))

# Extrair os dois primeiros dígitos do código
dados_mapa_estado$estado_code <- substr(dados_mapa_estado$codigo, 1, 2)

# Renomeando colunas
dados_mapa_estado <- dados_mapa_estado %>% rename(code_muni = codigo)

# Transformando em numérico
dados_mapa_estado$code_muni <- as.numeric(dados_mapa_estado$code_muni)
dados_mapa_estado$estado_code <- as.numeric(dados_mapa_estado$estado_code)
str(dados_mapa_estado)

# Carregar os dados de mapas
mapa_municipio <- geobr::read_municipality()

# Extraindo os dois primeiros dígitos dos códigos dos municípios do mapa
mapa_municipio$estado_code <- substr(as.character(mapa_municipio$code_muni), 1, 2)
mapa_municipio$estado_code <- as.numeric(mapa_municipio$estado_code)

str(mapa_municipio)

# Realizar a junção dos dados
base_mapa <- mapa_municipio %>% full_join(dados_mapa_estado, by = "estado_code")

# Plotando os gráficos
ggplot() +
  geom_sf(data = base_mapa, aes(fill = apgar_1)) +
  scale_fill_distiller(palette = "Reds", direction = 1, name = "APGAR 1", 
                       limits = c(0, 10))
