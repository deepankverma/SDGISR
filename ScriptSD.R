# Reading Shapefile into R  

library(rgdal)
map1 <-readOGR (dsn = ".", "4ZONES_TR")
## summary(map1)

library(ggplot2)
## p <-ggplot(map1@data, aes(a1,a2))
## p + geom_point()

# Fortifying with a2, Map showing according to a1
map1.f <-fortify(map1, region = "a2")
map1.f <-merge(map1.f, map1@data, by.x = "id", by.y = "a2")
head (map1.f)
finalmap <-ggplot(map1.f, aes(long, lat, group=group, fill= a3))+geom_polygon()+coord_equal()
ggtitle ("Trialmap")
finalmap

#Reading Xls data from Stella

library(XLConnect)
wk = loadWorkbook("Trialexport.xls")
df = readWorksheet(wk, sheet = "Sheet1")

#Reading data from shapefile attribute table as dbf 

library(foreign)
dbfdata <-read.dbf("4ZONES_TR.dbf")

#Extracting data from excel file from Stella according to Zones

dfZ1 <- df[1, 4:6]
dfZ2 <- df[1, 7:9]
dfZ3 <- df[1, 10:12]
dfZ4 <- df[1, 13:15]

#Making heads same for the dbf coloumn swap function to work

names(dfZ2) <- names(dfZ1)
names(dfZ3) <- names(dfZ1)
names(dfZ4) <- names(dfZ1)

dfZ <- rbind(dfZ1,dfZ2, dfZ3, dfZ4)

# rewriting dbf data of shapefile

dbfdata$a1 <- dfZ[1:4,1]
dbfdata$a2 <- dfZ[1:4,2]
dbfdata$a3 <- dfZ[1:4,3]

dbfdata

# Replacing original dbf in the shapefile

write.dbf (dbfdata,"4ZONES_TR.dbf")

# New map plotting

finalmap

