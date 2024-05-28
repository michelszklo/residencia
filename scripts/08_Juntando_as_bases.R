# Juntando as bases

base_taxa_mortalidade = read.csv2("base_taxa_mortalidade.csv")
base_com_indicadores = read.csv2('base_com_indicadores.csv')

base_final = inner_join(base_taxa_mortalidade, base_com_indicadores)

write.csv2(base_final, "base_final.csv", row.names = F)
