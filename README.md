# Análise Exploratória - Olist
Este projeto realiza uma série de análises detalhadas sobre os dados de vendas da Olist, focando em diferentes aspectos como vendas por tamanho de loja, desempenho de produtos e a relação entre avaliações, frete e vendas. Utilizamos Google BigQuery como Datawarehouse para armazenar e consultar os dados, e dbt (Data Build Tool) para transformar e preparar os dados para análise.

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




