main(){
    PATH_FILE=$(pwd)
    PYTHON_PATH=python3.4
    STRAINS=Staphylococcus_aureus_HG003
    ANNOGESIC_PATH=/home/silas/ANNOgesic/ANNOgesic.py
    ANNOGESIC_FOLDER=ANNOgesic
    FTP_SOURCE=ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Staphylococcus_aureus_NCTC_8325_uid57795
    ID_MAPPING_SOURCE=ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/idmapping_selected.tab.gz
    PAGIT_HOME=/home/silas/ANNOgesic/tools/PAGIT
    tex_notex_libs="TSB_OD_0.2_TEX_div_by_3598556.0_multi_by_3382258.0_reverse.wig:tex:1:a:- \
                   TSB_OD_0.5_TEX_div_by_4420442.0_multi_by_3382258.0_reverse.wig:tex:2:a:- \
                   TSB_OD_1_TEX_div_by_3956047.0_multi_by_3382258.0_reverse.wig:tex:3:a:- \
                   TSB_ON_TEX_div_by_4836916.0_multi_by_3382258.0_reverse.wig:tex:4:a:- \
                   TSB_t0_TEX_div_by_4817602.0_multi_by_3382258.0_reverse.wig:tex:5:a:- \
                   TSB_t1_TEX_div_by_4957924.0_multi_by_3382258.0_reverse.wig:tex:6:a:- \
                   TSB_t2_TEX_div_by_5024086.0_multi_by_3382258.0_reverse.wig:tex:7:a:- \
                   pMEM_OD_0.2_TEX_div_by_4581966.0_multi_by_3382258.0_reverse.wig:tex:8:a:- \
                   pMEM_OD_0.5_TEX_div_by_4968210.0_multi_by_3382258.0_reverse.wig:tex:9:a:- \
                   pMEM_OD_1_TEX_div_by_4719860.0_multi_by_3382258.0_reverse.wig:tex:10:a:- \
                   pMEM_ON_TEX_div_by_5454872.0_multi_by_3382258.0_reverse.wig:tex:11:a:- \
                   pMEM_t0_TEX_div_by_4872810.0_multi_by_3382258.0_reverse.wig:tex:12:a:- \
                   pMEM_t1_TEX_div_by_4637206.0_multi_by_3382258.0_reverse.wig:tex:13:a:- \
                   pMEM_t2_TEX_div_by_4782742.0_multi_by_3382258.0_reverse.wig:tex:14:a:- \
                   TSB_OD_0.2_TEX_div_by_3598556.0_multi_by_3382258.0_forward.wig:tex:1:a:+ \
                   TSB_OD_0.5_TEX_div_by_4420442.0_multi_by_3382258.0_forward.wig:tex:2:a:+ \
                   TSB_OD_1_TEX_div_by_3956047.0_multi_by_3382258.0_forward.wig:tex:3:a:+ \
                   TSB_ON_TEX_div_by_4836916.0_multi_by_3382258.0_forward.wig:tex:4:a:+ \
                   TSB_t0_TEX_div_by_4817602.0_multi_by_3382258.0_forward.wig:tex:5:a:+ \
                   TSB_t1_TEX_div_by_4957924.0_multi_by_3382258.0_forward.wig:tex:6:a:+ \
                   TSB_t2_TEX_div_by_5024086.0_multi_by_3382258.0_forward.wig:tex:7:a:+ \
                   pMEM_OD_0.2_TEX_div_by_4581966.0_multi_by_3382258.0_forward.wig:tex:8:a:+ \
                   pMEM_OD_0.5_TEX_div_by_4968210.0_multi_by_3382258.0_forward.wig:tex:9:a:+ \
                   pMEM_OD_1_TEX_div_by_4719860.0_multi_by_3382258.0_forward.wig:tex:10:a:+ \
                   pMEM_ON_TEX_div_by_5454872.0_multi_by_3382258.0_forward.wig:tex:11:a:+ \
                   pMEM_t0_TEX_div_by_4872810.0_multi_by_3382258.0_forward.wig:tex:12:a:+ \
                   pMEM_t1_TEX_div_by_4637206.0_multi_by_3382258.0_forward.wig:tex:13:a:+ \
                   pMEM_t2_TEX_div_by_4782742.0_multi_by_3382258.0_forward.wig:tex:14:a:+ \
                   TSB_OD_0.2_div_by_5033297.0_multi_by_3382258.0_reverse.wig:notex:1:a:- \
                   TSB_OD_0.5_div_by_4665048.0_multi_by_3382258.0_reverse.wig:notex:2:a:- \
                   TSB_OD_1_div_by_4443620.0_multi_by_3382258.0_reverse.wig:notex:3:a:- \
                   TSB_ON_div_by_7674201.0_multi_by_3382258.0_reverse.wig:notex:4:a:- \
                   TSB_t0_div_by_4053535.0_multi_by_3382258.0_reverse.wig:notex:5:a:- \
                   TSB_t1_div_by_4448582.0_multi_by_3382258.0_reverse.wig:notex:6:a:- \
                   TSB_t2_div_by_6988975.0_multi_by_3382258.0_reverse.wig:notex:7:a:- \
                   pMEM_OD_0.2_div_by_4664201.0_multi_by_3382258.0_reverse.wig:notex:8:a:- \
                   pMEM_OD_0.5_div_by_5217691.0_multi_by_3382258.0_reverse.wig:notex:9:a:- \
                   pMEM_OD_1_div_by_4699153.0_multi_by_3382258.0_reverse.wig:notex:10:a:- \
                   pMEM_ON_div_by_3977549.0_multi_by_3382258.0_reverse.wig:notex:11:a:- \
                   pMEM_t0_div_by_3606941.0_multi_by_3382258.0_reverse.wig:notex:12:a:- \
                   pMEM_t1_div_by_3722754.0_multi_by_3382258.0_reverse.wig:notex:13:a:- \
                   pMEM_t2_div_by_3382258.0_multi_by_3382258.0_reverse.wig:notex:14:a:- \
                   TSB_OD_0.2_div_by_5033297.0_multi_by_3382258.0_forward.wig:notex:1:a:+ \
                   TSB_OD_0.5_div_by_4665048.0_multi_by_3382258.0_forward.wig:notex:2:a:+ \
                   TSB_OD_1_div_by_4443620.0_multi_by_3382258.0_forward.wig:notex:3:a:+ \
                   TSB_ON_div_by_7674201.0_multi_by_3382258.0_forward.wig:notex:4:a:+ \
                   TSB_t0_div_by_4053535.0_multi_by_3382258.0_forward.wig:notex:5:a:+ \
                   TSB_t1_div_by_4448582.0_multi_by_3382258.0_forward.wig:notex:6:a:+ \
                   TSB_t2_div_by_6988975.0_multi_by_3382258.0_forward.wig:notex:7:a:+ \
                   pMEM_OD_0.2_div_by_4664201.0_multi_by_3382258.0_forward.wig:notex:8:a:+ \
                   pMEM_OD_0.5_div_by_5217691.0_multi_by_3382258.0_forward.wig:notex:9:a:+ \
                   pMEM_OD_1_div_by_4699153.0_multi_by_3382258.0_forward.wig:notex:10:a:+ \
                   pMEM_ON_div_by_3977549.0_multi_by_3382258.0_forward.wig:notex:11:a:+ \
                   pMEM_t0_div_by_3606941.0_multi_by_3382258.0_forward.wig:notex:12:a:+ \
                   pMEM_t1_div_by_3722754.0_multi_by_3382258.0_forward.wig:notex:13:a:+ \
                   pMEM_t2_div_by_3382258.0_multi_by_3382258.0_forward.wig:notex:14:a:+"
    frag_libs="ID-001873-Staph_aureus_sample_mix_div_by_3162486.0_multi_by_3162486.0_forward.wig:frag:1:a:+ \
               ID-001873-Staph_aureus_sample_mix_div_by_3162486.0_multi_by_3162486.0_reverse.wig:frag:1:a:-"

#    set_up_analysis_folder
#    get_input_files    
#    get_target_fasta
#    annotation_transfer
#    expression_analysis
#    SNP_calling_reference
#    TSS_prediction
#    Transcriptome_assembly
#    Terminator_prediction
#    processing_site_prediction
#    utr_detection
#    sRNA_detection
#    sORF_detection
#    promoter_detection
#    CircRNA_detection
#    Go_term
    sRNA_target
#    operon_detection
#    SNP_calling_target
#    PPI_network
#    Subcellular_localization
#    riboswitch
#    Optimize_TSSpredator
#    gen_screenshot
#    color_png
}


