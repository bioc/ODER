% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ODER.R
\name{ODER}
\alias{ODER}
\title{Generates the optimum expressed regions}
\usage{
ODER(
  bw_paths,
  auc_raw,
  auc_target,
  chrs = "",
  genome = "hg38",
  mccs,
  mrgs,
  gtf = NULL,
  ucsc_chr,
  ignore.strand,
  exons_no_overlap = NULL
)
}
\arguments{
\item{bw_paths}{paths to bigwig files with the RNA-seq data that you want the
coverage of.}

\item{auc_raw}{vector containing AUCs(Area Under Coverage) matching the order
of bigwig paths.}

\item{auc_target}{total AUC to normalise all samples to. E.g. 40e6 * 100
would be the estimated total auc for sample sequenced to 40 million reads
of 100bp in length.}

\item{chrs}{chromosomes to obtain mean coverage for, default is "" giving
every chromosome.}

\item{genome}{the UCSC genome you want to use, the default is hg38.}

\item{mccs}{mean coverage cut-offs to apply.}

\item{mrgs}{max region gaps to apply.}

\item{gtf}{Either a string containg the path to a .gtf file or a pre-imported
gtf using \code{\link[rtracklayer]{import}}.}

\item{ucsc_chr}{logical scalar, determining whether to add "chr" prefix to
the seqnames of non-overlapping exons and change "chrMT" -> "chrM". Note,
if set to TRUE and seqnames already have "chr", it will not add another.}

\item{ignore.strand}{logical value for input into
\code{\link[GenomicRanges]{findOverlaps}}, default is True.}
}
\value{
list containing optimised ERs, optimal pair of MCC/MRGs and
\code{delta_df}
}
\description{
Generates the optimum expressed regions
}
\examples{
\dontshow{
url <- recount::download_study(
    project = "SRP012682",
    type = "samples",
    download = FALSE
) # .file_cache is an internal function to download a bigwig file from a link
  # if the file has been downloaded recently, it will be retrieved from a cache
  
#' bw_path <- ODER:::.file_cache(url[1])
#' gtf_url <- paste0(
    "http://ftp.ensembl.org/pub/release-103/gtf/",
    "homo_sapiens/Homo_sapiens.GRCh38.103.chr.gtf.gz"
)
gtf_path <- ODER:::.file_cache(gtf_url)
}

opt_ers <- ODER(bw_paths = bw_path, auc_raw = auc_example, 
                auc_target = 40e6 * 100, chrs = c("chr21","chr22"),
                genome = "hg38", mccs = c(5,10), mrgs = c(10,20),
                gtf = gtf_path, ucsc_chr = TRUE, ignore.strand = TRUE,
                exons_no_overlap = NULL)
                
opt_ers
}