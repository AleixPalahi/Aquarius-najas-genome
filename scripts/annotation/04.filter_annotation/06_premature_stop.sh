#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J premStop
#SBATCH -o 20260113_premStop.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/04.merged_annotations/04_interpro_blast_diamond_mmseqsHS_FINAL_MERGED/interpro_blast_diamond_mmseqs.gff
GENOME=/proj/snic2019-35-58/water_strider/ingo/data/raw_internal/01.ref/Anajas_masked_genome.fa
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered/06.premature_stop

agat_sp_flag_premature_stop_codons.pl -gff $GFF -f $GENOME --ct 1 -o ${OUTDIR}/A_najas_premStop.gff
