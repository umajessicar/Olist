# Análise Exploratória E-commerce (Olist)
Este projeto realiza uma série de análises sobre os dados de vendas da Olist, focando em diferentes aspectos como vendas por tamanho de loja, desempenho de produtos e a relação entre avaliações, frete e vendas. 
Utilizei Google BigQuery como Datawarehouse para armazenar e consultar os dados, e dbt (Data Build Tool) para transformar e preparar os dados para análise.

# Estrutura do Projeto

**Modelos Transformados**

O projeto segue uma estrutura de transformação de dados em camadas:

Bronze: Dados brutos carregados diretamente das fontes.

Silver: Dados limpos e enriquecidos.

Gold: Dados finais prontos para análise, com as métricas e agregações necessárias.

**As tabelas finais deste projeto são:**

**final_store_analysis:** Análise de vendas por tamanho de loja e categoria de produto.

**freight_sales:** Análise de vendas baseada na média do valor do frete.

**product_analysis:** Desempenho detalhado de produtos, incluindo vendas, valor médio do pedido, valor médio do frete, número de comentários e avaliação média.

**reviews_sales:** Análise da relação entre vendas e satisfação do cliente, categorizando produtos por nível de satisfação.



# Qual é o desempenho das categorias em termos de frequência de compra e valor total?

# Qual é o impacto dos custos de frete nas vendas totais e na média de vendas por produto?

**Volume Total de Vendas e Custo de Frete:**
   
Frete Baixo: Os produtos com custo de frete mais baixo geraram um total de vendas de aproximadamente 7.23 milhões, distribuídos por 24.163 produtos. Isso indica que produtos com fretes mais baixos podem ter maior volume de vendas.

Frete Alto: Os produtos com frete mais alto geraram um total de vendas de cerca de 6.36 milhões, mas com um número significativamente menor de produtos, 8.788. Isso sugere que, embora o volume de vendas seja alto, há uma menor quantidade de produtos com esse tipo de frete.

**Média de Vendas por Produto:**

Frete Baixo: A média de vendas por produto para os itens com frete baixo é de aproximadamente 299.34. Isso indica que, embora esses produtos sejam mais numerosos, o valor médio das vendas por produto é relativamente menor.

Frete Alto: A média de vendas por produto para os itens com frete alto é significativamente maior, cerca de 723.57. Isso sugere que, mesmo com custos de frete mais altos, esses produtos conseguem manter um valor médio de vendas elevado, o que pode compensar o custo adicional.

**Potenciais Implicações:**

Estratégia de Preço e Frete: Os dados indicam que, para produtos com maior valor agregado, um custo de frete mais alto pode ser justificado, pois o valor médio de venda por produto ainda é alto. Isso pode indicar uma menor sensibilidade ao preço do frete para itens de maior valor.

Volume vs. Valor: Produtos com frete baixo são mais acessíveis em termos de volume de vendas, mas os produtos com frete alto oferecem maior valor por unidade vendida. Dependendo do objetivo da empresa (aumentar o volume de vendas ou maximizar a receita por produto), diferentes estratégias de precificação e frete podem ser aplicadas.


# Como a satisfação do cliente influencia o desempenho de vendas e o engajamento em diferentes categorias de produtos?

Análise com base na satisfação dos clientes, considerando as vendas totais, a quantidade total de produtos, a média de vendas por produto e o número total de avaliações:

**Insights:**

- Engajamento e Satisfação: Há uma clara correlação entre a satisfação do cliente e o número de avaliações, com as categorias de alta satisfação gerando mais engajamento.
- Média de Vendas por Produto: Curiosamente, a média de vendas por produto é alta tanto em categorias de alta quanto de baixa satisfação, sugerindo que outros fatores além da satisfação também influenciam nas vendas.
- Potencial de Melhoria: As categorias de satisfação média e baixa podem se beneficiar de estratégias para melhorar a satisfação do cliente, o que pode, por sua vez, aumentar as vendas e o engajamento.



# Qual o perfil dos produtos que mais venderam - categoria, média do valor de frete, média de avaliação de clientes.

**Produtos Bem Avaliados Vendem Mais:** A correlação entre avaliações altas e volume de vendas é evidente, com a maioria dos produtos mais vendidos recebendo boas avaliações dos clientes.

**Frete impacta diferentes categorias de maneiras variadas:** Produtos com fretes mais baixos como "Relógios e Presentes" podem estar em maior demanda devido ao custo adicional reduzido para o cliente. Em contrapartida, categorias como "Cool Stuff" ainda conseguem boas vendas, mesmo com fretes mais altos.

**Alta Demanda por Categorias Específicas:** "Beleza e Saúde" e "Informática e Acessórios" são categorias de destaque, com múltiplos produtos entre os top 10, sugerindo que essas áreas podem ser alvos para expandir a linha de produtos.

# O valor do frete tem relação com o volume de vendas?









