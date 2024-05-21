#criando gráficos

# Carregar pacotes
library(tidyr)
library(ggplot2)

# Faltou comando para puxar a base taxa_mortalidade_geral

top_municipios <- taxas_mortalidade_geral %>%
  arrange(Ano, desc(Taxa_Mortalidade_Geral)) %>%
  group_by(Ano) %>%
  top_n(10)


# Loop sobre cada ano
for (ano in anos) {
  # Filtra os dados para o ano atual
  dados_ano <- subset(top_municipios, Ano == ano)
  
  # Cria o gráfico de barras para o ano atual
  p <- ggplot(dados_ano, aes(x = Municipio, y = Taxa_Mortalidade_Geral, fill = Municipio)) +
    geom_bar(stat = "identity", show.legend = TRUE) +
    labs(title = paste("Ano", ano), y = "Taxa de Mortalidade", fill = "Município") +
    theme_minimal() +
    theme(axis.text.x = element_blank(),  # Oculta os rótulos do eixo x
          legend.position = "right")  # Posiciona a legenda à direita
  
  # Define o nome do arquivo a ser salvo
  nome_arquivo <- paste("grafico_", ano, ".png", sep="")
  
  # Salva o gráfico atual como um arquivo PNG
  ggsave(nome_arquivo, plot = p)
}
