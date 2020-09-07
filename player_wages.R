library(rvest)
library(dplyr)
library(stringr)
library(ggplot2)

site<-"https://www.spotrac.com/epl"
page<-"payroll/"

team<-c("arsenal-fc", "aston-villa-fc", "brighton-hove-albion", "burnley-fc", 
        "chelsea-fc", "crystal-palace", "everton-fc", "fulham-fc", "leeds-united-fc",
        "leicester-city", "liverpool-fc", "manchester-city-fc", "manchester-united-fc",
        "newcastle-united-fc", "sheffield-united-fc", "southampton-fc",
        "tottenham-hotspur-fc", "west-bromwich-albion-fc", "west-ham-united-fc",
        "wolverhampton-wanderers-fc")


urls<-paste(site, team, page, sep="/")


h<-lapply(urls, read_html)
names(h)<-team

table_maker<-function(t){
  t <- t %>% html_nodes("table")
  t <- t[[1]]%>% html_table
  }

t<-lapply(h, table_maker)

names(t)<-team

names(t[[1]])

t<-lapply(t, setNames, c("Player", "Position", "Age", "empty", 
                         "AnnualSalary", "WeeklySalary"))


wages_table<-do.call(bind_rows, t)

  




