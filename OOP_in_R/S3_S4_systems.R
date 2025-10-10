## Manisha Barse, October 2025

#devtools::install_github("r-lib/sloop")
library(sloop)
 ### different type of objects
otype(1:10)
#> [1] "base"

otype(mtcars)
#> [1] "S3"

mle_obj <- stats4::mle(function(x = 1) (x - 2) ^ 2)
otype(mle_obj)
#> [1] "S4"

##exploring sloop functions
s3_dispatch(print(Sys.time()))

### difference between base type and object oriented objects
attr(1:10, "class")

attr(mtcars, "class")

## exploring base tyope of OO objects
typeof(1:10)

typeof(mtcars)

typeof(NULL)

typeof(1i)

## Numeric Type
sloop::s3_class(1)
sloop::s3_class(1L)

typeof(factor("x"))
is.numeric(factor("x"))

####################################
##              S3
####################################
# ---- Constructor ----
person_s3 <- function(name, age) {
    if (!is.character(name)) stop("name must be a character")
    if (!is.numeric(age)) stop("age must be numeric")

    structure(list(name = name, age = age), class = "person_s3")
}

# ---- Create Object ----
p1 <- person_s3("Alice", 30)
p2 <- person_s3("Bob", 40)

# Inspect structure
class(p1)        # "Person"
otype(p1)
s3_class(p1)
isS4(p1)
unclass(p1)      # see internal list

# ---- Generic and Methods ----
print_S3 <- function(x)
    UseMethod("print")

print_S3.person_s3 <- function(x) {
    cat("Person name:", x$name, "\nAge:", x$age, "\n")
}

# ---- Dispatch demonstration ----
print_S3(p1)
print_S3.person_s3(p1)

s3_dispatch(print_S3(p1))   # Shows which method was chosen

# print.default <- function(x) {
#     cat("This is the default print method.\n")
# } ## this will override the default base print()
# print(123) #"This is the default print method

# ---- Another Generic ----
summary.person_s3 <- function(x) {
    paste0("Person(", x$name, ", ", x$age, ")")
}
summary(p1)

# ---- Inheritance Example ----
student_s3 <- function(name, age, grade) {
    structure(list(
        name = name,
        age = age,
        grade = grade
    ),
        class = c("student_s3", "person_s3"))
}

print_S3.student_s3 <- function(x) {
    NextMethod()  # call print.Person first
    cat("Grade:", x$grade, "\n")
}

stu <- student_s3("Clara", 22, "A")
print_S3(stu)
s3_dispatch(print(stu))

#------ Access like list- style ------
p1$name
p2$age
stu$grade

## Finding Mmthods defined for a generic or associated with a class
s3_methods_generic("mean")
s3_methods_class("ordered")

## Dispatch
class(matrix(1:5)) #implicit class
s3_class(matrix(1:5))
s3_dispatch(print(matrix(1:5)))


####################################
##              S4
####################################
#----- Define an S4 class ---------
setClass(
  "PersonS4",
  slots = list(
    name = "character",
    age = "numeric"
  )
) #class name by default: UpperCamelCase

print(getSlots("PersonS4"))
print(slotNames("PersonS4"))

# Create object using constructor new()
s4_p1 <- new("PersonS4", name = "Bob", age = 32)
print(s4_p1)

# Access S4 slots using @
cat("Name:", s4_p1@name, "\n")
cat("Age:", s4_p1@age, "\n")

#------ Define a method for S4 class ----------
setGeneric("introduce", function(object) standardGeneric("introduce"))

setMethod("introduce", "PersonS4",
          function(object) {
            cat("Hi, my name is", object@name, "and I am", object@age, "years old.\n")
          })

cat("\nCall introduce() generic on S4 object:\n")
introduce(s4_p1)

# ----- Check differences in structure and dispatch ----
cat("S3 (unclass):\n")
print(unclass(p1))

cat("\nS4 structure via str():\n")
str(s4_p1)

## Validity and formal class definitions in S4
validObject(s4_p1)

showClass("PersonS4")


##################################
## S4: SummarisedExperiment  ##
##################################
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SummarizedExperiment")
# BiocManager::install("airway")
           
# Load packages
library(SummarizedExperiment)
library(airway)

# Load S4 object
data("airway")

# Quick inspection
class(airway)
isS4(airway)
slotNames(airway)
assayNames(airway)
colData(airway)     # sample metadata (DataFrame S4 object)
rowRanges(airway)       # genomic ranges

# Access S4 slots using @
airway@assays           # list of assays
airway@colData          # metadata
airway@metadata         # additional info

# Attempting $ access (will not work for S4 slots)
# airway$assays
# airway$colData

# Use accessor functions instead of @ for safety
head(assay(airway))
colData(airway)

session_info()
