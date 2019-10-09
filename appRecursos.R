
library(shiny)
library(tidyverse)
library(DT)
library(extrafont)
library(here)
library(janitor)


# Pre-procesamiento ----------------------------
# leo los recursos compilados por Chicasentecnología

#reading_list <- read_tsv("D:/Patri/RPROJECTS/appCETecnologia/Reservorio.txt")
reading_list <- read_tsv("Reservorio.txt")

prueba <-reading_list%>%janitor::clean_names()
prueba
prueba2<-prueba%>%mutate(apellido_autor = toupper(prueba$apellido_autor), titulo = toupper(titulo),nombre_revista= toupper(nombre_revista), etiquetas= toupper(etiquetas), idioma=toupper(idioma), genero_autor= toupper(genero_autor))
prueba2

datatable(prueba2)
#Create string for hyperlinks

#reading_table2 <- prueba2 %>%
  #mutate(title_link =  paste0(titulo, " <a href='",link, "' target='_blank'></a>")) %>%
  #select(title_link, everything(), -titulo, -link, -etiquetas)
#datatable(reading_table2)

#reading_table <- prueba2 %>%
 # mutate(title_link =  paste0("<a href='",link,"' target='_blank'>",titulo,"</a>")) %>%
  #select(title_link, apellido_autor, nombre_revista, ano, idioma, genero_autor)
#datatable(reading_table)
    
URL link: <a href="https://www.google.com/">Google Homepage</a>

reading_table2 <- prueba2 %>%
 #mutate(title_link =  paste0("<a href='",link,"' target='_blank'>", ,"</a>")) %>%
 select(titulo, apellido_autor, nombre_revista, link, ano, idioma, genero_autor)
datatable(reading_table2)


# UI -------------------------------
ui <- fluidPage(
  # formatting with css
  includeCSS("styles.css"),
  #library(DT),
 
  shinyUI(fluidPage(
    # Application title
    titlePanel("Reservorio sobre Género en Ciencia, Tecnología, Ingeniería y Matemáticas (CTIM)"),
    
   # h2(toupper("Reservorio dinámico sobre Género en Ciencia, Tecnología, Ingeniería y Matemáticas (CTIM)")),
    
    # Intro text
    p(" Una colección de artículos de diarios electrónicos, científicos y de revistas on-line, blogs, informes, libros electrónicos, páginas webs y videos sobre Género en Ciencia, Tecnología, Ingeniería y Matemáticas"),
    
    p("Si existe algún material que creas que debe ser agregado, por favor podés sumar tu aporte en este",a("formulario", href = "https://forms.gle/ReDEEbx4Dqt28YzX7")),
    
    # DT table
    DTOutput("tbl"),
    
    br(),
    br(),
  # credits
  div(p("Compilado por", a("@chicasentecnología", href = "https://twitter.com/chicasentec"), "y desarrollado por", a("@patriloto", href = "https://twitter.com/patriloto"), "usando los paquetes shiny y DT"), 
     # p("Blog:", a("davidsmale.netlify.com", href = "https://davidsmale.netlify.com/portfolio/")),
      p("GitHub:", a("Recursos sobre Género", href = "https://github.com/PatriLoto/appRecursosGenero")),
      style="text-align: right;")
  )))

# Server -------------------------------

server <- function(input, output) {
  
  # render DT table
  output$tbl <- renderDT({
    
    datatable(reading_table2,
              colnames = c('Título','Autor(es)','Revista','Link','Año','Idioma','Género del Autor'),
              rownames = FALSE,
              escape = TRUE,
              class = 'display',
              style = 'default',
             # filter = c ("none", "top","bottom"),
              options = list(pageLength = 20,
                             lengthMenu = c(10, 20, 50)))
              
    
  })
  
}

# Run the application

shinyApp(ui = ui, server = server)
