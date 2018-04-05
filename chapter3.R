## Chapter 3

# 3 purposes of Layers

## Visualize the data

## display the summaries

## append the metadata

df <- data.frame(
  x = c(3,1,5),
  y = c(2,4,6),
  label = c("a","b","c")
)

p <- ggplot(df, aes(x,y, label = label)) +
  labs(x = NULL, y = NULL) + # 축 레이블 없애는것
  theme(plot.title = element_text(size=12)) # plot title 축소

p + geom_point() + ggtitle("point")
p + geom_text() + ggtitle("text")
p + geom_bar(stat="identity") + ggtitle("bar")
p + geom_tile() + ggtitle("raster")

p + geom_line() + ggtitle("line")
p + geom_area() + ggtitle("area")
p + geom_path() + ggtitle("path") 
p + geom_polygon() + ggtitle("polygon")

## problem set p.58

## 1. which geom object to use?
# scatter plot
# line chart
# bar graph
# histogram
# pie chart

## 2. Difference between geom_path, geom_polygon?
## Difference between geom_path, geom_line?

## 3. how to draw as same as geom_smooth? 
## how about geom_boxplot, geom_violin? (NOT using ggplot)

## add text to the plot (label)

df_2 <- data.frame(x = 1, y = 3:1, family= c("sans","serif","mono"))
ggplot(df_2, aes(x,y)) +
  geom_text(aes(label=family, family=family))

df_3 <- data.frame(x=1, y = 3:1, face = c("plain", "bold", "italic"))
ggplot(df_3, aes(x,y)) +
  geom_text(aes(label= face, fontface = face))

df_4 <- data.frame(
  x = c(1,1,2,2,1.5),
  y = c(1,2,1,2,1.5),
  text = c(
    "bottom-left", "bottom-right",
    "top-left", "top-right", "center"
  )
)
ggplot(df_4, aes(x,y)) +
  geom_text(aes(label= text))
ggplot(df_4, aes(x,y)) +
  geom_text(aes(label= text), vjust = "inward", hjust = "inward")

df_5 <- data.frame(trt = c("a", "b","c"), resp = c(1.2, 3.4, 2.5)) 
ggplot(df_5, aes(resp, trt)) +
  geom_point() +
  geom_text(aes(label= paste0("(", resp, ")")), nudge_y = -0.25) + 
  xlim(1, 3.6)

ggplot(mpg, aes(displ, hwy)) +
  geom_text(aes(label = model)) +
  xlim(1,8)

ggplot(mpg, aes(displ, hwy)) +
  geom_text(aes(label= model), check_overlap = T) +
  xlim(1,8)

## geom_text + text box = geom_label

label <- data.frame(
  waiting = c(55,80),
  eruptions = c(2, 4.3),
  label = c("peak one", "peak two")
)
ggplot(faithfuld, aes(waiting, eruptions)) +
  geom_tile(aes(fill = density)) +
  geom_label(data = label, aes(label= label))

ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()

# install.packages("directlabels") 
ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point(show.legend = F) +
  directlabels::geom_dl(aes(label= class), method = "smart.grid")

# how to annotation in the plot ?

ggplot(economics, aes(date, unemploy)) + 
  geom_line()

presidential <- subset(presidential, start > economics$date[1])

ggplot(economics) +
  geom_rect(
    aes(xmin = start, xmax = end, fill = party),
    ymin = -Inf, ymax = Inf, alpha = 0.2,
    data = presidential
  ) +
  geom_vline(
    aes(xintercept = as.numeric(start)),
    data = presidential,
    colour = "grey50", alpha = 0.5
  ) +
  geom_text(
    aes(x = start, y = 2500, label = name),
    data = presidential,
    size = 3, vjust = 0, hjust = 0, nudge_x = 50
  ) +
  geom_line(aes(date, unemploy)) +
    scale_fill_manual( values = c("blue", "red"))

yrng <- range(economics$unemploy)
xrng <- range(economics$date)
caption <- paste(strwrap("Unemployment rates in the US have varied a lot over the years", 40),
                 collapse = "\n")

ggplot(economics, aes(date, unemploy)) +
  geom_line() +
  geom_text(
    aes(x, y, label = caption),
    data = data.frame(x = xrng[1], y = yrng[2], caption = caption),
    hjust = 0, vjust = 1, size = 4
  )

ggplot(economics, aes(date, unemploy)) +
  geom_line() +
  annotate("text", x = xrng[1], y = yrng[2], label = caption, hjust = 0, vjust = 1, size = 4)

ggplot(diamonds, aes(log10(carat), log10(price))) +
  geom_bin2d() +
  facet_wrap(~cut, nrow = 1)

mod_coef <- coef(lm(log10(price) ~ log10(carat), data = diamonds))
ggplot(diamonds, aes(log10(carat), log10(price))) + 
  geom_bin2d() +
  geom_abline(intercept = mod_coef[1], slope = mod_coef[2],
              colour = "white", size = 1) +
  facet_wrap(~cut, nrow = 1)

data(Oxboys, package = "nlme") 
head(Oxboys) 

ggplot(Oxboys, aes(age, height, group = Subject)) +
  geom_point() +
  geom_line()

ggplot(Oxboys, aes(age, height)) +
  geom_point() +
  geom_line()

ggplot(Oxboys, aes(age, height, group = Subject)) +
  geom_line() +
  geom_smooth(method = "lm", se = F)

ggplot(Oxboys, aes(age, height)) +
  geom_line(aes(group = Subject)) +
  geom_smooth(method = "lm", size = 2, se = F)

