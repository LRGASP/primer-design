# primer-design
Primer design for LRGASP evaluation


## required files in data/ directory:

data/hg38
* hg38.2bit https://hgdownload.soe.ucsc.edu/gbdb/hg38/hg38.2bit
* GCF_000001405.39_GRCh38.p13_assembly_report.txt https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.39_GRCh38.p13/GCF_000001405.39_GRCh38.p13_assembly_report.txt
* hg38 assembly report https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.39_GRCh38.p13/GCF_000001405.39_GRCh38.p13_assembly_report.txt
* gencodeV39.bb https://hgdownload.soe.ucsc.edu/gbdb/hg38/gencode/gencodeV39.bb
* hg38KgSeqV39.2bit https://hgdownload.soe.ucsc.edu/gbdb/hg38/targetDb/hg38KgSeqV39.2bit
* WTC11_consolidated.bigBed http://conesalab.org/LRGASP/LRGASP_hub/hg38/Human_samples/WTC11_consolidated.bigBed
* H1_mix_consolidated.bigBed http://conesalab.org/LRGASP/LRGASP_hub/hg38/Human_samples/H1_mix_consolidated.bigBed

## isPcr blat server that includes LRGASP transcript models

cd data/hg38

Create transcriptome bed:
  bigBedToBed gencodeV39.bb stdout | tawk '{$4=$4"__"$18; print}' | cut -f 1-12 > gencodeV39.tmp.bed &
  bigBedToBed WTC11_consolidated.bigBed stdout | tawk '{$4=$4"_WTC11"; print}' | cut -f 1-12 > WTC11_consolidated.tmp.bed &
  bigBedToBed H1_mix_consolidated.bigBed stdout | tawk '{$4=$4"_H1_mix"; print}' | cut -f 1-12 > H1_mix_consolidated.tmp.bed &

Toss very larges BED, NIC_195936_H1_mix is 159,002,842 RNA, 159,055,147 DNA, biggest GENCODE is 2,471,657 DNA

  sort -k1,1 -k2,2n gencodeV39.tmp.bed WTC11_consolidated.tmp.bed H1_mix_consolidated.tmp.bed | tawk '$3-$2 <= 2500000' >hg38_transcriptome.tmp.bed

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

