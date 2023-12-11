install.packages("ggplot2")
install.packages("ggpmisc")
install.packages("dplyr")
install.packages("tidyverse")
install.packages("tinytex")
install.packages("usethis")
install.packages("lmtest")
install.packages("car")
install.packages("leaps")
install.packages("ggrepel")
# phylogenetics
install.packages("broom")
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("phyloseq")
install.packages("DAtest")
install.packages("vegan")
install.packages("DESeq2")
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ALDEx2")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2")