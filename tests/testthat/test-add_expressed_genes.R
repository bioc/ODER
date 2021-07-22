gtf_url <- "http://ftp.ensembl.org/pub/release-103/gtf/homo_sapiens/Homo_sapiens.GRCh38.103.chr.gtf.gz"
gtf_path <- ODER:::.file_cache(gtf_url)

gtex_metadata <- recount::all_metadata("gtex")
gtex_metadata <- gtex_metadata %>%
    as.data.frame() %>%
    dplyr::filter(project == "SRP012682")

# obtain path to example bw on recount2
url <- recount::download_study(
    project = "SRP012682",
    type = "samples",
    download = FALSE
)

bw_liver <- ODER:::.file_cache(url[1])

opt_lung_ers <- suppressWarnings(ODER(
    bw_paths = bw_liver, auc_raw = gtex_metadata[["auc"]][1],
    auc_target = 40e6 * 100, chrs = c("chr21", "chr22"),
    genome = "hg38", mccs = c(2, 4, 6, 8, 10), mrgs = c(10, 20, 30),
    gtf = gtf_path, ucsc_chr = TRUE, ignore.strand = TRUE,
    exons_no_overlap = NULL, bw_chr = "chr"
))

annot_lung_ers <- annotatERs(
    opt_ers = opt_lung_ers[["opt_ers"]], junc_data = lung_junc_21_22,
    gtf_path = gtf_path, chrs_to_keep = c("21", "22"), ensembl = TRUE
)

liver_tissue <- get_tissue(tissue = "liver")
lung_tissue <- get_tissue(tissue = "lung")
stomach_tissue <- get_tissue(tissue = "stomach")

livexpr_genes <- get_expressed_genes(gtf_path = gtf_path, tissue_df = liver_tissue)
lungexpr_genes <- get_expressed_genes(gtf_path = gtf_path, tissue_df = lung_tissue)

full_annot_lung_ers <- get_nearest_expressed_genes(annot_ers = annot_lung_ers, exp_genes = lungexpr_genes, gtf_path = gtf_path)

test_that("get_tissue works", {
    expect_equal(colnames(liver_tissue)[2], "Liver")
    expect_equal(colnames(stomach_tissue)[2], "Stomach")
})

test_that("get_expressed_genes works", {
    expect_true(methods::is(livexpr_genes, "GenomicRanges"))
    expect_true(all(grepl(pattern = "chr", x = seqnames(livexpr_genes))))
    expect_true("gene_id" %in% colnames(S4Vectors::mcols(livexpr_genes)))
})

test_that("get_nearest_expressed_genes works", {
    expect_equal(S4Vectors::mcols(full_annot_lung_ers)[["genes"]][[1]], S4Vectors::mcols(full_annot_lung_ers)[["nearest_gene_v94_name"]][[1]])
    expect_equal(S4Vectors::mcols(full_annot_lung_ers)[["genes"]][[6640]], S4Vectors::mcols(full_annot_lung_ers)[["nearest_expressed_gene_v94_name"]][[6640]])
})