library(tidyverse)
library(gt)

# read data
furniture <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-16/furniture.csv')

# manipulate data
tbl_dat <- 
  furniture |>
  # rescale dollars to be whole numbers
  mutate(x = `Houshold Value (Dollars)`,
         `Houshold Value (Dollars)` = vec_fmt_currency(`Houshold Value (Dollars)`),
         x = x / min(x),
         x = scales::rescale(x, c(1, 30), from = range(x))) |>
  mutate(x = floor(x)) |>
  # get all values, 1 to 30
  right_join(tibble(x = 1:30)) |>
  crossing(tibble(y = 1:30)) |>
  # only have values up to the relevant row (e.g., 10 rows for `1880`)
  filter(y <= x) |>
  arrange(y) |>
  # where row is less than target (1:9 for 1880), just put a space in
  mutate(`Houshold Value (Dollars)` = if_else(x == y,
                                              `Houshold Value (Dollars)`,
                                              "&nbsp;")) |>
  drop_na(Year) |>
  select(-x) |>
  # reshape
  pivot_wider(names_from = Year,
              values_from = `Houshold Value (Dollars)`) |>
  unnest(everything()) |>
  distinct() |>
  select(-y)

# make table!
gt(tbl_dat) |> 
  gtExtras::gt_theme_538() |>
  cols_align("center") |> 
  sub_missing(missing_text = "") |>
  # colour the cells to appear as a bar chart
  tab_style(
    cell_fill(color = "#d5a9a0"),
    cells_body(1, length(na.omit(tbl_dat[,1][[1]])))
  ) |> 
  tab_style(
    cell_fill(color = "#b0aebc"),
    cells_body(2, 1:length(na.omit(tbl_dat[,2][[1]])))
  ) |> 
  tab_style(
    cell_fill(color = "#baa28a"),
    cells_body(3, 1:length(na.omit(tbl_dat[,3][[1]])))
  ) |> 
  tab_style(
    cell_fill(color = "#d1a138"),
    cells_body(4, 1:length(na.omit(tbl_dat[,4][[1]])))
  ) |> 
  tab_style(
    cell_fill(color = "#eae9e6"),
    cells_body(5, 1:length(na.omit(tbl_dat[,5][[1]])))
  ) |> 
  tab_style(
    list(
      cell_fill(color = "#9e3844"),
      cell_text(color = "white")
    ),
    cells_body(6, 1:length(na.omit(tbl_dat[,6][[1]])))
  ) |> 
  fmt_markdown(everything()) |> 
  cols_width(everything() ~ px(120)) |> 
  tab_header(
    toupper("Assessed value of houshold and kitchen furniture owned by black americans in Georgia.")
  ) |> 
  tab_options(heading.align = "center")