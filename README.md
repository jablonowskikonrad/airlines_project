# airlines_project
Classification dataset with detailed airline, weather, airport and employment information. Optional cancellation and delay reasons for multiclass applications. 
A dataset with approximately 1.4 million rows.

source = 'https://www.kaggle.com/datasets/threnjen/2019-airline-delays-and-cancellations'

describe_creating_database

Tasks:
• Creating a kernel in Jupyter Notebook based on the 'requirements.txt' file with libraries,
• After the file ‘csv’ from the airport_id, download the API airport data and save the files in 'csv',
• Creating a database in Postgres by python-database connection,
• Load the file 'sql' with the database schema into Python, create a database with tables in Postgres,
• Uploading previously downloaded API data to assigned tables in the database on Postgres.


describe_data_analysis

Goals:
• Creating a backup,
• Checking the uniqueness of the column by which tables will be joined,
• Checking tables for duplicates,
• Matching data types to data in columns,
• Determining descriptive statistics and percentiles,
• Create a main table by pulling selected columns from additional tables,
• Removing outliers in the data set,
• Data aggregation by pandas,
• Plot analysis of selected data by matplotlib / seaborn.


describe_creating_reporting_schema

Goals:
• Creating a list of queries (list of views with aggregated data for visualization) to be performed for the database and saving them to an SQL file,
• Loading the SQL file with queries to the database, creating components that will be visualized.


describe_creating_dashboard

Goals:
• Preparing visualizations for dashboard:  pandas / plotly,
• Creating applications in dash: layouts / pages / link / callback.
