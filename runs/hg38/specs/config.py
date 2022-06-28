# configuration file with hg38

from os import path as osp
from primersjuju.config import PrimersJuJuConfig, GenomeConfig
from primersjuju.genome_data import GenomeData
from primersjuju.uniqueness_query import IsPcrServerSpec

data_dir = osp.join(osp.dirname(configPyFile), "../../../data/hg38")

def data_path(fname):
    return osp.join(data_dir, fname)

hg38_gd = GenomeData("hg38",
                     data_path("hg38.2bit"),
                     assembly_report=data_path("GCF_000001405.39_GRCh38.p13_assembly_report.txt"))
hg38_gd.add_track("gencodeV39",
                  data_path("gencodeV39.bb"),
                  "https://hgdownload.soe.ucsc.edu/gbdb/hg38/gencode/gencodeV39.bb")
hg38_gd.add_track("WTC11_consolidated",
                  data_path("WTC11_consolidated.bigBed"),
                  "http://conesalab.org/LRGASP/LRGASP_hub/hg38/Human_samples/WTC11_consolidated.bigBed")
hg38_gd.add_track("H1_MIX_consolidated",
                  data_path("H1_mix_consolidated.bigBed"),
                  "http://conesalab.org/LRGASP/LRGASP_hub/hg38/Human_samples/H1_mix_consolidated.bigBed")


genome_ispcr_spec = IsPcrServerSpec("blat1d.soe.ucsc.edu", 17903, data_dir)
transcriptome_ispcr_spec = IsPcrServerSpec("hgwdev.gi.ucsc.edu", 12201, data_dir,
                                           trans_bigbed=data_path("hg38_transcriptome.bb"))


hg38_config = GenomeConfig(hg38_gd,
                           genome_ispcr_spec=genome_ispcr_spec,
                           transcriptome_ispcr_spec=transcriptome_ispcr_spec)
config = PrimersJuJuConfig()
config.add_genome(hg38_config)
