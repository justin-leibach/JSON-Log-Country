import geoip2.database, csv, matplotlib.pyplot as plt, numpy as np, io
from PIL import Image
from collections import Counter

def main():
    # input from user
    location = input("Enter absolute file location of .csv file here: ")
    # open and read the csv file, create file handle, write csv data to empty list
    with open(location, "r") as fh:
        csv_data = list(csv.reader(fh, delimiter=","))
    # Reader object is expensive, set as variable for reuse. Would need to change to the location your GeoLite2 data is located
    reader = geoip2.database.Reader("/usr/share/GeoIP/GeoLite2-Country.mmdb")
    # Call strip function and assign it to variable
    stripped_list = strip_csv_data(csv_data)
    # Call geoiplookup function and assign it to a variable
    countries = geoiplookup(reader, stripped_list)
    # Call count_countries function and assing it to a variable
    country_count_dict = count_countries(countries)
    # Call top_countries function and assign variable.
    top_n_countries = top_countries(country_count_dict)
    #consider saving this as a text file upon completion
    print(f"Dictionary with (key:value) of (Country:Count)\n{country_count_dict}")
    ##### PIE CHART OR BAR CHART ######## 
    pie_chart(top_n_countries)
    # bar_chart(top_n_countries)

# This strips the [] and ' from the csv generated by combine-JSON Bash script. Will not create an error if nothing to strip
def strip_csv_data(dirty_list):
    stripped_list = []
    for i in dirty_list:
        stripped = str(i).strip("[]")
        stripped = stripped.strip("'")
        stripped_list.append(stripped)
    return stripped_list    

# looks up the ip in database, returns country name and appends it to a list
def geoiplookup(database, ip_addresses):
    countries = [] 
    for ip in ip_addresses:
        try:
            record = database.country(ip)
        except geoip2.errors.AddressNotFoundError:
            print("Record not found")
            record = None
        # Access the name of the country (from the database dict)
        name = record.country.name
        countries.append(name)
    return countries

# count count countries
def count_countries(country_list):
    country_count_dict = {}
    # create set to make unique list of countries
    country_set = set(country_list)
    for i in country_set:
        # iterative count for country name
        x = country_list.count(i)
        # update the dict using the key value pair syntax (update method does not work)
        country_count_dict[i] = x
    return country_count_dict

# return top N value in the dict
def top_countries(data_dict):
    n = 5
    counter = Counter(data_dict)
    top_n_countries = dict(counter.most_common(n))
    return top_n_countries

########################################    PIE CHART    ###########################################################
# pie chart plot and export.png
def pie_chart(data_dict):
    # create lists of dictionary values (they maintain key:value integrity by their index number as the dict called)
    country_labels = list(data_dict.keys())
    values = list(data_dict.values())
    # give value to numpy array
    y = np.array(values)
    # create pie chart
    plt.pie(y, labels = country_labels)
    # create legend
    plt.legend(title = "Country of Origin:")
    # create a variable for the figure
    fig = plt.gcf()

    #function to convert Matplotlib figure to PIL Image
    def fig2img(fig):
        buf = io.BytesIO()
        fig.savefig(buf)
        buf.seek(0)
        img = Image.open(buf)
        return img
    
    # call the function
    img  = fig2img(fig)

    # save the image
    img.save('countryPieChart.png')
    print("countryPieChart.png saved to current directory")

########################################    BAR CHART    ###########################################################

# Bar chart plot and export.png
def bar_chart(data_dict):
    # create lists of dictionary values (they maintain key:value integrity by their index number as the dict called)
    country_labels = list(data_dict.keys())
    values = list(data_dict.values())
    # give x and y value to numpy array
    x = np.array(country_labels)
    y = np.array(values)
    # create bar chart with skinny width
    plt.bar(x, y, width = 0.1)
    # create a variable for the figure
    fig = plt.gcf()

    #function to convert Matplotlib figure to PIL Image
    def fig2img(fig):
        buf = io.BytesIO()
        fig.savefig(buf)
        buf.seek(0)
        img = Image.open(buf)
        return img
    
    # call the function
    img  = fig2img(fig)

    # save the image
    img.save('countryBarChart.png')
    print("countryBarChart.png saved to current directory")


main()


# Need to add these functionalities still:
    # Sort out top 10 or 4
    # figure out how to use file io effectively for creating 2 different files
    # create pandas functionality for output of of a panda data frame (from the dict)