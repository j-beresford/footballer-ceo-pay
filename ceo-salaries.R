rm(list=ls())

library(rvest)
library(dplyr)
library(stringr)
library(ggplot2)


url<-"https://cglytics.com/2019-ceo-pay-review-the-top-50-highest-paid-ceos-2/"


h<-read_html(url)

t<- h %>% html_nodes("table")

tab <- t %>% html_table

tab<-as.data.frame(tab)
names(tab)<-as.character(tab[1,])
tab<-tab[-1,]

ceo_pay<-tab%>%
  select(-`TSR in %`, -Ranking, -`TSR 1YR growth in
%point`)

names(ceo_pay)<-c("name", "firm", "granted_compensation", "realised_compensation")

pattern<- "\\s*\\([^\\)]+\\)"

ceo_pay<-ceo_pay%>%
  mutate(granted_compensation=str_remove(granted_compensation, pattern))%>%
  mutate(realised_compensation=str_remove(realised_compensation, pattern))%>%
  mutate(granted_compensation=str_remove_all(granted_compensation, ","))%>%
  mutate(realised_compensation=str_remove_all(realised_compensation, ","))%>%
  mutate(granted_compensation=str_remove_all(granted_compensation, "\\$"))%>%
  mutate(realised_compensation=str_remove_all(realised_compensation, "\\$"))

ceo_pay[,3:4]<-lapply(ceo_pay[,3:4], as.numeric)


ceo_pay%>%
  ggplot(aes(realised_compensation))+
  geom_histogram(bins = 20)+
  scale_x_continuous(labels=comma)+
  theme_minimal()+
  labs(x="Granted Compensation", 
       y="Number of CEOs", 
       title="Distribution of CEO wages)")

