#Для сравнения результата в некоторым значением используются функции expect_lt(e), expect_gt(e)
a <- 9
expect_lt(a, 10)
a <- 11
expect_lt(a, 10)

#expect_equal допускает ошибки в точности вычислений, однако expect_identical не будет делать таких поправок
expect_equal(sqrt(2) ^ 2, 2)
expect_identical(sqrt(2) ^ 2, 2)

#equavialent оценивает только значение, наличие имён не влияет на сравнение
a <- b <- 1:3
names(b) <- letters[1:3]
#expect_equal(a, b) - вернёт ошибку, так как подпись разные.
expect_equivalent(a, b)
#setequal проверяет сходство множеств в ответе
expect_setequal(c(1,2,3,1), c(1,2,3))
#expect_setequal(c(1,2,3,1), c(1,2,3,4))




#Напишем программу для поиска решения уравнения
sq_sol <- function(a = 0, b = 0, c = 0) {
  if (a == 0) {
    if (b == 0) {
      if (c == 0) {
        list("x - любое")
      } else {
        list("решений нет")
      }
    } else {
      list(-c/b)
    }    
  } else {
    D = b^2 - 4*a*c
    if (D == 0) {
      list(-b/(2*a))
    } else {
      if (D < 0) {
        sqrtD = sqrt(as.complex(D))
      } else {
        sqrtD = sqrt(D)
      }
      list((-b-sqrtD)/(2*a), (-b+sqrtD)/(2*a))
    }
  }
}

library(testthat)
expect_equal(sq_sol(), list("x - любое"))
expect_equal(sq_sol(0, 0, 0), list("x - любое"))
expect_equal(sq_sol(0, 0, 1), list("решений нет"))
expect_equal(sq_sol(0, 1, 0), list(0))
expect_equal(sq_sol(0, 1, 1), list(-1))
expect_equal(sq_sol(1, 0, 1), list(0-1i, 0+1i))
expect_equal(sq_sol(1, -2, 1), list(1))
expect_equal(sq_sol(2, 1, -3), list(-1.5, 1))