create_folders(){
    for FOLDER in bin
    do
        if ! [ -d $FOLDER ]
        then
            mkdir -p $FOLDER
        fi
    done
}

set_up_analysis_folder(){
    if ! [ -d $ANNOGESIC_FOLDER ]
    then
        $PYTHON_PATH $ANNOGESIC_PATH create $ANNOGESIC_FOLDER
    fi
}

get_input_files(){
    $PYTHON_PATH $ANNOGESIC_PATH \
	get_input_files \
	-F $FTP_SOURCE \
	-g \
	-f \
	-e \
	-k \
	$ANNOGESIC_FOLDER
}

get_target_fasta(){
    $PYTHON_PATH $ANNOGESIC_PATH \
        get_target_fasta \
        -r $ANNOGESIC_FOLDER/input/reference/fasta \
	-o Staphylococcus_aureus_HG003:Staphylococcus_aureus_HG003 \
        -m $ANNOGESIC_FOLDER/input/mutation_table/Combined_table_Berscheid_and_Schuster.csv \
        $ANNOGESIC_FOLDER
}

annotation_transfer(){
    # instead of using "source"
    . $PAGIT_HOME/sourceme.pagit
    $PYTHON_PATH $ANNOGESIC_PATH \
        annotation_transfer \
        -re $ANNOGESIC_FOLDER/input/reference/annotation \
        -rf $ANNOGESIC_FOLDER/input/reference/fasta \
        -tf $ANNOGESIC_FOLDER/output/target/fasta \
        -e chromosome \
	-t Strain \
	-p NC_007795.1:Staphylococcus_aureus_HG003 \
	-g \
	--RATT_path /home/silas/ANNOgesic/tools/PAGIT/RATT/start.ratt.sh \
        $ANNOGESIC_FOLDER
}

