# Renomeando Capítulos
library(dplyr)

# Infeccioso - Cap 1
# Respiratório - Cap 10
# Congenital - Cap 17
# Perinatal - Cap 16
# Externo - Cap 20
# Nutricional - Cap 4

basesim = read.csv2("basesim.csv") %>% rename(Municipio = Município)

capitulos_usados = paste0('Cap.', c('I', 'IV', 'X', 'XVI', 'XVII', 'XX'))
base_mortalidade = basesim %>% select(Municipio, Ano, capitulos_usados)
colnames(base_mortalidade)[seq(3, 8)] = c('Infeccioso', 'Nutricional', 'Respiratório',
                                        'Perinatal', 'Congenital', 'Externo')

write.csv2(base_mortalidade, '05_base_mortalidade.csv', row.names = F)
