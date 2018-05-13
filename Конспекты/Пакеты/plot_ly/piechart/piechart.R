library(plotly)

USPersonalExpenditure <- data.frame("Categorie"=rownames(USPersonalExpenditure), USPersonalExpenditure)
data <- USPersonalExpenditure[,c('Categorie', 'X1960')]

colors <- c('rgb(211,94,96)', 'rgb(128,133,133)', 'rgb(144,103,167)', 'rgb(171,104,87)', 'rgb(114,147,203)')
plot_ly(
  data, 
  labels = ~Categorie, 
  values = ~X1960, 
  type = 'pie',
  textposition = 'insode', #("inside" | "outside" | "auto" | "none" )
  textinfo = 'label+percent', #"label", "text", "value", "percent" joined with a "+" OR "none". 
  insidetextfont = list(color = '#FFFFFF'),
  hoverinfo = 'text',
  text = ~paste('$', X1960, ' billions'),
  marker = list(
    colors = colors,
    line = list(
      color = '#FFFFFF', 
      width = 2
    )
  ),
  showlegend = FALSE,
  textfont = list(
    family = "Balto",
    size = 16
  )
)

