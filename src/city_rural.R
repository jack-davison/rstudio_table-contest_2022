library(tidyverse)
library(gt)

# read data
city_rural <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/city_rural.csv'
  )

# format for table
tbl_data <-
  city_rural |>
  mutate(
    Category = fct_inorder(Category),
    n = Population / 100000,
    n_ceil = ceiling(n) # n_ceil = number of "100000" chunks
  ) |>
  arrange(Category) |>
  uncount(n_ceil) |> # uncount - get a row per 100000
  mutate(val = if_else(n < 1, n * 100000, 100000)) |>
  group_by(Category) |>
  mutate(rn = row_number(),
         val = if_else(rn == max(rn),
                       100000 * (n - floor(n)),
                       val)) # final row per group should be remainder of Population 

# function to create bars
plot_bar <- function(data, color) {
  data |>
    ggplot(aes(y = "", x = val)) +
    geom_col(fill = color) +
    expand_limits(x = 100000) +
    theme_void()
}

# create plots
plots <-
  tbl_data |>
  group_by(Category, rn) |>
  group_split() |>
  map2(.y = c("#5f7767", "#6276ab", "#e1b323", rep("#b82a40", nrow(tbl_data) - 3)),
       plot_bar)

# create table
tbl_data |>
  # drop repeat values
  mutate(
    Category = if_else(rn == 1, as.character(Category), ""),
    Population = if_else(rn == 1, as.character(Population), "")
  ) |>
  ungroup() |>
  select(Category, Population) |>
  mutate(plots = NA) |>
  gt() |>
  gtExtras::gt_theme_538() |>
  tab_header(html("URBAN AND RURAL POPULATION.<br>1890.")) |>
  tab_options(heading.align = "center") |>
  text_transform(cells_body(plots),
                 function(x) {
                   ggplot_image(plots, height = px(20), aspect_ratio = 9)
                 })