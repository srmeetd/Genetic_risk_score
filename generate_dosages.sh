#!/bin/bash
## export environment variables (PBS -V)
#SBATCH --time=48:0:0 # set walltime (PBS -l walltime)
#SBATCH -p mrcq # queue (PBS -q)
#SBATCH -A Research_Project-MRC158833 # research project to run under
#SBATCH --nodes=2
#SBATCH --mem=20G
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=weightsgen
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --array=1-22 # ARRAY VARIABLE: $SLURM_ARRAY_TASK_ID
##SBATCH --output=%x.%A-%a.out # FOR ARRAY JOBS
##SBATCH --error=%x.%A-%a.err # FOR ARRAY JOBS


module purge
module load Boost/1.71.0-gompi-2019b

chr=$SLURM_ARRAY_TASK_ID 
/gpfs/mrc0/projects/Research_Project-MRC158833/programs/index_bgen/index_bgen -bgen /gpfs/mrc0/projects/Research_Project-MRC158833/sd718/AllcohortModymichigan/chr${chr}.bgen -sample /gpfs/mrc0/projects/Research_Project-MRC158833/sd718/AllcohortModymichigan/sample_info -index-file  /gpfs/mrc0/projects/Research_Project-MRC158833/sd718/AllcohortModymichigan/chr${chr}.bgen.index -snps snplist_michig37 -out All_chr${chr}.dosages -chr ${chr} 
