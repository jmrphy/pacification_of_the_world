require(foreign)
require(ggplot2)
require(plyr)
require(reshape2)

df<-read.dta("data_raw/dynamics_collective_action/final_data_v10.dta")

summary(df$rptyy)       # what year?
summary(df$days)        # how many days did it last?
summary(as.factor(df$where))    # where did it occur?
summary(as.factor(df$purpose))  # purpose of the protest
summary(df$page)  # page number
summary(df$particex)  # number of participants reported
summary(df$partices)  # number of participants estimated
summary(df$groups)  # number of initiating groups
summary(df$igrp1c1)  # 1st characteristic of initiating group 1
summary(df$igrp2c1)  # 1st characteristic of initiating group 2
summary(df$igrp3c1)  # 1st characteristic of initiating group 3

summary(df$igrp1c2)  # 2nd characteristic of initiating group 1
summary(df$igrp2c2)  # 2nd characteristic of initiating group 2
summary(df$igrp3c2)  # 2nd characteristic of initiating group 3

summary(df$targd)  # clearly identifiable target?
summary(df$targnum)  # number of them
summary(df$targnum)  # was violence used?

summary(df$police4)  # violence used by police?
summary(df$propdam)  # property damage reported?

### Make time-series of protests reported each year
years<-subset(df, select=c("rptyy"))  # subset to year only
years <- count(years, c('rptyy'))     # aggregate to yearly counts

ggplot(years, aes(x=rptyy, y=freq)) +
  geom_point() +
  stat_smooth(se=FALSE, span = 0.5) +
  theme_bw() +
  ggtitle("Number of Protests Reported by New York Times, 1960-1995") +
  xlab("Year") +
  ylab("Number of Protests Reported")

### Make time-series of page priority reported each year
text<-subset(df, select=c("rptyy", "page"))  # subset to year only
text<-ddply(text, c("rptyy"), summarize, page = mean(page, na.rm=TRUE))  # aggregate to yearly counts
text$page<-max(text$page, na.rm=TRUE)-text$page

molt<-melt(text, id.vars="rptyy")
ggplot(molt, aes(x=rptyy, y=value)) +
  geom_line() +
  theme_bw() +
  ggtitle("Priority Given to Protest Reportage in the NYT, 1960-1995") +
  xlab("Year") +
  ylab("< Appearances Toward the Back | Appearances Toward the Front >")

### Make time-series of protest size reported each year
alliances<-subset(df, select=c("rptyy", "groups"))  # subset to year only
alliances<-ddply(alliances, c("rptyy"), summarize, groups = mean(groups, na.rm=TRUE))  # aggregate to yearly counts

molt<-melt(alliances, id.vars="rptyy")
ggplot(molt, aes(x=rptyy, y=value)) +
  geom_line() +
  theme_bw() +
  ggtitle("Number of Different Social Groups Protesting Together, 1960-1995") +
  xlab("Year") +
  ylab("Mean Number of Social Groups")

  





