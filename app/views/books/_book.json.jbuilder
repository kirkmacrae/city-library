json.extract! book, :id, :title, :author, :genre, :subgenre, :pages, :publisher, :created_at, :updated_at
json.url book_url(book, format: :json)
