class PostsController < ApplicationController
  def new
  end
  def create
    #render text:params[:post].inspect
    uploaded_io = params[:post][:name]
    File.open(Rails.root.join('public','uploads',uploaded_io.original_filename),'w') do |file|
      file.write(uploaded_io.read)
    end
  end
end
