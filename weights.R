library(data.table)
a = fread ("snplist_michig37")
a$names = paste0("chr",a$V1,":",a$V2)
a1 = subset (a, select = c(names,V3,V4,V5))
a1 = as.data.frame(a1)
colnames(a1) =NULL
write.table (a1, "weights",sep = "\t", row.names=FALSE, quote = FALSE)