expression_analysis(){
    $PYTHON_PATH $ANNOGESIC_PATH \
         expression_analysis \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        -tl $tex_notex_libs \
        -fl $frag_libs \
        -tw $ANNOGESIC_FOLDER/input/wigs/tex_notex \
        -fw $ANNOGESIC_FOLDER/input/wigs/fragment \
        -f CDS tRNA rRNA \
        -rt 1 \
        -rf 1 \
        $ANNOGESIC_FOLDER
}

SNP_calling_reference(){
    $PYTHON_PATH $ANNOGESIC_PATH \
         snp \
        -p 1 2 3 \
        -t reference \
        -nw $ANNOGESIC_FOLDER/input/BAMs/BAMs_map_reference/tex_notex \
        -f $ANNOGESIC_FOLDER/input/reference/fasta \
        --samtools_path /home/silas/ANNOgesic/tools/samtools-bcftools-htslib-1.0_x64-linux/bin/samtools \
        --bcftools_path /home/silas/ANNOgesic/tools/samtools-bcftools-htslib-1.0_x64-linux/bin/bcftools \
        $ANNOGESIC_FOLDER
}

TSS_prediction(){
    $PYTHON_PATH $ANNOGESIC_PATH \
        tsspredator \
        --TSSpredator_path /home/silas/ANNOgesic/tools/TSSpredator_v1-04/TSSpredator.jar \
        -w $ANNOGESIC_FOLDER/input/wigs/tex_notex \
        -f $ANNOGESIC_FOLDER/output/target/fasta \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        -l $tex_notex_libs \
        -p TSB_OD_0.2 \
	   TSB_OD_0.5 \
	   TSB_OD_1 \
           TSB_ON \
	   TSB_t0 \
	   TSB_t1 \
	   TSB_t2 \
           pMEM_OD_0.2 \
	   pMEM_OD_0.5 \
	   pMEM_OD_1 \
	   pMEM_ON \
	   pMEM_t0 \
	   pMEM_t1 \
	   pMEM_t2 \
        -he 1.4 \
        -rh 1.3 \
        -fa 5.1 \
        -rf 0.7 \
        -bh 0.055 \
	-ef 0.4 \
	-pf 1.6 \
	-rm 1 \
        -s \
        -m $ANNOGESIC_FOLDER/input/manual_TSS/Staphylococcus_aureus_HG003_manual_TSS.gff \
        -v \
        $ANNOGESIC_FOLDER
}
#-ta $ANNOGESIC_FOLDER/output/transcriptome_assembly/gffs \
#-m $ANNOGESIC_FOLDER/input/manual_TSS/Staphylococcus_aureus_HG003_manual_TSS.gff \
#        -v \

