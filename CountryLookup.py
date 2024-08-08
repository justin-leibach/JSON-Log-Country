import geoip2.database, csv

def main():
    # input from user
    location = input("Enter absolute file location here: ")
    # initialize empty list
    csv_data = []
    # open and read the csv file, create file handle, write csv data to empty list
    with open(location, "r") as fh:
        csv_data = list(csv.reader(fh, delimiter=","))
    print(csv_data)

main()