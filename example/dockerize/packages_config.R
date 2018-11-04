#!/usr/bin/env Rscript

rm(list = ls())
cat("\014")

args = commandArgs(trailingOnly=TRUE)

if(!require(stringr)) install.packages("stringr")

scan_packages <- function(file) {
  x = readLines(file, warn = FALSE)
  packages = stringr::str_extract_all(
    x,
    "(library\\([A-Za-z0-9]+\\))|(require\\([A-Za-z0-9]+\\))|([A-Za-z0-9]+::)"
  ) %>% unlist %>% 
    stringr::str_replace_all(
      pattern = "library\\(|\\)|require\\(|::", 
      replacement = "")
  return(packages)
}

scan_all_R_files <- function(path="") {
  files <- list.files(pattern = "\\.R$", recursive = TRUE)
  files = files[files != "install_packages.R"]
  return(unique(unlist(sapply(files, scan_packages))))
}

filtered_installed_packages <- function(packages) {
  installed_packages = data.frame(installed.packages())[,c("Package", "Version")]
  installed_packages$Package = as.character(installed_packages$Package)
  installed_packages$Version = as.character(installed_packages$Version)
  installed_packages = installed_packages[installed_packages$Package %in% packages,]
  return(installed_packages)
}

path = ""

if(!is.null(args)) {
  path = args[1]
}

packages = scan_all_R_files(path)
installed_packages = filtered_installed_packages(packages)
row.names(installed_packages) = NULL
write(jsonlite::toJSON(installed_packages, pretty = TRUE), file = paste0(path, "/packages.json"))

