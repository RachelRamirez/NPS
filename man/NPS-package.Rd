\name{NPS-package}
\alias{NPS-package}
\alias{NPS}
\docType{package}
\title{
  visualize national park service acoustic data
}
\description{
  Uses interactive shiny app to look at scatterplots, maps, and parallel coordinate plots of data.
}
\details{
  The most important function is run_my_app("simpleplot"), and the second most important function that is exported though not intended to be used is myparacoords which displays the parallel coordinate plots.  It is  timelyportfolio's github parcoords code, just applied to this NPS data.
}
\author{
Rachel Ramirez
}
\references{
   Pertinent background information about the National Park Service variables in both data sets are found at the Natural Resource Publications Management website (http://www.nature.nps.gov/publications/nrpm/) search for ''Explanatory variable generation for geospatial soundscape modeling: Standard operating procedure. Natural Resource Report. Natural Resource Report NPS / NRSS / NRR - 2015 / 936'' by Lisa Nelson, Michelle Kinseth, and Thomas Flowe.  A 'codebook' is in development.
}
\keyword{ NPS }
\seealso{
  run_my_app, my_paracoords
}
\examples{
  \dontrun{
     ## run_my_app("simpleplot")
    
  }
}
