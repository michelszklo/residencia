library(ggplot2)

indicador_escolaridade <- na.omit(indicador_escolaridade)

# Gráfico para peso
grafico_peso <- ggplot(indicador_escolaridade, aes(x = intervalo_esc, y = media_peso, fill = as.factor(ano))) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Média de peso por intervalo de escolaridade da mãe",
       x = "Intervalo de escolaridade da mãe",
       y = "Média de peso",
       fill = "Ano") +
  scale_fill_manual(values = c("2010" = "skyblue", "2011" = "lightgreen")) +
  theme_minimal()

# Gráfico para APGAR1
grafico_apgar1 <- ggplot(indicador_escolaridade, aes(x = intervalo_esc, y = media_apgar1, fill = as.factor(ano))) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Média de APGAR1 por intervalo de escolaridade da mãe",
       x = "Intervalo de escolaridade da mãe",
       y = "Média de APGAR1",
       fill = "Ano") +
  scale_fill_manual(values = c("2010" = "skyblue", "2011" = "lightgreen")) +
  theme_minimal()

# Gráfico para APGAR5
grafico_apgar5 <- ggplot(indicador_escolaridade, aes(x = intervalo_esc, y = media_apgar5, fill = as.factor(ano))) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Média de APGAR5 por intervalo de escolaridade da mãe",
       x = "Intervalo de escolaridade da mãe",
       y = "Média de APGAR5",
       fill = "Ano") +
  scale_fill_manual(values = c("2010" = "skyblue", "2011" = "lightgreen")) +
  theme_minimal()

# Exibir os gráficos
print(grafico_peso)
print(grafico_apgar1)
print(grafico_apgar5)


ggsave("grafico_peso.png", plot = grafico_peso, width = 8, height = 6, units = "in", dpi = 300)
ggsave("grafico_apgar1.png", plot = grafico_apgar1, width = 8, height = 6, units = "in", dpi = 300)
ggsave("grafico_apgar5.png", plot = grafico_apgar5, width = 8, height = 6, units = "in", dpi = 300)
