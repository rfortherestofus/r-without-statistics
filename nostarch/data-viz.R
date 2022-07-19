## ----data-viz-1--------------------------------------------------------------------------------------------------------------------------------
library(tidyverse)
library(lubridate)
library(gapminder)
library(tidyverse)
library(lubridate)
library(sf)
library(albersusa)
library(colorspace)
library(shades)
library(scales)
library(showtext)
library(knitr)
library(patchwork)

## Add fonts
# font_add_google("Roboto", "Roboto")
# font_add_google("Roboto Mono", "Roboto Mono")
# font_add_google("Inter", "Inter")
# showtext_auto()


## Color palette hubs
greys <- c(0, 60, 40, 60, 0, 40, 60, 0)
pal1 <- paste0("grey", greys)
## Set up hubs map
hub_northwest <- c("AK", "OR", "ID", "WA")
hub_california <- "CA"
hub_southwest <- c("AZ", "HI", "NM", "NV", "UT")
hub_northern_plains <- c("CO", "MT", "ND", "NE", "SD", "WY")
hub_southern_plains <- c("KS", "OK", "TX")
hub_midwest <- c("IL", "IN", "MN", "IA", "MI", "MO", "OH", "WI")
hub_southeast <- c("AL", "AR", "LA", "MS", "TN", "KY", "GA", "NC", "FL", "GA", "SC", "VA")
hub_northeast <- c("CT", "DE", "ME", "MA", "MD", "NH", "NJ", "NY", "PA", "RI", "VT", "WV")
hubs_order <- c(
  "Northwest",
  "California",
  "Southwest",
  "Northern Plains",
  "Southern Plains",
  "Midwest",
  "Southeast",
  "Northeast"
)

## Read in DroughMonitor hub data
dm_perc_cat_hubs_raw <- rio::import(here::here("data", "dm_export_20000101_20210909_perc_cat_hubs.json"))

## Wrangle
dm_perc_cat_hubs <-
  dm_perc_cat_hubs_raw %>%
  ## Remove Northern Forest as it combines Midwest + Northeast
  filter(Name != "Northern Forests\\n") %>%
  ## Remove Carribean which shows no distinct drought patterns anyway
  filter(Name != "Caribbean") %>%
  mutate(
    across(c(MapDate, ValidStart, ValidEnd), as_date),
    across(None:D4, ~ as.numeric(.x) / 100),
    Name = stringr::str_remove(Name, "\\\\n"),
    Name = str_replace(Name, "Nothern", "Northern")
  ) %>%
  rename("date" = "MapDate", "hub" = "Name") %>%
  pivot_longer(
    cols = c(None:D4),
    names_to = "category",
    values_to = "percentage"
  ) %>%
  filter(category != "None") %>%
  mutate(category = factor(category)) %>%
  dplyr::select(-ValidStart, -ValidEnd, -StatisticFormatID) %>%
  mutate(
    year = year(date),
    week = week(date),
    hub = factor(hub, levels = hubs_order, labels = hubs_order)
  ) %>%
  group_by(year) %>%
  mutate(max_week = max(week)) %>% ## for var
  ungroup() %>%
  filter(percentage > 0)


