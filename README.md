# Projeto em SQL e DBT-core com dados da Olist (e-commerce)

A Olist é uma plataforma brasileira de e-commerce que oferece uma solução completa para lojistas que desejam vender seus produtos em grandes marketplaces, como Mercado Livre e Amazon. Facilitando o processo de venda online, a Olist suporta a logística, gerenciamento de estoque e integração com múltiplos canais de venda. Esse modelo de negócio gera uma vasta quantidade de dados sobre transações, produtos e comportamento dos consumidores, fornecendo uma rica base para análises de business intelligence.

Os dados utilizados neste projeto provêm de transações e interações dos clientes com a plataforma da Olist. As tabelas incluem:

**Orders:** Contém informações sobre os pedidos realizados, como data de compra, aprovação, envio, e entrega.

**Order Items:** Detalha os itens específicos comprados em cada pedido, incluindo preço, frete, e produto associado.

**Products:** Fornece detalhes sobre os produtos disponíveis, como categoria, nome, e características.

**Customers:** Informações sobre os clientes, incluindo localização, identificador único e dados demográficos.

**Reviews:** Avaliações dos clientes, incluindo nota de satisfação e comentários sobre os produtos.

Esses dados são armazenados e consultados utilizando o Google BigQuery e, para realizar as análises, foi utilizado o dbt (Data Build Tool), uma ferramenta  que que facilita a criação de modelos de dados reutilizáveis e otimiza as consultas SQL, organizando o fluxo de transformação em camadas, como bronze (dados brutos), silver (dados parcialmente transformados) e gold (dados prontos para análise).

As principais transformações incluem:

**Cálculo de Métricas de Vendas:** Como o total de vendas por produto, valor médio por pedido, e análise de frete.

**Análise de Avaliações de Produtos:** Categorização dos produtos com base em métricas de satisfação do cliente, incluindo a classificação em categorias como 'Alta', 'Média' e 'Baixa' satisfação.

**Integração de Dados:** Combinação de diversas fontes para criar uma visão unificada e abrangente sobre o desempenho dos produtos e comportamento dos clientes.

# Objetivo do Projeto

Este projeto tem como objetivo principal fornecer insights sobre o desempenho de vendas da Olist, com foco em diversas áreas:

**Análise de Desempenho de Produtos:** Identificar os produtos mais e menos vendidos, avaliar a relação entre preço, frete e volume de vendas, e analisar como as avaliações dos clientes impactam as vendas.

**Análise de Avaliações e Satisfação:** Examinar as avaliações dos clientes para entender a relação entre a satisfação do cliente e o desempenho do produto. Isso inclui a categorização de produtos com alta, média e baixa satisfação e a análise do impacto disso nas vendas.

**Análise de Frete:** Explorar a influência dos custos de frete no comportamento de compra e nas vendas totais, categorizando produtos por faixa de custo de frete (baixo ou alto).

**Análise Preditiva de Churn:** Além das análises descritivas, o projeto também inclui uma análise preditiva focada em identificar clientes com alta probabilidade de churn (desistência). Identificar esses padrões nos dados pode prever o churn, permitindo à Olist tomar ações proativas para reter clientes.

# Estrutura do Projeto

**Modelos Transformados**

O projeto segue uma estrutura de transformação de dados em camadas:

Bronze: Dados brutos carregados diretamente das fontes.

Silver: Dados limpos e enriquecidos.

Gold: Dados finais prontos para análise, com as métricas e agregações necessárias.

A imagem abaixo mostra o relacionamento entre elas:

