# Schriftgröße der Grafik
observeEvent(input$plot_base_size, {
  RV$plot_base_size <- input$plot_base_size
})

# Eventlistener Autoupdate (Einstellungen)
observeEvent(input$autoupdate_interval, {
  RV$autoupdate_interval <- input$autoupdate_interval
})
