---
title: "National Park Service Acoustic Dataset"
author: "Rachel Ramirez"
date: "2018-03-09"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{National Park Service Acoustic Dataset}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---


The intent of the NPS package is to allow a user to explore the original National Park Service acoustic geospatial dataset and the cleaned NPS data according to assumptions/imputations.  

## NPS Variables

Change the inputs available on the left-sidebar of the shiny app to explore the relations between variables in the data. The descriptions of most of the geospatial data are available from the NPS Report "Explanatory Variable Generation for Geospatial Sound Modeling" available on the Natural Resource Publications Management website (http://www.nature.nps.gov/publications/nrpm/) search for ''Explanatory variable generation for geospatial soundscape modeling: Standard operating procedure. Natural Resource Report. Natural Resource Report NPS / NRSS / NRR - 2015 / 936'' by Lisa Nelson, Michelle Kinseth, and Thomas Flowe.  A 'codebook' is in development.



## R Packages

**shiny** 
  Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2017).
  shiny: Web Application Framework for R. R package version 1.0.5.
  https://CRAN.R-project.org/package=shiny
  
**ggmap**
  D. Kahle and H. Wickham. ggmap: Spatial Visualization with ggplot2. The R
  Journal, 5(1), 144-161. URL
  http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf
  
**parcords**,  *from timelyportfolio's github*,
  Mike Bostock, Kai Chang and Kenton Russell (2017). parcoords: htmlwidget for
  d3.js parallel coordinates chart. R package version 0.5.0.
  https://github.com/timelyportfolio/parcoords
