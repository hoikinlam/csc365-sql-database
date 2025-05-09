import csv
import sys
def generate_sql_from_csv(csv_file, sql_file, table_name):
    # Open the CSV file
    with open(csv_file, 'r') as csvfile:
        csvreader = csv.reader(csvfile)
        # Extract the header to use as column names
        header = next(csvreader)  # Skipping the header in CSV file
        # Open the SQL file to write the generated SQL statements
        with open(sql_file, 'w') as sqlfile:
            # Start generating SQL Insert statements
            for row in csvreader:
                # Skip empty rows
                if len(row) == 0:
                    continue
                try:
                    # Prepare the insert statement by combining the column names and values
                    WineID = row[0]
                    GrapeName = row[1]
                    WineryName = row[2]
                    Appelation = row[3]
                    State = row[4]
                    Name = row[5]
                    Year = row[6]
                    Price = row[7]
                    Score = row[8]
                    Cases = row[9]
                    Drink = row[10]
                    # Constructing the SQL Insert statement
                    sql_insert_statement = (
                        f"INSERT INTO {table_name} (WineID, GrapeName, WineryName, Appelation, State, Name, Year, Price, Score, Cases, Drink) "
                        f"VALUES ({WineID}, {GrapeName}, {WineryName}, {Appelation}, {State}, {Name}, {Year}, {Price}, {Score}, {Cases}, {Drink});\n"
                    )
                    # Write the SQL insert statement into the file
                    sqlfile.write(sql_insert_statement)
                except IndexError:
                    # Log the error and continue with other rows
                    print(f"Skipping row due to missing values: {row}")
                    continue
if __name__ == "__main__":
    # Check if correct number of arguments are provided
    if len(sys.argv) != 2:
        print("Usage: python script_name.py <csv_file_path>")
        sys.exit(1)
    # File paths
    csv_file = sys.argv[1]                # Path to the CSV file provided as an argument
    sql_file = 'WINE-build-Wine.sql'    # Output SQL file
    table_name = 'Wine'               # Your actual table name
    # Call the function to generate the SQL file
    generate_sql_from_csv(csv_file, sql_file, table_name)
    print(f"SQL script has been generated and saved to {sql_file}")