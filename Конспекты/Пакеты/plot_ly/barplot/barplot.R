library(plotly)
library(magrittr)

d = data.frame(
  x = 1:5,
  xText = c("1sf", "2d", "3d", "4th", "5th"),
  y1 = c(1, 2, 0.5, 1.5, 1)
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
  type = "bar",
  name = "data1"
) %>% add_trace(
  y = ~y2,
  name = "data2"
)

#Пропуски - выдаст предупреждение. Выставит значение в 0
plot_ly(
  data = d,
  x = ~xText,
  y = ~y1,
  type = "bar",
  name = "data1"
) %>% add_trace(
  y = ~yWithGaps,
  name = "data2"
)

#Параметры visible, showlegend, legendgroup, opacity, name, noverinfo, hoverlabel - аналогично 
plot_ly(
  data = d,
  x = ~xText,
  y = ~y1,
  type = "bar",
  text = "Напишем что-нибудь под результатом"
) %>% add_trace(
  y = ~y2
)

#Задание ориентации
plot_ly(
  data = d,
  x = ~y1,
  y = ~xText,
  type = "bar",
  name = "data1",
  orientation = "h"
) %>% add_trace(
  y = ~xText,
  name = "data2"
)

plot_ly(
  data = d,
  x = ~xText,
  y = ~y1,
  type = "bar"
) %>% add_trace(
  y = ~y2
) %>%
  layout(barmode = "stack")

plot_ly(
  data = d,
  x = ~xText,
  y = ~y1,
  type = "bar",
  text = y,
  textfont = list(
    family = "Times New Roman",
    size = 20,
    color = "white"
  ),
  textposition = "auto",
  marker = list(
    line = list(
      color = "black",
      width = 1
    ),
    color = "lightblue"
  )
) %>% add_trace(
  y = ~y2,
  marker = list(
    color = "lightgreen"
  )
) 

plot_ly(
  data = d,
  x = ~x,
  y = ~y1,
  type = "bar",
  marker = list(
    line = list(
      color = "black",
      width = 2
    )
  )
) %>% add_trace(
  y = ~y1,
  base = -1
)

plot_ly() %>%
  add_bars(
    x = c("2016", "2017", "2018"),
    y = c(500,600,700),
    base = c(-500,-600,-700),
    marker = list(
      color = 'red'
    ),
    name = 'expenses'
  ) %>%
  add_bars(
    x = c("2016", "2017", "2018"),
    y = c(300,400,700),
    base = 0,
    marker = list(
      color = 'blue'
    ),
    name = 'revenue'
  )

library(dplyr)
ggplot2::diamonds %>% count(cut, clarity) %>%
  plot_ly(x = ~cut, y = ~n, color = ~clarity)

#Более сложные варианты:
x <- c(1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012)
roW <- c(219, 146, 112, 127, 124, 180, 236, 207, 236, 263, 350, 430, 474, 526, 488, 537, 500, 439)
China <- c(16, 13, 10, 11, 28, 37, 43, 55, 56, 88, 105, 156, 270, 299, 340, 403, 549, 499)
data <- data.frame(x, roW, China)

plot_ly(data, x = ~x, y = ~roW, type = 'bar', name = 'Rest of the World',
       marker = list(color = 'rgb(55, 83, 109)')) %>%
  add_trace(y = ~China, name = 'China', marker = list(color = 'rgb(26, 118, 255)')) %>%
  layout(title = 'US Export of Plastic Scrap',
         xaxis = list(
           title = "",
           tickfont = list(
             size = 14,
             color = 'rgb(107, 107, 107)')),
         yaxis = list(
           title = 'USD (millions)',
           titlefont = list(
             size = 16,
             color = 'rgb(107, 107, 107)'),
           tickfont = list(
             size = 14,
             color = 'rgb(107, 107, 107)')),
         legend = list(x = 0, y = 1, bgcolor = 'rgba(255, 255, 255, 0)', bordercolor = 'rgba(255, 255, 255, 0)'), barmode = 'group', bargap = 0.15, bargroupgap = 0.1)

x <- c('Product<br>Revenue', 'Services<br>Revenue', 'Total<br>Revenue', 'Fixed<br>Costs', 'Variable<br>Costs', 'Total<br>Costs', 'Total')
y <- c(400, 660, 660, 590, 400, 400, 340)
base <- c(0, 430, 0, 570, 370, 370, 0)
revenue <- c(430, 260, 690, 0, 0, 0, 0)
costs <- c(0, 0, 0, 120, 200, 320, 0)
profit <- c(0, 0, 0, 0, 0, 0, 370)
text <- c('$430K', '$260K', '$690K', '$-120K', '$-200K', '$-320K', '$370K')
data <- data.frame(x, base, revenue, costs, profit, text)

#The default order will be alphabetized unless specified as below:
data$x <- factor(data$x, levels = data[["x"]])

plot_ly(data, x = ~x, y = ~base, type = 'bar', marker = list(color = 'rgba(1,1,1, 0.0)')) %>%
  add_trace(y = ~revenue, marker = list(color = 'rgba(55, 128, 191, 0.7)',
                                        line = list(color = 'rgba(55, 128, 191, 0.7)',
                                                    width = 2))) %>%
  add_trace(y = ~costs, marker = list(color = 'rgba(219, 64, 82, 0.7)',
                                      line = list(color = 'rgba(219, 64, 82, 1.0)',
                                                  width = 2))) %>%
  add_trace(y = ~profit, marker = list(color = 'rgba(50, 171, 96, 0.7)',
                                       line = list(color = 'rgba(50, 171, 96, 1.0)',
                                                   width = 2))) %>%
  layout(title = 'Annual Profit - 2015',
         xaxis = list(title = ""),
         yaxis = list(title = ""),
         barmode = 'stack',
         paper_bgcolor = 'rgba(245, 246, 249, 1)',
         plot_bgcolor = 'rgba(245, 246, 249, 1)',
         showlegend = FALSE) %>%
  add_annotations(text = text,
                  x = x,
                  y = y,
                  xref = "x",
                  yref = "y",
                  font = list(family = 'Arial',
                              size = 14,
                              color = 'rgba(245, 246, 249, 1)'),
                  showarrow = FALSE)
