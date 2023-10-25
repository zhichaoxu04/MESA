# MESA: TopMed MESA cohort cleaning

## T2 Diabetes
Type 2 Diabetes is a chronic medical condition characterized by high blood sugar levels (hyperglycemia) resulting from the body's inability to properly use insulin or the insufficient production of insulin by the pancreas. Unlike Type 1 Diabetes, which is an autoimmune condition where the body doesn't produce any insulin, Type 2 Diabetes typically develops in adulthood and is often associated with lifestyle factors such as obesity, lack of physical activity, and poor dietary habits.
#### Study Report
[pht003659.v1](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/dataset.cgi?study_id=phs000209.v13.p3&pht=3659): (Data distribution set for Health/Medical/Biomedical (HMB) consent) MESA Time to Diabetes Dataset: This dataset contains phenotype variables for diabetes incidence and duration from baseline until the participant's Follow-Up Interview.

#### Files
- c1 Arm: phs000209.v13.pht003659.v1.p3.c1.MESA_TimeToDiabetes.HMB.txt.gz
- c2 Arm: phs000209.v13.pht003659.v1.p3.c2.MESA_TimeToDiabetes.HMB-NPU.txt.gz

#### Variables
- [dmittp](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/variable.cgi?study_id=phs000209.v13.p3&phv=197148&phd=1712&pha=&pht=3659&phvf=&phdf=&phaf=&phtf=&dssp=1&consent=&temp=1): INCIDENT TREATED DIABETES: Time Point Diagnosis Determined

| dmittp                | Raw    | DNA     | RNA | DNA+RNA |
| :------------------   | :---:  | :--:    | :--: | :--:   |
| Exam 2                |  123   |  14     |  15  |  10    |
| Exam 3                |  100   |  19     |  15  |  14    |
| Exam 4                |  121   |  21     |  23  |  17    |
| Exam 4.06: Follow up 6|   2    |   0     |   0  |   0    |
| Exam 4.07: Follow up 7|   2    |   0     |   0  |   0    |
| Exam 4.08: Follow up 8|   1    |   0     |   0  |   0    |
| Exam 4.09: Follow up 9|   5    |   1     |   2  |   1    |
| Exam 4.10: Follow up 10|  8    |   0     |   0  |   0    |
| Exam 5                |  222   |  45     |  40  |  32    |
| Exam 5.11: Follow up 11|  4    |   0     |   0  |   0    |
| Exam 5.12: Follow up 12|  7    |   0     |   0  |   0    |
| Not N/A Count         |  595   |  100    |  95  |  74    |
| N/A                   | 5834   |  877    | 841  | 658    |
| Total                 | 6429   |  977    | 936  | 732    |
> Raw represents the original data after being `dplyr::inner_joined` with the baseline demographic data. DNA represents the original data after being `dplyr::inner_joined` with the DNA data. RNA represents the original data after being `dplyr::inner_joined` with the RNA data. DNA+RNA represents the original data after being `dplyr::inner_joined` with both the DNA and RNA data.

## CHD
CHD stands for Coronary Heart Disease, which is also commonly known as coronary artery disease (CAD) or simply heart disease. CHD is a medical condition that primarily affects the blood vessels supplying the heart muscle (coronary arteries). It is characterized by the accumulation of plaque (atherosclerosis) within these arteries, which can narrow or block them over time.
#### Study Report
[MESA_ThruYear2011Events](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/dataset.cgi?study_id=phs000209.v13.p3&pht=1123): MESA Classic cardiovascular events through 2011. Also included are possible cardiovascular events abstracted from any hospital records via information about symptoms, history and biomarkers, scanned ECGs, echocardiograms, catheterization reports, outpatient records, and other relevant diagnostic and procedure reports. Cardiovascular events documented comprise myocardial infarctions, resuscitated cardiac arrests, angina, PTCA, CBG, CHF, PVD, stroke, TIA and fatal CHD.

#### Files
- c1 Arm: phs000209.v13.pht003659.v1.p3.c1.MESA_TimeToDiabetes.HMB.txt.gz
- c2 Arm: phs000209.v13.pht003659.v1.p3.c2.MESA_TimeToDiabetes.HMB-NPU.txt.gz