ggplot(Oxboys, aes(Occasion, height)) +
  geom_boxplot()

## Not the wanted result
ggplot(Oxboys, aes(Occasion, height)) +
  geom_boxplot() +
  geom_line(colour = "#3366FF", alpha = 0.5)

## this is the result
ggplot(Oxboys, aes(Occasion, height)) +
  geom_boxplot() +
  geom_line(aes(group=Subject), colour = "#3366FF", alpha = 0.5)

df_6 <- data.frame(x = 1:3, y = 1:3, colour = c(1,3,5))

# color 가 이산변수로 ... 
ggplot(df_6, aes(x, y, colour = factor(colour))) +
  geom_line(aes(group = 1), size = 2) +
  geom_point(size= 5)

# color 가 연속변수로.. (gradation)
ggplot(df_6, aes(x, y, colour = colour)) +
  geom_line(aes(group = 1), size = 2) +
  geom_point(size = 5)

xgrid <- with(df_6, seq(min(x), max(x), length= 50))
interp <- data.frame(
  x = xgrid,
  y = approx(df_6$x, df_6$y, xout = xgrid)$y, 
  colour = approx(df_6$x, df_6$colour, xout = xgrid)$y
)

ggplot(interp, aes(x,y, colour= colour)) +
  geom_line(size= 2) +
  geom_point(data = df_6, size = 5)

ggplot(mpg, aes(class)) +
  geom_bar()

ggplot(mpg, aes(class, fill = drv)) +
  geom_bar()

ggplot(mpg, aes(class, fill = hwy)) +
  geom_bar()

ggplot(mpg, aes(class, fill = hwy, group = hwy)) +
  geom_bar()

## Problem set p.78

## 1. hwy , displ box plot , additional visual factors?

## 2. modify the boxplot to display each boxplot of int(displ)
ggplot(mpg, aes(displ, cty)) + 
  geom_boxplot()
# answer
ggplot(mpg, aes(displ, cty, group = as.integer(displ))) + 
  geom_boxplot()

## 3. 연속색, 불연속 색 매핑 차이 이산은 aes(group = 1) 이 필요..
## 생략되면 어떻게?
## aes(group = 1) 과 aes(group = 2) 차이점?

## 4. how many bars in each plot?
ggplot(mpg, aes(drv)) +
  geom_bar()
ggplot(mpg, aes(drv, fill = hwy, group = hwy)) +
  geom_bar()
# install.packages("dplyr")
library(dplyr)
mpg2 <- mpg %>% arrange(hwy) %>% mutate(id = seq_along(hwy))
ggplot(mpg2, aes(drv, fill = hwy, group = id)) +
  geom_bar()

## hint: color = "white" 로 막대 주위 윤곽 추가?

## 5. babynames package , why are the plots ruined?
install.packages("babynames")
library(babynames)
hadley <- dplyr::filter(babynames, name == "Hadley")
ggplot(hadley, aes(year, n)) +
  geom_line()

####### contour plot ########

ggplot(faithfuld, aes(eruptions, waiting)) +
  geom_contour(aes(z = density, colour = ..level..))

ggplot(faithfuld, aes(eruptions, waiting)) +
  geom_raster(aes(fill = density))

small <- faithfuld[seq(1, nrow(faithfuld), by = 10), ]
ggplot(small, aes(eruptions, waiting)) +
  geom_point(aes(size= density), alpha = 1/3) +
  scale_size_area()

##### draw maps #######

library(dplyr)
install.packages("maps")
library(maps)
mi_counties <- map_data("county", "michigan") %>%
  select(lon = long, lat, group, id = subregion)
head(mi_counties)

ggplot(mi_counties, aes(lon, lat)) +
  geom_polygon(aes(group = group)) +
  coord_quickmap()

ggplot(mi_counties, aes(lon, lat)) +
  geom_polygon(aes(group = group), fill = NA, colour = "grey50") +
  coord_quickmap()

# this part does not work ... 
# install.packages("USAboundaries")
# 
# library(USAboundaries)
# c18 <- us_boundaries(as.Date("1820-01-01"))
# c18df <- fortify(c18)
# head(c18df)
# 
# ggplot(c18df, aes(long, lat)) +
#   geom_polygon(aes(group = group), colour = "grey50", fill = NA) +
#   coord_quickmap()
# 

mi_cities <- maps::us.cities %>%
  tbl_df() %>%
  filter(country.etc == "MI") %>%
  select(-country.etc, lon = long) %>% arrange(desc(pop))
mi_cities

ggplot(mi_cities, aes(lon, lat)) +
  geom_point(aes(size = pop)) +
  scale_size_area() +
  coord_quickmap()

ggplot(mi_cities, aes(lon, lat)) +
  geom_polygon(aes(group = group), mi_counties, fill = NA, colour = "grey50") +
  geom_point(aes(size = pop), colour = "red") +
  scale_size_area() +
  coord_quickmap()

install.packages("ggmap")
if(file.exists("mi_raster.rds")) {
  mi_raster <- readRDS("mi_raster.rds")
} else {
  bbox <- c(
    min(mi_counties$lon), min(mi_counties$lat),
    max(mi_counties$lon), max(mi_counties$lat)
  )
  mi_raster <- ggmap::get_map(location = bbox)
  saveRDS(mi_raster, "mi_raster.rds")
}

ggmap::ggmap(mi_raster)

ggmap::ggmap(mi_raster) +
  geom_point(aes(size = pop), mi_cities, colour = "red") +
  scale_size_area()

##### p.86 면 메타데이터 ######






