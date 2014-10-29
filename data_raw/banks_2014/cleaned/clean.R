require(gdata)
require(reshape2)
require(ggplot2)
require(zoo)

setwd("~/Dropbox/Data General/banks_2014")

df<-read.xls("CNTSDATA.xls")
df<-subset(df, code!="16524")

df$guerilla<-df$domestic3
df$overall.conflict<-df$domestic9
df$riots<-df$domestic6
df$strikes<-df$domestic2
df$demos<-df$domestic8
df$assassinations<-df$domestic1

df$internet<-df$computer4*.000001  # internet users per capita
df$computers<-df$computer6*.0001  # PCs per capita

df$radios<-df$media2*.0001
df$tvs<-df$media4*.00001
df$newspapers<-df$media5*.0001

df$landlines<-df$phone4*.00001
df$mobiles<-df$phone5*.00001

df$industry<-df$industry4*.1 #percent working in industry

df$oecd<-ifelse(df$country=="Austria" |
                  df$country=="Belgium" |
                  df$country=="Canada" |
                  df$country=="Denmark" |
                  df$country=="France" |
                  df$country=="Belgium" |
                  df$country=="German FR" |
                  df$country=="Greece" |
                  df$country=="Iceland" |
                  df$country=="Ireland" |
                  df$country=="Italy" |
                  df$country=="Luxembourg" |
                  df$country=="Netherlands" |
                  df$country=="Norway" |
                  df$country=="Portugal" |
                  df$country=="Spain" |
                  df$country=="Sweden" |
                  df$country=="Switzerland" |
                  df$country=="Turkey" |
                  df$country=="United Kingdom" |
                  df$country=="United States",
                "OECD", "Non-OECD")

write.csv(subset(df, oecd=="OECD"), file="cleaned/oecd.csv")

write.csv(subset(df, select=c("country", "year", "Wbcode", "oecd", "guerilla", "overall.conflict", "riots", "strikes", "demos", "assassinations",
                              "internet", "computers", "radios", "tvs", "newspapers", "landlines", "mobiles")), file="cleaned/media_politics.csv")


