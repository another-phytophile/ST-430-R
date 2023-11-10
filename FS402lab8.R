coffee <- read.csv("Datasets/Lab7fs402.csv") %>% as_tibble()

coffee

ggplot(coffee,aes(x=Extraction,y=Abs,fill=Roastlvl)) +
  geom_bar(stat="identity", position=position_dodge())+
  labs(
    title=paste("Figure 1: Melanoidin amount by Roast Level and Extraction Method"),
    subtitle = paste("By Jerry Yu")
  ) + 
  ylab("Absorbance at 400 nm")
