library(ggplot2)
library(dplyr)

df$Mouse.ID <- as.factor(df$Mouse.ID)

cages <- unique(df$Cage)

# Timestamp for title & filename
ts <- format(Sys.time(), "%Y-%m-%d_%H-%M")

for (c in cages) {
  
  subdf <- df %>% filter(Cage == c)
  
  p <- ggplot(subdf, aes(x = days_after_cath, 
                         y = weight, 
                         color = Mouse.ID, 
                         group = Mouse.ID)) +
    geom_line(linewidth = 1) +
    geom_point(size = 3) +
    scale_y_continuous(limits = c(0, 30)) +
    labs(
      title = paste("Cage", c, "- Weight Over Time (", ts, ")", sep = ""),
      x = "Days After Catheterization",
      y = "Weight (g)"
    ) +
    theme_bw() +
    theme(
      text = element_text(size = 16),        # increase ALL text
      plot.title = element_text(size = 20, face = "bold"),
      legend.title = element_text(size = 16),
      legend.text = element_text(size = 16)
    )
  
  print(p)
  
  
  # OPTIONAL: save each plot
  ggsave(
    filename = paste0("cage_", c, "_weight_plot_", ts, ".png"),
    plot = p,
    width = 7,
    height = 5,
    dpi = 300
  )
}

