class PostsController < ApplicationController
  def new
  end
  def create
    #render text:params[:post].inspect
    uploaded_io = params[:post][:name]
    md5 = Digest::MD5.hexdigest(uploaded_io.read())
    Rails.logger.info("md5 is:"+ md5)
    p = Post.find_by_md5(md5)
    @post = Post.new(params[:post].permit(:title,:text))
    if p != nil
      @post.errors.add(:md5_exist, p.id)
      render 'new'
      return
    end
    full_path = get_upload_path(get_time_f_s() + uploaded_io.original_filename).to_s
    File.open(full_path,'wb') do |file|
      file.write(uploaded_io.read)
    end
    @post.md5 = md5
    @post.origin_name = uploaded_io.original_filename
    @post.real_name = full_path
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end
  def show
    @post = Post.find(params[:id])
  end
  def index
    @posts = Post.all
  end
  def download
    @post = Post.find(params[:id])
    send_file @post.real_name, :filename => @post.origin_name ,:x_sendfile=>true
  end
  def edit
      @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])
    if @post.update(params[:post].permit(:title,:text))
      redirect_to @post
    else
      render 'edit'
    end
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

private

  def get_upload_path(file_name)
    return Rails.root.join('public','uploads',file_name)
  end
  def get_time_f_s
    Time.now.to_f.to_s() + '_'
  end

end
