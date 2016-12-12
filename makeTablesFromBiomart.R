library(biomaRt)

bm.host <- "Dec2016.archive.ensembl.org"
folder.table <- "tables"

if (!dir.exists(folder.table)){
    dir.create(folder.table)
}

listMarts(host = bm.host)

bm.mart <- useMart("ENSEMBL_MART_ENSEMBL", "hsapiens_gene_ensembl", bm.host)

listAttributes(bm.mart, "feature_page")[1:50,1]

table.gene <- getBM(
    c(
        "ensembl_gene_id","chromosome_name","start_position","end_position",
        "strand","band","description"
    ),
    mart = bm.mart
)
names(table.gene)
write.table(
    table.gene, "tables/genes.txt", quote = FALSE, sep = "\t", na = "\n",
    row.names = FALSE, col.names = FALSE
)

table.gene2tx <- getBM(
    c("ensembl_gene_id","ensembl_transcript_id"),
    mart = bm.mart
)
names(table.gene2tx)
write.table(
    table.gene2tx, "tables/table.gene2tx.txt", quote = FALSE, sep = "\t",
    na = "\n", row.names = FALSE, col.names = FALSE
)

table.symbol <- getBM(c("ensembl_gene_id","hgnc_symbol"), mart = bm.mart)
names(table.symbol)
write.table(
    table.symbol, "tables/symbols.txt", quote = FALSE, sep = "\t", na = "\n",
    row.names = FALSE, col.names = FALSE
)