Transcriptome_assembly(){
    $PYTHON_PATH $ANNOGESIC_PATH \
        transcript_assembly \
        -nw $ANNOGESIC_FOLDER/input/wigs/tex_notex \
	-fw $ANNOGESIC_FOLDER/input/wigs/fragment \
        -tl $tex_notex_libs \
        -fl $frag_libs \
        -rt 1 \
	-rf 1 \
        -te 2 \
	-ct $ANNOGESIC_FOLDER/output/TSS/gffs \
        -cg $ANNOGESIC_FOLDER/output/target/annotation \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        $ANNOGESIC_FOLDER
}

Terminator_prediction(){
    $PYTHON_PATH $ANNOGESIC_PATH \
        terminator \
        --TransTermHP_folder /home/silas/ANNOgesic/tools/transterm_hp_v2.09/transterm \
        --expterm_path /home/silas/ANNOgesic/tools/transterm_hp_v2.09/expterm.dat \
        -f $ANNOGESIC_FOLDER/output/target/fasta \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        -s \
        -fw $ANNOGESIC_FOLDER/input/wigs/fragment \
        -tw $ANNOGESIC_FOLDER/input/wigs/tex_notex \
        -a $ANNOGESIC_FOLDER/output/transcriptome_assembly/gffs \
        -tl $tex_notex_libs \
        -fl $frag_libs \
        -te 2 \
        -rt 1 \
	-rf 1 \
        -tb \
        $ANNOGESIC_FOLDER
}

processing_site_prediction()
{
    $PYTHON_PATH $ANNOGESIC_PATH \
        tsspredator \
        --TSSpredator_path /home/silas/ANNOgesic/tools/TSSpredator_v1-04/TSSpredator.jar \
        -w $ANNOGESIC_FOLDER/input/wigs/tex_notex \
        -f $ANNOGESIC_FOLDER/output/target/fasta \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        -l $tex_notex_libs \
        -p TSB_OD_0.2 \
           TSB_OD_0.5 \
           TSB_OD_1 \
           TSB_ON \
           TSB_t0 \
           TSB_t1 \
           TSB_t2 \
           pMEM_OD_0.2 \
           pMEM_OD_0.5 \
           pMEM_OD_1 \
           pMEM_ON \
           pMEM_t0 \
           pMEM_t1 \
           pMEM_t2 \
        -he 0.5 \
        -rh 0.2 \
        -fa 2.1 \
        -rf 1.4 \
	-bh 0.0 \
	-ef 4.7 \
	-pf 2.5 \
	-rm 1 \
	-t processing_site \
	-s \
	-m $ANNOGESIC_FOLDER/input/manual_processing_site/Staphylococcus_aureus_HG003_manual_processing_105000.gff \
        -le 105000 \
        $ANNOGESIC_FOLDER
}

utr_detection(){
    $PYTHON_PATH $ANNOGESIC_PATH \
        utr \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
	-t $ANNOGESIC_FOLDER/output/TSS/gffs \
        -a $ANNOGESIC_FOLDER/output/transcriptome_assembly/gffs \
	-e $ANNOGESIC_FOLDER/output/terminator/gffs/detect \
        $ANNOGESIC_FOLDER
}

sRNA_detection(){
    $PYTHON_PATH $ANNOGESIC_PATH \
        srna \
        -d 1 2 3 4 5 \
        --Vienna_folder /home/silas/ANNOgesic/tools/ViennaRNA-2.1.7 \
	--blast_plus_folder /home/silas/ANNOgesic/tools \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        -t $ANNOGESIC_FOLDER/output/TSS/gffs \
        -p $ANNOGESIC_FOLDER/output/processing_site/gffs \
        -a $ANNOGESIC_FOLDER/output/transcriptome_assembly/gffs \
        -fw $ANNOGESIC_FOLDER/input/wigs/fragment \
        -tw $ANNOGESIC_FOLDER/input/wigs/tex_notex \
        -f $ANNOGESIC_FOLDER/output/target/fasta \
	-O $ANNOGESIC_FOLDER/output/sORF/gffs/best \
        -m \
        -u \
	-fd \
        -sd $ANNOGESIC_FOLDER/input/database/sRNA_database \
        -nd $ANNOGESIC_FOLDER/input/database/nr \
        -tl $tex_notex_libs \
        -fl $frag_libs \
        -te 2 \
        -rt 1 \
	-rf 1 \
        -ba \
	-sb \
        $ANNOGESIC_FOLDER
}

