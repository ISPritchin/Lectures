#Общие параметры

#число наблюдений
x = rnorm(20)
plot_ly(
  x = ~x, 
  type = "histogram"
)

#вероятность
plot_ly(
  x = ~x,
  type = "histogram",
  histnorm  = "probability"
)

#проценты
plot_ly(
  x = ~x,
  type = "histogram",
  histnorm  = "percent"
)



plot_ly(
  y = ~x,
  type = "histogram",
  orientation = "h"
)

plot_ly(alpha = 0.6) %>%
  add_histogram(x = ~rnorm(500)) %>%
  add_histogram(x = ~rnorm(500) + 1) %>%
  layout(barmode = "overlay")

plot_ly(alpha = 0.6) %>%
  add_histogram(x = ~rnorm(500),
                marker = list(
                  lines = list(
                    color = "black",
                    width = 1
                  )
                )
                ) %>%
  add_histogram(x = ~rnorm(500) + 1) %>%
  layout(barmode = "stack")

plot_ly(x = ~rnorm(5000),
        type = "histogram",
        histnorm  = "probability",
        cumulative = list(enabled=TRUE))

plot_ly(x = ~rnorm(50000),
        type = "histogram",
        histnorm  = "probability",
        cumulative = list(enabled=TRUE))

plot_ly(
  x = ~rnorm(200),
  type = "histogram",
  nbinsx = 30
)

plot_ly(
  x = ~rnorm(200),
  type = "histogram",
  nbinsx = 60,
  marker = list(
    line = list(
      color = "black",
      width =1
    )
  )
)

plot_ly(
  x = ~rnorm(200),
  type = "histogram",
  xbins = list(
    start = -5, #начнёт не раньше, чем -5
    end = 3,
    size = 0.1
  )
)
