# Criando taxa de mortalidade
library(tidyr)

pop_transfor = read.csv2('01_pop_transfor.csv')
base_mortalidade = read.csv2('05_base_mortalidade.csv') %>% 
  pivot_longer(cols = Infeccioso:Externo, names_to = 'Categoria', values_to = 'Morte')

base_taxa_mortalidade = base_mortalidade %>% inner_join(pop_transfor) %>% 
  mutate(Taxa_mortalidade = Morte/Populacao*10**5, .keep = 'unused')

write.csv2(base_taxa_mortalidade, "base_taxa_mortalidade.csv", row.names = F)

# Ano de 2022 se perde

