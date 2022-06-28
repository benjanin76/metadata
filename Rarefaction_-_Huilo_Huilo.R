---
title: "Rarefaction - Huilo Huilo"
author: "Ben Matz"
date: '2022-06-28'
---
  
#Load library, read csv file, initialize variables
phototag <- read.csv("/Users/benmatz/Box/Duke/DukeEngage/ForCSV2.csv")
numUniq = length(unique(phototag$Species))
dateUnique = vector("numeric", numUniq)
speciesUnique = vector("numeric", numUniq)
k = 1
j = 1

#Convert date to numeric type
phototag$Date <- as.Date(phototag$Date, "%m/%d/%Y",)

#Accumualate dates where a new species was discovered
while(k < count(phototag)[[1]]){
  date <- phototag$Date[k]
  spec <- phototag$Species[k]
  if(!(spec %in% speciesUnique)){
    #Initialize day zero
    if(j == 1){
      dateUnique[j] = date
      speciesUnique[j] = spec
    }
    else{
      dateUnique[j] = date - dateUnique[1]
      speciesUnique[j] = spec
    }
    j = j + 1
  }
  k = k+1
}
#Zero day zero
dateUnique[1] = 0

#Create vector [1, 2, 3,..., number of unique species]
num = vector("numeric", length(dateUnique))
n = 1
while(n <= length(dateUnique)){
  num[n] = n
  n = n + 1
}
#Create plot
plot(dateUnique,num, type = 'l', xlab = 'Days Since First Species', ylab = 'Number of Unique Species')