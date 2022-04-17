"""Scrapes D.C. dockless vehicle locations every minute.

Scrapes General Bikeshare Feed Specification (GBFS) free_bike_status API endpoints for all current Washington, D.C.
dockless vehicle providers as of 2022-06-16. Saves data to a PostgreSQL database. Logs any errors to a separate table.
"""

import traceback
import time

import requests
import psycopg
import schedule

from datetime import datetime

def main():
    """Schedules scraper to run once every minute."""

    schedule.every().minute.at(':00').do(scrape_all)

    while True:
        schedule.run_pending()
        time.sleep(1)

def scrape_dockless_vehicles(provider, time_scraped=None):
    """Scrapes dockless vehicle locations from an API endpoint.

    Queries General Bikeshare Feed Specification (GBFS) free_bike_status API endpoint for a Washington, D.C.
    dockless vehicle provider, parses JSON vehicle data, and saves select fields to a PostgreSQL database.

    Args:
        provider (str): Vehicle provider name.
        time_scraped (datetime, optional): Timestamp. Omit unless passed by wrapper function.
    """

    # set timestamp if not passed from wrapper function
    if time_scraped == None:
        time_scraped = datetime.now().astimezone().isoformat(timespec='seconds', sep=' ')

    # GBFS free_bike_status endpoint URLs for all D.C. dockless providers as of 2022-04-13
    # source: https://ddot.dc.gov/page/dockless-api
    provider_urls = {
        'Bird': 'https://gbfs.bird.co/dc',
        'Capital Bikeshare': 'https://gbfs.capitalbikeshare.com/gbfs/en/free_bike_status.json',
        'Helbiz': 'https://admin-api-prod.helbizscooters.com//reporting/washington/gbfs/free_bike_status.json',
        'Lime': 'https://data.lime.bike/api/partners/v1/gbfs/washington_dc/free_bike_status.json',
        'Lyft': 'https://s3.amazonaws.com/lyft-lastmile-production-iad/lbs/dca/free_bike_status.json',
        'Spin': 'https://gbfs.spin.pm/api/gbfs/v1/washington_dc/free_bike_status'
    }

    # select correct URL for passed provider
    url = provider_urls[provider]

    # retrieve data from API endpoint; convert to JSON
    r = requests.get(url)
    j = r.json()

    # extract individual vehicles
    bikes = j['data']['bikes']

    # connect to database
    with psycopg.connect("dbname=capstone-local user=eli") as conn:

        # open cursor to perform database operations
        with conn.cursor() as cur:

            # iterate through JSON objects to parse
            for bike in bikes:

                # select relevant fields, coercing type where necessary
                bike_id = bike['bike_id']
                vehicle_type = bike['vehicle_type'] if 'vehicle_type' in bike else bike['type']
                is_reserved = bool(bike['is_reserved'])
                is_disabled = bool(bike['is_disabled'])
                battery_level = bike['battery_level'] if 'battery_level' in bike else None
                lat = bike['lat']
                lon = bike['lon']

                # add vehicle data to database
                cur.execute("""
                    INSERT INTO vehicles (
                        provider,
                        bike_id,
                        vehicle_type,
                        is_reserved,
                        is_disabled,
                        battery_level,
                        lat,
                        lon,
                        time_scraped)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """,
                            (provider, bike_id, vehicle_type, is_reserved, is_disabled, battery_level, lat, lon,
                             time_scraped))

            # commit updates to database
            conn.commit()


def scrape_all():
    """Scrapes dockless vehicles for all D.C. providers.

    Calls vehicle scraper function for all current Washington, D.C. dockless providers as of 2022-04-16.
    If scrape fails, logs timestamped traceback to database table.
    """

    time_scraped = datetime.now().astimezone().isoformat(timespec='seconds', sep=' ')

    providers = ['Bird', 'Capital Bikeshare', 'Helbiz', 'Lime', 'Lyft', 'Spin']

    for provider in providers:

        try:
            scrape_dockless_vehicles(provider, time_scraped=time_scraped)

        except:
            time_failed = datetime.now().astimezone().isoformat(timespec='seconds', sep=' ')
            traceback_text = traceback.format_exc()

            with psycopg.connect("dbname=capstone-local user=eli") as conn:

                with conn.cursor() as cur:
                    cur.execute("""
                        INSERT INTO errors (time_scraped, provider, time_failed, traceback) 
                        VALUES (%s, %s, %s, %s)
                        """, (time_scraped, provider, time_failed, traceback_text))

                    conn.commit()

if __name__ == '__main__':
    main()