library(profvis)
library(purrr)
library(dplyr)
library(magrittr)
library(ggplot2)

profvis({

  1:100000 %>%
    map(function(x) rnorm(10, x))
  
  map(1:100000, function(x) rnorm(10, x))
  
  for (i in 1:100000)
    rnorm(10, i)
  
})

profvis({
  
  vector <- 1:50000
  
  #map_int и подобные функции - для окончательного преобразования результата выполнения функции
  #профайлер не показывает особой разницы между следующими вызовами
  map(vector, function(x) x*x)
  map(vector, function(x) as.integer(x*x))
  map_int(vector, function(x) x*x)
  
  #Если функция принимает несколько аргументов - можно использовать варианты map2, как и map2 с приведением. Вернёт список
  #Не стоит применять map, если оно не нужно, например, как здесь)
  vect1 <- 10000:50000
  vect2 <- 60000:100000
  
  vect1 + vect2
  sum <- function(a, b) a + b
  as.vector(map2(vect1, vect2, sum))
  
  #Функции pmap - для произвольного числа аргументов
  linear <- function (a, x, b) {
    a*x+b
  }
  vect3 <- 60000:100000
  pmap(.l = list(vect1, vect2, vect3), .f = linear)
  #Непосредственный вызов работает быстрее. Настолько быстрее, что профайлер не может отловить
  res <- linear(vect1, vect2, vect3)
  
  #Порой применение некоторой функции хочется выполнить при соблшюдении определенных условий
  iris %>%
    map_if(is.factor, as.character) %>%
    str()
  
  #Можно применять фукнции и по именам столбцов и их позициям
  mtcars %>% map_at(c(1, 4, 5), as.character) %>% str()
  mtcars %>% map_at(c("cyl", "am"), as.character) %>% str()
})

#TODO
#invoke functions


#функции предикаты
is_odd <- function(x) {
  x %%  2 == 0
}

3:10 %>% detect(is_odd)
3:10 %>% detect_index(is_odd)
3:10 %>% detect(is_odd, .right = TRUE)
3:10 %>% detect_index(is_odd, .right = TRUE)
3:10 %>% every(is_odd)
3:10 %>% some(is_odd)

#Проверка на наличие объекта
c(1, 2, 3) %>% has_element(3)
1:3 %>% has_element(3)
c(1:3, 3) %>% has_element(3)

x <- list(1:10, 5, 9.9)
x %>% has_element(1:10)

#возврат значений, пока условие выполняется
pos <- function(x) x >= 0
head_while(5:-5, pos) #5, 4, 3, 2, 1, 0
tail_while(5:-5, negate(pos)) #-1, -2, -3, -4, -5
big <- function(x) x > 100
head_while(0:10, big)
tail_while(0:10, big)

#keep
sample(10, 5) #- вернёт выборку из 5 значений с возможным максимальным значением = 10
#формирует 10 выборок по 5 значений. Оставляет только те, среднее значение которых больше 6
rep(10, 10) %>%
  map(sample, 5) %>%
  keep(function(x) mean(x) > 6)
#Аналогичный результат
rep(10, 10) %>%
  map(sample, 5) %>%
  keep(~ mean(.x) > 6)

#Описание функции rerun описано ниже (возвращает результат 5 выполнений )
#Оставит только те наблюдения, у которых значение "a" = TRUE
x <- rerun(5, a = rbernoulli(1), b = sample(10))
x
x %>% keep("a")

#Функция discard имеет противоположное назначение
x %>% discard("a")

#Функция negate - возращает функцию, противоположную переданной
negate(~ x > 0)
is_odd <- function(x) {
  x %%  2 == 0
}
is_even <- negate(is_odd)
is_even(1)

x <- transpose(list(x = 1:10, y = rbernoulli(10)))
x %>% keep("y") %>% length()
x %>% keep(negate("y")) %>% length()
#аналогичный результат
x %>% discard("y") %>% length()

#prepend и append - вставка в начало и в конец списка
x <- as.list(0:3)
x %>% prepend("a")
x %>% prepend(c("a", "b"), before = 2)
x %>% prepend(list("a", "b"), before = 2)
x %>% prepend(list("a", "b"), before = 1)
x %>% append("a")
x %>% append("a", after = 0)

x <- data.frame(x = rnorm(10, mean = 20), y = rnorm(10))
mean_more_then5 <- function(x) {mean(x) > 5}
f <- function(x) {x * x}
x %>% map_if(mean_more_then5, f) %>% as.data.frame()

# Другие функции для работы с векторами
1:3 %>% accumulate(`+`) #cum-функции
1:3 %>% accumulate(`*`)
# Можно передавать и свои функции
1:3 %>% accumulate(function(acc, x) {
  acc + sin(x)
})
1:10 %>% accumulate_right(`+`)
1:10 %>% accumulate_right(`*`)

# Функции reduce r
1:3 %>% reduce(`+`)
1:10 %>% reduce(`*`)

samples <- rerun(2, sample(10, 5))
reduce(samples, union)
reduce(samples, intersect)

x <- list(c(0, 1), c(2, 3), c(4, 5))
x %>% reduce(c)
x %>% reduce_right(c)
#тот же самый результат
x %>% rev() %>% reduce(c)

# TODO
# Функция cross для получения комбинаций
# Функция flatten
# list_modify(x, y) list_update(`_x`, ...)
# splice(...)
# transpose(.l, .names = NULL)

# Композиция функций
not_null <- compose(`!`, is.null)
not_null(4)
not_null(NULL)
inc <- function(x) x + 1
doubleinc <- compose(inc, inc)
doubleinc(3) #5

# TODO
# lift(..f, ..., .unnamed = FALSE)
# lift_dl(..f, ..., .unnamed = FALSE)
# lift_dv(..f, ..., .unnamed = FALSE)
# lift_vl(..f, ..., .type)
# lift_vd(..f, ..., .type)
# lift_ld(..f, ...)
# lift_lv(..f, ...)
# partial(...f, ..., .env = parent.frame(), .lazy = TRUE, .first = TRUE)
# safely(.f, otherwise = NULL, quiet = TRUE)
# quietly(.f)
# possibly(.f, otherwise, quiet = TRUE)
# auto_browse(.f)

# x %||% y

# array_branch(array, margin = NULL)
# array_tree(array, margin = NULL)

# as_vector(.x, .type = NULL)
# simplify(.x, .type = NULL)
# simplify_all(.x, .type = NULL)