
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$model1info = renderTable({
    startYear = as.numeric(input$yearIntervention)
    startMonth = as.numeric(input$monthIntervention)
    
    yearDiff = startYear - min(crimeData$Year)
    monthDiff = startMonth - min(crimeData$Month)
    
    startID = yearDiff * 12 + monthDiff + 1
    crimeData$intervOn = as.numeric(crimeData$TrendID >= startID)
    
    crimeData_this = crimeData %>% filter(., City == input$cityChoiceExp)
    
    control = crimeData %>% filter(., City == input$cityChoiceCont)
    
    
    model1 = arimax(x=select(crimeData_this, input$homsOrGMI),
                   order=c(1,0,0), xreg=crimeData_this$intervOn)
    
    model1coefs = model1$coef
    
    model1pVals = (1-pnorm(abs(model1$coef)/sqrt(diag(model1$var.coef))))*2
    
    rownames_outTable = c("1-month lagged data", "Intercept", "Intervention in place?")
    
    outTable = as.data.frame(cbind(rownames_outTable, model1coefs, model1pVals, as.logical(model1pVals < .05)))
    
    names(outTable) = c("Coefficient", "Value", "p value", "Significant to p < .05?")
    
    outTable
  })
  
  output$model1text = renderText({"Baseline Significance Test of Intervention"})
  
  output$model2text = renderText({"Comparison to Control"})
  
  output$model2info = renderTable({
    startYear = as.numeric(input$yearIntervention)
    startMonth = as.numeric(input$monthIntervention)
    
    yearDiff = startYear - min(crimeData$Year)
    monthDiff = startMonth - min(crimeData$Month)
    
    startID = yearDiff * 12 + monthDiff + 1
    crimeData$intervOn = as.numeric(crimeData$TrendID >= startID)
    
    crimeData_this = crimeData %>% filter(., City == input$cityChoiceExp)
    
    control = crimeData %>% filter(., City == input$cityChoiceCont)
    
    model2 = arimax(x=select(crimeData_this, input$homsOrGMI), order=c(1,0,0),
                   xreg=cbind(crimeData_this$intervOn, select(control, input$homsOrGMI)))
    
    model2coefs = model2$coef
    
    model2pVals = (1-pnorm(abs(model2$coef)/sqrt(diag(model2$var.coef))))*2
    
    rownames_outTable = c("1-month lagged data", "Intercept", "Intervention in place?", "Control City Shootings or GMI")
    
    outTable = as.data.frame(cbind(rownames_outTable, model2coefs, model2pVals, as.logical(model2pVals < .05)))
    
    names(outTable) = c("Coefficient", "Value", "p value", "Significant to p < .05?")
    
    outTable
  })
  
  output$model3text = renderText({"Comparison to Co-offenses"})
  
  output$model3info = renderTable({
    startYear = as.numeric(input$yearIntervention)
    startMonth = as.numeric(input$monthIntervention)
    
    yearDiff = startYear - min(crimeData$Year)
    monthDiff = startMonth - min(crimeData$Month)
    
    startID = yearDiff * 12 + monthDiff + 1
    crimeData$intervOn = as.numeric(crimeData$TrendID >= startID)
    
    crimeData_this = crimeData %>% filter(., City == input$cityChoiceExp)
    
    model3 = arimax(x=select(crimeData_this, input$homsOrGMI), order=c(1,0,0),
                   xreg=cbind(crimeData_this$intervOn, crimeData_this$CoOffends))
    
    model3coefs = model3$coef
    
    model3pVals = (1-pnorm(abs(model3$coef)/sqrt(diag(model3$var.coef))))*2
    
    rownames_outTable = c("1-month lagged data", "Intercept", "Intervention in place?", "Co-Offenses")
    
    outTable = as.data.frame(cbind(rownames_outTable, model3coefs, model3pVals, as.logical(model3pVals < .05)))
    
    names(outTable) = c("Coefficient", "Value", "p value", "Significant to p < .05?")
    
    outTable
  })
  
  output$model5text = renderText({"Combined Model"})
  
  output$model5info = renderTable({
    startYear = as.numeric(input$yearIntervention)
    startMonth = as.numeric(input$monthIntervention)
    
    yearDiff = startYear - min(crimeData$Year)
    monthDiff = startMonth - min(crimeData$Month)
    
    startID = yearDiff * 12 + monthDiff + 1
    crimeData$intervOn = as.numeric(crimeData$TrendID >= startID)
    
    crimeData_this = crimeData %>% filter(., City == input$cityChoiceExp)
    
    control = crimeData %>% filter(., City == input$cityChoiceCont)
    
    model5 = arimax(x=select(crimeData_this, input$homsOrGMI), order=c(1,0,0),
                    xreg=cbind(crimeData_this$intervOn, select(control, input$homsOrGMI),
                               crimeData_this$CoOffends))
    
    model5coefs = model5$coef
    
    model5pVals = (1-pnorm(abs(model5$coef)/sqrt(diag(model5$var.coef))))*2
    
    rownames_outTable = c("1-month lagged data", "Intercept", "Intervention in place?", "Control City Shootings or GMI", "Co-Offenses")
    
    outTable = as.data.frame(cbind(rownames_outTable, model5coefs, model5pVals, as.logical(model5pVals < .05)))
    
    names(outTable) = c("Coefficient", "Value", "p value", "Significant to p < .05?")
    
    outTable
  })
  
})
