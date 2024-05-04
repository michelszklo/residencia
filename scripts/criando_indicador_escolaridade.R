# Carregar os dados do arquivo CSV previamente gerado
dados_sinasc_ <- read.csv2("Base_sinasc_.csv")

# Criar intervalos para a escolaridade da mãe
dados_sinasc_$intervalo_esc <- cut(dados_sinasc_$ESCMAE, 
                                  breaks = c(0, 1, 3, 7, 11, Inf), # Por exemplo, dividindo em intervalos de 3 anos
                                  labels = c("Nenhuma", "1-3 anos", "4-7 anos", "8-11 anos", "12 e mais"))

# Criar um novo dataframe para armazenar os resultados do indicador
indicador_escolaridade <- data.frame()

# Calcular as médias de peso, APGAR1 e APGAR5 por intervalo de escolaridade e ano
for (ano in unique(dados_sinasc_$ano)) {
  for (intervalo in unique(dados_sinasc_$intervalo_esc)) {
    subset_data <- subset(dados_sinasc_, intervalo_esc == intervalo & ano == ano)
    media_peso <- mean(subset_data$PESO, na.rm = TRUE)
    media_apgar1 <- mean(subset_data$APGAR1, na.rm = TRUE)
    media_apgar5 <- mean(subset_data$APGAR5, na.rm = TRUE)
    
    # Construir o indicador de escolaridade por intervalo e ano
    indicador <- data.frame(ano = ano,
                            intervalo_esc = intervalo,
                            media_peso = media_peso,
                            media_apgar1 = media_apgar1,
                            media_apgar5 = media_apgar5)
    
    # Adicionar o indicador ao dataframe principal
    indicador_escolaridade <- rbind(indicador_escolaridade, indicador)
  }
}

# Exibir o resultado
print(indicador_escolaridade)

write.csv2(indicador_escolaridade, "Base_indicador_escolaridade.csv", row.names = F)
