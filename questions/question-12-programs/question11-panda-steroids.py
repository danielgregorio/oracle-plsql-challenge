import pandas as pd
from sqlalchemy import create_engine
from concurrent.futures import ThreadPoolExecutor
import time

# Function to write CSV for each location
def write_csv_for_location(location, group):
    file_name = f"{location}_inventory.csv"
    group.to_csv(file_name, index=False)

# Connect to the database (update with your DB credentials)
db_url = "oracle+cx_oracle://user:password@host:port/sid"
engine = create_engine(db_url)

# Define the SQL query to extract the required data
sql = """
SELECT item_id, department, unit_cost, stock_on_hand, stock_value, location
FROM inventory_table
"""  # Replace with your actual table name

# Measure the start time
start_time = time.time()

# Fetch data into a pandas DataFrame
df = pd.read_sql(sql, engine)

# Group the data by location
grouped = df.groupby('location')

# Create a ThreadPoolExecutor to parallelize file creation
with ThreadPoolExecutor() as executor:
    for location, group in grouped:
        # Submit the task to the executor for each location
        executor.submit(write_csv_for_location, location, group)

# Measure and print the time it took to execute
elapsed_time = time.time() - start_time
print(f"Time taken to create the files: {elapsed_time:.2f} seconds")
