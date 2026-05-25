#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -n 1
#SBATCH -t 1:30:00
#SBATCH -J annot_stats
#SBATCH -o 20YYMMDD_AGAT_stats.log
#SBATCH --mail-type=END

mamba activate agat

WDIR=/path/to/functional
OUTDIR=/path/to/functional/05.eval/01.stats

#InterProScan
agat_sp_statistics.pl -gff ${WDIR}/01.interpro/braker_interpro/braker.gff -o $OUTDIR/interpro_stats.txt
#InterProScan+BLAST
agat_sp_statistics.pl -gff ${WDIR}/02.BLAST/braker_interpro_blast/braker.gff -o $OUTDIR/interpro_blast_stats.txt
#mmseqs2 high-sensitivity
agat_sp_statistics.pl -gff ${WDIR}/03.eggnog/01.mm_HS/A_najas_eggnog.emapper.decorated.gff -o $OUTDIR/mmseqs2_HS_stats.txt
#diamond
agat_sp_statistics.pl -gff ${WDIR}/03.eggnog/02.diamond/A_najas_eggnog_diamond.emapper.decorated.gff -o $OUTDIR/diamond_stats.txt
#InterProScan+BLAST+Diamond
agat_sp_statistics.pl -gff ${WDIR}/04.final_annotation/interpro_blast_diamond/interpro_blast_diamond.gff \
       -o $OUTDIR/interpro_blast_diamond_stats.txt
#InterProScan+BLAST+Diamond+mmseqs2(HS)
agat_sp_statistics.pl -gff ${WDIR}/04.final_annotation/interpro_blast_diamond_mmseqs/interpro_blast_diamond_mmseqs.gff \
       -o $OUTDIR/interpro_blast_diamond_mmseqs_stats.txt
