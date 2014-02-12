library(shiny)
library(poppr)
df <- read.table("reduced_database.txt.csv", header=TRUE, sep="\t")
df.m <- as.matrix(df)
newrow <- c()
msn.plot <- NULL
a <- NULL
gen <- NULL
random.sample <- 1

shinyServer(function(input, output) {
 
  treeInput <- reactive({
    switch(input$tree,
           "upgma" = "upgma",
           "nj" = "nj"
           )
  })

  output$distPlotTree <- renderPlot({
    newrow <<- c("query","???",input$mst1,input$mst2,input$mst3,input$mst4,input$mst5,input$mst6,input$mst7,input$mst8,input$mst9)
    if (any(is.na(newrow))){
      plot(c(0,1),c(0,1),ann=F,bty='n',type='n',xaxt='n',yaxt='n') + rect(0,1,1,0.8,col="indianred2",border='transparent' ) + text(x=0.5, y=0.9, "No SSR data has been input.",cex=1.6, col="white")
    }
    df.m <- rbind(df.m,newrow,deparse.level=0)
    df.m <- as.data.frame(df.m)
    gen <<- df2genind(df.m[, -c(1,2)], ploid=2, sep="/", pop=df.m[, 2], ind.names=df.m[, 1])
    if (input$boot > 1000){
      plot(c(0,1),c(0,1),ann=F,bty='n',type='n',xaxt='n',yaxt='n') + rect(0,1,1,0.8,col="indianred2",border='transparent' ) + text(x=0.5, y=0.9, "The number of bootstrap repetitions should be less or equal to 2000",cex=1.6, col="white")
    }
    else if (input$boot < 10){
      plot(c(0,1),c(0,1),ann=F,bty='n',type='n',xaxt='n',yaxt='n') + rect(0,1,1,0.8,col="indianred2",border='transparent' ) + text(x=0.5, y=0.9, "The number of bootstrap repetitions should be greater than 10",cex=1.6, col="white")
    }
    else{
    #Adding colors to the tip values according to the clonal lineage
    gen$other$tipcolor <<- pop(gen)
    levels(gen$other$tipcolor) <<- c("blue","darkcyan","darkolivegreen","darkgoldenrod","red")
    gen$other$tipcolor <<- as.character(gen$other$tipcolor)
      #Running the tree, setting a cutoff of 50 and saving it into a variable to be plotted (a)
    if (input$tree=="nj"){
     a <<- poppr:::genoid.bruvo.boot(gen, sample=input$boot, tree=input$tree, cutoff=50)
     a <<- midpoint(ladderize(a))
    }
    else {
      a <<- bruvo.boot(gen, sample=input$boot, tree=input$tree, cutoff=50)
    }
    #Drawing the tree
    plot(a)
    #Adding the tip lables from each population, and with the already defined colors
    tiplabels(pop(gen), adj=c(-4, 0.5), frame="n", col=gen$other$tipcolor, cex=0.8, font=2)
    
    #Adding the nodel labels: Bootstrap values.
    nodelabels(a$node.label, adj = c(1.2,-0.5), frame="n", cex=0.9, font=3)
    
    if (input$tree=="upgma"){
      axisPhylo(3)
    }
    else if (input$tree == "nj"){
      add.scale.bar(x=0.89,y=1.18,length=0.05,lwd=2)
    }
    }
  })
  
#Minimum Spanning Network
  output$MinSpanTree <- renderPlot({
    newrow <<- c("query","query",input$mst1,input$mst2,input$mst3,input$mst4,input$mst5,input$mst6,input$mst7,input$mst8,input$mst9)
    df.m <- rbind(df.m,newrow,deparse.level=0)
    df.m <- as.data.frame(df.m)
    gen <- df2genind(df.m[, -c(1,2)], ploid=2, sep="/", pop=df.m[, 2], ind.names=df.m[, 1])
    msn.plot <<- bruvo.msn(gen)
    V(msn.plot$graph)$size <<- 10
    #x <<- sample(10000, 1)
    x <<- 200
    set.seed(x)
    plot(msn.plot$graph, vertex.label=NA)
    legend("topleft" ,bty = "n", cex = 1.2, legend = msn.plot$populations,title = "Populations", fill = msn.plot$color, border = NULL)
  })
  
  
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$tree, '.tre', sep='') },
    content = function(file) {
      write.tree(a, file)
    })
  
  output$downloadPdf <- downloadHandler(
    filename = function() { paste(input$tree, '.pdf', sep='') },
    content = function(file) {
      pdf(file)
      plot(a, cex=0.5)
      tiplabels(pop(gen), adj=c(-4, 0.5), frame="n", col=gen$other$tipcolor, cex=0.4, font=2)
      nodelabels(a$node.label, adj = c(1.2,-0.5), frame="n", cex=0.4, font=3)
      if (input$tree=="upgma"){
        axisPhylo(3)
        }
      dev.off()
  })

  output$downloadPdfMst <- downloadHandler(
    filename = function() { paste("min_span_net", '.pdf', sep='')} ,
    content = function(file) {
    pdf(file)
    set.seed(x)
    plot(msn.plot$graph, vertex.label=NA)
    legend("topleft" ,bty = "n", cex = 1.2, legend = msn.plot$populations,title = "Populations", fill = msn.plot$color, border = NULL)
    dev.off()
  }
  )
  
})
