require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(number)
  if number.to_s.length < 10 || number.to_s.length > 11
    '0000000000'
  elsif number.to_s.length == 11 && number[0] == 1
    number[1..9]
  else
    number
  end
end

def find_most_time(file)
  times = []
  file.each do |row|
    times.append(Time.parse(Time.strptime(row[1], '%m/%d/%Y %k:%M').to_s).hour)
  end
  freq = times.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  times.max_by { |v| freq[v] }
end

def find_most_day(file)
  days = []
  file.each do |row|
    days.append(Date.parse((Date.strptime(row[1], '%m/%d/%Y %k:%M').to_s)).cwday)
  end
  freq = days.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  days.max_by { |v| freq[v] }
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end
