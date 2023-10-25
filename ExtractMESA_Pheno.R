library(data.table)
library(tidyverse)
library(R.utils)
library(janitor)
library(tibble)
library(purrr)

setwd("/rsrch3/scratch/biostatistics/zxu7/Rotation/PW/MESA/")
setwd("S:/Rotation/PW/MESA/")


# ---- Read in sample and subject ID
subjectMULTI <- fread("MESAc1/phs000209.v13.pht001108.v4.p3.MESA_Subject.MULTI.txt.gz", header=F) %>% 
  slice(-1) %>% 
  row_to_names(row_number = 1) %>% 
  mutate(dbGaP_Subject_ID = as.character(dbGaP_Subject_ID),
         SUBJECT_ID = as.character(SUBJID),
         SUBJID = as.numeric(SUBJID)) %>% 
  select(dbGaP_Subject_ID, SUBJECT_ID, SUBJID)

sampleMULTI <- fread("TOPMedMESAc1/phs001416.v3.pht009014.v2.p1.TOPMed_MESA_Sample.MULTI.txt.gz", header=F) %>% 
  slice(-1) %>% 
  row_to_names(row_number = 1)

DNAmethy_c1 <- fread("TOPMedMESAc1/phs001416.v3.pht010510.v1.p1.c1.TOPMed_MESA_Methylomics_Sample_Attributes.HMB.txt.gz", header=F) %>% 
  slice(-1) %>% 
  row_to_names(row_number = 1)

RNAseq_c1 <- fread("TOPMedMESAc1/phs001416.v3.pht010512.v1.p1.c1.TOPMed_MESA_RNA_Seq_Expression_Sample_Attributes.HMB.txt.gz", header=F) %>% 
  slice(-1) %>% 
  row_to_names(row_number = 1)

DNAmethy_c2 <- fread("TOPMedMESAc2/phs001416.v3.pht010510.v1.p1.c2.TOPMed_MESA_Methylomics_Sample_Attributes.HMB-NPU.txt.gz", header=F) %>% 
  slice(-1) %>% 
  row_to_names(row_number = 1)

RNAseq_c2 <- fread("TOPMedMESAc2/phs001416.v3.pht010512.v1.p1.c2.TOPMed_MESA_RNA_Seq_Expression_Sample_Attributes.HMB-NPU.txt.gz", header=F) %>% 
  slice(-1) %>% 
  row_to_names(row_number = 1)

DNAmethy <- DNAmethy_c1 %>% bind_rows(DNAmethy_c2)
RNAseq <- RNAseq_c1 %>% bind_rows(RNAseq_c2)
rm(DNAmethy_c1, DNAmethy_c2, RNAseq_c1, RNAseq_c2)

# ---- Read in Pheno
Exam5_c1 <- fread("./MESAc1/phs000209.v13.pht003091.v3.p3.c1.MESA_Exam5Main.HMB.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c1", exam = 5)

Exam5_c2 <- fread("./MESAc2/phs000209.v13.pht003091.v3.p3.c2.MESA_Exam5Main.HMB-NPU.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c2", exam = 5) %>% 
  mutate(mcf45 = as.character(mcf45))
Exam5 <- bind_rows(Exam5_c1, Exam5_c2)
rm(Exam5_c1, Exam5_c2)

