source("player_wages.R")

library(ggplot2)
library(scales)

wages<-wages_table%>%
  select(-empty)%>%
  filter(AnnualSalary!="-")%>%
  mutate(AnnualSalary=str_remove_all(AnnualSalary,"£"))%>%
  mutate(AnnualSalary=str_remove_all(AnnualSalary,","))%>%
  mutate(AnnualSalary=as.numeric(AnnualSalary))%>%
  mutate(WeeklySalary=str_remove_all(WeeklySalary,"£"))%>%
  mutate(WeeklySalary=str_remove_all(WeeklySalary,","))%>%
  mutate(WeeklySalary=as.numeric(WeeklySalary))


p<-wages%>%
  ggplot(aes(AnnualSalary))+
  geom_histogram(bins = 100)+
  scale_x_continuous(labels=comma)+
  theme_minimal()+
  labs(x="Annual Salary", 
       y="Number of players", 
       title="Distribution of player wages)")

print(p)
