library(magrittr)

#Оператор %>% производит передачу аргумента слева как первое значение аргумента справа
#x %>% f is equivalent to f(x)
#x %>% f(y) is equivalent to f(x, y)
#x %>% f %>% g %>% h is equivalent to h(g(f(x)))
#x %>% f(y, .) is equivalent to f(y, x)
#x %>% f(y, z = .) is equivalent to f(y, z = x)

car_data <- 
  mtcars %>%
  subset(hp > 100) %>%
  aggregate(. ~ cyl, data = ., FUN = . %>% mean %>% round(2)) %>%
  transform(kpl = mpg %>% multiply_by(0.4251)) %>%
  print

#Может быть использован для создания анонимной функции
car_data %>%
  (function(x) {
    if (nrow(x) > 2) 
      rbind(head(x, 1), tail(x, 1))
    else x
  })

#Пример выше, но короче
car_data %>%
{ 
  if (nrow(.) > 0)
    rbind(head(., 1), tail(., 1))
  else .
}

#Оператор 
rnorm(200) %>%
  matrix(ncol = 2) %T>%
  plot %>% # plot usually does not return anything. 
  colSums

#Оператор %$%

#Оператор %<>% - передаёт аргумент вправо, результат возвращает в выражение слева
tmpiris <- datasets::iris
tmpiris$Sepal.Length %<>% sqrt

#https://github.com/tidyverse/magrittr
