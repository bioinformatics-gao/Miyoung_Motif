library(biomaRt)
# define biomart object
mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")

# query biomart
gene_up = read.csv("eIF5B pSILAC_up.csv", header = T, check.names = F)
gene_down = read.csv("eIF5B pSILAC_down.csv", header = T, check.names = F)
gene_no_change = read.csv("eIF5B pSILAC_no_change.csv", header = T, check.names = F)

gene_up_with_ensmbl <- getBM(attributes = c("hgnc_symbol","ensembl_gene_id", "ensembl_transcript_id"),
     filters = "hgnc_symbol", values = gene_up$`Gene Name`, mart = mart) #"uniprotswissprot","ensembl_peptide_id"
gene_down_with_ensmbl <- getBM(attributes = c("hgnc_symbol","ensembl_gene_id", "ensembl_transcript_id"),
     filters = "hgnc_symbol", values = gene_down$`Gene Name`, mart = mart) #"uniprotswissprot","ensembl_peptide_id"
gene_no_change_with_ensmbl <- getBM(attributes = c("hgnc_symbol","ensembl_gene_id", "ensembl_transcript_id"),
     filters = "hgnc_symbol", values = gene_no_change$`Gene Name`,mart = mart) #"uniprotswissprot","ensembl_peptide_id"

UTR_5_file = read.csv("UTR_5_ensembl_GRCh38_gcv26.csv", header = T, check.names = F)
transcript_id = as.character(UTR_5_file$ensembl_transcript_id)
UTR_5_file$ensembl_transcript_short =  sapply(strsplit(transcript_id, ".", fixed = TRUE), "[", 1)  # dot needs specail treatment


UTR_5_for_gene_up =        UTR_5_file[which(UTR_5_file$ensembl_transcript_short %in% gene_up_with_ensmbl$ensembl_transcript_id), ]
UTR_5_for_gene_down =      UTR_5_file[which(UTR_5_file$ensembl_transcript_short %in% gene_down_with_ensmbl$ensembl_transcript_id), ]
UTR_5_for_gene_no_change = UTR_5_file[which(UTR_5_file$ensembl_transcript_short %in% gene_no_change_with_ensmbl$ensembl_transcript_id), ]

UTR_5_for_gene_up_with_symbol =        merge(UTR_5_for_gene_up[,-2], gene_up_with_ensmbl, by.x="ensembl_transcript_short", by.y="ensembl_transcript_id")
UTR_5_for_gene_down_with_symbol =      merge(UTR_5_for_gene_down[,-2], gene_down_with_ensmbl, by.x="ensembl_transcript_short",by.y="ensembl_transcript_id")
UTR_5_for_gene_no_change_with_symbol = merge(UTR_5_for_gene_no_change[,-2], gene_no_change_with_ensmbl, by.x="ensembl_transcript_short",by.y="ensembl_transcript_id")


write.csv(UTR_5_for_gene_up_with_symbol, "./Result/UTR_5_for_gene_up.csv", row.names=T)
write.csv(UTR_5_for_gene_down_with_symbol, "./Result/UTR_5_for_gene_down.csv", row.names=T)
write.csv(UTR_5_for_gene_no_change_with_symbol, "./Result/UTR_5_for_gene_no_change.csv", row.names=T)


