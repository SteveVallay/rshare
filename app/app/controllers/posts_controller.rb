class PostsController < ApplicationController
  def new
  end
  def create
    #render text:params[:post].inspect
    uploaded_io = params[:post][:name]
    full_path = get_upload_path(get_time_f_s() + uploaded_io.original_filename).to_s
    File.open(full_path,'w') do |file|
      file.write(uploaded_io.read)
    end
    @post = Post.new(params[:post].permit(:title,:text))
    @post.origin_name = uploaded_io.original_filename
    @post.real_name = full_path
    @post.save
    redirect_to @post
  end
  def show
    @post = Post.find(params[:id])
  end

private

  def get_upload_path(file_name)
    return Rails.root.join('public','uploads',file_name)
  end
  def get_time_f_s
    Time.now.to_f.to_s() + '_'
  end

end
