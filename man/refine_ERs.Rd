% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/refine-ERs.R
\name{refine_ERs}
\alias{refine_ERs}
\title{Refines the ERs start and end points}
\usage{
refine_ERs(annot_ers)
}
\arguments{
\item{annot_ers}{ERs that have been annotated (result of annotatER)}
}
\value{
Genomic ranges with refined base pair starts and ends
}
\description{
Uses the junctions added by \code{\link{annotatERs}} to modify the starts and
ends of the expressed regions. When a junction intersects an expressed region
depending on whether it is the start or end or both, the regions
corresponding starts and ends will be modified.
}
\details{
As junctions mark intron boundaries, the expressed region will be changed to
either being one less or one more than the junction end.
}
\examples{
# create example set of ers to save runtime
ex_annot_ers <- GenomicRanges::GRanges(
    seqnames = S4Vectors::Rle(c("chr21"), c(3)),
    ranges = IRanges::IRanges(
        start = c(5093576, 5097663, 5162182),
        end = c(5093833, 5097762, 5162257)
    ),
    grl = GenomicRanges::GRangesList(
        GenomicRanges::GRangesList(
            GenomicRanges::GRanges(
                seqnames = S4Vectors::Rle(c("chr21"), c(1)),
                ranges = IRanges::IRanges(
                    start = c(5093712),
                    end = c(5093744)
                )
            ),
            GenomicRanges::GRanges(
                seqnames = S4Vectors::Rle(c("chr21"), c(1)),
                ranges = IRanges::IRanges(
                    start = c(5097642),
                    end = c(5097669)
                )
            ),
            GenomicRanges::GRanges(
                seqnames = S4Vectors::Rle(c("chr21"), c(1)),
                ranges = IRanges::IRanges(
                    start = c(5162249),
                    end = c(5162287)
                )
            )
        )
    ),
    annotation = c("intron", "intron", "intron")
)

refined_ers <- refine_ERs(ex_annot_ers)

refined_ers
}
