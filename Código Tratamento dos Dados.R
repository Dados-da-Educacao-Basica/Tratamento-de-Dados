if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, vroom)

# Script de ajuste e tratamento do banco de dados ----
#Carregando dados
NO <- vroom("dados/docentes_norte1.csv")[-1]
CO <- vroom("dados/docentes_co1.csv")[-1]
NE <- vroom("dados/docentes_nordeste1.csv")[-1]
SE <- vroom("dados/docentes_sudeste1.csv")[-1]
SU <- vroom("dados/docentes_sul1.csv")[-1]

#Transformando em fator para poder juntar os bancos
NO$CO_CURSO_3 <- factor(NO$CO_CURSO_3)
NE$CO_CURSO_3 <- factor(NE$CO_CURSO_3)
SE$CO_CURSO_3 <- factor(SE$CO_CURSO_3)
CO$CO_CURSO_3 <- factor(CO$CO_CURSO_3)
SU$CO_CURSO_3 <- factor(SU$CO_CURSO_3)

#Juntando as planilhas em um banco
df <- full_join(CO,NE) %>%
  full_join(.,NO) %>%
  full_join(.,SE) %>%
  full_join(.,SU)

rm(CO,NE,NO,SE,SU)

# Eliminando as linhas totalmente duplicadas
df <- unique(df)

# Retirando colunas desnecessárias
df <- df %>%
  select(-ENSINO_MEDIO,-IN_LICENCIATURA)

# ---------------------- Banco com duplicidades em Estados ------------------ #

dados2 <- df %>% 
  distinct(ID_DOCENTE,CO_UF, .keep_all = TRUE)
banco2 <- dados2[1:16]

# ---------------------- Banco sem duplicidades em Estados ------------------ #

banco <- banco2 %>% 
  distinct(ID_DOCENTE, .keep_all = TRUE)