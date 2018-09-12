observeEvent(input$grouping_enable, {
  RV$grouping_enable <- input$grouping_enable
})


output$scatter_plot <- renderPlot({
  req(RV$data)
  req(RV$plot_base_size)
  p <- ggplot(RV$data[!is.na(dist) & !is.na(SozialesUmfeld) & !is.na(Gesellschaftsabend)], aes(x = dist, y = SozialesUmfeld)) +
    labs(
      "x" = "Distanz des Herkunftsortes von Frankfurt",
      "y" = "Anzahl bekannter Personen"
    ) +
    theme_minimal(base_size = RV$plot_base_size)

  if (RV$grouping_enable) {
    p <- p + geom_point(aes(colour = Gesellschaftsabend), size = 3) +
      scale_colour_manual(values = c(
        "ja" = "#E91E63",
        "nein" = "#03A9F4",
        "unsicher" = "#757575"
      )) +
      theme(
        legend.justification = c(1, 1),
        legend.position = c(0.97, 0.97)
      )
  } else {
    p <- p + geom_point(size = 3)
  }
  print(p)
})
