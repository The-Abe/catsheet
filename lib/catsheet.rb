# Author: Abe van der Wielen
# Email: abevanderwielen@gmail.com
# Website: https://github.com/the-abe
# Date: 2015-04-16
# File: catsheet.rb

require 'rubygems'
# Require the spreadsheet gem and check for success.
begin
  require 'spreadsheet'
rescue LoadError
  puts "Could not load the spreadsheet gem. Please run \"gem install spreadsheet\"."
  exit 1
end

# Return the length of the string, taking multibyte characters into account.
def string_length(string)
  return string.scan(/./mu).size
end

# Check if the name of a spreadsheet was supplied.
if ARGV[0].nil?
  puts "You did not supply a spreadsheet to open."
  exit 1
end

# Open the spreadsheet supplied in the arguments
begin
  book = Spreadsheet.open(ARGV[0],'r')
rescue Ole::Storage::FormatError
  puts "The file you wanted to open seems to be invalid."
  exit 1
end

# If a sheet number is supplied, use it.
# The spreadsheet gem starts counting from 0, to we decrease the number by one.
# If no number is supplied we assume the first one.
sheet_number = (ARGV[1]||1).to_i - 1
sheet = book.worksheet sheet_number
if sheet.nil?
  puts "There doesn't seem to be a sheet #{sheet_number}."
  exit 1
end

# Build and array of column widths based on the max width per column.
width_array = []
column_counter = 0
sheet.each do |row|
  column_counter = row.length-1 if row.length-1 > column_counter
  row.each_with_index do |cell,index|
    row.format 2
    if width_array[index].nil? || width_array[index] < string_length(cell.to_s)
      cell = " " if cell.nil?
      width_array[index] = string_length(cell.to_s)
    end
  end
end

# Now that we've got the maximum width per column, we can print a table!
sheet.each do |row|
  # Assume we only need two decimals for numbers.
  row.format 2
  row_array = []
  row.each_with_index do |cell,index|
    # Put a space in empty cells so we don't break the layout of the table.
    cell = " " if cell.nil?
    # Get the maximum length from the array and add spaces to make the cell as
    # long as the rest.
    length = width_array[index]
    filler = length - string_length(cell.to_s)
    #Cells without digits are left aligned number cells are right aligned
    if cell =~ /[^\d\.]+/
      row_array << "#{cell}#{' '*filler}"
    else
      row_array << "#{' '*filler}#{cell}"
    end
  end
  # Loop through it all and fill empty cells at the end of the row.
  result_columns = (0..column_counter).map do |index|
    row_array[index].nil? ? " "*width_array[index] : row_array[index]
  end
  result = "|"
  result += result_columns.join("|")
  result += "|"
  puts result
end
exit 0
