# Object-Oriented Programming in R: S3 and S4 Systems

This project demonstrates object-oriented programming (OOP) in R, focusing on the **S3** and **S4** systems — the foundations behind most R and Bioconductor packages.  

The R script (`.R`), R Markdown (`.Rmd`), and HTML output (`.html`) include:

- S3 concepts: constructors, generic functions, method dispatch, `unclass()` and `$` access.  
- S4 concepts: formal class definitions, slots, `setClass()`, `new()`, `setGeneric()`, `setMethod()`, `@` slot access.  
- Real-world example using **SummarizedExperiment** (airway dataset) to illustrate S4 formal classes in bioinformatics.  
- Inspection and utility functions: `is.object()`, `s3_class()`, `isS4()`, `slotNames()`, `assay()`, `colData()`.  
- Tips on naming conventions, constructor design, and method creation.  

## Requirements

- R >= 4.0  
- Bioconductor packages:
  - `SummarizedExperiment`
  - `airway`
- `{sloop}` for S3 introspection  

## Usage

1. Open the `.R` script or `.Rmd` file in RStudio.  
2. Run each section step by step to see S3 and S4 objects, method dispatch, and real-world S4 examples.  
3. Use the `.html` file to view rendered explanations and output.  

## References

- Hadley Wickham, *Advanced R* (S3 and S4 chapters)  
- Bioconductor: [SummarizedExperiment](https://bioconductor.org/packages/SummarizedExperiment/)  
