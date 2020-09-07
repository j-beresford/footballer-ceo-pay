source("footballer_dataviz.R")
source("ceo_salaries.R")

# Run footballer and CEO scripts, and compare distributions

print(p)
print(c)

ceo<-ceo_pay%>%
  select(-firm, -granted_compensation)%>%
  rename(pay=realised_compensation)%>%
  mutate(job="CEO")


footballers<-wages%>%
  select(-Position, -Age, -WeeklySalary)%>%
  rename(name=Player)%>%
  rename(pay=AnnualSalary)%>%
  mutate(job="Footballer")

all<-bind_rows(ceo, footballers)


all%>%
  ggplot(aes(pay))+
  geom_histogram(bins = 100)+
  scale_x_continuous(labels=comma)+
  facet_grid(rows = vars(job))+
  labs(x="Earnings", y="Number of earners")