#### Variables
- [dmittp](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/variable.cgi?study_id=phs000209.v13.p3&phv=197148&phd=1712&pha=&pht=3659&phvf=&phdf=&phaf=&phtf=&dssp=1&consent=&temp=1): INCIDENT TREATED DIABETES: Time Point Diagnosis Determined



## DNA Methylomics
#### Study Report
[TOPMed_MESA_Methylomics_Sample_Attributes](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/dataset.cgi?study_id=phs001416.v3.p1&pht=10510): This sample attributes table for methylomics samples includes body site where sample was collected, analyte type, histological type, tumor status, sequencing center, funding source, TOPMed phase, project, and study name. This -omics dataset also includes subject ID, consent, subject status, age at collection, primary biosample ID and type, UBERON ID and term, collection year and visit, and analyte information (n=4 variables; sample ID, type of analyte isolated, year, and lab).

#### Files
- c1 Arm: phs001416.v3.pht010510.v1.p1.c1.TOPMed_MESA_Methylomics_Sample_Attributes.HMB.txt
- c2 Arm: phs001416.v3.pht010510.v1.p1.c2.TOPMed_MESA_Methylomics_Sample_Attributes.HMB-NPU.txt

## RNA seq
#### Study Report
[TOPMed_MESA_RNA_Seq_Expression_Sample_Attributes](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/dataset.cgi?study_id=phs001416.v3.p1&pht=10512): This sample attributes table for RNA-seq expression samples includes body site where sample was collected, analyte type, histological type, tumor status, sequencing center, funding source, TOPMed phase, project, and study name. This -omics dataset also includes subject ID, consent, subject status, age at collection, primary biosample ID and type, UBERON ID and term, collection year and visit, analyte information (n=5 variables; sample ID, type of analyte isolated, year, lab), sample container and well ID, assay lab, and sample use.

#### Files
- c1 Arm: phs001416.v3.pht010512.v1.p1.c1.TOPMed_MESA_RNA_Seq_Expression_Sample_Attributes.HMB.txt
- c2 Arm: phs001416.v3.pht010512.v1.p1.c2.TOPMed_MESA_RNA_Seq_Expression_Sample_Attributes.HMB-NPU.txt

## Exam 5
#### Study Report
[MESA Classic Exam 5 Main Dataset](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/dataset.cgi?study_id=phs000209.v13.p3&pht=3091): Variables included in the MESA Exam are those from standard questionnaires, clinical and laboratory measurements. The questionnaires include variables of demography, socioeconomic and psychosocial status, medical and family history, medication use, dietary and alcohol intakes, smoking, cognitive function, erectile disfunction, and physical activity. The clinical measurements include anthropometry, blood pressure, ankle/brachial blood pressure indices, ECG, MRI, coronary calcium determination, arterial wave forms, and corotid artery IMT. Laboratory measurements include various lipids, and urinary albumin and creatinine.

#### Variables
- sidno: SHARE ID NUMBER
- [race1c](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/variable.cgi?study_id=phs000209.v13.p3&phv=176008&phd=1712&pha=&pht=3091&phvf=&phdf=&phaf=&phtf=&dssp=1&consent=&temp=1): RACE / ETHNICITY
- [gender1](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/variable.cgi?study_id=phs000209.v13.p3&phv=176009&phd=1712&pha=&pht=3091&phvf=&phdf=&phaf=&phtf=&dssp=1&consent=&temp=1): GENDER
- [age5c](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/variable.cgi?study_id=phs000209.v13.p3&phv=176011&phd=1712&pha=&pht=3091&phvf=&phdf=&phaf=&phtf=&dssp=1&consent=&temp=1): AGE AT EXAM 5

#### Files
- c1 Arm: phs000209.v13.pht003091.v3.p3.c1.MESA_Exam5Main.HMB.txt.gz
- c2 Arm: phs000209.v13.pht003091.v3.p3.c2.MESA_Exam5Main.HMB-NPU.txt.gz























