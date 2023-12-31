% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get-coverage.R
\name{get_coverage}
\alias{get_coverage}
\title{Obtain the mean coverage across multiple BigWig files}
\usage{
get_coverage(
  bw_paths,
  auc_raw,
  auc_target,
  chrs = "",
  genome = "hg38",
  bw_chr = "chr"
)
}
\arguments{
\item{bw_paths}{path(s) to bigwig file(s) with the RNA-seq data that you want
the #'   coverage of.}

\item{auc_raw}{vector containing AUCs(Area Under Coverage) matching the order
of bigwig path(s).}

\item{auc_target}{total AUC to normalise all samples to e.g. 40e6 * 100 would
be the estimated total auc for sample sequenced to 40 million reads of
100bp in length.}

\item{chrs}{chromosomes to obtain mean coverage for, default is "" giving
every chromosome. Can take UCSC format(chrs = "chr1") or just the
chromosome i.e. chrs = c(1,X)}

\item{genome}{the UCSC genome you want to use, the default is hg38.}

\item{bw_chr}{specifies whether the bigwig files has the chromosomes labelled
with a "chr" preceding the chromosome i.e. "chr1" vs "1". Can be either
"chr" or "nochr" with "chr" being the default.}
}
\value{
a list of Rles detailing the mean coverage per chromosome passed in.
}
\description{
\code{get_coverage} returns the mean coverage of the BigWig files passed in.
Internally, this operates through \code{derfinder::loadCoverage}.
}
\examples{
rec_url <- recount::download_study(
    project = "SRP012682",
    type = "samples",
    download = FALSE
)
bw_path <- file_cache(rec_url[1])
# As of rtracklayer 1.25.16, BigWig is not supported on Windows.
if (!xfun::is_windows()) {
    eg_coverage <- get_coverage(
        bw_paths = bw_path,
        auc_raw = 11872688252,
        auc_target = 40e6 * 100,
        chrs = c("chr21", "chr22")
    )
    eg_coverage
}
}