## ----data-viz-2, fig.height = 8----------------------------------------------------------------------------------------------------------------
dm_perc_cat_hubs %>%
  filter(hub %in% c("Northwest", 
                    "California", 
                    "Southwest", 
                    "Northern Plains")) %>%
  ggplot(aes(x = week, 
             y = percentage)) +
  geom_rect(
    aes(
      xmin = .5,
      xmax = max_week + .5,
      ymin = -0.005,
      ymax = 1
    ),
    fill = "#f4f4f9",
    color = NA,
    size = 0.4,
    show.legend = FALSE
  ) +
  geom_col(
    aes(
      fill = category,
      fill = after_scale(addmix(darken(fill, .05, space = "HLS"), 
                                "#d8005a", 
                                .15)),
      color = after_scale(darken(fill, .2, space = "HLS"))
    ),
    width = .9,
    size = 0.12
  ) +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y") +
  coord_cartesian(clip = "off") +
  scale_x_continuous(expand = c(.02, .02), 
                     guide = "none", 
                     name = NULL) +
  scale_y_continuous(expand = c(0, 0), 
                     position = "right", 
                     labels = NULL, 
                     name = NULL) +
  scale_fill_viridis_d(
    option = "rocket",
    name = NULL,
    direction = -1,
    begin = .17,
    end = .97,
    labels = c(
      "Abnormally Dry",
      "Moderate Drought",
      "Severe Drought",
      "Extreme Drought",
      "Exceptional Drought"
    )
  ) +
  guides(fill = guide_legend(override.aes = list(size = 1))) +
  theme_light(base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, 
                              color = "black"),
    axis.text = element_text(family = "Roboto Mono", 
                             size = 11),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", 
                               size = .2),
    axis.ticks.y = element_line(color = "black", 
                                size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "top",
    legend.title = element_text(color = "#2DAADA", 
                                face = "bold"),
    legend.text = element_text(color = "#2DAADA"),
    strip.text.x = element_text(hjust = .5, 
                                face = "plain", 
                                color = "black", 
                                margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(angle = 0, 
                                     vjust = .5, 
                                     face = "plain", 
                                     color = "black"),
    strip.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.border = element_rect(color = "transparent", 
                                size = 0),
    plot.background = element_rect(fill = "transparent", 
                                   color = "transparent", 
                                   size = .4),
    plot.margin = margin(rep(18, 4))
  )

opts_current$get()$label

ggsave(plot = last_plot(),
       filename = "nostarch/data-viz/data-viz-figure-1.pdf",
       device = cairo_pdf,
       width = 4.675,
       height = 8)


## ----data-viz-3, fig.height = 8----------------------------------------------------------------------------------------------------------------
dm_perc_cat_hubs %>%
  filter(hub %in% c("Northwest", 
                    "California", 
                    "Southwest", 
                    "Northern Plains")) %>%
  ggplot(aes(x = week, 
             y = percentage)) +
  # geom_rect(
  #   aes(
  #     xmin = .5,
  #     xmax = max_week + .5,
  #     ymin = -0.005,
  #     ymax = 1
  #   ),
  #   fill = "#f4f4f9",
  #   color = NA,
  #   size = 0.4,
  #   show.legend = FALSE
# ) +
geom_col(
  aes(
    fill = category,
    fill = after_scale(addmix(darken(fill, .05, space = "HLS"), 
                              "#d8005a", 
                              .15)),
    color = after_scale(darken(fill, .2, space = "HLS"))
  ),
  width = .9,
  size = 0.12
) +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y") +
  coord_cartesian(clip = "off") +
  scale_x_continuous(expand = c(.02, .02), 
                     guide = "none", 
                     name = NULL) +
  scale_y_continuous(expand = c(0, 0), 
                     position = "right", 
                     labels = percent_format(), 
                     name = NULL) +
  scale_fill_viridis_d(
    option = "rocket",
    name = NULL,
    direction = -1,
    begin = .17,
    end = .97,
    labels = c(
      "Abnormally Dry",
      "Moderate Drought",
      "Severe Drought",
      "Extreme Drought",
      "Exceptional Drought"
    )
  ) +
  guides(fill = guide_legend(override.aes = list(size = 1))) +
  theme_light(base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, 
                              color = "black"),
    axis.text = element_text(family = "Roboto Mono"),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", 
                               size = .2),
    axis.ticks.y = element_line(color = "black", 
                                size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "top",
    legend.title = element_text(color = "#2DAADA", 
                                face = "bold"),
    legend.text = element_text(color = "#2DAADA"),
    strip.text.x = element_text(hjust = .5, 
                                face = "plain", 
                                color = "black", 
                                margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(angle = 0, 
                                     vjust = .5, 
                                     face = "plain", 
                                     color = "black"),
    strip.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    # panel.grid.minor = element_blank(),
    # panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.border = element_rect(color = "transparent", 
                                size = 0),
    plot.background = element_rect(fill = "transparent", 
                                   color = "transparent", 
                                   size = .4),
    plot.margin = margin(rep(18, 4))
  )


