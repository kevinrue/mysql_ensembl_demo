-- Create database
SHOW DATABASES;
CREATE DATABASE ensembl;
USE ensembl;
SELECT DATABASE(); -- active database
SHOW TABLES;

-- Create tables
CREATE TABLE genes (
    ensembl_gene_id CHAR(15) PRIMARY KEY,
    chromosome_name VARCHAR(38),
    start_position INT UNSIGNED,
    end_position INT UNSIGNED,
    strand TINYINT,
    band VARCHAR(7),
    description VARCHAR(165)
);
LOAD DATA LOCAL INFILE '/Users/kevin/git/mysql_ensembl_demo/tables/genes.txt' INTO TABLE genes;
DROP table genes;

-- Show all records (Workbench defaults to first 1000)
SELECT 
    *
FROM
    genes;

-- Show count of genes
SELECT 
    COUNT(*)
FROM
    genes;

-- Show count of genes per chromosome
SELECT 
    chromosome_name, COUNT(*)
FROM
    genes
GROUP BY chromosome_name
ORDER BY COUNT(*) DESC;

CREATE TABLE transcripts (
    ensembl_transcript_id CHAR(15) PRIMARY KEY,
    transcript_biotype VARCHAR(35),
    transcript_status VARCHAR(10),
    transcript_version TINYINT UNSIGNED,
    external_transcript_source_name VARCHAR(30)
);
-- DROP table ensembl.transcripts;
LOAD DATA LOCAL INFILE '/Users/kevin/git/mysql_ensembl_demo/tables/transcripts.txt' INTO TABLE transcripts;

-- Show all records (Workbench defaults to first 1000)
SELECT 
    *
FROM
    transcripts;

-- Show count of transcripts
SELECT 
    COUNT(*)
FROM
    transcripts;

-- Show count of transcripts for each biotype
SELECT 
    transcript_biotype, COUNT(*)
FROM
    transcripts
GROUP BY transcript_biotype
ORDER BY COUNT(*) DESC;

CREATE TABLE gene2tx (
	ensembl_gene_id CHAR(15),
    ensembl_transcript_id CHAR(15),
    FOREIGN KEY (ensembl_gene_id)
        REFERENCES genes(ensembl_gene_id),
	FOREIGN KEY (ensembl_transcript_id)
        REFERENCES transcripts(ensembl_transcript_id)
);
-- DROP table gene2tx;
LOAD DATA LOCAL INFILE '/Users/kevin/git/mysql_ensembl_demo/tables/table.gene2tx.txt' INTO TABLE gene2tx;

-- Show all records (Workbench defaults to first 1000)
SELECT 
    *
FROM
    gene2tx;

-- Show count of mapping records
SELECT 
    COUNT(*)
FROM
    gene2tx;

-- Show count of transcripts per gene in decreasing order
SELECT 
    ensembl_gene_id, COUNT(*)
FROM
    gene2tx
GROUP BY ensembl_gene_id
ORDER BY COUNT(*) DESC;

CREATE TABLE gene2symbol (
	ensembl_gene_id CHAR(15),
    hgnc_symbol VARCHAR(22),
    FOREIGN KEY (ensembl_gene_id)
        REFERENCES genes(ensembl_gene_id)
);
-- DROP table gene2tx;
LOAD DATA LOCAL INFILE '/Users/kevin/git/mysql_ensembl_demo/tables/symbols.txt' INTO TABLE gene2symbol;

-- Show all records (Workbench defaults to first 1000)
SELECT 
    *
FROM
    gene2symbol;

-- Show count of mapping records
SELECT 
    COUNT(*)
FROM
    gene2symbol;

-- Show count of transcripts per gene in decreasing order
SELECT 
    ensembl_gene_id, COUNT(*)
FROM
    gene2symbol
GROUP BY ensembl_gene_id
ORDER BY COUNT(*) DESC;

-- Annotate earlier count of transcripts per gene with gene symbol
select * FROM (
SELECT 
    ensembl_gene_id, COUNT(*)
FROM
    gene2tx
GROUP BY ensembl_gene_id
ORDER BY COUNT(*) DESC
)
left join gene2symbol;