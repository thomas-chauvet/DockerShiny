cat("\014")

setwd("/srv/shiny-server/")

if(file.exists("packages.json")) {

	if (!require(jsonlite)) install.packages("jsonlite");library(jsonlite)

	if (!require(devtools)) install.packages("devtools"); library(devtools)

	install_packages_with_version <- function(packages) {
	  # Check keys are valid in json file
	  if(sum(sapply(packages, function(x) sum(names(x) == c("Package", "Version")))) == (length(packages) * 2)) {
	    # Install each package with specific version
	    for (package in packages) {
	      print(paste0("Install ", package$Package, " package with version ", package$Version))
	      devtools::install_version(
	        package = package$Package,
	        version = package$Version
	      )
	    }
	  } else {
	    stop("Keys ('Package' and 'Version') are not present for all elements in 'packages.json'")
	  }
	}

	packages = jsonlite::read_json("packages.json")

	install_packages_with_version(packages)

}
