## ---- start 
 # @knitr Install ----
list.of.packages <- 
  c(
    "leaps",
    "knitr",
    "stargazer",
    "corrplot",
    "ppcor",
    "magrittr",
    "Hmisc" ,
    "tidyverse",
    "maps",
    "readxl",
    "car",
    "plotly",
    "caret",
    "broom"
  )

new.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]

if (length(new.packages))
  install.packages(new.packages, repos = "http://cran.us.r-project.org", dependencies = TRUE)


library(leaps) #stepwise regression functions regsubsets()
library(stargazer)  #beautifies regression tables
library(corrplot)   #correlation plots /  this package interferes with "select"dplyr
library(ppcor) #Calculates parital correlations along with p value with function 'pcor'
library(Hmisc) #for the 'rcorr' function
library(tidyverse)  #ggplot, dplyr
library(maps)  #helps map out USA in ggplot
library(readxl)     #reads the excel file
library(knitr) #for kable-tables
library(magrittr)   # for piping %>% functions
library(car)  #for VIF function
library(plotly) #plotly not working
library(caret) #multiple models in Regression, Random Forests, Elastic Nets
library(broom) #for functions augment() for residuals and glance()/glimpse()

#rm(list.of.packages , new.packages)  #clean out global environment since we're done here

 # @knitr ReadFile -----------
#important!! this is based on the current file I received from Capt Benson, if the source file changes which it certainly will with more data, this currently chops off the rows at 513 and assumes the structure in Bensons' file stays the same.  if it doesn't then everything following will not work. 
 


dataSource <-
  readxl::read_excel(
    "./inst/apps/dataSource.xlsx",
    sheet = "CONUS Data",
    col_types = c(
      "skip",
      siteID = "text",
      Season = "text",
      "skip",
      "text",
      "skip",
      rep("numeric", 245)
    ),
    skip = 2,
    n_max = 513
  )


dataSource <- as.data.frame(dataSource)  # made stargazer work!
dataSource <- na.omit(dataSource)

#@knitr Tidy -------


#rescoping dataset to get rid of   City data based on above graph (2 rows)
#dataSource <- dataSource[dataSource$park != "CITY", ]


## MUWO Outlier Decision:
# I considered getting rid of MUWO Site1 data since there was a huge fluctuation between two identical sites and nothing changed except year but then ultimately decidede to keep it in because it was probably realistic phenomenon rather than an outlier
# dataSource <- dataSource[dataSource$siteID != "MUWO001",]
# I wonder if the MUWO01 L90 and L10 levels were flipped for that one season??


#get rid of the UrbanHigh200m column which only contains 0s
#dataSource <- dataSource[, names(dataSource) != "UrbanHigh200m"]

 #get rid of the UrbanHigh200m column which only contains 0s
#dataSource <- dataSource[, names(dataSource) != "UrbanLow5km"]

#get rid of the Industrial column which only has 2 values
#dataSource <- dataSource[, names(dataSource) != "Industrial200m"]

#mixed feelings about leaving in the noise floor variable?
#dataSource <- dataSource[, names(dataSource) != "ndBA"]
#
#get rid of the LDN column which  has 5 missing values in approx rows 513
#dataSource <- dataSource[, names(dataSource) != "Ldn"]
# we're not studying these y-values value at the moment

#OUTLIERS
#Loud NOCA008 values
#dataSource[dataSource$siteID=="NOCA008",]=NA
#dataSource <- na.omit(dataSource)



#ZERO-wind values

zero_wind_values <- dataSource[dataSource$Wind_CRU == 0,]
# saveRDS(object = zero_wind_values, file = "zerowindvalues")

dataSource[dataSource$Wind_CRU == 0,"Wind_CRU"] =4.7
#   dataSource <- na.omit(dataSource)
  
#   
# print("The following 22 sites had zero values for wind, which were far different than the rest of the values.")
# print("CAHA002, CALO001, EVER001, EVER006, GOGA001, GOGA003, GOGA004, GOGA005, GUIS001, GUIS002, GUIS003, WRBR001, WRBR002")


#if (impute == FALSE) {
# there are five missing values in the LDN column from Winter  513->508 already taken care of
#dataSource <- na.omit(dataSource)
#}
#



