# Predicting Shared Dockless Vehicle Time to Activation

`/raw_data/` currently contains the following: 

- minute-to-minute inactive dockless bike location data scraped from Washington, D.C.'s Capital Bikeshare system between January 31 and February 1, 2022
- minute-to-minute data for available bicycles and docks at Capital Bikeshare docking stations during the same period
- a one-time scrape of Capital Bikeshare station information on January 31, 2022; Capital Bikeshare trip history data for December 2021 and January 2022
- San Francisco Bay Wheels trip history data for January 2022

Of those, I am currently only using the first dataset; I explored the others in the initial stages of this project.

`/notebooks/` contains a handful of Jupyter notebooks containing the initial proof-of-concept API scraper, some preliminary exploratory analysis, and some technical problem-solving.

`/r/` contains a couple of small exploratory R scripts I created early on because I still find ggplot easier to use than matplotlib/seaborn.