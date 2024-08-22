# Projeto de SQL com dados da Olist (e-commerce)
Este projeto realiza uma série de análises sobre os dados de vendas da Olist, focando em diferentes aspectos como desempenho de produtos e a relação entre avaliações, frete e vendas. 
Utilizei Google BigQuery como data warehouse para armazenar e consultar os dados, e dbt (Data Build Tool) para transformar e preparar os dados para análise.

# Estrutura do Projeto

**Modelos Transformados**

O projeto segue uma estrutura de transformação de dados em camadas:

Bronze: Dados brutos carregados diretamente das fontes.

Silver: Dados limpos e enriquecidos.

Gold: Dados finais prontos para análise, com as métricas e agregações necessárias.

**As tabelas finais deste projeto são:**

**freight_sales:** Análise de vendas baseada na média do valor do frete.

**product_analysis:** Desempenho detalhado de produtos, incluindo vendas, valor médio do pedido, valor médio do frete, número de comentários e avaliação média.

**reviews_sales:** Análise da relação entre vendas e satisfação do cliente, categorizando produtos por nível de satisfação.


# Análise de Desempenho e Satisfação de Produtos por Categoria

Fiz uma query que junta dados de vendas de produtos (products_sales) com informações de avaliações e comentários (product_reviews). A união entre essas duas tabelas é feita com base no product_id, e o resultado final é ordenado pela métrica de vendas totais (total_sales), listando os produtos mais vendidos primeiro.

**Categoria de Beleza e Saúde:**

Produtos dessa categoria são bem avaliados, com uma média de avaliações superior a 4,2. Isso, combinado com altos valores de venda, sugere que os consumidores estão satisfeitos com os produtos, o que pode estar impulsionando as vendas.
O frete para esses produtos varia, mas permanece relativamente acessível, o que pode estar contribuindo positivamente para a decisão de compra.

**Categoria PCS:**

Este produto específico apresenta um valor de pedido médio extremamente alto (R$ 1.397,12) e uma alta avaliação média (4,59). Isso pode indicar que o produto é de alta qualidade e provavelmente atende a um nicho específico, o que justifica o preço elevado e a boa recepção do público.

**Categoria Informática e Acessórios:**

Embora tenha uma média de frete relativamente alta, os produtos desta categoria têm um bom desempenho em termos de vendas e satisfação do cliente (4,22). A alta quantidade de comentários (326) sugere que esses produtos são populares e frequentemente adquiridos.

**Categoria Cama, Mesa e Banho:**

Esta categoria tem um grande número de comentários (468), mas a avaliação média é um pouco mais baixa (3,90). Isso pode indicar que, apesar da popularidade, há alguns problemas de qualidade ou expectativas não atendidas que podem estar afetando a percepção geral do produto.

