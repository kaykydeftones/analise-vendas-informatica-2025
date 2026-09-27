# Análise de Vendas - Distribuidora de Informática (2025)

Projeto de análise exploratória de dados com o objetivo de identificar alternativas para aumentar as vendas de uma distribuidora de informática com 5 filiais.

## Contexto

A empresa possui 5 filiais (Centro, Barra da Tijuca, Botafogo, Irajá e Bangu) e queria entender **o que fazer para aumentar o número de vendas**. A única informação disponível era uma planilha com o histórico de vendas de 2025 (data, loja, produto, quantidade, valor unitário e valor final).

## Ferramentas utilizadas

- R
- readxl (leitura do Excel)
- dplyr (manipulação dos dados)
- ggplot2 (visualização)
- scales (ajuste)

## Análises realizadas

1. Faturamento e ticket médio por loja
2. Faturamento por produto (top vendedores e produtos de baixo giro)
3. Faturamento por dia da semana
4. Faturamento por mês (sazonalidade)
5. Correlação entre preço médio e quantidade vendida

## Principais insights

- **Loja Bangu fatura menos da metade do Centro**, mesmo com ticket médio praticamente igual às outras filiais — o problema é volume de clientes, não preço ou mix de produtos.
- **Correlação de -0,73 entre preço médio e quantidade vendida**: produtos mais caros (HD Externo, RAM, SSD) vendem bem menos unidades que produtos de ticket baixo (Pendrive, Mouse, Fone de Ouvido).
- Produtos de baixo giro (Cabo USB, Leitor de Cartão, Mousepad, Filtro de Linha) são candidatos naturais a **kits/combos** com os produtos mais vendidos.
- **Domingo é o dia mais fraco da semana** (~15% abaixo de segunda-feira).
- **Novembro e dezembro concentram o pico de faturamento** (efeito Black Friday + Natal), enquanto fevereiro e abril são os meses mais fracos.

## Recomendações

- Investir em marketing local e captação de clientes na filial de Bangu, em vez de ajustes de preço.
- Testar descontos controlados nos produtos de ticket alto e baixo giro para validar o efeito sobre o volume.
- Criar kits combinando produtos de baixo giro com os campeões de venda.
- Criar promoções específicas para o fim de semana.
- Planejar estoque e campanhas com antecedência para o pico de novembro/dezembro, e usar fevereiro/abril para liquidação de estoque parado.

## Como rodar

1. Instale os pacotes necessários:
```r
install.packages(c("readxl", "dplyr", "ggplot2", "scales"))
```
2. Coloque o arquivo `Vendas_Informatica_2025.xlsx` na mesma pasta do script.
3. Execute o script `script_analise_vendas.R` no RStudio.

## Autor

Kayky de Oliveira Pavão
