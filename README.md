# Scraping Real-Time Dockless Vehicle Data to Model Time to Activation

## Status

The final report is saved in the root directory. It is currently missing a conclusion, but is reasonably comprehensive otherwise, I think.

## Repo structure

`py` contains Python scripts, currently only the scraper collecting inactive vehicle locations on a minute-to-minute basis.

`/notebooks/` contains Jupyter notebooks with the initial proof-of-concept API scraper, some preliminary exploratory analysis, some technical problem-solving, and the revised scraper that I turned into the final script.

`sql` contains the queries with which I created my PostgreSQL database tables.

`/r/` contains a couple of small exploratory R scripts I created early on because I still find ggplot easier to use than matplotlib/seaborn.

`/raw_data/` contents include but are not limited to the following: 

- minute-to-minute inactive dockless bike location data scraped from Washington, D.C.'s Capital Bikeshare system between January 31 and February 1, 2022
- minute-to-minute data for available bicycles and docks at Capital Bikeshare docking stations during the same period
- a one-time scrape of Capital Bikeshare station information on January 31, 2022; Capital Bikeshare trip history data for December 2021 and January 2022
- San Francisco Bay Wheels trip history data for January 2022

I have reorganized the old data slightly and will update this README to reflect it. Due to the enormous size of my vehicle database, I could not possibly include it here. A day's worth of data is 1.5 gb, and I collected nearly two weeks' worth, but I may export a sample as a CSV for illustrative purposes.