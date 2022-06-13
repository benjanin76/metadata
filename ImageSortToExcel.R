#Please make four folders named "Animals", "Bugs", "Duplicates", "NoAnimals" inside of one bigger folder named "z_" with the blank being the number of your folder
#wd should be whatever folder your files are in so change the below variable ie. "/Users/benmatz/Desktop/z4"
wd = "__"
inDir = file.path(wd) 
outDir = file.path(wd)
setwd(wd)

#Installs necessarey packagesse
install.packages(c("knitr", "exifr", "dplyr", "leaflet"))
library("knitr")
library("exifr")
library("dplyr")
library("leaflet")

#Iterate through folders to extract metadata and create dataframe
folders = list.files(wd)
allData = data.frame()
for(i in folders){
  setwd(paste(wd,"/", i, sep = ""))
  files = list.files(pattern = "(*).JPG")
  cols = c("FileName","DateTimeOriginal", "Make", "Model", "ShutterSpeed", "TagsList")
  data = read_exif(files, tags = cols)
  data[, "Container"] = i
  #For untagged photos, this adds an "N/A" tag
  if(length(data)==7){
    data[, "TagsList"] = "N/A"
  }
  allData = rbind(allData, data)
}
#Change date separators from colons to slashes
for(x in allData[3]){
  x <- (sub(":", "/", x))
  x <- (sub(":", "/", x))
}
allData[3] = x
#If you have one camera, fill in the quotes with the camera number ie. "CT19". Otherwise, leave it blank and come to me
allData[, "Station"] = "__"
# Fill in blank with z# ie. "z4.csv" and uncomment line below once we check that your dataframe looks good to save the dataframe as a .csv file
write.csv(allData, "__.csv")
