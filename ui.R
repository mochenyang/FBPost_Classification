library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Facebook Posts Classification"),
  
  sidebarPanel(actionButton("NextButton", "Next"),p("Next Post"),
               verbatimTextOutput("progress"),
               checkboxGroupInput("response", "Select Categories:",
                                  choices = c("Positive Quality"="posQ",
                                              "Positive Money"="posM",
                                              "Positive CSR"="posC",
                                              "Positive Other"="posO",
                                              "Negative Quality"="negQ",
                                              "Negative Money"="negM",
                                              "Negative CSR"="negC",
                                              "Negative Other"="negO",
                                              "Neutral Quality"="neuQ",
                                              "Neutral Money"="neuM",
                                              "Neutral CSR"="neuC",
                                              "Neutral Other"="neuO",
                                              "Unclear Quality"="uncQ",
                                              "Unclear Money"="uncM",
                                              "Unclear CSR"="uncC",
                                              "Unclear Other"="uncO"))
               ),
  
  mainPanel(
    h4("The following post comes from the company:"),
    verbatimTextOutput("company"),
    
    h4("Here is the post:"),
    verbatimTextOutput("text"),
    
    h4("Photo or Video"),
    htmlOutput("media")
  )
)
)
