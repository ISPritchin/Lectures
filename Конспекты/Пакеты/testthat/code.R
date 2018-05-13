real.roots <- function(a, b, c)
{
  if (a == 0.) {
    warning("Leading term cannot be zero");
    return(linear(b, c))
  }
  
  d = b*b - 4*a*c
  
  if (d < 0)
    rr = c()
  else if (d == 0)
    rr = c( -b/(2*a) )
  else
    rr = c( (-b - sqrt(d))/(2*a), 
            (-b + sqrt(d))/(2*a))
  
  return(rr)
}


linear <- function(a, b) {
  if (a == 0) {
    if (b == 0) {
      res <- "x - любое"
    }
    else {
      res <- "решений нет"
    }
  } else {
    res <- -b/a
  }
  return(res)
}
