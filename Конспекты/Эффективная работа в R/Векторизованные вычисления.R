install.packages("microbenchmark")
library("microbenchmark")

#Выполним замер времени работы посредством пакета microbenchmark
#Механизм работы
# - пишем фрагмент
# - загоняем куски кода
df = data.frame(v = 1:4, name = c(letters[1:4]))
microbenchmark(
  df[3, 2],
  df$name[3],
  df[3, "v"],
  df[3, "name"]
)

inc1a <- function(vector) {
  for (i in 1:length(vector)) {
    vector[i] = vector[i] + 1
  }
  vector
}

inc1b <- function(vector) {
  vector = vector + 1
}

v <- 1:100000
microbenchmark(
  inc1a(v),
  inc1b(v)
)

