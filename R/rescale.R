rescale <- function(x, digits = 2) {
   if(class(x) %in% 'data.frame')  stop('object x must be a vector')
  
     rng <- range(x, na.rm = TRUE)
        scaled <- (x-rng[1])/(rng[2]-rng[1])
        round(scaled, digits = digits)
}

