# Extrair população
library(dplyr)
form_data = "Linha=Munic%EDpio&Coluna=Ano&Incremento=Popula%E7%E3o_residente&Arquivos=pop21.dbf&Arquivos=pop20.dbf&Arquivos=pop19.dbf&Arquivos=pop18.dbf&Arquivos=pop17.dbf&Arquivos=pop16.dbf&Arquivos=pop15.dbf&Arquivos=pop14.dbf&Arquivos=pop13.dbf&Arquivos=pop12.dbf&Arquivos=pop11.dbf&Arquivos=pop10.dbf&SRegi%E3o=TODAS_AS_CATEGORIAS__&pesqmes2=Digite+o+texto+e+ache+f%E1cil&SUnidade_da_Federa%E7%E3o=TODAS_AS_CATEGORIAS__&pesqmes3=Digite+o+texto+e+ache+f%E1cil&SMunic%EDpio=TODAS_AS_CATEGORIAS__&pesqmes4=Digite+o+texto+e+ache+f%E1cil&SCapital=TODAS_AS_CATEGORIAS__&pesqmes5=Digite+o+texto+e+ache+f%E1cil&SRegi%E3o_de_Sa%FAde_%28CIR%29=TODAS_AS_CATEGORIAS__&pesqmes6=Digite+o+texto+e+ache+f%E1cil&SMacrorregi%E3o_de_Sa%FAde=TODAS_AS_CATEGORIAS__&pesqmes7=Digite+o+texto+e+ache+f%E1cil&SMicrorregi%E3o_IBGE=TODAS_AS_CATEGORIAS__&pesqmes8=Digite+o+texto+e+ache+f%E1cil&SRegi%E3o_Metropolitana_-_RIDE=TODAS_AS_CATEGORIAS__&pesqmes9=Digite+o+texto+e+ache+f%E1cil&STerrit%F3rio_da_Cidadania=TODAS_AS_CATEGORIAS__&pesqmes10=Digite+o+texto+e+ache+f%E1cil&SMacrorregi%E3o_PNDR=TODAS_AS_CATEGORIAS__&SAmaz%F4nia_Legal=TODAS_AS_CATEGORIAS__&SSemi%E1rido=TODAS_AS_CATEGORIAS__&SFaixa_de_Fronteira=TODAS_AS_CATEGORIAS__&SZona_de_Fronteira=TODAS_AS_CATEGORIAS__&SMunic%EDpio_de_extrema_pobreza=TODAS_AS_CATEGORIAS__&SSexo=TODAS_AS_CATEGORIAS__&pesqmes17=Digite+o+texto+e+ache+f%E1cil&SFaixa_Et%E1ria_1=TODAS_AS_CATEGORIAS__&pesqmes18=Digite+o+texto+e+ache+f%E1cil&SFaixa_Et%E1ria_2=TODAS_AS_CATEGORIAS__&pesqmes19=Digite+o+texto+e+ache+f%E1cil&SIdade_simples=TODAS_AS_CATEGORIAS__&formato=table&mostre=Mostra"

site <- httr::POST(url = "http://tabnet.datasus.gov.br/cgi/tabcgi.exe?ibge/cnv/popsvsbr.def",
                   body = form_data)
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

write.csv(df, 'populacao.csv', row.names = F)
