#!/bin/bash -l
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -n 4
#SBATCH -t 06:00:00
#SBATCH -J merge_eggnog
#SBATCH -o 20YYMMDD_merge_eggnog.log
#SBATCH --mail-type=END

### Merge eggnog gff with braker output,
### then use the resulting gffs to merge with Interproscan+BLAST (first just Diamond, then add mmseq2_HS annotation)

# Load environment (AGAT v 1.5.1)
mamba activate agat

WDIR=/path/to/functional

agat_sp_merge_annotations.pl --gff ${WDIR}/04.final_annotation/braker_interpro_blast_ID/braker.gff \
	--gff ${WDIR}/03.eggnog/02.diamond/A_najas_eggnog_diamond.emapper.decorated.gff \
       	--out ${WDIR}/04.final_annotation/interpro_blast_diamond/interpro_blast_diamond.gff

agat_sp_merge_annotations.pl --gff ${WDIR}/04.final_annotation/interpro_blast_diamond/interpro_blast_diamond.gff \
        --gff ${WDIR}/03.eggnog/01.mm_HS/A_najas_eggnog.emapper.decorated.gff \
        --out ${WDIR}/04.final_annotation/interpro_blast_diamond_mmseqs/interpro_blast_diamond_mmseqs.gff
