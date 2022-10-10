library(tidyverse)
library(gt)

# read data
georgia_pop <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/georgia_pop.csv'
  ) |>
  # descending "Year"
  arrange(desc(Year)) |>
  # language
  rename(Black = Colored)

# function to create plots
plot_dots <- function(data) {
  # only label 0, 50 and 100
  labs <- tibble(y = rep("", 3), x = c(0, 50, 100))
  
  # create plot
  plt <-
    data |>
    ggplot(aes(y = "")) +
    geom_vline(xintercept = seq(0, 100, 10), color = "red") +
    theme_void() +
    expand_limits(x = c(0, 100)) +
    scale_x_reverse() # reverse x-axis
  
  # only add labels to the first and last years
  if (data$Year %in% c(1790, 1890)) {
    plt <-
      plt + geom_text(
        inherit.aes = FALSE,
        data = labs,
        aes(x, y, label = x),
        size = 27.5
      )
  }
  
  # add points
  plt +
    geom_point(aes(x = Black), size = 35) +
    geom_point(
      aes(x = White),
      fill = "white",
      stroke = 4,
      shape = 21,
      size = 35
    )
  
}

# use function to create plots
plots <- georgia_pop |>
  group_split(Year) |>
  map(plot_dots)

# create table
georgia_pop |>
  mutate(dots = NA) |>
  gt() |>
  gtExtras::gt_theme_538() |>
  fmt_percent(Black:White, scale_values = F, decimals = 0) |>
  tab_header(toupper("Comparative Increase of White and Black Population in Georgia.")) |>
  # dropping padding makes plots look better
  tab_options(data_row.padding = 0, heading.align = "center") |> 
  cols_width(dots ~ px(250),
             Year:White ~ px(80)) |>
  # use of unicode to create "legend"
  cols_label(
    dots = "",
    Black = html("<div style='font-size:2.5em'>&#8226</div>Black"),
    White = html("<div style='font-size:2.5em'>&#9702</div>White")
  ) |>
  cols_align("center") |>
  # add plots
  text_transform(cells_body(columns = dots),
                 function(x) {
                   ggplot_image(rev(plots), height = px(35), aspect_ratio = 6)
                 })