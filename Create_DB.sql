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
-- DROP table ensembl.genes;
SELECT 
    *
FROM
    genes;

SELECT 
    COUNT(*)
FROM
    genes;

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

SELECT 
    *
FROM
    transcripts;

SELECT 
    COUNT(*)
FROM
    transcripts;

SELECT 
    transcript_biotype, COUNT(*)
FROM
    transcripts
GROUP BY transcript_biotype
ORDER BY COUNT(*) DESC;

create table gene2tx (
	ensembl_gene_id CHAR(15),
    ensembl_transcript_id CHAR(15),
    FOREIGN KEY (ensembl_gene_id)
        REFERENCES genes(ensembl_gene_id),
	FOREIGN KEY (ensembl_transcript_id)
        REFERENCES transcripts(ensembl_transcript_id)
);
-- DROP table ensembl.transcripts;
LOAD DATA LOCAL INFILE '/Users/kevin/git/mysql_ensembl_demo/tables/table.gene2tx.txt' INTO TABLE gene2tx;

SELECT 
    *
FROM
    gene2tx;

SELECT 
    COUNT(*)
FROM
    gene2tx;

SELECT 
    ensembl_gene_id, COUNT(*)
FROM
    gene2tx
GROUP BY ensembl_gene_id
ORDER BY COUNT(*) DESC;