zeroL90values <- dataSource[dataSource$L90f1 == 0,]

# saveRDS(zeroL90values, file = "zeroL90values")

# # -------------------------------------------------- # # ------ Imputing values for zero-sound values
 # @knitr  Impute ----------
dataSource <- dataSource %>%
  mutate(L90f1 = ifelse(dataSource$L90f1 != 0, L90f1, (L90f3 + 2)))

dataSource <- dataSource %>%
  mutate(L90f2 = ifelse(dataSource$L90f2 != 0, L90f2, (L90f3 + 1)))

dataSource <- dataSource %>%
  mutate(L50f1 = ifelse(dataSource$L50f1 != 0, L50f1, (L50f3 + 2)))

dataSource <- dataSource %>%
  mutate(L50f2 = ifelse(dataSource$L50f2 != 0, L50f2, (L50f3 + 1)))

dataSource <- dataSource %>%
  mutate(L10f1 = ifelse(dataSource$L10f1 != 0, L10f1, (L10f3 + 2)))

dataSource <- dataSource %>%
  mutate(L10f2 = ifelse(dataSource$L10f2 != 0, L10f2, (L10f3 + 1)))

 
scaled <- dataSource %>%  select(starts_with("Dist")) %>% names()
dataSource %<>% mutate_at(.vars=scaled, .funs=funs((.)/1000))
#UPDATED these vars:
# [1] "DistAirportsAllMotorized" "DistAirportsSeaplane"     "DistCoast"               
# [4] "DistHeliports"            "DistHighAirports"         "DistLowAirports"         
# [7] "DistMilitary"             "DistModerateAirports"     "DistRailroads"           
# [10] "DistRoadsAll"             "DistRoadsMajor"           "DistStrahlerCalgt1"      
# [13] "DistStrahlerCalgt3"       "DistStrahlerCalgt4"       "DistStreamsAny"          
# [16] "DistWaterbody"  
 

dataSource$Wilderness <- dataSource$Wilderness/1000
dataSource$FlightFreq25Mile <- dataSource$FlightFreq25Mile/1000 

#which.min(dataSource$FlightFreq25Mile) results in "ORPI003" with "55" flightfreq in 25 miles


# Correcting proportions and percentage values less than zero and greater than 1
 # How many of these variables have 0s' or less than 0's in their fields?
# uPDATED JAN 22 - if run after taking away the near-zero-value columns the comment annotations will not be true any more

negativeVariables200m <-
  dplyr::select(dataSource, contains("200m")) %>%
  keep(is.numeric) %>%
  gather() %>%
  group_by(key) %>%
  summarize(min = min(value)) %>%
  filter(min < 0)  

negVars <- (negativeVariables200m$key) 
negSiteIDs <- dataSource  %>% filter_at(vars(negVars), any_vars(.<0)) %>% 
  select("siteID")



# 15 of the 31 200m Variables have negative values!  Most appear to be Land Use category
# saveRDS(object = negativeVariables200m$key, file = "negativeVariables200m")


negativeVariables5km <-
  dplyr::select(dataSource, contains("5km")) %>%
  keep(is.numeric) %>%
  gather() %>%
  group_by(key) %>%
  summarize(min = min(value)) %>%
  filter(min < 0)

#NONE of the 36 5km variables have a value less than ZERO
# saveRDS(object = negativeVariables5km$key, file = "negativeVariables5km")


# dataSource %>%
#      keep(is.numeric) %>%
#      gather() %>%
#      group_by(key) %>%
#      summarize(min = min(value)) %>%
#      arrange(min) %>%
#      filter(min < 0)

# TDEWAvgWinter, TDEWNorms, TDEWAvgSummer, TPIRaw, TAVGWinter, PopDensity_2010_50km,
#   TAVGNorms, DistWaterbody, Slope

greaterThanOneVariables200m <-
  dplyr::select(dataSource, contains("200m")) %>%
  keep(is.numeric) %>%
  gather() %>%
  group_by(key) %>%
  summarize(max = max(value)) %>%
  filter(max > 1)

