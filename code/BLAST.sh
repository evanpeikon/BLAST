#!/bin/bash

fetch_and_create_db() {
    local protein_id=$1
    local fasta_file="${protein_id}.fasta"
    local db_name="${protein_id}_db"
    esearch -db protein -query "$protein_id" | efetch -format fasta > "$fasta_file"
    makeblastdb -in "$fasta_file" -dbtype prot -out "$db_name"
}

perform_blast() {
    local db_protein_id=$1
    local query_protein_id=$2
    local result_file="result.out"
    query_fasta_file="${query_protein_id}.fasta"
    esearch -db protein -query "$query_protein_id" | efetch -format fasta > "$query_fasta_file"
    blastp -db "${db_protein_id}_db" -query "$query_fasta_file" -out "$result_file" -outfmt 7
    cat "$result_file"
}

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <DB_protein_ID> <query_protein_ID>"
    exit 1
fi

DB_protein_ID=$1
query_protein_ID=$2

fetch_and_create_db "$DB_protein_ID"
perform_blast "$DB_protein_ID" "$query_protein_ID"
