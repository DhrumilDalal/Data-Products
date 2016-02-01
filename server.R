library(shiny) 
data(mtcars) 


modelFit <- lm(mpg ~ hp + cyl + wt, data=mtcars) 


mpg <- function(hp, cyl, wt) { 
  modelFit$coefficients[1] + modelFit$coefficients[2] * hp +  
    modelFit$coefficients[3] * cyl + modelFit$coefficients[4] * wt 
} 


shinyServer( 
  function(input, output) { 
    adjusted_weight <- reactive({input$wt/1000}) 
    predicted_mpg <- reactive({mpg(input$hp, as.numeric(input$cyl), adjusted_weight())}) 
    output$inputValues <- renderPrint({paste(input$cyl, "cylinders, ", 
                                             input$hp, "horsepower, ", 
                                             input$wt, "lbs")}) 
    output$prediction <- renderPrint({paste(round(predicted_mpg(), 2), "miles per gallon")},quoted = "FALSE") 
    
    
    
    output$plots <- renderPlot({ 
      par(mfrow = c(1, 3), bg="white") 
      # (1, 1) 
      with(mtcars, plot(hp, mpg, 
                        xlab='Engine HorsePower', col="steelblue",bg="steelblue",cex=2,
                        ylab='MPG',pch=19,
                        main='MPG vs HorsePower')) 
      points(input$hp, predicted_mpg(), col='red', cex=4, pch=23)                  
      # (1, 2) 
      with(mtcars, plot(cyl, mpg, 
                        xlab='# of cylinders',  col="steelblue",bg="steelblue",cex=2,
                        ylab='MPG',pch=19,
                        main='MPG vs # of cylinders')) 
      points(as.numeric(input$cyl), predicted_mpg(), col='red', cex=4, pch=23)   
      # (1, 3) 
      with(mtcars, plot(wt, mpg, 
                        xlab='Weight (lb/1000)',  col="steelblue",bg="steelblue",cex=2,
                        ylab='MPG', pch=19,
                        main='MPG vs weight')) 
      points(adjusted_weight(), predicted_mpg(), col='red', cex=4, pch=23)   
    }) 
  } 
) 
