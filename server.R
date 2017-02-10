# credit: http://stackoverflow.com/questions/38302682/next-button-in-a-r-shiny-app

library(shiny)

# read posts
posts = read.csv("10640 final sample.txt", sep = '\t', header = TRUE, stringsAsFactors = FALSE)
outputDir <- "labels"

shinyServer(function(input, output, session) {

  # make a counter
  values = reactiveValues()
  has_label = length(list.files(outputDir))
  values$count = has_label
  
  nextPost <- eventReactive(input$NextButton,{
    if(is.null(input$response) & values$count > has_label){
      return(posts[values$count,])
    }
    else{
      if(values$count > has_label){
        write.csv(input$response, file = file.path(outputDir, posts[values$count,]$postid), 
                  row.names = FALSE, quote = FALSE)
      }
      values$count = values$count + 1
      updateCheckboxGroupInput(session = session, inputId = "response", choices = c("Positive Quality"="posQ",
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
      return(posts[values$count,])
    }
  })
  
  output$company = renderText({nextPost()$company})
  
  output$text = renderText({nextPost()$message})
  
  output$media = renderUI({
    if(nextPost()$type %in% c("photo", "video")){
      tags$a(href=nextPost()$link, "Click to view", target="_blank")
    }
  })
  
  output$progress = renderText({paste("Finished", values$count, "out of 10640")})
  
  observe({
    if (values$count > nrow(posts)){
      stopApp()
    }
  })

})