# 9 of the 31 200m Variables have greater than 1.0 values!  They were mostly the LandUSE types:
# RecCon200m	1.0756200
# Built200m	1.0642860
# Cropland200m	1.0642860
# Extractive200m	1.0642860
# Grazing200m	1.0642860
# Park200m	1.0642860
# WaterHum200m	1.0642860
# WaterNat200m	1.0642860
# Institutional200m 1.0283760
# saveRDS(object = greaterThanOneVariables200m$key, file = "greaterThanOneVariables200m")


greaterThanOneVars <- (greaterThanOneVariables200m$key) 
greaterOneSiteIDs <- dataSource  %>% filter_at(vars(greaterThanOneVars), any_vars(.>1)) %>% 
  select("siteID")



# "3.1), LU data infers the degree of human usage on the respective land cover types. Land use data is expected to help measure potential anthrophony noise resulting from human use activities ranging from natural to urban environments. In particular the LU dataset measures land use activities related to the extractive industry and varying levels of the human built environment." (Sherrill GIS Metrics - Soundscape Modeling 2012)


greaterThanOneVariables5km <-
  dplyr::select(dataSource, contains("5km")) %>%
  keep(is.numeric) %>%
  gather() %>%
  group_by(key) %>%
  summarize(max = max(value)) %>%
  filter(max >= 1) %>%
  arrange(max) %>%
  filter(max < 500)

 

#8 of the 36 5km variables have a value GREATER than one!  FIVE of them seem like legit errors - the other three are for RDDWeightedValues which seem to be appropriate-- I filtered those out useing max<500
# saveRDS(object = greaterThanOneVariables5km$key, file = "greaterThanOneVariables5km")

#
#    dataSource %>%
#         keep(is.numeric) %>%
#         gather() %>%
#         group_by(key) %>%
#         summarize(min = min(value)) %>%
#         arrange(min)

# TDEWAvgWinter, TDEWNorms, TDEWAvgSummer, TPIRaw, TAVGWinter, PopDensity_2010_50km,
#   TAVGNorms, DistWaterbody, Slope

# Why would distance to waterbody be negative?
# why would the AVERAGE temperature be negative?
# why would the population density be negative?
# TPIRaw and Slope seem like they may have a plausible reason to be negative, sortof
#
# "The GeoTIFF Tile 1 for North and Central America was processed as follows. The source raster was re-projected to the Albers Equal Area USGS spatial reference from GCS WGS84, re-sampled (using cubic convolution) to 270m from 504m, and re-scaled to remove negative values created when raster was re-sampled. However, for Alaska, the 2013 data were resampled to 250m to conform to the Alaska land cover raster."

#Lisa Nelson, Michelle Kinseth, and Thomas Flowe, SOP, 2015, page 12.  So maybe because it was from 504 meters to 270 meters, that whoever changed it to 200m may had a computational error when going from 270 meters to 200 meters?

# Reason perhaps why distance to water is negative?
# Protected areas (national parks, wilderness, and GAP status areas) are excluded from population calculations. These features are source from the Protected Areas Database of the US (version 1.3; Gergely and McKerrow, 2013). And, the U.S. Census-reported area of water is subtracted as part of the NPScape density processing logic. Therefore, density values are adjusted for both protected area and water area. Population total is adjusted for protected area only.     #Lisa Nelson, Michelle Kinseth, and Thomas Flowe, SOP, 2015, Page 14



#The following variables had negative values or values greater than one when their definitions imply they need to be from zero to one.

# x = list("Negative Variables" = negativeVariables200m, "Greater Than One (200m)" = greaterThanOneVariables200m, "Greater than one (5km)" = greaterThanOneVariables5km)
# kable(x, row.names = FALSE )

# All wrongly negative now become zero (zero+0.01)
for (x in 1:nrow(negativeVariables200m)) {
  tmp <- negativeVariables200m$key[x]
  dataSource[, c(tmp)] <-
    dplyr::if_else(dataSource[, c(tmp)] <= 0, (0), dataSource[, c(tmp)])
}
rm(tmp, x)

# All wrongly greater than one (>100%) now become one (1-0.01) 0.99
for (x in 1:nrow(greaterThanOneVariables200m)) {
  tmp <- greaterThanOneVariables200m$key[x]
  dataSource[, c(tmp)] <-
    dplyr::if_else(dataSource[, c(tmp)] >= 1, (1), dataSource[, c(tmp)])
}
rm(tmp, x)
for (x in 1:nrow(greaterThanOneVariables5km)) {
  tmp <- greaterThanOneVariables5km$key[x]
  dataSource[, c(tmp)] <-
    dplyr::if_else(dataSource[, c(tmp)] >= 1, (1), dataSource[, c(tmp)])
}

 



 # @knitr  Substitute ------