![produtos](https://github.com/user-attachments/assets/d5338d83-cbdf-4955-8f48-4152754b3b6a)

**Outros Insights:**

**Produtos Bem Avaliados Vendem Mais:** A correlação entre avaliações altas e volume de vendas é evidente, com a maioria dos produtos mais vendidos recebendo boas avaliações dos clientes.

**Frete impacta diferentes categorias de maneiras variadas:** Produtos com fretes mais baixos como "Relógios e Presentes" podem estar em maior demanda devido ao custo adicional reduzido para o cliente. Em contrapartida, categorias como "Cool Stuff" ainda conseguem boas vendas, mesmo com fretes mais altos.

**Alta Demanda por Categorias Específicas:** "Beleza e Saúde" e "Informática e Acessórios" são categorias de destaque, com múltiplos produtos entre os top 10, sugerindo que essas áreas podem ser alvos para expandir a linha de produtos.


# Volume Total de Vendas e Custo de Frete:

Nesta análise, explorei a relação entre o custo de frete e o volume de vendas, buscando entender como diferentes faixas de frete impactam o comportamento de compra dos consumidores. Foram definidas duas categorias de valores de frete - Low (baixo), High (alto). Considerei Low todos os valores na média e abaixo dela, já a High, os valores são acima da média. 

![frete](https://github.com/user-attachments/assets/62933683-70c6-425e-9e87-fef5919fb694)

- A faixa de frete "Low" gerou um maior volume total de vendas ($7.232.882,81) em comparação com a faixa "High" ($6.358.760,89). Isso sugere que, em termos absolutos, produtos com frete mais baixo são mais populares ou têm uma demanda maior.
  
**Número de Produtos Vendidos:**

- Um número significativamente maior de produtos foi vendido na faixa de frete "Low" (24.163 produtos) em comparação com a faixa "High" (8.788 produtos). Isso indica que os consumidores tendem a comprar mais produtos quando o frete é mais baixo.
  
**Média de Preço por Produto:**

- No entanto, a média de preço por produto é significativamente maior para a faixa de frete "High" ($723,57) em comparação com a faixa de frete "Low" ($299,34). Isso sugere que, embora menos produtos sejam vendidos com frete mais alto, aqueles que são vendidos têm um valor unitário mais alto, ou seja, são produtos mais caros ou de maior valor percebido.

**Potenciais Implicações:**

Estratégia de Preço e Frete: Os dados indicam que, para produtos com maior valor agregado, um custo de frete mais alto pode ser justificado, pois o valor médio de venda por produto ainda é alto. Isso pode indicar uma menor sensibilidade ao preço do frete para itens de maior valor.

Volume vs. Valor: Produtos com frete baixo são mais acessíveis em termos de volume de vendas, mas os produtos com frete alto oferecem maior valor por unidade vendida. Dependendo do objetivo da empresa (aumentar o volume de vendas ou maximizar a receita por produto), diferentes estratégias de precificação e frete podem ser aplicadas.


# Como a satisfação do cliente influencia o desempenho de vendas e o engajamento em diferentes categorias de produtos?

Análise com base na satisfação dos clientes, considerando as vendas totais, a quantidade total de produtos, a média de vendas por produto e o número total de avaliações:

![reviews](https://github.com/user-attachments/assets/9dfe3f3e-aefe-4a8b-bed3-5c74165eed14)


**Insights:**

- Engajamento e Satisfação: Há uma clara correlação entre a satisfação do cliente e o número de avaliações, com as categorias de alta satisfação gerando mais engajamento.
- Média de Vendas por Produto: Curiosamente, a média de vendas por produto é alta tanto em categorias de alta quanto de baixa satisfação, sugerindo que outros fatores além da satisfação também influenciam nas vendas.
- Potencial de Melhoria: As categorias de satisfação média e baixa podem se beneficiar de estratégias para melhorar a satisfação do cliente, o que pode, por sua vez, aumentar as vendas e o engajamento.

# Análise Preditiva de Churn 

Esta análise preditiva tem como objetivo segmentar os clientes com base no tempo decorrido desde sua última compra, identificando o risco de churn de acordo com o comportamento de compra. Para isso, utilizei a data 17/10/2018 como ponto de referência para comparação e classificação dos clientes nos seguintes grupos:

- High Risk (Alto Risco): Clientes que estão há mais de 90 dias sem realizar uma compra. Este grupo representa aqueles com maior probabilidade de churn, exigindo ações imediatas para tentar reverter o risco de cancelamento.

- Medium Risk (Risco Médio): Clientes que estão entre 60 e 90 dias sem comprar. Estes clientes estão em uma zona intermediária, com chances significativas de churn, mas ainda passíveis de reengajamento com campanhas direcionadas.

- Low Risk (Baixo Risco): Clientes que compraram nos últimos 60 dias, apresentando o menor risco de churn.


A análise de churn revelou uma preocupante concentração de clientes em alto risco de cancelamento, com quase 90% dos clientes classificados nesta categoria.

Isso sublinha a urgência de implementar estratégias de retenção focadas em reengajar esses clientes, enquanto se reforçam práticas de fidelização para manter os clientes de baixo risco engajados. O sucesso dessas intervenções poderá não apenas reduzir a taxa de churn, mas também revitalizar o crescimento e a sustentabilidade do negócio a longo prazo.













