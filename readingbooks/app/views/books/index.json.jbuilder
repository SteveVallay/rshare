json.array!(@books) do |book|
  json.extract! book, :name, :desc, :image, :uploader, :filesize, :downloads
  json.url book_url(book, format: :json)
end
