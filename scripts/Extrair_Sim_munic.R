# Extrair base SIM-DO.
library(dplyr)
pacotes = c('tidyverse', 'dplyr', 'remotes')
if (!require(pacotes)) install.packages(pacotes)

remotes::install_github("rfsaldanha/microdatasus")
library(microdatasus)

dados_sim = fetch_datasus(year_start = 2010, year_end = 2011, 
                             information_system = "SIM-DO",
                             vars = c("CODMUNRES", "CAUSABAS", "DTOBITO"))

dados_sim$ano = substr(dados_sim$DTOBITO, 
                          start = nchar(dados_sim$DTOBITO) - 3,
                          stop = nchar(dados_sim$DTOBITO))

dados_sim = dados_sim %>% select(-DTOBITO) %>% 
  group_by(CODMUNRES, ano, CAUSABAS) %>% summarise(n = n())

