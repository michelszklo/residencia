
#carregando arquivos

basesim <- read.csv2("basesim.csv", header = TRUE)
basepop <- read.csv2("pop_transfor.csv", header = TRUE)
base_apgar1 <- read.csv2("Apgar1.csv", header = TRUE)
base_apgar5 <- read.csv2("Apgar5.csv", header = TRUE)
base_peso <- read.csv2("Peso_ao_nascer.csv", header = TRUE)


#unindo bases

base_unica <- merge(merge(merge(merge(basesim, basepop, by = c("Ano", "Municipio"), all = TRUE), 
                                 base_apgar1, by = c("Ano", "Municipio"), all = TRUE), 
                           base_apgar5, by = c("Ano", "Municipio"), all = TRUE), 
                     base_peso, by = c("Ano", "Municipio"), all = TRUE)

write.csv(base_unica, "base_unica.csv", row.names = FALSE)