## ----data-viz-4, fig.height = 4----------------------------------------------------------------------------------------------------------------
dm_perc_cat_hubs %>%
  filter(hub == "Southwest") %>%
  filter(year == 2003) %>% 
  ggplot(aes(x = week, 
             y = percentage)) +
  geom_rect(
    aes(
      xmin = .5,
      xmax = max_week + .5,
      ymin = -0.005,
      ymax = 1
    ),
    fill = "#f4f4f9",
    color = NA,
    size = 0.4,
    show.legend = FALSE
  ) +
  geom_col(
    aes(
      fill = category,
      fill = after_scale(addmix(darken(fill, .05, space = "HLS"), 
                                "#d8005a", 
                                .15)),
      color = after_scale(darken(fill, .2, space = "HLS"))
    ),
    width = .9,
    size = 0.12
  ) +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y") +
  coord_cartesian(clip = "off") +
  scale_x_continuous(expand = c(.02, .02), 
                     guide = "none", 
                     name = NULL) +
  scale_y_continuous(expand = c(0, 0), 
                     position = "right", 
                     labels = NULL, 
                     name = NULL) +
  scale_fill_viridis_d(
    option = "rocket",
    name = NULL,
    direction = -1,
    begin = .17,
    end = .97,
    labels = c(
      "Abnormally Dry",
      "Moderate Drought",
      "Severe Drought",
      "Extreme Drought",
      "Exceptional Drought"
    )
  ) +
  guides(fill = guide_legend(override.aes = list(size = 1))) +
  theme_light(base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, 
                              color = "black"),
    axis.text = element_text(family = "Roboto Mono", 
                             size = 11),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", 
                               size = .2),
    axis.ticks.y = element_line(color = "black", 
                                size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "none",
    legend.title = element_text(color = "#2DAADA", 
                                face = "bold"),
    legend.text = element_text(color = "#2DAADA"),
    strip.text.x = element_text(hjust = .5, 
                                face = "plain", 
                                color = "black", 
                                margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(angle = 0, 
                                     vjust = .5, 
                                     face = "plain", 
                                     color = "black"),
    strip.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.border = element_rect(color = "transparent", 
                                size = 0),
    plot.background = element_rect(fill = "transparent", 
                                   color = "transparent", 
                                   size = .4),
    plot.margin = margin(rep(18, 4))
  )


## ----data-viz-5, out.width="100%"--------------------------------------------------------------------------------------------------------------
include_graphics("assets/excel-chart-chooser.png")


## ----data-viz-6--------------------------------------------------------------------------------------------------------------------------------
gapminder_10_rows <- gapminder %>%
  slice(1:10)

bar_chart <- ggplot(
  data = gapminder_10_rows,
  mapping = aes(
    x = year,
    y = lifeExp
  )
) +
  geom_col() +
  scale_y_continuous(limits = c(0, 45)) +
  scale_x_continuous(limits = c(1950, 2000))

line_chart <- ggplot(
  data = gapminder_10_rows,
  mapping = aes(
    x = year,
    y = lifeExp
  )
) +
  geom_line() +
  scale_y_continuous(limits = c(0, 45)) +
  scale_x_continuous(limits = c(1950, 2000))


bar_chart + line_chart +
  plot_annotation(
    title = "Life Expectancy in Afghanistan, 1952-1997",
    caption = "Data from Gapminder Foundation"
  ) &
  theme_minimal() +
  theme(
    axis.title = element_blank(),
    axis.text = element_text(),
    plot.title = element_text(
      face = "bold",
      hjust = 0.5,
      size = 14
    ),
    plot.caption = element_text(
      color = "grey40",
      size = 10
    )
  )


## ----data-viz-7--------------------------------------------------------------------------------------------------------------------------------
gapminder_10_rows


## ----data-viz-8, echo = TRUE-------------------------------------------------------------------------------------------------------------------
ggplot(
  data = gapminder_10_rows,
  mapping = aes(
    x = year,
    y = lifeExp
  )
)


## ----data-viz-9--------------------------------------------------------------------------------------------------------------------------------
ggplot(
  data = gapminder_10_rows,
  mapping = aes(
    x = year,
    y = lifeExp
  )
)


## ----data-viz-10, echo = TRUE------------------------------------------------------------------------------------------------------------------
ggplot(
  data = gapminder_10_rows,
  mapping = aes(
    x = year,
    y = lifeExp
  )
) +
  geom_point()


## ----data-viz-11, echo = TRUE------------------------------------------------------------------------------------------------------------------
ggplot(
  data = gapminder_10_rows,
  mapping = aes(
    x = year,
    y = lifeExp
  )
) +
  geom_line()


## ----data-viz-12, echo = TRUE------------------------------------------------------------------------------------------------------------------
ggplot(
  data = gapminder_10_rows,
  mapping = aes(
    x = year,
    y = lifeExp
  )
) +
  geom_point() +
  geom_line()


## ----data-viz-13, echo = TRUE------------------------------------------------------------------------------------------------------------------
ggplot(
  data = gapminder_10_rows,
  mapping = aes(
    x = year,
    y = lifeExp
  )
) +
  geom_col()


## ----data-viz-14, echo = TRUE------------------------------------------------------------------------------------------------------------------
ggplot(
  data = gapminder_10_rows,
  mapping = aes(
    x = year,
    y = lifeExp,
    fill = year
  )
) +
  geom_col()


## ----data-viz-15, echo = TRUE------------------------------------------------------------------------------------------------------------------
ggplot(
  data = gapminder_10_rows,
  mapping = aes(
    x = year,
    y = lifeExp,
    fill = year
  )
) +
  geom_col() +
  scale_fill_viridis_c()


## ----data-viz-16, echo = TRUE------------------------------------------------------------------------------------------------------------------
ggplot(
  data = gapminder_10_rows,
  mapping = aes(
    x = year,
    y = lifeExp,
    fill = year
  )
) +
  geom_col() +
  scale_fill_viridis_c() +
  theme_minimal()


## ----data-viz-17, echo = TRUE------------------------------------------------------------------------------------------------------------------
southwest_2003 <- dm_perc_cat_hubs %>%
  filter(hub == "Southwest") %>%
  filter(year == 2003)


## ----data-viz-18, echo = TRUE------------------------------------------------------------------------------------------------------------------
southwest_2003 %>%
  slice(1:10)


## ----data-viz-19, echo = TRUE------------------------------------------------------------------------------------------------------------------
ggplot(
  data = southwest_2003,
  aes(
    x = week,
    y = percentage,
    fill = category
  )
) +
  geom_col()


## ----data-viz-20, echo = TRUE------------------------------------------------------------------------------------------------------------------
ggplot(
  data = southwest_2003,
  aes(
    x = week,
    y = percentage,
    fill = category
  )
) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  )


