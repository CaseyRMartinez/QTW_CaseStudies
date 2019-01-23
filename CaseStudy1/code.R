
data = readLines('C:/Users/Martinez/Dropbox/SMU_DataScience/MSDS_7333_QuantifyingTheWorld/Homework/CaseStudy1/offline.final.trace.txt')


record = strsplit(data[4], ";")[[1]]

strsplit(record, "=")[[1]]

strsplit(record, ",")

