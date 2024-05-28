# Residência em Pesquisa em Monitoramento e Avaliação: Projeto de Programação e Análise de Dados

_Repositório criado para o trabalho a ser realizado no workshop de programação do Programa de Residência_

A desigualdade de saúde é um problema crítico que prevalece nos países em desenvolvimento, incluindo o Brasil. O uso dos dados de nascimentos e mortes coletados por meio dos sistemas SINASC e SIM do DATASUS ajudará a rastrear e analisar como as tendências da desigualdade de saúde nos municípios do Brasil mudaram ao longo da última década. A análise cobrirá o período de 2010 até o 2022, fornecendo uma imagem abrangente e atualizada das mudanças e tendências gerais em termos de saúde pública no Brasil. A unidade de análise é constituída por municípios do Brasil e oferecerá a capacidade de entender as disparidades de saúde em níveis locais.

Antes da execução do projeto, foi realizado um brainstorming para organizar a execução do trabalho utilizando a plataforma de colaboração Miro. Este processo colaborativo resultou em um caminho lógico claro para a execução do projeto. Abaixo se encontra imagem que resume o processo.

### Fluxograma do Projeto de Desigualdade de Saúde
![](https://github.com/michelszklo/residencia/assets/167810039/571a2096-25f7-4314-8297-401aa149dcc2)

O fluxograma é organizado em várias etapas, com diferentes formas representando elementos distintos do processo:

- Quadrados Verdes: Representam bases de dados.
- Círculos Azuis: Representam scripts ou processos.
- Losangos Brancos: Representam outputs ou produtos finais.

Em resumo, a imagem acima ilustra o processo detalhado que começa com a extração e transformação dos dados, passa pela unificação das bases de dados, criação de indicadores e culmina na análise dos dados, que inclui a geração de gráficos e mapas para visualização dos resultados. Este caminho lógico, colaborativamente elaborado e visualizado na plataforma Miro, estrutura a execução do projeto de maneira clara e organizada.

### Análise dos dados

A escala de APGAR é um teste realizado logo após o nascimento do bebê para avaliar sua vitalidade e estado geral. A avaliação é feita tanto ao final do primeiro quanto do quinto minuto após o nascimento. Um resultado superior a 7 é considerado normal, indicando menor risco de complicações pós-nascimento, como infecções e hipoglicemia. Fatores como gravidez de risco, parto por cesárea, complicações no parto e nascimentos antes de 37 semanas podem influenciar a pontuação. Pontuações baixas podem levar à internação na neonatologia para cuidados específicos e garantir um desenvolvimento saudável.

Observa-se que a maioria dos municípios apresenta uma pontuação na escala de APGAR acima de 7, havendo uma notável melhoria ao comparar os dados de 2010 e 2022. No último ano mencionado, o mapa exibe tons mais escuros, sugerindo uma incidência maior de pontuações mais altas na escala. Apesar do progresso, as regiões norte e nordeste continuam a ter as pontuações mais baixas em 2022, refletindo um desempenho inferior em relação às demais regiões.


![mapa1](https://github.com/michelszklo/residencia/assets/167810039/20c05910-eca7-4d3d-ab7b-0896edec046a)
![mapa2](https://github.com/michelszklo/residencia/assets/167810039/979100e6-2137-47e6-8bc2-f276a2ad01e1)

Ainda sobre o APGAR, quando se analisa a distribuição dos pontos de dados, a maioria destes está agrupada em torno dos valores médios de log(taxa de mortalidade). Alguns pontos estão dispersos nas extremidades inferiores e superiores de log(taxa de mortalidade), o que pode indicar outliers ou simplesmente valores menos comuns no conjunto de dados.

A tendência positiva sugere que, em regiões ou populações com uma taxa de mortalidade geral mais alta, os recém-nascidos tendem a ter um Apgar score mais alto no 1º minuto. Isso pode parecer contra-intuitivo, pois esperaríamos que uma maior taxa de mortalidade geral estivesse associada a piores condições de saúde. É importante investigar possíveis fatores subjacentes ou variáveis de confusão que possam explicar essa relação.

O gráfico de dispersão e a análise de regressão sugerem uma correlação positiva entre log(taxa de mortalidade) e o APGAR no 1º minuto. Essa relação é forte e consistente na faixa intermediária dos dados, mas mostra mais variabilidade nas extremidades. A natureza contra-intuitiva dessa relação sugere que outros fatores contextuais e variáveis de confusão devem ser considerados para uma interpretação mais completa desses resultados. O vídeo abaixo sintetiza a análise.

https://github.com/michelszklo/residencia/assets/167810039/ddb77fd7-b133-4b9d-8dad-4e4ed8cb8f94
