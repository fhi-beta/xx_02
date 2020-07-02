library(data.table)

# You will need to change your working directory
setwd("C:/Users/riwh/OneDrive - Folkehelseinstituttet/git/2020/xx_02")

fileSources = file.path("code_create_fake_data", list.files("code_create_fake_data", pattern = "*.[rR]$"))
sapply(fileSources, source, .GlobalEnv)

CreateFakeData()
