#!/bin/bash -l
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -n 1
#SBATCH -t 3:00:00
#SBATCH -J comp_annots
#SBATCH -o 20251216_comp_annots.log
#SBATCH --mail-type=END

mamba activate agat

WDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/05.eval/02.comps

#InterProScan(IPS) vs IPS+BLAST(IPSBL)
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/01.interpro/01.output/braker_interpro/braker.gff \
	-gff2 ${WDIR}/02.BLAST/braker_interpro_blast/braker.gff -o ${OUTDIR}/ips_vs_ips+BL
#Diamond(DIA) vs mmseqs2 high-sensitivity (mmHS)
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/03.eggnog/03.diamond/A_najas_eggnog_diamond.emapper.decorated.gff \
	-gff2 ${WDIR}/03.eggnog/01.mm_HS/A_najas_eggnog.emapper.decorated.gff -o ${OUTDIR}/DIA_vs_mmHS
#DIA vs mmseqs2 defaults (mmdef)
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/03.eggnog/03.diamond/A_najas_eggnog_diamond.emapper.decorated.gff \
	-gff2 ${WDIR}/03.eggnog/02.mm_def/A_najas_eggnog_mm_def.emapper.decorated.gff -o ${OUTDIR}/DIA_vs_mmdef
#mmHS vs mmdef
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/03.eggnog/01.mm_HS/A_najas_eggnog.emapper.decorated.gff \
	-gff2 ${WDIR}/03.eggnog/02.mm_def/A_najas_eggnog_mm_def.emapper.decorated.gff -o ${OUTDIR}/mmHS_vs_mmdef
#IPS+BL vs DIA
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/02.BLAST/braker_interpro_blast/braker.gff \
	-gff2 ${WDIR}/03.eggnog/03.diamond/A_najas_eggnog_diamond.emapper.decorated.gff -o ${OUTDIR}/ips+BL_vs_DIA
#IPS+BL vs mmHS
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/02.BLAST/braker_interpro_blast/braker.gff \
	-gff2 ${WDIR}/03.eggnog/01.mm_HS/A_najas_eggnog.emapper.decorated.gff -o ${OUTDIR}/ips+BL_vs_mmHS
#IPS+BL vs IPS+BL+DIA
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/02.BLAST/braker_interpro_blast/braker.gff \
	-gff2 ${WDIR}/04.final_annotations/02_interpro_blast_diamond/interpro_blast_diamond.gff \
	-o ${OUTDIR}/ips+BL_vs_ips+BL+DIA
#IPS+BL+DIA vs IPS+BL+DIA+mmHS
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/04.final_annotations/02_interpro_blast_diamond/interpro_blast_diamond.gff \
	-gff2 ${WDIR}/04.final_annotations/03_interpro_blast_diamond_mmseqs/interpro_blast_diamond_mmseqs.gff \
	-o ${OUTDIR}/ips+BL+DIA_vs_ips+BL+DIA+mmHS
#IPS+BL+DIA vs IPS+BL+DIA+mmdef
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/04.final_annotations/02_interpro_blast_diamond/interpro_blast_diamond.gff \
        -gff2 ${WDIR}/04.final_annotations/04_interpro_blast_diamond_mmseqsdef/interpro_blast_diamond_mmseqsdef.gff \
        -o ${OUTDIR}/ips+BL+DIA_vs_ips+BL+DIA+mmdef
#IPS+BL+DIA+mmHS vs IPS+BL+DIA+mmdef
agat_sp_compare_two_annotations.pl \
	-gff1 ${WDIR}/04.final_annotations/03_interpro_blast_diamond_mmseqs/interpro_blast_diamond_mmseqs.gff \
        -gff2 ${WDIR}/04.final_annotations/04_interpro_blast_diamond_mmseqsdef/interpro_blast_diamond_mmseqsdef.gff \
        -o ${OUTDIR}/ips+BL+DIA+mmHS_vs_ips+BL+DIA+mmdef
