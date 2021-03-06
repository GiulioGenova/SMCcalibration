


if (!require("Cairo")) install.packages("Cairo")
if (!require("robustbase")) install.packages("robustbase")
if (!require("dplyr")) install.packages("dplyr")
if (!require("tidyr")) install.packages("tidyr")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("leaflet")) install.packages("leaflet")
if (!require("leaflet.extras")) install.packages("leaflet.extras")

data_def<-read.csv("SensorVSample_new.csv",sep=",",dec=".")

ui <- fluidPage(
  
  sidebarLayout(fluid = T, position = "left",
                
                # Sidebar with a slider input
                sidebarPanel(width=2,
                             
                             
                             
                             
                             #data_def$depth %>% unique %>% as.numeric  
                             #data_def$project %>% levels
                             #data_def$landuse %>% levels
                             #data_def$station %>% levels
                             #data_def$date_obs %>% levels
                             #data_def$sensorType %>% levels 
                             #data_def$sensorName %>% levels 
                             #data_def$soilType %>% levels
                             
                             
                             selectInput("Project", label = h4("project"),"placeholder1",  
                                         multiple=T),  
                             #selectInput("Project", label = h4("project"), 
                             #           choices = list("ALL","matsch","monalisa")),
                             
                             selectInput("Landuse", label = h4("land use"),  "placeholder2",multiple=T),               
                             #selectInput("Landuse", label = h4("land use"), 
                             #           choices = list("ALL","appleorchards","meadow","pasture","forest","grassland")),
                             
                             selectInput("Depth", label = h4("soil depth"),"placeholder3",multiple=T),#choices = list("ALL","5","20","40")
                             
                             #selectInput("Station", label = h4("station"), 
                             #           choices = list("ALL","B1","B2","B3","domef1500","domes1500","eppanberg","girlan","gries","I1","I3",
                             #                        "kaltern","lana6","latsch1","latsch3","latsch4","M1","M3","M4","M5","M6",
                             #                        "M7","nals","nemef1500","nemes1500","neumarkt","P1","P2","P3","S2","S4",
                             #                       "S5","stpauls","terlanalt","terlanneu","tramin13","unterrain","vimef2000","vimes2000","XS1")),
                             
                             selectInput("Station", label = h4("station"),  "placeholder4",multiple=T),           
                             
                             selectInput("Date", label = h4("date"),  "placeholder5",multiple=T),
                             #selectInput("Date", label = h4("date"), 
                             #           choices = list("ALL","2013","2014","2015")),
                             
                             selectInput("SoilType", label = h4("soil type"),  "placeholder6",multiple=T),              
                             #selectInput("SoilType", label = h4("soil type"), 
                             #           choices = list("ALL","sandy","loamy","clay")),           
                             
                             selectInput("SensorType", label = h4("sensor type"),  "placeholder7",multiple=T),           
                             #selectInput("SensorType", label = h4("sensor type"), 
                             #           choices = list("ALL","CS655","Decagon10HS","OnsetSMB005")),
                             
                             selectInput("SensorName", label = h4("sensor name"),  "placeholder8",multiple=T),            
                             #selectInput("SensorName", label = h4("sensor name"), selected = "SensorMean",
                             #           choices = list("ALL","SensorMean","A","B","C","CI","LSp","LBL","CSt","T","L","LSt","CSn","TSt","LS","TSn")),
                             
                             br(),
                             
                             checkboxInput("robust", label = "robust estimates", value = FALSE),
                             
                             br(),
                             
                             checkboxInput("facet", label = "facet grid", value = FALSE),
                             checkboxInput("Rownames", label = "show row.names", value = FALSE),
                             checkboxInput("Zoom", label = "zoom in", value = FALSE),
                             fileInput('datafile', 'Choose CSV file',
                                       accept = c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))#,
                             #selectInput("upload_file", label = "use an uploaded file?",choices=c("default","uploaded"))#, value = FALSE
                             
                ),
                
                mainPanel(
                  tabsetPanel(
                    tabPanel("Model Fit",
         
         #fluidRow(
         #column(width = 6,
                plotOutput("plot1", height = 800, width = 800,
                           click = "plot1_click",
                           brush = brushOpts(
                             id = "plot1_brush"
                           ))
                # )
                #   ,
                #column(width = 4,
                # leafletOutput("map")
                # )
                ,
                # column(width = 4,
                actionButton("exclude_toggle", "Toggle points")
                #      )
                ,
                #column(width = 4,
                actionButton("exclude_reset", "Reset")
         #)
#)


),
                    tabPanel("Map Table", 
                             leafletOutput("map")),
                    
                    tabPanel("Diagnostics", plotOutput("plot2", height = 1000, width = 1000,
                                                       click = "plot2_click",
                                                       brush = brushOpts(
                                                         id = "plot2_brush"
                                                       ))),
                    tabPanel("Data Table", 
                             br(),
                             dataTableOutput("table")),
                    
                    tabPanel("Description", 
                             br(),
                             h4("Side Panel for Data Subsetting"),
                             p("The left side panel enables subsetting of the data set. By default the whole unique data set is used. An option for ggplot's facet_grid functionality is included. Klick", em("facet grid"), "and the data set will be shown grouped by landuse and soil depth in the Model Fit panel. One can enable", em("Show row.names"), "to easily choose points to remove. Zooming to the data range of 0 to 60 %vol is also possible."),
                             p("For a description of the data set have a look at", code("?SensorVSample")),
                             p(""),
                             br(),
                             hr(),
                             h4("The Model Fit Panel"),
                             p("The data subset is visualised in a scatter plot. Moreover, the statistical model with the 95% confidence intervall for the estimates is ablined. Estimates are computed either with the lm() function or with robust statistics (SMDM fit from the", strong("robustbase"), "R-package). One can toogle outlying points by klicking one or mark multiple and apply", em("Toogle points"), ". A helpful descision tool for indicating possible outliers are the diagnostic plots on the next panel."),
                             br(),
                             hr(),
                             h4("The Diagnostic Panel"),
                             p("Four diagostic plots for the roblm object are visualised: (1) Standardized residuals vs. Robust Distances, (2) Normal Q-Q vs. Residuals, (3) Residuals vs. Fitted Values, (4) Sqrt of abs(Residuals) vs. Fitted Values"),
                             br(),
                             hr(),
                             h4("The Data Table Panel"),
                             p("The last panel contains the data table of the data subset."))
                  )
                )
  )
)
