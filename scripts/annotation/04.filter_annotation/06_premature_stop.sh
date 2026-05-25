#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J premStop
#SBATCH -o 20YYMMDD_premStop.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/path/to/interpro_blast_diamond_mmseqs.gff
GENOME=/path/to/masked_genome.fa
OUTDIR=/path/to/06.premature_stop

agat_sp_flag_premature_stop_codons.pl -gff $GFF -f $GENOME --ct 1 -o ${OUTDIR}/A_najas_premStop.gff
