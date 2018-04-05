# Chapter 1~2.

install.packages("ggplot2")
library(ggplot2)
mpg

## Problem set p.30

## 1. List 5 functions to dive into mpg dataset.

## 2. how to find dataset included in ggplot2?

## 3. how to calculate cty & hwy to Europe standard way?

## 4. Who is the most cited manufacturer in mpg dataset? 
## what is the most various model? 
## Will it be different if the unnecessary names(4wd, quattro) are deleted?



ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

ggplot(mpg, aes(displ, hwy)) +
  geom_point()

## Problem set p.32

## 1. Describe the relationship between cty and hwy. Any consideration when the conclusion was made?

## 2. ggplot(mpg, aes(model, manufacturer)) + geom_point() shows?
## Does it have more information? how to gain more information?

## 3. Explain data, visualization mapping, layer from each plots below.
## ggplot(mpg, aes(cty, hwy)) + geom_point()
## ggplot(diamonds, aes(carat, price)) + geom_point()
## ggplot(economics, aes(data, unemploy)) + geom_line()
## ggplot(mpg, aes(cty)) + geom_histogram()

ggplot(mpg, aes(displ, cty, colour = class)) +
  geom_point()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour="blue"))

ggplot(mpg, aes(displ, hwy)) +
  geom_point(colour="blue")

## Problem set p.35

## 1. Experience the color, shape, size. 

## 2. What will happen if continuous varibles are mapped to shape? why?
## How about trans mapped to shape? why?

## 3. What is relationship between trans and hwy?

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(~class)

## Problem set p.37

## 1. what will happen when using hwy? how about cyl? what is the difference?

## 2. Probing relationship between hwy, displ, and cyl using facetting. (using facetting by cyl)

## 3. read manual of facet_wrap()

## 4. what is scale parameter in facet_wrap()

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth()

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(se=F)

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(span = 0.2)

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(span = 1)

## for n > 1000

library(mgcv)
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(method= "gam", formula= y~s(x))

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(method = "lm")

## 'rlm' method is in mass package, strong optimizing , not affected by outliers

ggplot(mpg, aes(drv, hwy)) + 
  geom_jitter()

ggplot(mpg, aes(drv, hwy)) +
  geom_boxplot()

ggplot(mpg, aes(drv, hwy)) +
  geom_violin()

ggplot(mpg, aes(hwy)) +
  geom_histogram()

ggplot(mpg, aes(hwy)) +
  geom_freqpoly()

ggplot(mpg, aes(hwy)) +
  geom_freqpoly(binwidth= 2.5)

ggplot(mpg, aes(hwy)) +
  geom_freqpoly(binwidth= 1)

ggplot(mpg, aes(displ, colour= drv)) +
  geom_freqpoly(binwidth= 0.5)

ggplot(mpg, aes(displ, fill = drv)) +
  geom_histogram(binwidth = 0.5) +
  facet_wrap(~drv, ncol = 1)

ggplot(mpg, aes(manufacturer)) + 
  geom_bar()

ggplot(economics, aes(date, unemploy / pop)) +
  geom_line()

ggplot(economics, aes(date, uempmed)) +
  geom_line()

ggplot(economics, aes(unemploy / pop, uempmed)) +
  geom_path() +
  geom_point()

year <- function(x) as.POSIXlt(x)$year + 1900
ggplot(economics, aes(unemploy / pop, uempmed)) +
  geom_path(colour= "grey50") + 
  geom_point(aes(colour=year(date)))


## Problem set p.48

## 1. ggplot(mpg, aes(cty, hwy)) + geom_point() 's defect? which geom-object is objective to solve this?

## 2. ggplot(mpg, aes(class, hwy)) + geom_boxplot() , class' ordered by alphabet, how to convert the order?
## See the ?reorder

## 3. Probing distribution of diamond carrats. which binwidth is most effective?

## 4. Probing distribtuion of diamond prices. 


ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 1 / 3 )

ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 1/3) +
  xlab("city driving(mpg)") +
  ylab("highway driving(mpg)")

ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 1/3) +
  xlab(NULL) +
  ylab(NULL)

ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width=0.25)

ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width=0.25) +
  xlim("f", "r") +
  ylim(20, 30)

ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width = 0.25, na.rm = T) +
  ylim(NA, 30)

p <- ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) +
  geom_point()

print(p)
ggsave("plot.png", width = 5, height = 5) # saves to home? check the default path

summary(p)

saveRDS(p, "plot.rds")
q <- readRDS("plot.rds")

qplot(displ, hwy, data = mpg)
qplot(displ, data = mpg)

qplot(displ, hwy, data = mpg, colour = "blue")
qplot(displ, hwy, data = mpg, colour = I("blue"))

