sORF_detection(){
    $PYTHON_PATH $ANNOGESIC_PATH \
        sorf \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        -t $ANNOGESIC_FOLDER/output/TSS/gffs \
        -a $ANNOGESIC_FOLDER/output/transcriptome_assembly/gffs \
        -fw $ANNOGESIC_FOLDER/input/wigs/fragment \
        -tw $ANNOGESIC_FOLDER/input/wigs/tex_notex \
        -f $ANNOGESIC_FOLDER/output/target/fasta \
	-s $ANNOGESIC_FOLDER/output/sRNA/gffs/best \
        -tl $tex_notex_libs \
        -fl $frag_libs \
        -te 2 \
        -rt 1 \
	-rf 1 \
        -u \
        $ANNOGESIC_FOLDER
}
#-s $ANNOGESIC_FOLDER/output/sRNA/gffs/best \
promoter_detection(){
    $PYTHON_PATH $ANNOGESIC_PATH \
        promoter \
        -t $ANNOGESIC_FOLDER/output/TSS/gffs \
        -f $ANNOGESIC_FOLDER/output/target/fasta \
	-w 50 51 45 2-10 \
	-p 10 \
	-g $ANNOGESIC_FOLDER/output/TSS/gffs \
        $ANNOGESIC_FOLDER
}

CircRNA_detection(){
    $PYTHON_PATH $ANNOGESIC_PATH \
        circrna \
        -f $ANNOGESIC_FOLDER/output/target/fasta \
        -p 10 \
	-g $ANNOGESIC_FOLDER/output/target/annotation \
	-cg \
	-a \
	--samtools_path /home/silas/ANNOgesic/tools/samtools-bcftools-htslib-1.0_x64-linux/bin/samtools \
        --segemehl_folder /home/silas/ANNOgesic/tools/segemehl_0_1_9/segemehl \
	$ANNOGESIC_FOLDER	
}

Go_term(){
    $PYTHON_PATH $ANNOGESIC_PATH \
        go_term \
        -g $ANNOGESIC_FOLDER/output/target/annotation\
        $ANNOGESIC_FOLDER
}

sRNA_target(){
    $PYTHON_PATH $ANNOGESIC_PATH \
         srna_target \
        --Vienna_folder /home/silas/ANNOgesic/tools/ViennaRNA-2.1.7 \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        -f $ANNOGESIC_FOLDER/output/target/fasta \
        -r $ANNOGESIC_FOLDER/output/sRNA/gffs/best \
        -q all \
        -p both \
        $ANNOGESIC_FOLDER
}

operon_detection(){
    $PYTHON_PATH $ANNOGESIC_PATH \
         operon \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        -t $ANNOGESIC_FOLDER/output/TSS/gffs \
        -a $ANNOGESIC_FOLDER/output/transcriptome_assembly/gffs \
	-u5 $ANNOGESIC_FOLDER/output/UTR/5UTR/gffs \
        -u3 $ANNOGESIC_FOLDER/output/UTR/3UTR/gffs \
	-e $ANNOGESIC_FOLDER/output/terminator/gffs/detect \
	-s \
	-c \
        $ANNOGESIC_FOLDER
}

SNP_calling_target(){
    $PYTHON_PATH $ANNOGESIC_PATH \
         snp \
	-t target \
	-p 1 2 3 \
	-nw $ANNOGESIC_FOLDER/input/BAMs/BAMs_map_target/tex_notex \
	-fw $ANNOGESIC_FOLDER/input/BAMs/BAMs_map_target/fragment \
	-f $ANNOGESIC_FOLDER/output/target/fasta \
        --samtools_path /home/silas/ANNOgesic/tools/samtools-bcftools-htslib-1.0_x64-linux/bin/samtools \
        --bcftools_path /home/silas/ANNOgesic/tools/samtools-bcftools-htslib-1.0_x64-linux/bin/bcftools \
        $ANNOGESIC_FOLDER
}

