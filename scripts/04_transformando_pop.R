#modificando a planilha população para o padrão das demais

library(tidyr)
library(dplyr)

populacao <- read.csv2("populacao.csv", header = TRUE, sep = ",")
colnames(populacao) <- c("Municipio", 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021)
transformando_pop <- pivot_longer(populacao, cols = -Municipio, names_to = "Ano", values_to = "Populacao")


write.csv(transformando_pop, "pop_transfor.csv", row.names = FALSE)


