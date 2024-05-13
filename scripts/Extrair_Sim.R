# WebScrapping para a base do Sinasc no R
library(httr)
library(dplyr)
library(rvest)

# Loop com os anos
anos = seq(10, 22)
anos_formatados = paste0("20", anos)
variavel = paste0("obtbr", seq(10, 22))

bases = list()

for(i in seq(1, length(variavel))){
  ano = variavel[i]
  form_data = paste0("Linha=Munic%EDpio&Coluna=Cap%EDtulo_CID-10&Incremento=%D3bitos_p%2FResid%EAnc&Arquivos=",ano,".dbf&pesqmes1=Digite+o+texto+e+ache+f%E1cil&SMunic%EDpio=TODAS_AS_CATEGORIAS__&pesqmes2=Digite+o+texto+e+ache+f%E1cil&SCapital=TODAS_AS_CATEGORIAS__&pesqmes3=Digite+o+texto+e+ache+f%E1cil&SRegi%E3o_de_Sa%FAde_%28CIR%29=TODAS_AS_CATEGORIAS__&pesqmes4=Digite+o+texto+e+ache+f%E1cil&SMacrorregi%E3o_de_Sa%FAde=TODAS_AS_CATEGORIAS__&pesqmes5=Digite+o+texto+e+ache+f%E1cil&SMicrorregi%E3o_IBGE=TODAS_AS_CATEGORIAS__&pesqmes6=Digite+o+texto+e+ache+f%E1cil&SRegi%E3o_Metropolitana_-_RIDE=TODAS_AS_CATEGORIAS__&pesqmes7=Digite+o+texto+e+ache+f%E1cil&STerrit%F3rio_da_Cidadania=TODAS_AS_CATEGORIAS__&pesqmes8=Digite+o+texto+e+ache+f%E1cil&SMesorregi%E3o_PNDR=TODAS_AS_CATEGORIAS__&SAmaz%F4nia_Legal=TODAS_AS_CATEGORIAS__&SSemi%E1rido=TODAS_AS_CATEGORIAS__&SFaixa_de_Fronteira=TODAS_AS_CATEGORIAS__&SZona_de_Fronteira=TODAS_AS_CATEGORIAS__&SMunic%EDpio_de_extrema_pobreza=TODAS_AS_CATEGORIAS__&pesqmes14=Digite+o+texto+e+ache+f%E1cil&SCap%EDtulo_CID-10=TODAS_AS_CATEGORIAS__&pesqmes15=Digite+o+texto+e+ache+f%E1cil&SGrupo_CID-10=TODAS_AS_CATEGORIAS__&pesqmes16=Digite+o+texto+e+ache+f%E1cil&SCategoria_CID-10=TODAS_AS_CATEGORIAS__&pesqmes17=Digite+o+texto+e+ache+f%E1cil&SCausa_-_CID-BR-10=TODAS_AS_CATEGORIAS__&SCausa_mal_definidas=TODAS_AS_CATEGORIAS__&pesqmes19=Digite+o+texto+e+ache+f%E1cil&SFaixa_Et%E1ria=TODAS_AS_CATEGORIAS__&pesqmes20=Digite+o+texto+e+ache+f%E1cil&SFaixa_Et%E1ria_OPS=TODAS_AS_CATEGORIAS__&pesqmes21=Digite+o+texto+e+ache+f%E1cil&SFaixa_Et%E1ria_det=TODAS_AS_CATEGORIAS__&SFx.Et%E1ria_Menor_1A=TODAS_AS_CATEGORIAS__&SSexo=TODAS_AS_CATEGORIAS__&SCor%2Fra%E7a=TODAS_AS_CATEGORIAS__&SEscolaridade=TODAS_AS_CATEGORIAS__&SEstado_civil=TODAS_AS_CATEGORIAS__&SLocal_ocorr%EAncia=TODAS_AS_CATEGORIAS__&formato=table&mostre=Mostra")
  site <- httr::POST(url = "http://tabnet.datasus.gov.br/cgi/tabcgi.exe?sim/cnv/obt10br.def",
                     body = form_data, timeout(20))
  tabdados <- httr::content(site, encoding = "Latin1") %>%
    rvest::html_nodes(".tabdados tbody tr td") %>%
    rvest::html_text() %>%
    trimws()
  col_tabdados <- httr::content(site, encoding = "Latin1") %>%
    rvest::html_nodes("th")%>%
    rvest::html_text() %>%
    trimws()
  
  f1 <- function(x) x <- gsub("\\.", "", x)
  f2 <- function(x) x <- as.numeric(as.character(x))
  
  df <- as.data.frame(matrix(data = tabdados, nrow = length(tabdados)/length(col_tabdados), ncol = length(col_tabdados), byrow = TRUE))
  
  names(df) <- col_tabdados
  df[-1] <- lapply(df[-1], f1)
  df[-1] <- suppressWarnings(lapply(df[-1], f2))
  df[is.na(df)] <- 0
  df = df %>% mutate(Ano = anos_formatados[i])
  bases[[i]] = df
}
library(xlsx)
df_final = rbind(bases[[1]], bases[[2]], bases[[3]], bases[[4]],
                 bases[[5]], bases[[6]], bases[[7]], bases[[8]],
                 bases[[9]], bases[[10]], bases[[11]], bases[[12]],
                 bases[[13]])
# É só até 2022
setwd("D:/Desktop")
write.csv2(df_final, "basesim.csv")
