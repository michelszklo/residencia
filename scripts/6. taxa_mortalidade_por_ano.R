#calculando taxas de mortalidade geral por municipio segundo ano

base_unica <- read.csv2("base_unica.csv", header = TRUE, sep = ",")

# Criando um novo dataframe para armazenar as taxas de mortalidade por ano e município
taxas_mortalidade_geral <- base_unica %>%
  group_by(Ano, Municipio) %>%
  summarise(Taxa_Mortalidade_Geral = sum(Total) / sum(Populacao) * 1000)

write.csv(taxas_mortalidade_geral, "taxa_mortalidade_geral.csv", row.names = FALSE)
