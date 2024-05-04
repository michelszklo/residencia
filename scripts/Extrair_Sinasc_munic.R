pacotes = c('tidyverse', 'dplyr', 'remotes')
if (!require(pacotes)) install.packages(pacotes)

remotes::install_github("rfsaldanha/microdatasus")
library(microdatasus)

dados_sinasc = fetch_datasus(year_start = 2010, year_end = 2011, 
                             information_system = "SINASC",
                             vars = c("CODMUNNASC", "PESO",
                                      "APGAR1", "APGAR5", "ESCMAE", "DTNASC"))

dados_sinasc$ano = substr(dados_sinasc$DTNASC, 
                      start = nchar(dados_sinasc$DTNASC)-3, 
                      stop = nchar(dados_sinasc$DTNASC))

base_sinasc = dados_sinasc %>% select(-DTNASC) %>% mutate_all(as.numeric) %>% 
  group_by(CODMUNNASC, ano) %>% summarise_all(~mean(., na.rm = T))

write.csv2(base_sinasc, "Base_sinasc.csv", row.names = F)
