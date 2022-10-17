# primer-design
Primer design for LRGASP evaluation


# hg38 data construction

download to data/hg38/
* hg38.2bit https://hgdownload.soe.ucsc.edu/gbdb/hg38/hg38.2bit
* GCF_000001405.39_GRCh38.p13_assembly_report.txt https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.39_GRCh38.p13/GCF_000001405.39_GRCh38.p13_assembly_report.txt
* gencodeV39.bb https://hgdownload.soe.ucsc.edu/gbdb/hg38/gencode/gencodeV39.bb
* hg38KgSeqV39.2bit https://hgdownload.soe.ucsc.edu/gbdb/hg38/targetDb/hg38KgSeqV39.2bit
* WTC11_consolidated.bigBed http://conesalab.org/LRGASP/LRGASP_hub/hg38/Human_samples/WTC11_consolidated.bigBed
* H1_mix_consolidated.bigBed http://conesalab.org/LRGASP/LRGASP_hub/hg38/Human_samples/H1_mix_consolidated.bigBed
* non_redundant_FSM.bb http://conesalab.org/LRGASP/LRGASP_hub/hg38/non_redundant.Manual_Annotation/non_redundant_FSM.bb
* non_redundant_NIC.bb http://conesalab.org/LRGASP/LRGASP_hub/hg38/non_redundant.Manual_Annotation/non_redundant_NIC.bb
* non_redundant_NNC.bb http://conesalab.org/LRGASP/LRGASP_hub/hg38/non_redundant.Manual_Annotation/non_redundant_NNC.bb
* human_GENCODE_tmerge_transcripts.bb http://conesalab.org/LRGASP/LRGASP_hub/hg38/non_redundant.Manual_Annotation/human_GENCODE_tmerge_transcripts.bb


## isPcr blat server that includes LRGASP transcript models

cd data/hg38

Create transcriptome bed with unique ids:
  bigBedToBed gencodeV39.bb stdout | tawk '{$4=$4"__"$18; print}' | cut -f 1-12 > gencodeV39.tmp.bed &
  bigBedToBed WTC11_consolidated.bigBed stdout | tawk '{$4=$4"_WTC11"; print}' | cut -f 1-12 > WTC11_consolidated.tmp.bed &
  bigBedToBed H1_mix_consolidated.bigBed stdout | tawk '{$4=$4"_H1_mix"; print}' | cut -f 1-12 > H1_mix_consolidated.tmp.bed &

  Didn't late-comer tracks:
    non_redundant_FSM.bb
    non_redundant_NIC.bb
    non_redundant_NNC.bb
    human_GENCODE_tmerge_transcripts.bb
    
Toss very larges BED, NIC_195936_H1_mix is 159,002,842 RNA, 159,055,147 DNA, biggest GENCODE is 2,471,657 DNA

  sort -k1,1 -k2,2n *.tmp.bed | tawk '$3-$2 <= 2500000' >hg38_transcriptome.tmp_all.bed

Create transcriptome BigBed
  bedToBigBed -type=bed12 -tab -extraIndex=name -sizesIs2Bit hg38_transcriptome.tmp.bed /hive/data/genomes/hg38/hg38.2bit hg38_transcriptome.bb

  
Create transcriptome twobit
  bedToGenePred hg38_transcriptome.tmp.bed stdout | getRnaPred hg38 stdin all stdout | faToTwoBit -ignoreDups -long stdin hg38_transcriptome.2bit

Sanity check sizes with
  twoBitInfo hg38_transcriptome.2bit stdout | sort -k 2,2nr | head

Intermediates not needed 
  rm *.tmp.bed

start a gaServer for PCR:
  cd pcr

  (gfServer start hgwdev.gi.ucsc.edu 12201 -stepSize=5 -log=lrgasp-hg38-pcr.log  /hive/users/markd/gencode/projs/lrgasp/primers/primer-design/data/hg38/hg38_transcriptome.2bit </dev/null >&/dev/null &)&

# manatee data construction

download to data/manatee/
* manatee.2bit http://conesalab.org/LRGASP/LRGASP_manatee_hub/manatee/manatee/manatee.2bit
* Annot.bb http://conesalab.org/LRGASP/LRGASP_manatee_hub/manatee/manatee/Annot.bb
* Manatee_consolidated.bb http://conesalab.org/LRGASP/LRGASP_manatee_hub/manatee/manatee/Manatee_consolidated.bb


Need to fix nameIndex in Annot.bb and Manatee_consolidated.bb
  bigBedToBed Annot.bb Annot.tmp.bed
  bedToBigBed -type=bed12+8 -tab -as=${HOME}/kent/src/hg/lib/bigGenePred.as -sizesIs2Bit -extraIndex=name Annot.tmp.bed manatee.2bit Annot.tmp.bb
  mv Annot.tmp.bb Annot.bb

  bigBedInfo -as Manatee_consolidated.bb  >isoformSummaryBed.as
  bigBedToBed Manatee_consolidated.bb Manatee_consolidated.tmp.bed
  bedToBigBed -type=bed12+21 -tab -as=isoformSummaryBed.as -sizesIs2Bit -extraIndex=name Manatee_consolidated.tmp.bed manatee.2bit Manatee_consolidated.tmp.bb
  mv Manatee_consolidated.tmp.bb Manatee_consolidated.bb 
  rm *.tmp.bed


## isPcr blat servers for genome and that includes LRGASP transcript models


Create transcriptome bed:
  bigBedToBed Annot.bb stdout | cut -f 1-12 > Annot.tmp.bed &
  bigBedToBed Manatee_consolidated.bb stdout| cut -f 1-12 > Manatee_consolidated.tmp.bed &
  wait
  sort -k1,1 -k2,2n Annot.tmp.bed Manatee_consolidated.tmp.bed > manatee_transcriptome.tmp.bed

Create transcriptome bigBed
  bedToBigBed -type=bed12 -tab -extraIndex=name -sizesIs2Bit manatee_transcriptome.tmp.bed manatee.2bit manatee_transcriptome.bb
  
Create transcriptome twobit
  bedToGenePred manatee_transcriptome.tmp.bed stdout | getRnaPred  -genomeSeqs=manatee.2bit none stdin all stdout | faToTwoBit -ignoreDups -long stdin manatee_transcriptome.2bit

Sanity check sizes with
  twoBitInfo manatee_transcriptome.2bit stdout | sort -k 2,2nr | head

Intermediates not needed 
  rm *.tmp.bed

start gaServers for PCR:
  cd pcr

  (gfServer start hgwdev.gi.ucsc.edu 12202 -stepSize=5 -log=lrgasp-manatee-transcriptome-pcr.log  /hive/users/markd/gencode/projs/lrgasp/primers/primer-design/data/manatee/manatee_transcriptome.2bit </dev/null >&/dev/null &)&
  (gfServer start hgwdev.gi.ucsc.edu 12203 -stepSize=5 -log=lrgasp-manatee-genome-pcr.log  /hive/users/markd/gencode/projs/lrgasp/primers/primer-design/data/manatee/manatee.2bit </dev/null >&/dev/null &)&
