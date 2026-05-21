#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -n 1
#SBATCH -t 1:30:00
#SBATCH -J annot_stats
#SBATCH -o 20251216_AGAT_stats.log
#SBATCH --mail-type=END

mamba activate agat

WDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/05.eval/01.stats

#InterProScan
agat_sp_statistics.pl -gff ${WDIR}/01.interpro/01.output/braker_interpro/braker.gff -o $OUTDIR/interpro_stats.txt
#InterProScan+BLAST
agat_sp_statistics.pl -gff ${WDIR}/02.BLAST/braker_interpro_blast/braker.gff -o $OUTDIR/interpro_blast_stats.txt
#mmseqs2 high-sensitivity
agat_sp_statistics.pl -gff ${WDIR}/03.eggnog/01.mm_HS/A_najas_eggnog.emapper.decorated.gff -o $OUTDIR/mmseqs2_HS_stats.txt
#mmseqs2 defaults
agat_sp_statistics.pl -gff ${WDIR}/03.eggnog/02.mm_def/A_najas_eggnog_mm_def.emapper.decorated.gff -o $OUTDIR/mmseqs2_def_stats.txt
#diamond
agat_sp_statistics.pl -gff ${WDIR}/03.eggnog/03.diamond/A_najas_eggnog_diamond.emapper.decorated.gff -o $OUTDIR/diamond_stats.txt
#InterProScan+BLAST+Diamond
agat_sp_statistics.pl -gff ${WDIR}/04.final_annotations/02_interpro_blast_diamond/interpro_blast_diamond.gff \
       -o $OUTDIR/interpro_blast_diamond_stats.txt
#InterProScan+BLAST+Diamond+mmseqs2(HS)
agat_sp_statistics.pl -gff ${WDIR}/04.final_annotations/03_interpro_blast_diamond_mmseqs/interpro_blast_diamond_mmseqs.gff \
       -o $OUTDIR/interpro_blast_diamond_mmseqs_stats.txt
#InterProScan+BLAST+Diamond+mmseqs2(def)
agat_sp_statistics.pl -gff ${WDIR}/04.final_annotations/04_interpro_blast_diamond_mmseqsdef/interpro_blast_diamond_mmseqsdef.gff \
       -o $OUTDIR/interpro_blast_diamond_mmseqsdef_stats.txt
