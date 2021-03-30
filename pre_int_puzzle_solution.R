# pre-int survey - ID puzzle

# 1 -- load libraries
library(tidyverse)

# 2 -- read in data
data <- read_csv("pre_int_puzzle2.csv")

# 3 -- Create Condition variable in the dataset using ID definition and then create a pair ID
cleaned_data <- data %>% 
        mutate(condition_digit = str_sub(as.character(ID), 1, 1), # Split out first digit of ID to build Condition variable
               New_Condition = ifelse(condition_digit < 3, "Trans", "Control"), # build condition dimension
               pair_id = str_sub(as.character(ID), 2, -1)) # build pair_id dimension to denote which Trans/Control pairs match

# 4 -- build table of pair_ids for trans participants who have completed question 1 to be used as filtering criterion for full dataset
filter_table <- cleaned_data %>% 
        filter(New_Condition == "Trans" & !is.na(Q1))

# 5 -- build final data set by filtering full dataset for only those pair_id #s that contained in the filter_table
final_dataset <- cleaned_data %>% 
        filter(pair_id %in% filter_table$pair_id)
