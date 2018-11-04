pageWithSidebar(
  headerPanel("Your app is running thanks to docker! Congrats!"),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(iris)),
    selectInput('ycol', 'Y Variable', names(iris),
                selected=names(iris)[[2]]),
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 9)
  ),
  mainPanel(
    h3("Iris k-means clustering"),
    plotOutput('plot1')
  )
)