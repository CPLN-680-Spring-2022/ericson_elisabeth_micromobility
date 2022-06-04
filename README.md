# MUSA Capstone: Real-Time Micromobility Data Pipeline for Shared Vehicle Survival Modeling

## Final report

The final report is saved in the root directory as `Final Report.pdf`.

## Repo structure

`/py/` contains the Python script I used to query micromobility providers' `free_bike_status` API endpoints, parse JSON requests, and write structured data to a PostgreSQL database on a minute-to-minute basis. This is without a doubt the cleanest code here.

`/notebooks/` contains several Jupyter notebooks with the initial proof-of-concept API scraper, some preliminary exploratory analysis, some technical problem-solving, the revised scraper that I turned into the final script, some more analysis and visualization, and survival modeling to predict vehicle time to activation. These notebooks are _messy_ -- just ran out of time to clean them up before the submission deadline.

`/sql/` contains the queries with which I created my PostgreSQL database tables, along with some draft queries I used to pull data from the database into Python for analysis.

`/r/` contains a couple of small exploratory R scripts I created early on because I still find ggplot easier to use than matplotlib/seaborn.

`/raw_data/` contents include an export of the errors logged to my database by my scraper script, along with the preliminary bikeshare data I collected during a test run of an early version of my scraper in late January, 2022. The latter includes dockless vehicle status, docked station status, and docking station information for Washington, D.C.'s Capital Bikeshare system.

Due to the enormous size of my vehicle database, I could not include my final dataset here. The full `vehicles` table contains more than 212 million records across a dozen partitions, but I may export a sample as a CSV for illustrative purposes.
