library(ggplot2)
library(manipulate)

ggplot(mtcars) + 
  geom_point(aes(mpg, qsec))

manipulate(
  ggplot(mtcars) + 
    geom_point(aes(mpg, qsec)),
  secondParam = picker("1", "2"),
  slider = slider(15,25),
  checkbox = checkbox(FALSE, "checkbox label"),
  buttonName = button("buttonLabel")
)

manipulate(
  ggplot(mtcars) + 
    geom_point(aes(mpg, mtcars[[secondParam]])) +
    ylab(label = secondParam),
  secondParam = picker("qsec", "drat")
)

manipulate(
  ggplot() + 
    geom_point(aes(mtcars[[firstParam]], mtcars[[secondParam]])) + 
    xlab(label = firstParam) +
    ylab(label = secondParam),
  firstParam = picker(as.list(names(mtcars))),
  secondParam = picker(as.list(names(mtcars)))
)