x1Col <- which(colnames(dataSource) == "Barren200m")
x2Col <- which(colnames(dataSource) == "Wind_CRU")



#Replace all the X-variables that have a zero with 0.0000001
for (i in seq(from = x1Col, to = x2Col, by = 1)) {
  for (j in seq(from = 1,
                to = nrow(dataSource),
                by = 1))
    if (dataSource[j, i] == 0) {
      dataSource[j, i] <- (0.0)                #<-0.0000001
    }
}
# 
# print(" ~~~~~~~~~~~~~~~~~ ")
# print("  There are this many zeros in the data set: ")
# tmp <- sum(dataSource == 0)
# print(tmp)
# print(" ~~~~~~~~~~~~~~~~~ ")


rm(greaterThanOneVariables200m, greaterThanOneVariables5km, negativeVariables200m, negativeVariables5km, i , j )


 # In future Research insteadf of throwing away all the near-zero values (which would be done by Caret-RandomForests anyway) "http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.719.195&rep=rep1&type=pdf" "Modelling skewed data with many zeros: "A simple approach combining ordinary and logistic regression"  would be helpful to experiment with

nzv1 <- caret::nearZeroVar(dataSource, freqCut = 95/5, saveMetrics = TRUE, names = TRUE) %>%              rownames_to_column(var = "variable") %>%               
 dplyr::filter(nzv==TRUE) #%>% 
  # dplyr::arrange(desc(freqRatio)) %>% 
  # filter(freqRatio<200)# %>% 
  # #filter(percentUnique < 10) 

 
near_zero_columns <- nzv1[,"variable"]

# print("The following near-zero-variance variables were selected for removal: ")
# paste0(near_zero_columns, collapse = ", ")


# saveRDS(object = near_zero_columns, file = "nearZeroVariance") 
# In main file put this:
# near_zero_columns <- readRDS(file ="nearZeroVariance")
# print("The following near-zero-variance variables were selected for removal: ")
# paste0(near_zero_columns, collapse = ", ")




tmp <- setdiff( names(dataSource), near_zero_columns)
dataSource <- dataSource[, tmp]

#remove the most highly correlated variables to limit the dataset

#CAN MAKE THIS A FUNCTION WHEN LOOKIJNG AT L90F1:33 - {
x1Col <- which(colnames(dataSource)=="Elevation")
x2Col <- which(colnames(dataSource)=="Wind_CRU")
whole <- dataSource[, (x1Col:x2Col)]
whole <- whole[,colnames(whole) != "LCLUCI"]

correlationMatrix <- cor(whole)
cutoff = 0.75
# saveRDS(object = cutoff, file = "cutoff")

highlyCorr <- findCorrelation(correlationMatrix, cutoff = cutoff)
deleteCols <- names(whole[,(highlyCorr)])  #22 cols
keptCols <- names(whole[,-(highlyCorr)])   #53 cols
rightCols <- setdiff(names(dataSource),deleteCols) #214 cols in dataSource
                                                # want 214-22 = 192
dataSource <- dataSource[,rightCols]

# corrplot(correlationMatrix, method = "circle", type = "full", bg = "white", diag = FALSE, insig = "blank", order = "hclust", hclust.method = "ward.D2", tl.cex = 0.6, tl.col = "black", cl.ratio = 0.1, addrect = 10 )


# saveRDS(object = deleteCols, file = "deleteCols")






# @knitr  Categoricals --------------
# ## how to code categorical factors (reading)
# ## from https://www.statmethods.net/input/valuelabels.html
# good to know how to use contrasts() although the lm(~) seems to automatically categorize/contrast categoricals in lin regression

# # variable v1 is coded 1, 2 or 3
# # we want to attach value labels 1=red, 2=blue, 3=green
#
# mydata$v1 <- factor(mydata$v1,
# levels = c(1,2,3),
# labels = c("red", "blue", "green"))
#
# # variable y is coded 1, 3 or 5
# # we want to attach value labels 1=Low, 3=Medium, 5=High
#
# mydata$v1 <- ordered(mydata$y,
# levels = c(1,3, 5),
# labels = c("Low", "Medium", "High"))
#

