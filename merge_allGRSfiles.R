library (data.table)
files = list.files (pattern = "^grs")
listOfFiles <- lapply(files, function(x) read.table(x, header = TRUE)) 
A=Reduce(function(dtf1, dtf2) merge(dtf1, dtf2, by = "id", all.x = TRUE),
        listOfFiles)

rownames(A) = A$id
A$id = NULL
A$GRS = rowSums(A)
A$sample = rownames(A)
a1 = subset (A, select =c(sample,GRS))
write.table(a1, "GRS_score", sep = "\t", quote=FALSE, row.names=FALSE)


