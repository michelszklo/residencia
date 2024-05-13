# WebScrapping para a base do Sinasc no R
library(httr)
library(dplyr)
library(rvest)
# Loop com os anos e com as variáveis (APGAR1, APGAR5 e Peso ao Nascer)

anos = seq(10, 22)
anos_formatados = paste0("20", anos)
variavel = seq(10, 22)
bases_totais = list()

bases = list()
for (k in seq(1, 3)){
  categoria = c('Peso_ao_nascer','Apgar_5%BA_minuto', 'Apgar_1%BA_minuto')
  for(i in seq(1, length(variavel))){
    ano = variavel[i]
    form_data = paste0("Linha=Munic%EDpio&Coluna=", categoria[k], "&Incremento=Nascim_p%2Fresid.m%E3e&Arquivos=nvbr", variavel[i],".dbf&pesqmes1=Digite+o+texto+e+ache+f%E1cil&SMunic%EDpio=TODAS_AS_CATEGORIAS__&pesqmes2=Digite+o+texto+e+ache+f%E1cil&SCapital=TODAS_AS_CATEGORIAS__&pesqmes3=Digite+o+texto+e+ache+f%E1cil&SRegi%E3o_de_Sa%FAde_%28CIR%29=TODAS_AS_CATEGORIAS__&pesqmes4=Digite+o+texto+e+ache+f%E1cil&SMacrorregi%E3o_de_Sa%FAde=TODAS_AS_CATEGORIAS__&pesqmes5=Digite+o+texto+e+ache+f%E1cil&SMicrorregi%E3o_IBGE=TODAS_AS_CATEGORIAS__&pesqmes6=Digite+o+texto+e+ache+f%E1cil&SRegi%E3o_Metropolitana_-_RIDE=TODAS_AS_CATEGORIAS__&pesqmes7=Digite+o+texto+e+ache+f%E1cil&STerrit%F3rio_da_Cidadania=TODAS_AS_CATEGORIAS__&pesqmes8=Digite+o+texto+e+ache+f%E1cil&SMesorregi%E3o_PNDR=TODAS_AS_CATEGORIAS__&SAmaz%F4nia_Legal=TODAS_AS_CATEGORIAS__&SSemi%E1rido=TODAS_AS_CATEGORIAS__&SFaixa_de_Fronteira=TODAS_AS_CATEGORIAS__&SZona_de_Fronteira=TODAS_AS_CATEGORIAS__&SMunic%EDpio_de_extrema_pobreza=TODAS_AS_CATEGORIAS__&SLocal_ocorr%EAncia=TODAS_AS_CATEGORIAS__&pesqmes15=Digite+o+texto+e+ache+f%E1cil&SIdade_da_m%E3e=TODAS_AS_CATEGORIAS__&pesqmes16=Digite+o+texto+e+ache+f%E1cil&SInstru%E7%E3o_da_m%E3e=TODAS_AS_CATEGORIAS__&SEstado_civil_m%E3e=TODAS_AS_CATEGORIAS__&SDura%E7%E3o_gesta%E7%E3o=TODAS_AS_CATEGORIAS__&STipo_de_gravidez=TODAS_AS_CATEGORIAS__&pesqmes20=Digite+o+texto+e+ache+f%E1cil&SGrupos_de_Robson=TODAS_AS_CATEGORIAS__&SAdeq_quant_pr%E9-natal*=TODAS_AS_CATEGORIAS__&STipo_de_parto=TODAS_AS_CATEGORIAS__&SConsult_pr%E9-natal=TODAS_AS_CATEGORIAS__&SSexo=TODAS_AS_CATEGORIAS__&SCor%2Fra%E7a=TODAS_AS_CATEGORIAS__&SApgar_1%BA_minuto=TODAS_AS_CATEGORIAS__&SApgar_5%BA_minuto=TODAS_AS_CATEGORIAS__&SPeso_ao_nascer=TODAS_AS_CATEGORIAS__&SAnomalia_cong%EAnita=TODAS_AS_CATEGORIAS__&pesqmes30=Digite+o+texto+e+ache+f%E1cil&STipo_anomal_cong%EAn=TODAS_AS_CATEGORIAS__&formato=table&mostre=Mostra")
    site <- httr::POST(url = "http://tabnet.datasus.gov.br/cgi/tabcgi.exe?sinasc/cnv/nvbr.def",
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
  df_final = rbind(bases[[1]], bases[[2]], bases[[3]], bases[[4]],
                   bases[[5]], bases[[6]], bases[[7]], bases[[8]],
                   bases[[9]], bases[[10]], bases[[11]], bases[[12]],
                   bases[[13]])
  bases_totais[[k]] = df_final
}

# são 3 write.csv()

write.csv(bases_totais[[1]], 'Peso_ao_nascer.csv')
write.csv(bases_totais[[2]], 'Apgar5.csv')
write.csv(bases_totais[[3]], 'Apgar1.csv')
