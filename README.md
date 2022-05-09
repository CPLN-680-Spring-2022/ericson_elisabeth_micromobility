# MUSA Capstone: Real-Time Micromobility Data Pipeline for Shared Vehicle Survival Modeling

## Final report

The final report is saved in the root directory as `Final Report.pdf`. It has a conclusion now.

## Repo structure

`py` contains the Python script I used to query micromobility providers' `free_bike_status` API endpoints, parse JSON requests, and write structured data to a PostgreSQL database on a minute-to-minute basis. This script is what I would like all my code to look like.

`/notebooks/` contains several Jupyter notebooks with the initial proof-of-concept API scraper, some preliminary exploratory analysis, some technical problem-solving, the revised scraper that I turned into the final script, some more analysis and visualization, and survival modeling to predict vehicle time to activation. These notebooks are _messy_, and I wish I'd had time to clean them up.

`sql` contains the queries with which I created my PostgreSQL database tables, along with some draft queries I used to pull data from the database into Python for analysis.

`/r/` contains a couple of small exploratory R scripts I created early on because I still find ggplot easier to use than matplotlib/seaborn.

`/raw_data/` contents include but are not limited to the following: 

- minute-to-minute inactive dockless bike location data scraped from Washington, D.C.'s Capital Bikeshare system between January 31 and February 1, 2022
- minute-to-minute data for available bicycles and docks at Capital Bikeshare docking stations during the same period
- a one-time scrape of Capital Bikeshare station information on January 31, 2022; Capital Bikeshare trip history data for December 2021 and January 2022
- San Francisco Bay Wheels trip history data for January 2022

I have reorganized the old data slightly and will update this README to reflect it. Due to the enormous size of my vehicle database, I could not possibly include it here. The full `vehicles` table contains 212 million records across a dozen partitions, but I may export a sample as a CSV for illustrative purposes.
