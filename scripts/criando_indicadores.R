library(dplyr)
library(tidyverse)
# Criando os Indicadores

base = read.csv2('2_base_unica.csv')

apgar1 = base %>% select(Ano, Municipio, contains('apgar1')) %>% 
  summarise(Ano, Municipio, 
  apgar_1 = (X0.a.2_apgar1 + X3.a.5_apgar1*4 + 
               X6.a.7_apgar1*6.5 + X8.a.10_apgar1*9)/Total_apgar1)

apgar5 = base %>% select(Ano, Municipio, contains('apgar5')) %>% 
  summarise(Ano, Municipio, 
            apgar_5 = (X0.a.2_apgar5 + X3.a.5_apgar5*4 + 
                         X6.a.7_apgar5*6.5 + X8.a.10_apgar5*9)/Total_apgar5)

peso_ao_nascer = base %>% select(!contains('Cap')) %>% select(!contains('apgar'), -Total, -Populacao) %>% 
  summarise(Ano, Municipio, 
         Peso = (Menos.de.500g*250 + X500.a.999g*750 + X1000.a.1499.g*1250 + 
           X1500.a.2499.g*2000 + X2500.a.2999.g*2750 + X3000.a.3999.g*3500 + 
             X4000g.e.mais*4500)/Total_peso/1000)

base_com_indicadores = inner_join(apgar1, apgar5) %>% inner_join(peso_ao_nascer)

write.csv2(base_com_indicadores, 'base_com_indicadores.csv', row.names = F)
