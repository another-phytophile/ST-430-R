library(ggplot2)
library(ggpmisc)
library(dplyr)
library(tidyr)
library(here)
library(tidyverse)
library(tinytex)
library(usethis)
library(lmtest)
library(car)

# 1.	For Experiment 1, make a figure of:  Unheated Turbidity and Heated Turbidity before centrifugation (O.D. 500 nm, Y-axis) vs. pH (X-axis) (Figure 1).  Use this figure to determine the isoelectric point (based on maximum aggregation).

L5 <- as_tibble(read.csv("Datasets/lab5fs402.csv"))
L5t <- pivot_longer(L5,cols=-pH)

L5t <- pivot_longer(L5,cols=-pH) %>% rename(,State=name)

L5t1 <- subset.data.frame(L5t,State!="heated.turbidity.with.centrifuge")
L5t2 <-  subset.data.frame(L5t,State!="unheated.turbidity")

ggplot(L5t1,aes(x=pH,y=value))+
  geom_jitter(aes(color=State))+
  labs(title=paste("Figure 1:Optical Density of Whey Protein at Different pHs and Different Heat Treatments"))+
  ylab("O.D. 500 nm")

ggplot(L5t2,aes(x=pH,y=value))+
  geom_jitter(aes(color=State))+
  labs(title=paste("Figure 2:Optical Density at Different pHs With and Without Centrifugation"))+
  ylab("O.D. 500 nm")

L5t3 <- subset.data.frame(L5t,State=="unheated.turbidity")

ggplot(L5t3,aes(x=pH,y=value))+
  geom_jitter(aes(color=State))+
  labs(title=paste("Table 2:Optical Density at Different pHs With and Without Centrifugation"))+
  ylab("O.D. 500 nm")

citation("tidyverse")