T2Dia_c1 <- fread("./MESAc1/phs000209.v13.pht003659.v1.p3.c1.MESA_TimeToDiabetes.HMB.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID)
T2Dia_c2 <- fread("./MESAc2/phs000209.v13.pht003659.v1.p3.c2.MESA_TimeToDiabetes.HMB-NPU.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID)
T2Dia <- bind_rows(T2Dia_c1, T2Dia_c2)
rm(T2Dia_c1, T2Dia_c2)

# ---- Get statistics
T2Dia_Sta <- T2Dia %>% 
  inner_join(subjectMULTI, by = c("sidno"="SUBJID")) %>% 
  select(-c("dbGaP_Subject_ID", "SUBJECT_ID")) %>% 
  inner_join(Exam5, by = "sidno") %>% 
  inner_join(DNAmethy %>% mutate(SUBJECT_ID = as.numeric(SUBJECT_ID)) %>% filter(COLLECTION_VISIT == "5"),
             by = c("sidno"="SUBJECT_ID")) %>%
  inner_join(RNAseq %>% mutate(SUBJECT_ID = as.numeric(SUBJECT_ID))%>% filter(COLLECTION_VISIT == "5" & HISTOLOGICAL_TYPE == "PBMC"),
             by = c("sidno"="SUBJECT_ID")) %>%
  distinct(sidno, .keep_all = TRUE)

table(T2Dia_Sta$dmittp, useNA = "always")

# ---- 
CHD_c1 <- fread("./MESAc1/phs000209.v13.pht001123.v7.p3.c1.MESA_ThruYear2011Events.HMB.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID)
CHD_c2 <- fread("./MESAc2/phs000209.v13.pht001123.v7.p3.c2.MESA_ThruYear2011Events.HMB-NPU.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID)
CHD <- bind_rows(CHD_c1, CHD_c2)
rm(CHD_c1, CHD_c2)

# ---- Get statistics
CHD_Sta <- CHD %>% 
  inner_join(subjectMULTI, by = c("sidno"="SUBJID")) %>% 
  select(-c("dbGaP_Subject_ID", "SUBJECT_ID")) %>% 
  inner_join(Exam5, by = "sidno") %>% 
  # inner_join(DNAmethy %>% mutate(SUBJECT_ID = as.numeric(SUBJECT_ID)) %>% filter(COLLECTION_VISIT == "5"),
  #            by = c("sidno"="SUBJECT_ID")) %>%
  # inner_join(RNAseq %>% mutate(SUBJECT_ID = as.numeric(SUBJECT_ID))%>% filter(COLLECTION_VISIT == "5" & HISTOLOGICAL_TYPE == "PBMC"),
  #            by = c("sidno"="SUBJECT_ID")) %>%
  distinct(sidno, .keep_all = TRUE)

table(CHD_Sta$strktype, useNA = "always")

# ---- Race breakdown for DNA and RNA
DNABreak <- DNAmethy %>% mutate(SUBJECT_ID = as.numeric(SUBJECT_ID)) %>% 
  filter(COLLECTION_VISIT == "1") %>% 
  inner_join(Exam5, by = c("SUBJECT_ID"="sidno")) %>%
  distinct(SUBJECT_ID, .keep_all = TRUE)
table(DNABreak$gender1, useNA = "always")
table(Exam5$gender1, useNA = "always")
RNABreak <- RNAseq %>% mutate(SUBJECT_ID = as.numeric(SUBJECT_ID)) %>% 
  filter(COLLECTION_VISIT == "1" & HISTOLOGICAL_TYPE == "PBMC") %>% 
  inner_join(Exam5, by = c("SUBJECT_ID"="sidno")) %>%
  distinct(SUBJECT_ID, .keep_all = TRUE)
table(RNABreak$gender1, useNA = "always")

DNARNABreak <- RNAseq %>% mutate(SUBJECT_ID = as.numeric(SUBJECT_ID)) %>% 
  filter(COLLECTION_VISIT == "1" & HISTOLOGICAL_TYPE == "PBMC") %>% 
  inner_join(Exam5, by = c("SUBJECT_ID"="sidno")) %>% 
  inner_join(DNABreak, by = "SUBJECT_ID") %>% 
  distinct(SUBJECT_ID, .keep_all = TRUE)
table(DNARNABreak$gender1.x, useNA = "always")

# ------ Read Pheno
setwd("/rsrch3/scratch/biostatistics/zxu7/Rotation/PW/MESA/")
# 
Exam1_c1 <- fread("./MESAc1/phs000209.v13.pht001116.v10.p3.c1.MESA_Exam1Main.HMB.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c1", exam = 1)

Exam1_c2 <- fread("./MESAc2/phs000209.v13.pht001116.v10.p3.c2.MESA_Exam1Main.HMB-NPU.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c2", exam = 1)

Exam2_c1 <- fread("./MESAc1/phs000209.v13.pht001118.v8.p3.c1.MESA_Exam2Main.HMB.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c1", exam = 2)

Exam2_c2 <- fread("./MESAc2/phs000209.v13.pht001118.v8.p3.c2.MESA_Exam2Main.HMB-NPU.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c2", exam = 2)

Exam3_c1 <- fread("./MESAc1/phs000209.v13.pht001119.v8.p3.c1.MESA_Exam3Main.HMB.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c1", exam = 3)

Exam3_c2 <- fread("./MESAc2/phs000209.v13.pht001119.v8.p3.c2.MESA_Exam3Main.HMB-NPU.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c2", exam = 3)

Exam4_c1 <- fread("./MESAc1/phs000209.v13.pht001120.v10.p3.c1.MESA_Exam4Main.HMB.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c1", exam = 4)

Exam4_c2 <- fread("./MESAc2/phs000209.v13.pht001120.v10.p3.c2.MESA_Exam4Main.HMB-NPU.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c2", exam = 4)

Exam5_c1 <- fread("./MESAc1/phs000209.v13.pht003091.v3.p3.c1.MESA_Exam5Main.HMB.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c1", exam = 5)

Exam5_c2 <- fread("./MESAc2/phs000209.v13.pht003091.v3.p3.c2.MESA_Exam5Main.HMB-NPU.txt.gz",
                  skip = "dbGaP_Subject_ID") %>% select(-dbGaP_Subject_ID) %>% mutate(Arm = "c2", exam = 5) %>% 
  mutate(mcf45 = as.character(mcf45))


Exam1 <- bind_rows(Exam1_c1, Exam1_c2)
Exam2 <- bind_rows(Exam2_c1, Exam2_c2)
Exam3 <- bind_rows(Exam3_c1, Exam3_c2)
Exam4 <- bind_rows(Exam4_c1, Exam4_c2)
Exam5 <- bind_rows(Exam5_c1, Exam5_c2)

# ------ Exact Pheno
MESA_pheno <- Exam1 %>% 
  select(sidno, age1c, race1c, gender1, bmi1c, trig1, ldl1, hdl1, chol1, htnmed1c, 	cursmk1, curalc1, sbp1c, dbp1c) %>% 
  left_join(Exam2 %>% select(sidno, age2c, bmi2c, trig2, ldl2, hdl2, chol2, htnmed2c, cursmk2, curalc2, sbp2c, dbp2c), by = c("sidno"="sidno")) %>% 
  left_join(Exam3 %>% select(sidno, age3c, bmi3c, trig3, ldl3, hdl3, chol3, htnmed3c, cursmk3, curalc3, sbp3c, dbp3c), by = c("sidno"="sidno")) %>% 
  left_join(Exam4 %>% select(sidno, age4c, bmi4c, trig4, ldl4, hdl4, chol4, htnmed4c, cursmk4, curalc4, sbp4c, dbp4c), by = c("sidno"="sidno")) %>% 
  left_join(Exam5 %>% select(sidno, age5c, bmi5c, trig5, ldl5, hdl5, chol5, htnmed5c, cursmk5, curalc5, sbp5c, dbp5c), by = c("sidno"="sidno")) %>% 
  mutate(sbp1c_adj = case_when(htnmed1c == 1 ~ sbp1c + 15,
                               htnmed1c == 0 ~ sbp1c,
                               TRUE ~ as.numeric(NA)),
         dbp1c_adj = case_when(htnmed1c == 1 ~ dbp1c + 15,
                               htnmed1c == 0 ~ dbp1c,
                               TRUE ~ as.numeric(NA)),
         sbp2c_adj = case_when(htnmed2c == 1 ~ sbp2c + 15,
                               htnmed2c == 0 ~ sbp2c,
                               TRUE ~ as.numeric(NA)),
         dbp2c_adj = case_when(htnmed2c == 1 ~ dbp2c + 15,
                               htnmed2c == 0 ~ dbp2c,
                               TRUE ~ as.numeric(NA)),
         sbp3c_adj = case_when(htnmed3c == 1 ~ sbp3c + 15,
                               htnmed3c == 0 ~ sbp3c,
                               TRUE ~ as.numeric(NA)),
         dbp3c_adj = case_when(htnmed3c == 1 ~ dbp3c + 15,
                               htnmed3c == 0 ~ dbp3c,
                               TRUE ~ as.numeric(NA)),
         sbp4c_adj = case_when(htnmed4c == 1 ~ sbp4c + 15,
                               htnmed4c == 0 ~ sbp4c,
                               TRUE ~ as.numeric(NA)),
         dbp4c_adj = case_when(htnmed4c == 1 ~ dbp4c + 15,
                               htnmed4c == 0 ~ dbp4c,
                               TRUE ~ as.numeric(NA)),
         sbp5c_adj = case_when(htnmed5c == 1 ~ sbp5c + 15,
                               htnmed5c == 0 ~ sbp5c,
                               TRUE ~ as.numeric(NA)),
         dbp5c_adj = case_when(htnmed5c == 1 ~ dbp5c + 15,
                               htnmed5c == 0 ~ dbp5c,
                               TRUE ~ as.numeric(NA)))


tem <- MESA_pheno %>% 
  select(1:27) %>%  # Med
  filter(complete.cases(.))
# Summarise all statistics
tem_1 <- MESA_pheno %>% summarise_at(vars(age1c, bmi1c, trig1, ldl1, hdl1, chol1, sbp1c, dbp1c, sbp1c_adj, dbp1c_adj,
                                          age2c, bmi2c, trig2, ldl2, hdl2, chol2, sbp2c, dbp2c, sbp2c_adj, dbp2c_adj,
                                          age3c, bmi3c, trig3, ldl3, hdl3, chol3, sbp3c, dbp3c, sbp3c_adj, dbp3c_adj,
                                          age4c, bmi4c, trig4, ldl4, hdl4, chol4, sbp4c, dbp4c, sbp4c_adj, dbp4c_adj,
                                          age5c, bmi5c, trig5, ldl5, hdl5, chol5, sbp5c, dbp5c, sbp5c_adj, dbp5c_adj,), 
                              list(~ sum(!is.na(.)),
                                   ~ sum(is.na(.)),
                                   mean = mean,
                                   sd = sd,
                                   min = min, 
                                   ~ quantile(., 0.25, na.rm = T),
                                   median = median,
                                   ~ quantile(., 0.75, na.rm = T),
                                   max = max),
                              na.rm = T) %>% 
  pivot_longer(everything()) %>%   # Reshape it to long format
  separate(name, into = c("Variable", "Sta"), sep = "_(?=[^_]+$)") %>% 
  pivot_wider(names_from = Sta, values_from = value) %>% # Reshape it to wide format
  mutate_at(vars(min:sd), function(x) round(x, 4)) %>%
  rename(N = sum..1,
         missing = sum..2,
         q1 = quantile..6,
         q3 = quantile..8)

write_excel_csv(tem_1, file = "/rsrch3/scratch/biostatistics/zxu7/Rotation/PW/MESA/tem.csv")

table(MESA_pheno$race1c, useNA = "always")
table(MESA_pheno$gender1, useNA = "always")

# ------ Match Pheno and Geno
RNAsampleAttri_c1 <- fread("./TOPMedMESAc1/phs001416.v3.pht010512.v1.p1.c1.TOPMed_MESA_RNA_Seq_Expression_Sample_Attributes.HMB.txt.gz", header = F) %>% 
  slice(-1) %>% 
  row_to_names(row_number = 1) 

RNAsampleAttri_c2 <- fread("./TOPMedMESAc2/phs001416.v3.pht010512.v1.p1.c2.TOPMed_MESA_RNA_Seq_Expression_Sample_Attributes.HMB-NPU.txt.gz", header = F) %>% 
  slice(-1) %>% 
  row_to_names(row_number = 1) 

RNAsampleAttri <- RNAsampleAttri_c1 %>% bind_rows(RNAsampleAttri_c2)
rm(RNAsampleAttri_c1, RNAsampleAttri_c2)

RNAsampleAttri_Exam5 <- RNAsampleAttri %>% 
  mutate(COLLECTION_VISIT = as.numeric(COLLECTION_VISIT)) %>% 
  filter(COLLECTION_VISIT == 5 & HISTOLOGICAL_TYPE == "PBMC")
RNAseq_EXAM5 <- RNAseq_combine %>% 
  filter(SAMPLE_ID %in% RNAsampleAttri_Exam5$SAMPLE_ID) %>% 
  distinct(SUBJECT_ID, .keep_all = T)

RNAsampleAttri_Exam1 <- RNAsampleAttri %>% 
  mutate(COLLECTION_VISIT = as.numeric(COLLECTION_VISIT)) %>% 
  filter(COLLECTION_VISIT == 1 & HISTOLOGICAL_TYPE == "PBMC")

RNAseq_EXAM1 <- RNAseq_combine %>% 
  filter(SAMPLE_ID %in% RNAsampleAttri_Exam1$SAMPLE_ID) %>% 
  distinct(SUBJECT_ID, .keep_all = T)

# Verify there is no duplicates
RNAseq_EXAM5 %>% 
  group_by(SUBJECT_ID) %>% 
  filter(n()>1)

RNAseq_EXAM1 %>% 
  group_by(SUBJECT_ID) %>% 
  filter(n()>1)

# RNAsampleAttri %>% filter(SAMPLE_ID %in% c("TOR241007", "TOR379757", "TOR461526", "TOR882863", "TOR811735", "TOR128978", "TOR238339") )


Pheno_RNA_EXAM5 <- MESA_pheno %>%
  mutate(sidno = as.character(sidno)) %>% 
  right_join(RNAseq_EXAM5 %>% filter(complete.cases(.)), 
             by = c("sidno"="SUBJECT_ID"))

Pheno_RNA_EXAM1 <- MESA_pheno %>%
  mutate(sidno = as.character(sidno)) %>% 
  right_join(RNAseq_EXAM1 %>% filter(complete.cases(.)), 
             by = c("sidno"="SUBJECT_ID"))

# Break Down by Race
Pheno_RNA_EXAM1 %>% group_by(race1c) %>% summarise(n=n())
Pheno_RNA_EXAM5 %>% group_by(race1c) %>% summarise(n=n())

save(Pheno_RNA_EXAM1, Pheno_RNA_EXAM5,
     file="/rsrch3/scratch/biostatistics/zxu7/Rotation/PW/MESA/PhenoRNA_052123.RData")

# Pheno_RNA_EXAM5 %>% select(starts_with("ENSG")) %>% ncol()




