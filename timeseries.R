output$ts_plot <- renderPlot({
  req(RV$ts_data)
  req(RV$plot_base_size)
  p <- ggplot(RV$ts_data, aes(x = datestamp, y = cumsum, group = complete)) +
    geom_hline(yintercept = 0, colour = "#9E9E9E") +
    geom_step(aes(colour = complete), size = 1, direction = "hv") +
    scale_colour_manual(values = c("#03A9F4", "#FFC107"), name = NULL) +
    theme_minimal(base_size = RV$plot_base_size) +
    labs(
      y = "Anzahl abgegebener Umfragen",
      x = "Datum"
    ) +
    theme(
      legend.justification = c(1, 0),
      legend.position = c(1, 0.05)
    )
    print(p)
})
