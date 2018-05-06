library(dplyr)
library(ggplot2)
library(datasets)
library(stringr)

data <- airquality
str(data)
summary(data)

# Информация по пакету: 
browseVignettes(package = "dplyr")

# Описание работы фукнций select
# select
airquality %>% select(Ozone)
airquality %>% select(Ozone, Wind)
airquality %>% select(Ozone:Wind)
airquality %>% select(Ozone:Wind, everything())       # everything() - помещает все неупомянутые столбцы до него в таблицы
all_equal(airquality, airquality %>% select(Wind, everything()), ignore_col_order = FALSE)
airquality %>% select(Ozone:Wind, everything(), Temp) # После everything() не могут идти столбцы
airquality %>% select(-Temp)
airquality %>% select(-(Ozone:Wind))
airquality %>% select(-starts_with("O"), -ends_with("d"))
# другие функции для select
# TODO
cols_to_select <- c("Wind", "Ozone")
airquality %>% select(cols_to_select)

# select_if
iris %>% select_if(is.numeric)
iris %>% select_if(is.factor)
iris %>% select_if(function(col) is.numeric(col) && mean(col) > 3.5)
# select_all
select_all(mtcars, toupper)
# TODO
# select_at
# TODO

# Функции filter
airquality %>% filter(Wind > 10)
airquality %>% filter(is.na(Ozone))

# Данный код вернёт пустой датасет. Причина описывается ниже:
airquality %>% filter(Ozone > median(Ozone))
m <- median(airquality$Ozone) # значение медианы - NA
airquality$Ozone > m # сравнение с NA даёт NA
# функция filter вернёт только те значения, для который условие истинно, а оно не истинно ни для какой строки
# решение проблемы
airquality %>% filter(Ozone > median(Ozone, na.rm = TRUE))

airquality %>% filter(Ozone < 5 || Ozone > 100) # Результат - датасет без значений
# Причина - использование ||. Оператор || возвращает значение TRUE, если любое из первых значений векторов является истинной. Операция не является веторизованной.
# Аналогично и для &&
c(T, F, F) & F
c(T, F, F) && F
# Следующий код вернёт все значения. Функция filter приведёт значение TRUE до вектора со значениями TRUE длины n и никакой сортировки не произойдёт
airquality %>% filter(Ozone > 5 || Ozone < 100)

#filter_if
iris %>% filter_if(is.numeric, all_vars(. > 2))
iris %>% filter_if(is.numeric, any_vars(. > 2.0 & . < 2.3))
iris %>% filter_if(is.numeric, any_vars(between(., 2.0, 2.3)))
# функция between проверяет принадлежность значения некоторому промежутку
between(1, 1, 3)
between(1, 2, 3)

# filter_all
# TODO

# filter_at
# TODO


# Упорядочивание столбцов - функция arrange
airquality %>% select(Ozone, Temp) %>% arrange(Ozone, Temp)
airquality %>% arrange(-Ozone)
airquality %>% arrange(sin(Ozone), cos(Temp))
# Аналогичный результат
airquality %>% arrange(desc(Ozone))

# Функция arrange_if будет выполняться аналогично
# Упорядочивание будет производить слева-направо
airquality %>% arrange_if(is.numeric)

# Объединение строк и столбцов
# rbind() cbind() - функции для работы с DF
# Варианты данных функций в dplyr: bind_rows, bind_cols


# Функция coalesce производит обход первого массива. 
# Если некоторый элемент вектора равен na, она заменяет значением из второго вектора значением, находящимся на той же позиции
x <- c(NA, 1:5, NA)
coalesce(x, 0L)
coalesce(x, c(1:6, NA))


airquality %>% group_by(Month) %>% summarise({
  mean = mean(Temp)
  `sum/n` = sum(Temp)/count(Temp)
})
