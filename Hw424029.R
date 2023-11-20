# R script for this HW; given that I am asked to make 3 graphs

library(tidyverse)
library(ggpmisc)
library(dplyr)
library(tidyverse)
library(tinytex)
library(usethis)
library(lmtest)
library(car)
library(rsq)
library(leaps)
library(ggrepel)

color <- read.csv("Datasets/color.csv") %>% as_tibble()

colorb <- subset(color,sub=="Beet Juice")
colorb

colorbmax <- colorb %>%
  group_by(pH) %>%
  filter(abs == max(abs))
colorbmax

ggplot(colorb,aes(x=wv,y=abs))+
  geom_point(aes(color=factor(pH))) +
  geom_vline(aes(xintercept=520)) +
  geom_text_repel(data = max_df, aes(x = wv, y = abs, color=factor(pH), label = paste(wv, abs, sep = ", ")), vjust = 3)+

  labs(
    title=paste("Figure 1: Absorbance of Beet Juice by pH"),
    subtitle = paste("By Jerry Yu")
  ) + 
  ylab("Absorbance")+
  xlab("Wavelength")

colorp <- subset(color,pH=3.5)
colorp

ggplot(colorp,aes(x=wv,y=abs))+
  geom_point(aes(color=sub)) +
  
  labs(
    title=paste("Figure 2: wavelength vs absorption for all pigments at pH 3.5 "),
    subtitle = paste("By Jerry Yu")
  ) + 
  ylab("Absorbance")+
  xlab("Wavelength")

cheat <- read.csv("Datasets/c-heat.csv") %>% as_tibble()
cheat

ggplot(cheat,aes(x=Heat,y=Abs))+
  geom_point(aes(color=Sub)) +
  labs(
    title=paste("Figure 3: Heating Time vs Absorbance Value for FD&C Red 40 /n and Cochineal Extract"),
    subtitle = paste("By Jerry Yu")
  ) + 
  ylab("Absorbance")+
  xlab("HEating Time (min)")
