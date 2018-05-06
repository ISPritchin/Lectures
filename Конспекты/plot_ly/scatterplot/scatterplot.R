library(plotly)
library(magrittr)

d = data.frame(
  x = 1:5,
  y1 = c(1, 2, 0, 1.5, 1)
)
d$y2 = d$y1 + 3
d$y3 = d$y2 + 3
d$y4 = d$y3 + 3
d$y5 = d$y4 + 3
d$y6 = d$y5 + 3
d$y7 = d$y6 + 3
d$yWithGaps = c(1, 2, NA, 1.5, 1)

plot_ly(
  data = d,
  x = ~x,
  y = ~y1,
  type = "scatter",
  mode = "lines+markers",
  name = "data1"
) %>% add_trace(
  y = ~y2,
  name = "data2"
)


plot_ly(
  data = d,
  x = ~x,
  y = ~y1,
  type = "scatter",
  mode = "lines+markers",
  visible = FALSE
) %>% add_trace(
  y = ~y2,
  visible = "legendonly"
)

plot_ly(
  data = d,
  x = ~x,
  y = ~y1,
  type = "scatter",
  mode = "lines+markers"
) %>% add_trace(
  y = ~y2,
  showlegend = FALSE
) %>% add_trace(
  y = ~y3
)

plot_ly(
  data = d,
  x = ~x,
  y = ~y1,
  type = "scatter",
  mode = "lines+markers",
  legendgroup = "Группа 1"
) %>% add_trace(
  y = ~y2,
  legendgroup = "Группа 2",
  mode = "lines"
) %>% add_trace(
  y = ~y3,
  legendgroup = "Группа 2",
  mode = "markers"
) %>% add_trace(
  y = ~y4,
  legendgroup = "Группа 3",
  mode = "text",
  text = as.character(1:5)
)

plot_ly(
  data = d,
  x = ~x,
  y = ~y1,
  type = "scatter",
  mode = "lines+markers",
  opacity = 0.2
) %>% add_trace(
  y = ~y2,
  opacity = 1
) %>% add_trace(
  y = ~y3
) 

plot_ly(
  data = d,
  x = ~x,
  y = ~y1,
  type = "scatter",
  mode = "lines+markers",
  hoverinfo = "x",
  name = "x"
) %>% add_trace(
  y = ~y2,
  opacity = 1,
  hoverinfo = "y",
  name = "y"
) %>% add_trace(
  y = ~y3,
  hoverinfo = "x+y",
  name = "x+y"
) %>% add_trace(
  y = ~y4,
  hoverinfo = "name",
  name = "name"
) %>% add_trace(
  y = ~y5,
  hoverinfo = "name+x+y",
  name = "name+x+y"
) %>% add_trace(
  y = ~y6,
  hoverinfo = "text+name",
  text = c("Первая метка", "2", "3", "4", "Последняя метка"),
  name = "text+name"
) 

library(dplyr)
library(ggplot2)
plot_ly(
  diamonds[sample(nrow(diamonds), 1000), ], 
  x = ~carat, 
  y = ~price,
  type = "scatter",
  mode = "markers",
  # Hover text:
  text = ~paste("Price: ", price, '$<br>Cut:', cut),
  color = ~carat, 
  size = ~carat
)

plot_ly(
  diamonds[sample(nrow(diamonds), 1000), ], 
  x = ~carat, 
  y = ~price,
  type = "scatter",
  mode = "markers",
  # Hover text:
  text = ~paste("Price: ", price, '$<br>Cut:', cut),
  color = ~carat, 
  size = ~carat,
  hoverlabel = list(
    bgcolor = "lightgreen",
    bordercolor = "rgb(200, 50, 50)",
    font = list(
      # Возможные шрифты:  "Arial", "Balto", "Courier New", "Droid Sans",, "Droid Serif", "Droid Sans Mono", "Gravitas One", "Old Standard TT", "Open Sans", "Overpass", "PT Sans Narrow", "Raleway", "Times New Roman".
      family = "Balto",
      size = 14,
      color = "white"
    ),
    namelength = 100 #Максимальная длина метки
  )
)

#Стилизация
plot_ly(
  data = d,
  x = ~x,
  y = ~y1,
  type = "scatter",
  mode = "lines",
  #line = list(
    #color - цвет
    #width - ширина
    #shape - тип соединения точек 
    #smoothing - сглаживание
    #dash - тип линии
  #)
  line = list(
    width = 4,
    shape = "linear", #Значение по умолчанию
    dash = "solid"    #Значение по умолчанию
  )
) %>% add_trace(
  y = ~y2,
  line = list(
    shape = "spline",
    dash = "dot"
  )
) %>% add_trace(
  y = ~y3,
  line = list(
    shape = "hv",
    dash = "dash"
  )
) %>% add_trace(
  y = ~y4,
  line = list(
    shape = "vh",
    dash = "longdash"
  )
) %>% add_trace(
  y = ~y5,
  line = list(
    shape = "hvh",
    dash = "dashdot"
  )
) %>% add_trace(
  y = ~y6,
  line = list(
    shape = "vhv",
    dash = "longdashdot"
  )
)

#Пропуски в данных
plot_ly(
  data = d,
  x = ~x,
  y = ~yWithGaps,
  type = "scatter",
  mode = "lines+markers",
  hoverinfo = "x",
  name = "x"
) %>% add_trace(
  y = ~yWithGaps + 1,
  connectgaps = TRUE
)

#РЎРїРёСЃРѕРє РґРѕРїСѓСЃС‚РёРјС‹С… Р·РЅР°С‡РµРЅРёР№ symbol
#"circle"
#"circle-open"
#"circle-dot"
#"circle-open-dot"
#"square"
#"square[-open][-dot]"
#"diamond[-open][-dot]"
#"cross[-open][-dot]"
#"x[-open][-dot]"
#"triangle-(up|down|left|right|ne|se|sw|nw)[-open][-dot]"
#"pentagon[-open][-dot]"
#"hexagon[2][-open][-dot]"
#Рё С‚ Рґ

# Настройка маркера
plot_ly(
  data = d,
  x = ~x,
  y = ~y1,
  type  = "scatter",
  mode  = "markers",
  color = ~y1,
  marker = list(
    symbol = c("hexagon", "hexagon-open", "hexagon-dot", "hexagon-dot-open"),
    size = c(10, 20, 30, 40, 50),
    opacity = c(1, 1, 0.5, 1, 0.5)
  )
)

aLotOfDots = data.frame(
  x = 1:12,
  y = 1:12
)

plot_ly(
  d = aLotOfDots,
  x = ~x,
  y = ~y,
  type  = "scatter",
  mode  = "markers",
  color = ~y,
  marker = list(
    symbol = rep(c("hexagon", "hexagon-open", "hexagon-dot", "hexagon-dot-open"), 3),
    size = 30,
    line = list(
      width = 2,
      color = "black"
    )
  )
)
