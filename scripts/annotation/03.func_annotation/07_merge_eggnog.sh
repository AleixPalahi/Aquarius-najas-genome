#!/bin/bash -l
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -n 4
#SBATCH -t 06:00:00
#SBATCH -J merge_eggnog
#SBATCH -o 20251215_merge_eggnog.log
#SBATCH --mail-type=END

### Merge eggnog gff with braker output,
### then use the resulting gffs to merge with Interproscan+BLAST (first just Diamond, then add mmseq2_HS annotation)

# Load environment (AGAT v 1.5.1)
mamba activate agat

WDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional

agat_sp_merge_annotations.pl --gff ${WDIR}/04.final_annotations/01_braker_interpro_blast_ID/braker.gff \
	--gff ${WDIR}/03.eggnog/03.diamond/A_najas_eggnog_diamond.emapper.decorated.gff \
       	--out ${WDIR}/04.final_annotations/02_interpro_blast_diamond/interpro_blast_diamond.gff

agat_sp_merge_annotations.pl --gff ${WDIR}/04.final_annotations/02_interpro_blast_diamond/interpro_blast_diamond.gff \
        --gff ${WDIR}/03.eggnog/01.mm_HS/A_najas_eggnog.emapper.decorated.gff \
        --out ${WDIR}/04.final_annotations/03_interpro_blast_diamond_mmseqs/interpro_blast_diamond_mmseqs.gff

agat_sp_merge_annotations.pl --gff ${WDIR}/04.final_annotations/02_interpro_blast_diamond/interpro_blast_diamond.gff \
        --gff ${WDIR}/03.eggnog/02.mm_def/A_najas_eggnog_mm_def.emapper.decorated.gff \
        --out ${WDIR}/04.final_annotations/04_interpro_blast_diamond_mmseqsdef/interpro_blast_diamond_mmseqsdef.gff
