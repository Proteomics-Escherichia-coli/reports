renv::restore()
files <- c("index.qmd",
           "./processing/processing_steps.qmd",
           "./downstream_analysis/differential expression.qmd")
for (f in files) quarto::quarto_render(input = f)
