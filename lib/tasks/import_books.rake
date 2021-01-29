require 'roo'
#TODO: this import will not work for the city library system.
namespace :import_books do
  desc "import excel sheet of library books for single library"
  task single_library: :environment do
    puts 'Importing Data'

    #before running script make sure excel file can be found at 'lib/data.xlsx'
    data = Roo::Spreadsheet.open('lib/data.xlsx')    
    headers = data.row(1)
    headers.map!(&:downcase)

    data.each_with_index do |row, index|
      next if index == 0

      #grab number of copies for each row
      copies = data.cell(index+1,data.last_column)
      #for each copy of the book
      for i in 1..copies
        #add a copy of the book
        book_data = Hash[[headers,row].transpose]
        #remove "copies" from the book_data hash
        book_data.except!("copies")
        
        #check to see if existing book exists and use that book_number otherwise assign next available number
        @matching_book = Book.where(book_data).take
        if @matching_book
          book_data[:book_number] = @matching_book.book_number
        else
          book_data[:book_number] = Book.maximum(:book_number).to_i.next
        end
        
        book = Book.new(book_data)
        book.save!        
      end
    end
  end

  desc "import excel sheet of city library books for multiple libraries"
  task city_library: :environment do
    puts 'Importing Data'

    #before running script make sure excel file can be found at 'lib/data.xlsx'
    data = Roo::Spreadsheet.open('lib/data.xlsx')    
    headers = data.row(1)
    headers.map!(&:downcase)

    data.each_with_index do |row, index|
      next if index == 0

      #grab number of copies for each row
      copies = data.cell(index+1,data.last_column)
      library = data.cell(index+1,data.first_column)

      #get library id
      @existing_library = Library.where(name: library).take

      if @existing_library
        library_id = @existing_library.id
      else
        new_library = Library.new(name: library)
        new_library.save!
        library_id = new_library.id
      end

      #for each copy of the book
      for i in 1..copies
        #add a copy of the book
        book_data = Hash[[headers,row].transpose]
        #remove "copies" from the book_data hash
        book_data.except!("copies","library")
                
        #check to see if existing book exists and use that book_number otherwise assign next available number
        @matching_book = Book.where(book_data).take
        if @matching_book
          book_data[:book_number] = @matching_book.book_number
        else
          book_data[:book_number] = Book.maximum(:book_number).to_i.next
        end
        
        book_data[:library_id] = library_id

        book = Book.new(book_data)
        book.save!        
      end
    end
  end

end
