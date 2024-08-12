#Insalling and importing packages
install.packages("tidyverse")
library(tidyverse)
install.packages("ggpubr")
library("ggpubr")



#Imported datasets that will be used for analysis namely (dailyActivity) and (hourlytracker)

colnames(dailyActivity) # Preview column column names to emsure all colims imported

str(dailyActivity) #Preview dtails of daily activity

#we want to chek the relationship between total steps taken, distance travelled and calories burned
ggplot(data=dailyActivity, aes(x=TotalSteps,y=Calories))+geom_point()+geom_smooth() +
  geom_jitter() +
  labs(title = "TotalSteps vs Calories")

#I want to check the relationship between SedentaryMinutes/innactivity and calories burned
ggplot(data=Merge_sleep_Activity, aes(x=SedentaryMinutes,y=Calories))+geom_point()+geom_smooth() 

#Want to find out what are the busiest times of day
hr_tracker_new <- hourlytracker%>%
  group_by(time) %>%
  drop_na() %>%
  summarize(average_steps = mean(hourlyStepsTotal))

ggplot(data= hr_tracker_new, aes(x=time, y=average_steps)) + geom_histogram(stat = "identity", fill='darkblue') +
  theme(axis.text.x = element_text(angle = 90)) + 
  labs(title="Average Steps / Hr. vs. Time")

ggplot(data=Sleep, aes(x=TotalMinutesAsleep,y=TotalTimeInBed))+geom_point()+geom_smooth()


ggplot(data=hourlytracker, aes(x= TotalIntensity, Calories))+geom_point()+geom_smooth() +
  geom_jitter() +
  labs(title = "TotalIntensity vs Calories")

hr_tracker_new <- hourlytracker%>%
  drop_na() %>%
  summarize(average_intensity = mean(TotalIntensity))

ggplot(data=hourlytracker, aes(x= average_intensity, Calories))+geom_point()+geom_smooth() +
  geom_jitter() +
  labs(title = "Average Intensity vs Calories")

hr_tracker_new <- hourlytracker %>%
  drop_na() %>%
  summarize(average_intensity = mean(TotalIntensity))

ggplot(data = hourlytracker, aes(x = average_intensity, y = Calories)) +
  geom_point() +
  geom_smooth() +
  geom_jitter() +
  labs(title = "Average Intensity vs Calories")

ggplot(data=hourlytracker, aes(x= AverageIntensity, Calories))+geom_point()+geom_smooth()
