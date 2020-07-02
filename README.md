# 2046 SM

## Email

Dear XXXXXXX,

Thank you for agreeing to take part in this assessment! This is an assignment related to infectious disease surveillance that will test your skills in either R or Python. The deadline for submission of the test is 24 hours after you receive this email.

The assessment description is available at https://github.com/folkehelseinstituttet/xx_02/blob/master/README.md

Please read through all of this document before beginning the test.

If you have any questions or problems, please contact Richard via email (richardaubrey.white@fhi.no) or via iMessage/WhatsApp/Signal on +47 XXX XX XXX.

## Github repository

The data required for this test is available at https://github.com/folkehelseinstituttet/xx_02

All folders/files in this email refer to this repository, unless otherwise specified.

## Information about Norway

There was a dramatic regional reform (kommunesammenslåing) that occurred on 2020-01-01, which involved large-scale redistricting and renaming of municipalities (kommuner) and counties (fylker).

Norway now has 356 municipalities and 11 counties. Each county has multiple municipalities inside it.

You can find out more information on the 356 Norwegian municipalities here: https://en.wikipedia.org/wiki/List_of_municipalities_of_Norway

You can find out more information on the 11 Norwegian counties here: https://en.wikipedia.org/wiki/Counties_of_Norway

We have provided you with a "structural" dataset `data_structural/norway_locations_b2020.xlsx` that links `municip_code` (e.g. `municip0301`) to `municip_name` (e.g. `Oslo`) and `county_code` (e.g. `county03`) and `county_name` (e.g. `Oslo`). These are real municipality numbers (`kommunenummer`) and county numbers (`fylkenummer`) based on the geographical units that existed on 2020-01-01.

## Background

The scenario is broadly as follows:

You are responsible for `Disease X`. There is a data file `input/individual_level_data.csv` which contains individual level daily data for `Disease X` for Norway (at the municipality level) between `2015-01-01` and `2020-12-31`. Each row of this dataset corresponds to 1 sick person on that date. To be more explicit:

- If there are 100 rows for `municip0301` on `2015-01-01` it means that there were 100 sick people in `municip0301` on `2015-01-01`.
- If there are 0 rows for `municip0301` on `2015-01-01` it means that there were 0 sick people in `municip0301` on `2015-01-01`.

You will create a Docker image that analyses the data file `input/individual_level_data.xlsx` and saves the results in `output/`.

## Goal (deliverable 1)

You need to upload a public Docker image to Docker hub (https://hub.docker.com/) that we can run with the following command:

`docker run -v ~/git/xx_02/input:/input -v ~/git/xx_02/output:/output USER/xx02`

Where:
- `~/git/xx_02/` corresponds to the location of the https://github.com/folkehelseinstituttet/xx_02 repository on a computer
- USER corresponds to your Docker hub username
- xx02 is the Docker image name

This Docker image will perform the following tasks (folders listed in this section refer to the folder locations inside of the Docker container):

1. Load in the data file `/input/individual_level_data.csv`
2. Download the population data available here: https://data.ssb.no/api/v0/dataset/26975?lang=en
3. Create a dataset that contains the aggregated number of sick people per day per a) municipality, b) county, c) Norway. It will have the following columns: a) location_code (e.g. `municip0301`, `county03`, `norge` for Norway), b) location_name (e.g. Oslo, Norge), c) date, d) num_sick, e) num_population. Save this dataset as `/output/full_day.xlsx`
4. Aggregate your data down to iso-year/iso-weeks for each location. If you are not familiar with iso-week/years, there is information available at https://en.wikipedia.org/wiki/ISO_week_date and https://rdrr.io/cran/surveillance/man/isoWeekYear.html. Your new dataset will have the following columns: a) location_code, b) location_name, c) isoyearweek, d) num_sick, e) num_population. The column isoyearweek will be formatted as `YYYY-WW`. Save this dataset as `/output/full_week.xlsx`
5. For Norway, create a folder called `/output/Norge`. This folder will be used to save the results for national level analyses.
6. For each of the 11 counties, create a folder (e.g. `/output/Norge`, `/output/Oslo`, `/output/Nordland`, `/output/Troms og Finnmark`).
7. For each of the 11 counties, create a second folder inside it called "_county" (e.g. `/output/Oslo/_county`, `/output/Nordland/_county`, `/output/Troms og Finnmark/_county`). These folders will be used to save the results for county level analyses.
8. For each of the 356 municipalities, create a named municipality folder inside the named county folder (e.g. `/output/Oslo/Oslo`, `/output/Rogaland/Eigersund`, `/output/Rogaland/Stavanger`, `/output/Troms og Finnmark/Berlevåg`). These folders will be used to save the results for municipality level analyses.
9. For each of the folders created in points 5 (`/output/Norge`), 7 (e.g. `/output/Oslo/_county`, `/output/Nordland/_county`, `/output/Troms og Finnmark/_county`), and 8 (e.g. `/output/Oslo/Oslo`, `/output/Rogaland/Eigersund`, `/output/Rogaland/Stavanger`, `/output/Troms og Finnmark/Berlevåg`) perform the following analyses (corresponding to the appropriate geographical location:

a) save the datasets `full_day.xlsx` and `full_week.xlsx` (appropriately stratified for the correct geographical location)

b) create and save a png graph called `graph.png`. This graph will have date (days) as the x-axis, and number of sick people as the y-axis. Inside the graph, it will be given the following title: "Disease X in [LOCATION_NAME] (pop. [POPULATION NUMBER])". E.g. "Disease X in Norway (pop. 5 368 000)", or "Disease X in Oslo (pop. 681 067)". It is important that the population is formatted according to the Norwegian standard (i.e. do not separate when a number is 4 digits or less. When a number is 5 digits or more, 3 digits are seperated by whitespace " ", not by commas. e.g. `1000`, `5000`, `10 000`, `100 000`, `1 000 000`).

## Goal (deliverable 2)

You need to upload a github repo containing your Dockerfile and all relevant code/files such that we can independently rebuild your Docker image from `deliverable 1`.

## Submission

Send RichardAubrey.White@fhi.no, GryMarysol.Groneng@fhi.no, and Birgitte.Freiesleben.DeBlasio@fhi.no an email with:

a) the link to your Docker image on Docker-hub (deliverable 1)
b) the link to your Github repo (deliverable 2)

## Hints

If you choose to do this assignment in R, we suggest you take a look at https://www.rocker-project.org/ for Docker images that you can build upon.
