library(profvis)

#Пакет позволяет выполнять профилирование кода
profvis({
  data(diamonds, package = "ggplot2")
  
  plot(price ~ carat, data = diamonds)
  m <- lm(price ~ carat, data = diamonds)
  abline(m, col = "red")
})