## ----data-viz-21, echo = TRUE------------------------------------------------------------------------------------------------------------------
ggplot(
  data = southwest_2003,
  aes(
    x = week,
    y = percentage,
    fill = category
  )
) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  ) +
  scale_x_continuous(name = NULL, 
                     guide = "none") +
  scale_y_continuous(name = NULL, 
                     labels = NULL, 
                     position = "right")


## ----data-viz-22, fig.height = 8, echo = TRUE--------------------------------------------------------------------------------------------------
dm_perc_cat_hubs %>%
  filter(hub %in% c("Northwest", 
                    "California", 
                    "Southwest", 
                    "Northern Plains")) %>%
  ggplot(aes(x = week, 
             y = percentage,
             fill = category)) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  ) +
  scale_x_continuous(name = NULL, 
                     guide = "none") +
  scale_y_continuous(name = NULL, 
                     labels = NULL, 
                     position = "right") +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y")


## ----data-viz-23, fig.height = 8, echo = TRUE--------------------------------------------------------------------------------------------------
dm_perc_cat_hubs %>%
  filter(hub %in% c("Northwest", 
                    "California", 
                    "Southwest", 
                    "Northern Plains")) %>%
  ggplot(aes(x = week, 
             y = percentage,
             fill = category)) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  ) +
  scale_x_continuous(name = NULL, 
                     guide = "none") +
  scale_y_continuous(name = NULL, 
                     labels = NULL, 
                     position = "right") +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y") +
  theme_light(base_family = "Roboto")