dataSource$LCLUCI.labels <-
  factor(
    dataSource$LCLUCI,
    levels = c(11,	12,	21,	22,	23,	31,	41,	42,	52,	71,	81,	82,	90,	95),
    labels = c(
      "Open Water",             #HEX   486da2
      "Perennial Ice/Snow",     #      e7effc     
      "Developed (Low Intensity)", #   dc9881
      "Developed (Medium Intensity)",# f10100
      "Developed (High Intensity)", #  ab0101
      "Barren Land (Rock/Sand/Clay)", # b3afa4
      "Deciduous Forest",             #6ba966
      "Evergreen Forest",             #1d6533
      "Shrub/Scrub",                  #d1bb82
      "Grassland/Herbaceous",          #edeccd
      "Pasture/Hay",                   #ddd83e
      "Cultivated Crops",              #ae7229
      "Woody Wetlands",                #bbd7ed
      "Emergent Herbaceous Wetland"     #71a4c1
    )
  )

dataSource$LCLUCI <- factor(dataSource$LCLUCI)


dataSource$LCLUCI.colors <-
  factor(
    dataSource$LCLUCI,
    levels = c(11,	12,	21,	22,	23,	31,	41,	42,	52,	71,	81,	82,	90,	95),
    labels = c(
      "#486da2", 
      "#e7effc",  
      "#dc9881", 
      "#f10100", 
      "#ab0101",  
      "#b3afa4",             
      "#6ba966", 
      "#1d6533", 
      "#d1bb82", 
      "#edeccd",
      "#ddd83e",              
      "#ae7229", 
      "#bbd7ed", 
      "#71a4c1"
    ))

# I make this factor LCLUCI.color and Season.color because eventually I'd like to assign custom color codes to the charts to show  what they are "supposed" to loook like (just google National Land Cover Database LCLU and you'll see each of these LCLU Type II and Type I have specifc values )

# "TPI classifies proximate landform into six categories: flat, ridge, upper slope, middle slope, lower slope, and valleys." [Mennitt 2014]

#"TPI - Topographic Position Index: 1 - Ridge, 2 - Upper Slope, 3 - Middle Slope, 4 - Flat, 5 - Lower Slope, 6 - Valleys (Point)" (Sherrill 2012, page 19)

dataSource$TPI.labels <-
  factor(
    dataSource$TPI,
    levels = c(1:6),
    labels = c(
      "1 - Ridge",
      "2 - Upper Slope",
      "3 - Middle Slope",
      "4 - Flat",
      "5 - Lower Slope",
      "6 - Valleys (Point)"
    ))



#http://topepo.github.io/caret/pre-processing.html#dummy


# Categorizing/Re-arrangnig Seasons (instaed of alphabetically)
# I realize the seasons don't occur in this sequence but I felt this sequence would allow me to visualize anomoolies more easliy.  if you can see loudest sounds were coming from Winter (which will be colored a certain way in the graphs) then you'll see that more obviously.  I would think Summer/Spring are louder than Fall/Winter esp in the National Parks where people are less likely to visit in the winter/fall or be loud

dataSource$Season <-
  factor(dataSource$Season,
         levels = c("Summer", "Spring", "Fall", "Winter"))

dataSource<- dataSource %>% 
  mutate("SeasonSpring" = ifelse(Season=="Spring",1,0)) %>% 
  mutate("SeasonSummer" = ifelse(Season=="Summer",1,0)) %>% 
  mutate("SeasonFall" = ifelse(Season=="Fall",1,0))


