# Criando os Indicadores

library(dplyr)
library(tidyverse)

apgar1 = read.csv2('Apgar1.csv', sep = ',') %>% rename(Municipio = Município)
apgar5 = read.csv2('Apgar5.csv', sep = ',') %>% rename(Municipio = Município)
peso_ao_nascer = read.csv2('peso_ao_nascer.csv', sep = ',') %>% rename(Municipio = Município)

apgar1 = apgar1 %>% 
  group_by(Ano, Municipio) %>%  
  summarise(apgar_1 = (X0.a.2 + X3.a.5*4 + 
               X6.a.7*6.5 + X8.a.10*9)/Total)

apgar5 = apgar5 %>%
  group_by(Ano, Municipio) %>% 
  summarise(apgar_5 = (X0.a.2 + X3.a.5*4 + 
                         X6.a.7*6.5 + X8.a.10*9)/Total)

peso_ao_nascer = peso_ao_nascer %>%  
  group_by(Ano, Municipio) %>% 
         summarise(Peso = (Menos.de.500g*250 + X500.a.999g*750 + X1000.a.1499.g*1250 + 
           X1500.a.2499.g*2000 + X2500.a.2999.g*2750 + X3000.a.3999.g*3500 + 
             X4000g.e.mais*4500)/Total/1000)

base_com_indicadores = inner_join(apgar1, apgar5) %>% inner_join(peso_ao_nascer)

write.csv2(base_com_indicadores, 'base_com_indicadores.csv', row.names = F)
