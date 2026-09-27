# instalando e carregando pacotes ---------------------

install.packages('readxl')
install.packages('dplyr') #instalação dos pacotes
install.packages('ggplot2')
install.packages("scales")

library(readxl)
library(dplyr) #carregamento dos pacotes
library(ggplot2)
library(scales)

# importação dos dados, ajustes e analise exploratoria -----------------

vendas <- read_excel("Vendas_Informatica_2025.xlsx") #importaçao
str(vendas) #verificação da estrutura interna
summary(vendas) #resumo estatistico


vendas$Data <- as.Date(vendas$Data) # Ajustando a data e criando colunas de mes e dia da semana
vendas$Mes <- format(vendas$Data, "%m")
vendas$DiaSemana <- weekdays(vendas$Data)

resumo_loja <- vendas |> 
  group_by(ID_Loja) |> 
  summarise(
    faturamento = sum(Valor_Final), #faz um df com: faturamento, qtd vendas e ticket med
    qtd_vendas = n(),
    ticket_medio = mean(Valor_Final)
  ) |> 
  arrange(desc(faturamento)) 

resumo_produto <- vendas |> 
  group_by(Produto) |> #lista todo o faturamente por protudo
  summarise(faturamento = sum(Valor_Final), qtd_vendas = n()) |> 
  arrange(desc(faturamento))

top10 <- head(resumo_produto, 10) #pega os 10 melhores
piores10 <- tail(resumo_produto, 10) #pega os 10 piores

resumo_mes <- vendas |> 
  group_by(Mes) |> #faturamento total de cada mes
  summarise(faturamento = sum(Valor_Final))

resumo_dia <- vendas |> 
  group_by(DiaSemana) |> #cria um df com o faturamento por cada dia da semana (Seg - dom)
  summarise(faturamento = sum(Valor_Final)) |> 
  arrange(desc(faturamento))

produtos_alvo <- c("HD Externo 1TB", "Carregador para Notebook", "Memoria RAM 8GB")
vendas_alvo <- filter(vendas, Produto %in% produtos_alvo)

faturamento_mensal <- vendas_alvo |> 
  group_by(ID_Loja, Mes) |> #df com faturamento somente dos produtos alvos
  summarise(faturamento_mes = sum(Valor_Final), .groups = "drop")

consistencia <- faturamento_mensal |> 
  group_by(ID_Loja) |> 
  summarise(  #media a desvio padrao
    media = mean(faturamento_mes),
    desvio_padrao = sd(faturamento_mes)
  ) |> 
  arrange(desvio_padrao)

# Graficos ------------------------------

ggplot(resumo_loja, aes(x = ID_Loja, y = faturamento)) +
  geom_col(fill = "steelblue") + #grafico do df resumo loja
  labs(title = "Faturamento por loja", x = "Loja", y = "Faturamento (R$)") +
  scale_y_continuous(
    labels = label_number(big.mark = ".", decimal.mark = ",")
  )

ggplot(top10, aes(x = reorder(Produto, faturamento), y = faturamento)) +
  geom_col(fill = "forestgreen") + #grafico do top 10 por faturamento
  coord_flip() +
  labs(title = "Top 10 produtos por faturamento", x = "", y = "Faturamento (R$)") +
  scale_y_continuous(
    labels = label_number(big.mark = ".", decimal.mark = ",")
  )

ggplot(resumo_mes, aes(x = Mes, y = faturamento, group = 1)) +
  geom_line(color = "red") + #grafico do faturamento de cada mes
  geom_point() +
  labs(title = "Faturamento por mes", x = "Mes", y = "Faturamento (R$)")+
  scale_y_continuous(
    labels = label_number(big.mark = ".", decimal.mark = ",")
  )

ggplot(resumo_dia, aes(x = DiaSemana, y = faturamento)) +
  geom_col(fill = "purple") + #grafico do faturamento de cada dia da semana
  labs(title = "Faturamento por dia da semana", x = "", y = "Faturamento (R$)")+
  scale_y_continuous(
    labels = label_number(big.mark = ".", decimal.mark = ",")
  )

#