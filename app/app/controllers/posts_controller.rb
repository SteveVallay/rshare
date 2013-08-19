class PostsController < ApplicationController
  def new
  end
  def create
    #render text:params[:post].inspect
    uploaded_io = params[:post][:name]
    time = Time.now.to_f.to_s() + '_'
    File.open(Rails.root.join('public','uploads',time + uploaded_io.original_filename),'w') do |file|
      file.write(uploaded_io.read)
    end
    @post = Post.new(params[:post].permit(:title,:text))
    @post.save
    redirect_to @post
  end
  def show
    @post = Post.find(params[:id])
  end
end