![relationship](https://github.com/user-attachments/assets/32d167f7-d6c4-4400-8aa6-12a412fafef0)


**As tabelas finais deste projeto são:**

**freight_sales:** Análise de vendas baseada na média do valor do frete.

**product_analysis:** Desempenho detalhado de produtos, incluindo vendas, valor médio do pedido, valor médio do frete, número de comentários e avaliação média.

**reviews_sales:** Análise da relação entre vendas e satisfação do cliente, categorizando produtos por nível de satisfação.

**churn_analysis:** Análise preditiva para identificar o risco de churn e potenciais padrões.


# Análise de Desempenho e Satisfação de Produtos por Categoria

Com essa tabela, foi possível realizar a análise cruzada entre as métricas de vendas totais, avaliações dos clientes e custos de frete, proporcionando uma visão clara sobre quais produtos estão se destacando em termos de popularidade e qualidade percebida pelos consumidores.

**Categoria de Beleza e Saúde:**

Produtos dessa categoria são bem avaliados, com uma média de avaliações superior a 4,2. Isso, combinado com altos valores de venda, sugere que os consumidores estão satisfeitos com os produtos, o que pode estar impulsionando as vendas.
O frete para esses produtos varia, mas permanece relativamente acessível (na média ou abaixo dela), o que pode estar contribuindo positivamente para a decisão de compra.

**Categoria PCS:**

Por se tratar de uma categoria de computadores, o valor médio do pedido é bem mais alto que a média (R$ 1.397,12). A alta avaliação média (4,59)  sugere que os produtos são de alta qualidade.

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

Nesta análise, explorei a relação entre o custo de frete, faixa de preço dos produtos e o volume de vendas, buscando entender como cada parâmetro impacta o comportamento de compra dos consumidores. 

Para definir as faixas de valores de frete e produtos, considerei:

Para frete - Duas categorias de valores de frete - Low (baixo), High (alto), sendo o primeiro todos os valores na média e abaixo dela e "High" os valores acima da média. 

Para os produtos - Como o produto de maior valor é custa R$6.735 e a média de valores dos produtos é de R$120, considerei produtos de valor baixo igual ou abaixo de R$100, médio entre R$100 e R$500 e alto a partir de R$500.

![volume de vendas vs custo do frete](https://github.com/user-attachments/assets/b41b5375-b008-4cc4-84cc-effa2b387fb3)

Analisando os resultados, podemos tirar algumas conclusões:

**Produtos de Faixa de Preço Alta**

**Frete Alto:** Essa categoria tem as maiores vendas totais ($2.547.174,58), com um preço médio por produto elevado ($973,32). Isso sugere que, embora o custo de frete seja alto, os consumidores que compram produtos caros estão dispostos a pagar mais pelo frete. Além disso, o valor médio de vendas por produto é muito alto ($1.939,97), indicando que produtos premium continuam vendendo bem, mesmo com custos de frete elevados.

**Frete Baixo:** As vendas totais nessa categoria são consideravelmente menores ($441.504,74), com um preço médio por produto ainda alto ($726,16). Isso pode ser justificado pela menor quantidade disponível de produtos da categoria de preço alto com frete baixo em relação aos produtos de preço alto e frete alto (conforme tabela abaixo)

![Capturar](https://github.com/user-attachments/assets/a9ec77c9-5109-4005-8a3a-c41f0a7513b5)


**Produtos de Faixa de Preço Baixa:**

**Frete Alto:** Um número elevado de produtos vendidos (5.471), mas um total de vendas relativamente baixo (R$749.466,08). O preço médio por produto é muito baixo (R$62,13), sugerindo que produtos baratos ainda são comprados, mas o frete alto pode estar limitando o volume total de vendas.

**Frete Baixo:** Esta categoria apresenta o maior volume de vendas totais (R$2.991.538,41) e o maior número de produtos vendidos (17.818), apesar do preço médio por produto ser baixo ($49,25). Isso indica que, para produtos baratos, um frete baixo é um ponto crítico para aumentar o volume de vendas.

**Produtos de Faixa de Preço Média:**

**Frete Alto:** Apesar do frete elevado, essa categoria tem vendas totais significativas (R$3.339.606,09) e um preço médio por produto de R$198,87. O número de produtos vendidos (6.512) é relativamente alto, o que sugere que os consumidores aceitam um frete mais caro para produtos que não são nem tão caros nem tão baratos.

**Frete Baixo:** Aqui, as vendas totais são as mais altas ($3.577.665,38), com um preço médio por produto de R$174,99, reforçando ainda mais a ideia de que o frete baixo é um fator importante para maximizar as vendas, mesmo para produtos de preço médio.

**Potenciais Implicações:**

**Estratégia de Preço e Frete:** Os dados sugerem que, para produtos de maior valor agregado, um custo de frete mais elevado pode ser justificado, pois o valor médio de venda por unidade permanece significativamente alto. Nesse contexto, é importante reavaliar a viabilidade de oferecer fretes com valores baixos para esses produtos, considerando que isso pode aumentar os custos operacionais da empresa. A análise também indica que os consumidores tendem a ser menos sensíveis ao preço do frete quando se trata de itens de maior valor, o que permite à empresa explorar estratégias de frete mais flexíveis e potencialmente mais lucrativas.

**Volume vs. Valor:** Produtos com frete baixo são mais acessíveis em termos de volume de vendas, mas os produtos com frete alto oferecem maior valor por unidade vendida. Dependendo do objetivo da empresa (aumentar o volume de vendas ou maximizar a receita por produto), diferentes estratégias de precificação e frete podem ser aplicadas.


# Como a satisfação do cliente influencia o desempenho de vendas e o engajamento em diferentes categorias de produtos?

Análise com base na satisfação dos clientes, considerando as vendas totais, a quantidade total de produtos, a média de vendas por produto e o número total de avaliações:

![reviews](https://github.com/user-attachments/assets/9dfe3f3e-aefe-4a8b-bed3-5c74165eed14)


**Insights:**

- Engajamento e Satisfação: Há uma clara correlação entre a satisfação do cliente e o número de avaliações, com as categorias de alta satisfação gerando mais engajamento.
- Média de Vendas por Produto: Curiosamente, a média de vendas por produto é alta tanto em categorias de alta quanto de baixa satisfação, sugerindo que outros fatores além da satisfação também influenciam nas vendas.
- Potencial de Melhoria: As categorias de satisfação média e baixa podem se beneficiar de estratégias para melhorar a satisfação do cliente, o que pode, por sua vez, aumentar as vendas e o engajamento.

# Análise Preditiva de Churn 

Esta análise preditiva tem como objetivo segmentar os clientes com base no tempo decorrido desde sua última compra, identificando o risco de churn de acordo com o comportamento de compra e procurando identificar alguns padrões para tais comportamentos (nota da avaliação, possíveis atrasos,  Para isso, utilizei a data 17/10/2018 como ponto de referência para comparação e classificação dos clientes nos seguintes grupos:

**High Risk (Alto Risco) - Clientes que estão há mais de 90 dias sem realizar uma compra:** Representndo o maior grupo, clientes em alto risco de churn experimentaram tempos de entrega significativamente mais longos e mais entregas atrasadas, resultando na menor pontuação média de avaliação. Esses fatores negativos podem estar contribuindo para a maior probabilidade de esses clientes deixarem de comprar novamente.

**Medium Risk (Risco Médio) - Clientes que estão entre 60 e 90 dias sem comprar:** Clientes de risco médio têm tempos de entrega e taxas de atraso menores do que os clientes de alto risco, mas ainda assim sofrem de desafios suficientes para colocar sua retenção em risco. Embora estejam mais satisfeitos do que os clientes de alto risco, há espaço para melhorias, especialmente no tempo de entrega, para evitar o churn.

**Low Risk (Baixo Risco) - Clientes que compraram nos últimos 60 dias:** Clientes de baixo risco sofreram menos com o tempo de entrega, sendo poucas atrasadas, e as melhores avaliações. Esses fatores contribuem para a alta satisfação e baixa probabilidade de churn. Esse grupo representa o perfil ideal que a empresa deve se esforçar para replicar em outras faixas de risco.
  
![churn](https://github.com/user-attachments/assets/fbce5618-1c8d-494e-8cfd-05e177c4ccc6)

A análise de churn revelou uma preocupante concentração de clientes em alto risco de cancelamento, com mais de 90% dos clientes classificados nesta categoria.

Isso sublinha a urgência de implementar estratégias de retenção focadas em reengajar esses clientes, enquanto se reforçam práticas de fidelização para manter os clientes de baixo risco engajados. O sucesso dessas intervenções poderá não apenas reduzir a taxa de churn, mas também revitalizar o crescimento e a sustentabilidade do negócio a longo prazo.













