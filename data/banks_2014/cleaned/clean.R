require(gdata)
require(reshape2)
require(ggplot2)
require(zoo)
require(WDI)

setwd("~/Dropbox/gh_projects/pacification_of_the_world/data/banks_2014")

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
df$mdi<-rowMeans(subset(df, select=c("tvs", "newspapers", "radios"), na.rm=FALSE))*100 

df$landlines<-df$phone4*.00001
df$mobiles<-df$phone5*.00001

df$industry<-df$industry4*.1 #percent working in industry

wdi<-WDI(country = "all", extra=TRUE)
wdi$Wbcode<-wdi$iso3c

df<-merge(df, wdi[c("Wbcode", "region")],  by=c("Wbcode"), all.x=TRUE)
df<-unique(df)
df<-df[with(df, order(country, year)), ]
df$region<-gsub("\\(all income levels\\)", "", df$region)
df$region[is.na(df$region)] <- "Other"
df$region<-as.factor(df$region)

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

write.csv(subset(df, select=c("country", "year", "Wbcode", "region", "oecd", "guerilla", "overall.conflict", "riots", "strikes", "demos", "assassinations",
                              "internet", "computers", "radios", "tvs", "newspapers", "mdi", "landlines", "mobiles")), file="cleaned/media_politics.csv")


