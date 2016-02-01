library(shiny) 
shinyUI(pageWithSidebar( 
  headerPanel('Developing Data Products'), 
  sidebarPanel( 
    h3('MPG Prediction UI'), 
    p('Enter the gross horsepower, number of cylinders, and weight of your  
      car below.  The predicted MPG will be shown to the right.'), 

    
    radioButtons('cyl', 'Number of cylinders in Car:', c('4' = 4, '6' = 6, '8' = 8), selected = '6'),  
   
    
    numericInput('hp', 'Engine horsepower:', 140, min = 50, max = 330, step = 10),  
    
    sliderInput('wt', 'Weight (lbs):', 3200, min = 1500, max = 5500, step = 100) 
    ), 
  mainPanel( 
    h6('Course Project by Dhrumil Dalal  30/1/2016'), 
    h3('Predicted MPG'), 
    h4('Inputs Provided:'), 
    verbatimTextOutput("inputValues"), 
    h4('Which resulted in a prediction of:'), 
    verbatimTextOutput("prediction"), 
    h4('MPG relative to cars in mtcars data set'), 
    plotOutput('plots'), 
    h3('Method'), 
    p('This project simply fits a linear model to the mtcars dataset, modeling the effect of  
      horsepower, number of cylinders.' ),
    HTML(" The application accepts 3 inputs  <ul><li>Number of cylinders</li><li>Engine Horsepower</li><li>Vehicle Weight</li></ul>"),
    p('Based on these inputs the MPG is predicted.' )
    ) 
  )) 
