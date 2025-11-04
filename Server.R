library('bslib')
library('shiny')
source(file = "app_functions.R")
server <- function(input, output) {

 dna_sequence <- reactive({
    gene_dna(length = input$n_bases, 
             base_probs = c(input$prob_A,
                            input$prob_T,
                            input$prob_C,
                            input$prob_G))
    
  })
 
 rna_sequence <- reactive({
   transcribe_dna(dna_sequence())
 })
 
 protein_formation <- reactive({
   translate_rna(rna_sequence())
 })
 
 base <- reactive({
   base_freqs(dna_sequence())
   
 })
 
  output$dna<- renderText({dna_sequence()})
  
  output$rna <- renderText({rna_sequence()})
  
  output$protein <- renderText({protein_formation()})
  
  output$basecounts <- renderTable({base()})
}
