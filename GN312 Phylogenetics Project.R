
library(tidyverse)
library(broom)
library(phyloseq)
library(DAtest)
library(vegan)
library(DESeq2)
library(ALDEx2)

Salt <- read.delim("Datasets/Salt.txt",header=TRUE,sep="\t") %>% tibble()
Salt

# create a grouped bar plot
ggplot(Salt, aes(x = taxon_name, y = percent, fill = file)) +
  geom_bar(position = "dodge", stat = "identity") +
  labs(x = "Taxon ID", y = "Percent", fill = "Treatment")


SaltDE <- select(Salt,c("file","reads","taxon_name"))

SaltDE

SaltDEwide <- pivot_wider(SaltDE,names_from = file,values_from = reads)
SaltDEwide %>% print(n=30)

saltDEexp <- SaltDEwide[c(-21,-22,-23),] %>%   remove_rownames %>% 
  column_to_rownames(var="taxon_name")

saltDEexp <- na.omit(saltDEexp)
saltDEexp

DESeq2::DESeq(saltDEexp)



coldata <- tibble("condition"=c("Control0","HighSalt6","LowSalt6","Control6")) %>%   column_to_rownames(var="condition") %>% add_column("condition"=c("Control0","HighSalt6","LowSalt6","Control6")) 
coldata$condition <-  as.factor(coldata$condition)
coldata
DESeq2::design(coldata) <- ~1+condition


saltDEexpdds <- DESeq2::DESeqDataSetFromMatrix(countData = saltDEexp,
                                       colData = coldata,
                                       design = ~1+condition)

DESeq2::DESeq(saltDEexpdds)
saltDEexpdds
conds <- c("C0","H6","S6","C6")

conds

aldex(saltDEexp, conds, mc.samples=128, test="kw", effect=TRUE, include.sample.summary=FALSE, verbose=FALSE)

help(aldex)

print(SaltDEwide,n=30)


## Graph###

Salt <- read.delim("Datasets/Salt.txt",header=TRUE,sep="\t") %>% tibble()

SaltS <- Salt %>%
  filter(!(taxon_name %in% c("cannot be assigned to a (non-viral) species", "unclassified", "belong to a (non-viral) species with less than 0.5% of all reads")))

# create a grouped bar plot
saltp <- ggplot(SaltS, aes(x = taxon_name, y = percent, fill = file)) +
  geom_bar(position = "dodge", stat = "identity") +
  scale_fill_manual(values = c("#7D9150", "#FD9A38", "#889DA2","#DC644B"))+
  theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1,size=14,color=
                                     "black"),
        axis.title.y = element_text(size=20),
        title = element_text(size=20),
        legend.text = element_text(size=14),
        plot.margin = margin(.5, .5, .5, 2, "cm"),
        plot.background = element_rect(fill = "transparent", colour = NA),
        panel.background = element_rect(color="#EDD9D3"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major = element_line(color="black",linetype = "dashed")
        #panel.grid.minor = element_line(color="black",linetype = "dotted")
        )+
  labs(x = "Taxon ID", y = "Percent of Reads", fill = "Starter Type",title =paste("Figure 1: Different Percent Abundances of Reads at the Species Level for 4 Different \n Sourdough Cultures Grown at Different Salt Levels and Times" ))

saltp
# Save the plot with a transparent background
ggsave("Sourdough1.png", plot = saltp, width = 14, height = 8, bg = "transparent")
