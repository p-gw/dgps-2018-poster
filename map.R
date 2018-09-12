output$map <- renderLeaflet({
  req(RV$data)
  leaflet(data = RV$data) %>% addTiles() %>%
    addMarkers(~long, ~lat, popup = ~label, label = ~label)
})
