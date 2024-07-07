esearch -db protein -query "ABP49492" | efetch -format fasta > ABP49492.fasta
makeblastdb -in ABP49492.fasta -dbtype prot -out ABP49492_db
esearch -db protein -query "BDP39085" | efetch -format fasta > BDP39085.fasta
blastp -db ABP49492_db -query BDP39085.fasta -out result.out -outfmt 7
cat result.out
