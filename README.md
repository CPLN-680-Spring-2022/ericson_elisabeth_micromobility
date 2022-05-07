# Scraping Real-Time Dockless Vehicle Data to Model Time to Activation

## Status

An unfinished version of the final report is saved in the root directory as "Final report - UNFINISHED." I have had another difficult medical week but am continuing to write.

## Repo structure

`py` contains Python scripts, currently only the scraper collecting inactive vehicle locations on a minute-to-minute basis.

`/notebooks/` contains Jupyter notebooks with the initial proof-of-concept API scraper, some preliminary exploratory analysis, some technical problem-solving, and the revised scraper that I turned into the final script.

`sql` contains the queries with which I created my PostgreSQL database tables.

`/r/` contains a couple of small exploratory R scripts I created early on because I still find ggplot easier to use than matplotlib/seaborn.

`/raw_data/` contains the following: 

- minute-to-minute inactive dockless bike location data scraped from Washington, D.C.'s Capital Bikeshare system between January 31 and February 1, 2022
- minute-to-minute data for available bicycles and docks at Capital Bikeshare docking stations during the same period
- a one-time scrape of Capital Bikeshare station information on January 31, 2022; Capital Bikeshare trip history data for December 2021 and January 2022
- San Francisco Bay Wheels trip history data for January 2022

Of those, I am currently only using the first dataset; I explored the others in the initial stages of this project.