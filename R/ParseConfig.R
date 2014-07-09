ParseConfig <-
function(fileName){
  Lines  <- readLines(fileName);
  Lines <- chartr("[]", "==", Lines)  # change section headers
  ## convert to table (section breaks have empty first columns)
  d <- read.table(textConnection(Lines), as.is = TRUE, sep = "=", fill = TRUE)
  L <- d$V1 == ""                    # location of section breaks
  ## add section name to 3rd column
  d <- subset(transform(d, V3 = V2[which(L)[cumsum(L)]])[1:3],
                           V1 != "")
  ## convert to R code (removing extra space)
  ToParse <- sprintf("res$%s$%s <- '%s'", d$V3, d$V1, substring(d$V2,2));
  ## run code
  res <- list()
  eval(parse(text=ToParse))
  return(res)
}
