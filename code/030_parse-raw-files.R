library(tidyverse)
library(frsRisk)
library(janitor)
library(readxl)


risk_file <- "data/2022-07-15_smid-risk-summary.xlsx"
exp_file  <- "data/2022-07-15_security-exposures.xlsx"
char_file <- "data/2022-07-15_characteristics.xlsx"



# process risk data -------------------------------------------------------

risk_tbl <- frsRisk::parse_axioma_risk_summary(risk_file, sheet = 1, frsAttr::axioma_factor_levels_tbl)
risk_rds_file <- str_replace(risk_file, "xlsx", "rds")
saveRDS(risk_tbl, risk_rds_file)



# process exposure data ---------------------------------------------------

exp_tbl <- frsRisk::parse_axioma_security_exposures(exp_file, sheet = 1)
exp_tbl <- exp_tbl %>% rename(ticker = symbol)
exp_rds_file <- str_replace(exp_file, "xlsx", "rds")
saveRDS(exp_tbl, exp_rds_file)



# process characteristics data --------------------------------------------

char_tbl <- read_excel(char_file, skip = 3) %>% 
  clean_names() %>% 
  filter(!is.na(company_symbol))
char_rds_file <- str_replace(char_file, "xlsx", "rds")

saveRDS(char_tbl, char_rds_file)
