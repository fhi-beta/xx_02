CreateFakeDataForOneMunicipality <- function(seed = 4) {
  skeleton <- data.table(date = seq.Date(as.Date("2015-01-01"), as.Date("2020-12-31"), by = 1))

  skeleton[, year := as.numeric(strftime(date, format = "%Y"))]
  skeleton[, month := as.numeric(strftime(date, format = "%m"))]
  skeleton[, monthEffect := 0]
  skeleton[month == 2, monthEffect := 0.2]
  skeleton[month == 3, monthEffect := 0.4]
  skeleton[month == 4, monthEffect := 0.7]
  skeleton[month == 5, monthEffect := 1.2]
  skeleton[month == 6, monthEffect := 2.0]
  skeleton[month == 7, monthEffect := 2.2]
  skeleton[month == 8, monthEffect := 2.0]
  skeleton[month == 9, monthEffect := 0.5]
  skeleton[month == 10, monthEffect := 0.2]
  skeleton[month == 11, monthEffect := 0.2]
  skeleton[month == 12, monthEffect := 0.1]

  skeleton[, outbreak := sample(c(0, 1), size = .N, prob = c(0.95, 0.05), replace = TRUE)]
  skeleton[, mu := exp(1.2 + 0.01 * (year - 2000)) + monthEffect + 4 * outbreak]
  skeleton[, n := rpois(n = .N, lambda = mu)]

  d <- tidyr::uncount(skeleton, n)
  d[, year := NULL]
  d[, month := NULL]
  d[, monthEffect := NULL]
  d[, outbreak := NULL]
  d[, mu := NULL]
  suppressWarnings(d[, value := "1 person"])
  
  d <- d[!(date >= "2016-04-01" & date <= "2016-08-15")]

  return(d)
}

CreateFakeData <- function() {
  # individual_level_data
  norwayLocations <- fhidata::norway_locations_b2020
  municipalities <- norwayLocations$municip_code
  data <- vector("list", length = length(municipalities))
  for (i in seq_along(municipalities)) {
    if(runif(1)<0.4) next # skip 40% of municipalities
    data[[i]] <- CreateFakeDataForOneMunicipality(seed = i)
    data[[i]][, location_code := municipalities[i]]
  }
  data <- rbindlist(data)
  setorder(data, location_code, date)

  fwrite(data, file = file.path("input", "individual_level_data.csv"))
  
  # norway_locations
  writexl::write_xlsx(
    fhidata::norway_locations_b2020, 
    path = file.path("data_structural", "norway_locations_b2020.xlsx")
  )
  
}
