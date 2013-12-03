require 'rubygems'
require 'httparty'
require 'json'
require 'date'

#####################################################################
# Configuration Start
#####################################################################

# For more information about the parameters, see https://appannie.zendesk.com/entries/23215097-2-App-Sales
username = "foo@bar.com" # App Annie username
password = "abc123def" # App Annie password
account_id = "12345" # App Annie account connection id. You can get all account connection info by calling /v1/accounts
graph_title = "App Store Downloads"
graph_type = "line"
hide_totals = false
days_to_show = 30
products = [
    { :title => "App 1", :app_id => 123456789, :color => "red" },
    { :title => "App 2", :app_id => 987654321, :color => "blue" }
]

outputFile = "/Users/foo/Dropbox/yourpath/downloadssboard.json"

#####################################################################
# Configuration End
#####################################################################

options = { :basic_auth => { :username => username , :password => password } }
end_date = Date.today
start_date = (end_date - days_to_show)

months = { 
    "1" => "Jan",
    "2" => "Feb",
    "3" => "Mar",
    "4" => "Apr",
    "5" => "May",
    "6" => "Jun",
    "7" => "Jul",
    "8" => "Aug",
    "9" => "Sep",
    "10" => "Oct",
    "11" => "Nov",
    "12" => "Dec"
}

data_sequences = []
min_total = 0
max_total = 0

products.each do |p|
  downloads_data = []
  response = HTTParty.get("https://api.appannie.com/v1/accounts/#{account_id}/apps/#{p[:app_id]}/sales?break_down=date&start_date=#{start_date.to_s}&end_date=#{end_date.to_s}", options)

  downloads = response.parsed_response["sales_list"]
  downloads.reverse!

  downloads.each do |datapoint|
    date = Date.parse(datapoint["date"])
    date_string = "#{months["#{date.month}"]} #{date.day}"

    value_downloads = datapoint["units"]["app"]["downloads"]
    value_sales = datapoint["revenue"]["app"]["downloads"]
    value = value_downloads.to_i + value_sales.to_i

    min_total = value.to_i if value.to_i < min_total || min_total == 0
    max_total = value.to_i if value.to_i > max_total

    downloads_data << {
      :title => date_string,
      :value => value
    }
  end

  # Add the product to the data sequences.
  data_sequences << { :title => p[:title], :color => p[:color], :datapoints => downloads_data }
end

downloads_graph = {
  :graph => {
    :title => graph_title,
    :type => graph_type,
    :yAxis => {
      :hide => hide_totals,
      :units => {
          #:prefix => "$",
        :min_total => min_total,
        :max_total => max_total
      }
    },
    :datasequences => data_sequences
  }
}

File.open(outputFile, "w") do |f|
  f.write(downloads_graph.to_json)
end