## ----data-viz-24, fig.height = 8, echo = TRUE--------------------------------------------------------------------------------------------------
dm_perc_cat_hubs %>%
  filter(hub %in% c("Northwest", 
                    "California", 
                    "Southwest", 
                    "Northern Plains")) %>%
  ggplot(aes(x = week, 
             y = percentage,
             fill = category)) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  ) +
  scale_x_continuous(name = NULL, 
                     guide = "none") +
  scale_y_continuous(name = NULL, 
                     labels = NULL, 
                     position = "right") +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y") +
  theme_light(base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, 
                              color = "black"),
    axis.text = element_text(family = "Roboto Mono", 
                             size = 11),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", 
                               size = .2),
    axis.ticks.y = element_line(color = "black", 
                                size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "top",
    legend.title = element_text(color = "#2DAADA", 
                                face = "bold"),
    legend.text = element_text(color = "#2DAADA"),
    strip.text.x = element_text(hjust = .5, 
                                face = "plain", 
                                color = "black", 
                                margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(angle = 0, 
                                     vjust = .5, 
                                     face = "plain", 
                                     color = "black"),
    strip.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.border = element_rect(color = "transparent", 
                                size = 0),
    plot.background = element_rect(fill = "transparent", 
                                   color = "transparent", 
                                   size = .4),
    plot.margin = margin(rep(18, 4))
  )


## ----data-viz-25, fig.height = 8---------------------------------------------------------------------------------------------------------------
dm_perc_cat_hubs %>%
  filter(hub %in% c("Northwest", 
                    "California", 
                    "Southwest", 
                    "Northern Plains")) %>%
  ggplot(aes(x = week, 
             y = percentage,
             fill = category)) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  ) +
  scale_x_continuous(name = NULL, 
                     guide = "none") +
  scale_y_continuous(name = NULL, 
                     labels = NULL, 
                     position = "right") +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y") +
  theme_light(base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, 
                              color = "black"),
    axis.text = element_text(family = "Roboto Mono", 
                             size = 11),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", 
                               size = .2),
    axis.ticks.y = element_line(color = "black", 
                                size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "top",
    legend.title = element_text(color = "#2DAADA", 
                                face = "bold"),
    legend.text = element_text(color = "#2DAADA"),
    strip.text.x = element_text(hjust = .5, 
                                face = "plain", 
                                color = "black", 
                                margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(vjust = .5, 
                                     face = "plain", 
                                     color = "black"),
    strip.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.border = element_rect(color = "transparent", 
                                size = 0),
    plot.background = element_rect(fill = "transparent", 
                                   color = "transparent", 
                                   size = .4),
    plot.margin = margin(rep(18, 4))
  )


## ----data-viz-26, eval = FALSE, echo = TRUE----------------------------------------------------------------------------------------------------
## axis.line.x = element_blank(),
## axis.line.y = element_line(color = "black", size = .2),
## axis.ticks.y = element_line(color = "black", size = .2),
## axis.ticks.length.y = unit(2, "mm")


## ----data-viz-27, eval = FALSE, echo = TRUE----------------------------------------------------------------------------------------------------
## panel.background = element_rect(fill = "transparent", color = "transparent"),
## panel.border = element_rect(color = "transparent", size = 0),
## plot.background = element_rect(fill = "transparent", color = "transparent", size = .4)


## ----data-viz-28, echo = TRUE, eval = FALSE----------------------------------------------------------------------------------------------------
## geom_rect(
##   aes(
##     xmin = .5,
##     xmax = max_week + .5,
##     ymin = -0.005,
##     ymax = 1
##   ),
##   fill = "#f4f4f9",
##   color = NA,
##   size = 0.4
## )


## ----data-viz-29, fig.height = 10, echo = FALSE------------------------------------------------------------------------------------------------
dm_perc_cat_hubs %>%
  filter(hub %in% c("Northwest", 
                    "California", 
                    "Southwest", 
                    "Northern Plains")) %>%
  ggplot(aes(
    x = week,
    y = percentage,
    fill = category
  )
  ) +
  geom_rect(
    aes(
      xmin = .5,
      xmax = max_week + .5,
      ymin = -0.005,
      ymax = 1
    ),
    fill = "#f4f4f9",
    color = NA,
    size = 0.4
  ) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  ) +
  scale_x_continuous(name = NULL, guide = "none") +
  scale_y_continuous(name = NULL, labels = NULL, position = "right") +
  facet_grid(rows = vars(year), cols = vars(hub), switch = "y") +
  theme_light(base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, 
                              color = "black"),
    axis.text = element_text(family = "Roboto Mono", 
                             size = 11),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", 
                               size = .2),
    axis.ticks.y = element_line(color = "black", 
                                size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "top",
    legend.title = element_text(color = "#2DAADA", 
                                face = "bold"),
    legend.text = element_text(color = "#2DAADA"),
    strip.text.x = element_text(hjust = .5, 
                                face = "plain", 
                                color = "black", 
                                margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(angle = 0, 
                                     vjust = .5, 
                                     face = "plain", 
                                     color = "black"),
    strip.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.border = element_rect(color = "transparent", 
                                size = 0),
    plot.background = element_rect(fill = "transparent", 
                                   color = "transparent", 
                                   size = .4),
    plot.margin = margin(rep(18, 4))
  )


## ----data-viz-30, echo = TRUE, eval = FALSE----------------------------------------------------------------------------------------------------
## scale_fill_viridis_d(
##   option = "rocket",
##   direction = -1,
##   name = "Category:",
##   labels = c(
##     "Abnormally Dry",
##     "Moderate Drought",
##     "Severe Drought",
##     "Extreme Drought",
##     "Exceptional Drought"
##   )
## )


## ----data-viz-31, fig.height = 8---------------------------------------------------------------------------------------------------------------
dm_perc_cat_hubs %>%
  filter(hub %in% c("Northwest", 
                    "California", 
                    "Southwest", 
                    "Northern Plains")) %>%
  ggplot(aes(x = week, 
             y = percentage)) +
  geom_rect(
    aes(
      xmin = .5,
      xmax = max_week + .5,
      ymin = -0.005,
      ymax = 1
    ),
    fill = "#f4f4f9",
    color = NA,
    size = 0.4,
    show.legend = FALSE
  ) +
  geom_col(
    aes(
      fill = category,
      fill = after_scale(addmix(darken(fill, .05, space = "HLS"), 
                                "#d8005a", 
                                .15)),
      color = after_scale(darken(fill, .2, space = "HLS"))
    ),
    width = .9,
    size = 0.12
  ) +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y") +
  coord_cartesian(clip = "off") +
  scale_x_continuous(expand = c(.02, .02), 
                     guide = "none", 
                     name = NULL) +
  scale_y_continuous(expand = c(0, 0), 
                     position = "right", 
                     labels = NULL, 
                     name = NULL) +
  scale_fill_viridis_d(
    option = "rocket",
    name = NULL,
    direction = -1,
    begin = .17,
    end = .97,
    labels = c(
      "Abnormally Dry",
      "Moderate Drought",
      "Severe Drought",
      "Extreme Drought",
      "Exceptional Drought"
    )
  ) +
  guides(fill = guide_legend(override.aes = list(size = 1))) +
  theme_light(base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, 
                              color = "black"),
    axis.text = element_text(family = "Roboto Mono", 
                             size = 11),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", 
                               size = .2),
    axis.ticks.y = element_line(color = "black", 
                                size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "top",
    legend.title = element_text(color = "#2DAADA", 
                                face = "bold"),
    legend.text = element_text(color = "#2DAADA"),
    strip.text.x = element_text(hjust = .5, 
                                face = "plain", 
                                color = "black", 
                                margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(angle = 0, 
                                     vjust = .5, 
                                     face = "plain", 
                                     color = "black"),
    strip.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.border = element_rect(color = "transparent", 
                                size = 0),
    plot.background = element_rect(fill = "transparent", 
                                   color = "transparent", 
                                   size = .4),
    plot.margin = margin(rep(18, 4))
  )


## ----data-viz-32, echo = TRUE, eval = FALSE----------------------------------------------------------------------------------------------------
## ggplot(dm_perc_cat_hubs, aes(week, percentage)) +
##   geom_rect(
##     aes(
##       xmin = .5,
##       xmax = max_week + .5,
##       ymin = -0.005,
##       ymax = 1
##     ),
##     fill = "#f4f4f9",
##     color = NA,
##     size = 0.4,
##     show.legend = FALSE
##   ) +
##   geom_col(
##     aes(
##       fill = category,
##       fill = after_scale(addmix(darken(fill, .05,
##                                        space = "HLS"),
##                                 "#d8005a",
##                                 .15)),
##       color = after_scale(darken(fill, .2,
##                                  space = "HLS"))
##     ),
##     width = .9,
##     size = 0.12
##   ) +
##   facet_grid(rows = vars(year),
##              cols = vars(hub),
##              switch = "y") +
##   coord_cartesian(clip = "off") +
##   scale_x_continuous(expand = c(.02, .02),
##                      guide = "none",
##                      name = NULL) +
##   scale_y_continuous(expand = c(0, 0),
##                      position = "right",
##                      labels = NULL,
##                      name = NULL) +
##   scale_fill_viridis_d(
##     option = "rocket",
##     name = "Category:",
##     direction = -1,
##     begin = .17,
##     end = .97,
##     labels = c(
##       "Abnormally Dry",
##       "Moderate Drought",
##       "Severe Drought",
##       "Extreme Drought",
##       "Exceptional Drought"
##     )
##   ) +
##   guides(fill = guide_legend(override.aes = list(size = 1))) +
##   theme_light(base_size = 18,
##               base_family = "Roboto") +
##   theme(
##     axis.title = element_text(size = 14,
##                               color = "black"),
##     axis.text = element_text(family = "Roboto Mono",
##                              size = 11),
##     axis.line.x = element_blank(),
##     axis.line.y = element_line(color = "black",
##                                size = .2),
##     axis.ticks.y = element_line(color = "black",
##                                 size = .2),
##     axis.ticks.length.y = unit(2, "mm"),
##     legend.position = "top",
##     legend.title = element_text(color = "#2DAADA",
##                                 size = 18,
##                                 face = "bold"),
##     legend.text = element_text(color = "#2DAADA",
##                                size = 16),
##     strip.text.x = element_text(size = 16,
##                                 hjust = .5,
##                                 face = "plain",
##                                 color = "black",
##                                 margin = margin(t = 20, b = 5)),
##     strip.text.y.left = element_text(size = 18,
##                                      angle = 0,
##                                      vjust = .5,
##                                      face = "plain",
##                                      color = "black"),
##     strip.background = element_rect(fill = "transparent",
##                                     color = "transparent"),
##     panel.grid.minor = element_blank(),
##     panel.grid.major = element_blank(),
##     panel.spacing.x = unit(0.3, "lines"),
##     panel.spacing.y = unit(0.25, "lines"),
##     panel.background = element_rect(fill = "transparent",
##                                     color = "transparent"),
##     panel.border = element_rect(color = "transparent",
##                                 size = 0),
##     plot.background = element_rect(fill = "transparent",
##                                    color = "transparent",
##                                    size = .4),
##     plot.margin = margin(rep(18, 4))
##   )

