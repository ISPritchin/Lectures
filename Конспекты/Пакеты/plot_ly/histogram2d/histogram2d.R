library(plotly)

s <- matrix(c(1, -.75, -.75, 1), ncol = 2)
obs <- mvtnorm::rmvnorm(500, sigma = s)
p <- plot_ly(x = obs[,1], y = obs[,2])
subplot(
  p %>% add_markers(alpha = 0.2),
  p %>% add_histogram2d(
    colorscale = "Blue",
    histnorm = "percent", #"density" | "probability
    nbinsx = 10
    #xbins = list(
      #start, end, size
    #)
    #ybins = list(
      #start, end, size
    #)
  ) 
)
