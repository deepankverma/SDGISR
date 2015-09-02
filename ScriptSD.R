
library(rgdal)
map1 <-readOGR (dsn = ".", "4ZONES_TR")
summary(map1)
library(ggplot2)
p <-ggplot(map1@data, aes(a1,a2))
p + geom_point()
map1.f <-fortify(map1, region = "a2")
map1.f <-merge(map1.f, map1@data, by.x = "id", by.y = "a2")
head (map1.f)
finalmap <-ggplot(map1.f, aes(long, lat, group=group, fill= a1))+geom_polygon()+coord_equal()
ggtitle ("Trialmap")
finalmap

#Reading Xls data from Stella

library(XLConnect)
wk = loadWorkbook("Trialexport.xls")
df = readWorksheet(wk, sheet = "Sheet1")
head(df)

foreign::read.dbf(file.choose())

