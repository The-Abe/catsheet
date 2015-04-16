# Catsheet

Catsheet is a very simple script that uses the "spreadsheet" gem to print the
contents of spreadsheets. All it does it print the contents in an ASCII table,
so you'll want to use something like "less" to make it readable.

I've created this simple command line tool because I often run into debugging
spreadsheet imports at work and hate having to copy the files off the server
every time.

# Usage

To use catsheet, all you'll want to do is run the following.

    catsheet spreadsheet.xls

It's also possible to select a worksheet within a spreadsheet with a second
parameter, as follows.

    catsheet spreadsheet.xls 2

Worksheets are numbered starting at one.

# Todo

* ~~Support multibyte strings in determining the length of cells.~~
