# configuration file with manatee

from os import path as osp
from primersjuju.config import PrimersJuJuConfig, GenomeConfig
from primersjuju.genome_data import GenomeData
from primersjuju.uniqueness_query import IsPcrServerSpec

data_dir = osp.join(osp.dirname(configPyFile), "../../../data/manatee")

def data_path(fname):
    return osp.join(data_dir, fname)

manatee_gd = GenomeData("manatee",
                        data_path("manatee.2bit"))
manatee_gd.add_track("Annot",
                  data_path("Annot.bb"),
                  "http://conesalab.org/LRGASP/LRGASP_manatee_hub/manatee/manatee/Annot.bb")
manatee_gd.add_track("manatee_consolidated",
                  data_path("Manatee_consolidated.bb"),
                  "http://conesalab.org/LRGASP/LRGASP_manatee_hub/manatee/manatee/Manatee_consolidated.bb")

genome_ispcr_spec = IsPcrServerSpec("hgwdev.gi.ucsc.edu", 12203, data_dir)
transcriptome_ispcr_spec = IsPcrServerSpec("hgwdev.gi.ucsc.edu", 12202, data_dir,
                                           trans_bigbed=data_path("manatee_transcriptome.bb"))


manatee_config = GenomeConfig(manatee_gd,
                              genome_ispcr_spec=genome_ispcr_spec,
                              transcriptome_ispcr_spec=transcriptome_ispcr_spec)
config = PrimersJuJuConfig()
config.add_genome(manatee_config)
