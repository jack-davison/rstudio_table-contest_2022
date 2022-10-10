library(tidyverse)
library(gt)

freed_slaves <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/freed_slaves.csv'
  )

labs_df <- 
  mutate(freed_slaves,
         label = str_glue("<b>{Year}</b><br>
                          <span style='color:#1c1c1c'>{round(Slave)}</span>% | 
                          <span style='color:#6c986f'>{round(Free)}</span>%"))

long <- crossing(a = letters, b = letters) |> unite(a, a, b) |> pull()

pad <- function(vec) {
  if (length(vec) < 100) {
    append(vec, rep(FALSE, 100 - length(vec)))
  }
}

lst <-
  freed_slaves |>
  select(Slave) |>
  mutate(Slave = round(Slave / 1) * 1,
         Slave = Slave / 1) |>
  pull(Slave) |>
  map(~ rep(TRUE, .x)) |>
  map(pad) |>
  map( ~ set_names(.x, long[1:100]))

tbl_dat <-
  tibble(lst) |>
  unnest_wider(lst) |>
  mutate(rownum = row_number()) |>
  pivot_longer(-rownum) |> pivot_wider(names_from = rownum) |>
  arrange(desc(name)) |>
  select(-name) |>
  set_names(labs_df$Year)

gt(tbl_dat) |>
  gtExtras::gt_theme_538() |>
  data_color(columns = everything(),
             colors = scales::col_numeric(
               palette = c("#6c986f", "#1c1c1c"),
               domain = 0:1
             )) |>
  text_transform(cells_body(),
                 function(x) {
                   ""
                 }) |>
  tab_options(
    data_row.padding = 3,
    table_body.hlines.width = 0,
    heading.align = "center"
  ) |>
  tab_header(
    title = md(
      "PROPORTION OF <span style='color:#6c986f'>FREEMEN</span> AND SLAVES AMONG BLACK AMERICANS."
    ),
    subtitle = "DONE BY ATLANTA UNIVERSITY."
  ) |>
  cols_width(everything() ~ px(75)) |>
  cols_label(
    `1790` = md(labs_df$label[1]),
    `1800` = md(labs_df$label[2]),
    `1810` = md(labs_df$label[3]),
    `1820` = md(labs_df$label[4]),
    `1830` = md(labs_df$label[5]),
    `1840` = md(labs_df$label[6]),
    `1850` = md(labs_df$label[7]),
    `1860` = md(labs_df$label[8]),
    `1870` = md(labs_df$label[9])
  )