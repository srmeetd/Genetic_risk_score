# Genetic_risk_score
Script used to generate genetic risk score from bgen files



1. generate_dosages.sh - It will take input of your bgen files and sample names and generate the dosages output for each chromomose
	Note that you need to change the location of your bgen files and samples in the script.

2. weights.R - It requires input of your SNP file (assuming SNPs files has weight last column), script will output the file that can be used in next step

3. generategrs.sh - It will generate GRS for each chromosome
	Note need to change the input file names, if you modified output name from above script.

4. merge_allGRSfiles.R - Merge all GRS in one file  
