wd = getwd()
setwd(wd)

# install.packages('readxl')
library('readxl')
data = read_excel("../../Sl-VI DataSets/Online Retail.xlsx")
data

data$Quantity <- replace(data$Quantity,data$Quantity < 0,0)
# COnsider a subset

# subset 1 is of 1000 rows, with col no. 1 2 4 and 6
subset1 <- data[c(1:1000),c(1,2,4,6)]
subset1

# subset2 <- data[c(1:1000),c(1,2,6,7)]

subset1 <- subset1[order(subset1$Quantity),]
t(subset1)

library(reshape2)

# sort the dataframe as per Customer ID
data <- data[order(data$CustomerID),]
data  # inspect the data

# Melt the subset 1 in long format as per Invoice n quantity
melt1 <- melt(subset1, id <- c("InvoiceNo","Quantity"))
melt1

# sort the melted data as per quantity and then invoice
melt1 <- melt1[order(melt1$Quantity,melt1$InvoiceNo),]
melt1

# cast into Wide format
melt2 <- dcast(melt1,Quantity + InvoiceNo ~ variable,value.var = "value")
melt2
