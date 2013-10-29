class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :can_edit_books, only: [:edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.search(params[:search])
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    uploaded_io = params[:book][:file]
    aa = uploaded_io.read

    md5 = Digest::MD5.hexdigest(aa)
    Rails.logger.info("md5 is:"+ md5)

    same_book = Book.find_by_md5(md5)

    if same_book != nil
      #@book.errors.add(:exist,same_book.name + " already exist")
      flash[:error] = same_book.name + " already exist !"
    else
      full_path = get_upload_path(get_time_f_s() + uploaded_io.original_filename).to_s
      File.open(full_path,'wb') do |file|
        file.write(aa)
      end

      @book.location = full_path
      @book.name = uploaded_io.original_filename
      @book.md5 = md5
      default_user = current_user.name if current_user
      @book.uploader = default_user || 'N/A'
      @book.filesize = format_file_size(uploaded_io.size())
    end


    respond_to do |format|
      if !same_book && @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  def download
    @book = Book.find(params[:id])
    send_file @book.location, :filename => @book.name ,:x_sendfile=>true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :desc, :image, :uploader, :filesize, :downloads)
    end

    def get_upload_path(file_name)
      return Rails.root.join('public','uploads',file_name)
    end
    def get_time_f_s
      Time.now.to_f.to_s() + '_'
    end
    def format_file_size(size)
      k = 1024
      m = 1024*1024
      if size > m
        (size/m).to_s + ' M'
      else
        (size/k).to_s + ' K'
      end
    end
end