##arrange df vars by position
##https://stackoverflow.com/questions/5620885/how-does-one-reorder-columns-in-a-data-frame
##'vars' must be a named vector, e.g. c("var.name"=1)
arrange.vars <- function(data, vars){
  ##stop if not a data.frame (but should work for matrices as well)
  stopifnot(is.data.frame(data))
  
  ##sort out inputs
  data.nms <- names(data)
  var.nr <- length(data.nms)
  var.nms <- names(vars)
  var.pos <- vars
  ##sanity checks
  stopifnot( !any(duplicated(var.nms)), 
             !any(duplicated(var.pos)) )
  stopifnot( is.character(var.nms), 
             is.numeric(var.pos) )
  stopifnot( all(var.nms %in% data.nms) )
  stopifnot( all(var.pos > 0), 
             all(var.pos <= var.nr) )
  
  ##prepare output
  out.vec <- character(var.nr)
  out.vec[var.pos] <- var.nms
  out.vec[-var.pos] <- data.nms[ !(data.nms %in% var.nms) ]
  stopifnot( length(out.vec)==var.nr )
  
  ##re-arrange vars by position
  data <- data[ , out.vec]
  return(data)
}

dataSource <- arrange.vars(data = dataSource, vars = c("SeasonSummer"=10, "SeasonFall" =11, "SeasonSpring"=12))






dataSource$Season.colors <-
  factor(
    dataSource$Season,
    levels = c("Summer", "Spring", "Fall", "Winter"),
    labels = c("orange", "purple", "darkred", "blue")
  )  #Eventually I'd like to assign better colors to Seasons so I can eye-ball them more easily - it's weird seeing Winter show up as Red for example, when R assigns them random colors






# Add the park full NAMES to dataSource  ----
dataSource$park.labels <-
  factor(
    dataSource$park,
    levels = c('ACAD', 'AGFO','ARCH','BADL','BAND','BITH','BLMNV','BRCA','CAHA',
               'CALO','CANY','CEBR','CIRO','COLM','DEPO','DETO','DEVA','DINO',
               'ELMA','ELMO','EVER','FODO','FOLA','FORA','GLAC','GLCA','GOGA','GRBA',
               'GRCA','GRTE','GRKO','GRSA','GRSM','GUIS','HOME','ISRO','KIMO','LAKE',
               'LAME','LAMR','LIBI','MIMA','MOCA','MOJA','MONO','MORA','MORU','MUWO',
               'NOCA','OLYM','ORPI','OZAR','PEFO','PETR','PIPE','PIRO','ROCR','ROMO',
               'SAAN','SACN','SAGU','SAND','SEKI','THRO','TUZI','VICK','WRBR','WUPA',
               'YELL','YOSE','ZION'
    ),
    labels = c('Acadia','Agate Fossil Beds','Arches','Badlands','Bandelier','Big Thicket',
               'BLMNV','Bryce Canyon','Cape Hatteras','Cape Lookout','Canyonlands',
               'Cedar Breaks','City of Rocks','Colorado National Monument',
               'Devils Postpile','Devils Tower','Death Valley','Dinosaur National Monument',
               'El Malpais','El Morro','Everglades','Fort Donelson',
               'Fort Laramie','Fort Raleigh','Glacier National Park','Glen Canyon',
               'Golden Gate','Great Basin','Grand Canyon','Grand Teton',
               'Grant-Kohrs Ranch','Great Sand Dunes','Great Smoky Mountains',
               'Gulf Islands','Homestead','Isle Royale','Kings Mountain','Lake Mead',
               'Lake Mead2','Lake Meredith','Little Bighorn','Minute Man',           
               'MontezumaCastle','Mojave','Monocacy','Mount Rainier','Mount Rushmore',
               'Muir Woods','North Cascades','Olympic','Organ Pipes','Ozark',
               'Petrified Forest','Petroglyphs','Pipestone','Pictured Rocks',
               'Rock Creek','Rocky Mountain','San Antonio Missions','Saint Croix',
               'Saguaro','Sand Creek','Sequoia and Kings Canyon','Theodore Roosevelt',
               'Tuzigoot','Vicksburg','Wright Brothers National Monument',
               'Wupatki','Yellowstone','Yosemite','Zion'
    )
  )


#Move Park Labels to Column 1 
dataSource <- arrange.vars(data = dataSource, vars = c("park.labels"=1))


 
saveRDS(object = dataSource,file = "cleandata")
 
#Unless you are going to review these, we don't need them anymore so I removed them from the environment:
rm(nzv1, tmp, near_zero_columns, new.packages, x, zero_wind_values, whole, correlationMatrix, deleteCols, highlyCorr, keptCols, rightCols, x1Col, x2Col, list.of.packages)  #to avoid confusion later when making the TRAIN data

rm(dataSource)