PPI_network(){
    $PYTHON_PATH $ANNOGESIC_PATH \
         ppi_network \
        -s all:Staphylococcus_aureus_HG003.ptt:Staphylococcus_aureus_HG003:'Staphylococcus aureus 8325':'Staphylococcus aureus' \
        -p $ANNOGESIC_FOLDER/output/target/annotation \
        -d $ANNOGESIC_FOLDER/input/database/species.v9.1.txt \
        -n \
	-q Staphylococcus_aureus_HG003:1954999:1956240:- \
        -ns 4000 \
        $ANNOGESIC_FOLDER
}

Subcellular_localization(){
    $PYTHON_PATH $ANNOGESIC_PATH \
         subcellular_localization \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        -f $ANNOGESIC_FOLDER/output/target/fasta \
        -m \
        -b positive \
        --Psortb_path /home/silas/ANNOgesic/tools/psortb/bin/psort \
        --EMBOSS_transeq_path /home/silas/ANNOgesic/tools/EMBOSS-6.6.0/emboss/transeq \
        $ANNOGESIC_FOLDER
}

riboswitch(){
    $PYTHON_PATH $ANNOGESIC_PATH \
         riboswitch \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        -f $ANNOGESIC_FOLDER/output/target/fasta \
	-r \
        -i $ANNOGESIC_FOLDER/input/riboswitch_ID/Rfam_riboswitch_ID.csv \
        -R $ANNOGESIC_FOLDER/input/database/Rfam/CMs/Rfam.cm \
	--infernal_path /home/silas/ANNOgesic/tools/infernal-1.1.1/src \
        $ANNOGESIC_FOLDER
}

Optimize_TSSpredator(){
    $PYTHON_PATH $ANNOGESIC_PATH \
         optimize_tsspredator \
        --TSSpredator_path /home/silas/ANNOgesic/tools/TSSpredator_v1-04/TSSpredator.jar \
        -w $ANNOGESIC_FOLDER/input/wigs/tex_notex \
        -fs $ANNOGESIC_FOLDER/output/target/fasta \
        -g $ANNOGESIC_FOLDER/output/target/annotation \
        -n Staphylococcus_aureus_HG003 \
	-l $tex_notex_libs \
	-p TSB_OD_0.2 \
           TSB_OD_0.5 \
           TSB_OD_1 \
           TSB_ON \
           TSB_t0 \
           TSB_t1 \
           TSB_t2 \
           pMEM_OD_0.2 \
           pMEM_OD_0.5 \
           pMEM_OD_1 \
           pMEM_ON \
           pMEM_t0 \
           pMEM_t1 \
           pMEM_t2 \
        -m $ANNOGESIC_FOLDER/input/manual_TSS/Staphylococcus_aureus_HG003_manual_TSS.gff  \
        -c 4 \
	-rm 1 \
        $ANNOGESIC_FOLDER
}

gen_screenshot(){
    $PYTHON_PATH $ANNOGESIC_PATH \
         screenshot \
        -mg $ANNOGESIC_FOLDER/output/sRNA/gffs/best/Staphylococcus_aureus_HG003_sRNA.gff \
        -sg $ANNOGESIC_FOLDER/output/target/annotation/Staphylococcus_aureus_HG003.gff \
            $ANNOGESIC_FOLDER/output/TSS/gffs/Staphylococcus_aureus_HG003_TSS.gff \
            $ANNOGESIC_FOLDER/output/processing_site/gffs/Staphylococcus_aureus_HG003_processing.gff \
        -f $ANNOGESIC_FOLDER/output/target/fasta/Staphylococcus_aureus_HG003.fa \
        -o $ANNOGESIC_FOLDER/output/sRNA/screenshots \
        -fl $frag_libs \
        -tl $tex_notex_libs \
        -fw $ANNOGESIC_FOLDER/input/wigs/fragment \
        -tw $ANNOGESIC_FOLDER/input/wigs/tex_notex \
    $ANNOGESIC_FOLDER
}

color_png(){
    $PYTHON_PATH $ANNOGESIC_PATH \
        color_png \
        -t 29 \
	-f $ANNOGESIC_FOLDER/output/sRNA \
	--ImageMagick_covert_path /home/silas/ANNOgesic/tools/ImageMagick-6.9.0-0/utilities/convert \
        $ANNOGESIC_FOLDER
}

main
