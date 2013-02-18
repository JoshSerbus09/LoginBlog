class PostsController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
	# GET /posts
	# GET /posts.json
	def index
		@posts = Post.all

		respond_to do |format|
			format.html #index.html.erb
			format.json {render json: @posts }
		end
	end

	def show
		@post = Post.find(params[:id])

		respond_to do |format|
			format.html
			format.json {render json: @post }
		end
	end

	# GET /posts/new
  	# GET /posts/new.json
	def new
		@post = Post.new
		@post.uid = current_user.id

		respond_to do |format|
			format.html
			format.json {render json: @post }
		end
	end

	def edit
		if current_user.id == Post.find(params[:id]).uid
			@post = Post.find(params[:id])
		else
			respond_to do |format|
				format.html { redirect_to posts_url, notice: 'You may only edit your own posts'}
				format.json { render json: @post.error, stats: :unprocessable_entity }
			end
		end	
	end

	def create 
		@post = Post.new(params[:post])
		@post.uid = current_user.id

		respond_to do |format|
			if @post.save
				format.html { redirect_to @post, notice: 'Post Successful'}
				format.json { render json: @post, status: :created, location: @post}
			else 
				format.html { render action: "new"}
				format.json { render json: @post.errors, stats: :unprocessable_entity}
			end	
		end
	end 

	def update 
		@post = Post.find(params[:id])

		respond_to do |format|
			if @post.update_attributes(params[:post])
				format.html { redirect_to @post, notice: "Post Updated" }
				format.json { head :no_content }
			else 
				format.html { render action: "edit" }
				format.json { render json: @post.errors, stats: :unprocessable_entity }
			end
		end
	end

	def destroy
		if current_user.id == Post.find(params[:id]).uid
			@post = Post.find(params[:id])
			@post.destroy

			respond_to do |format|
				format.html { redirect_to posts_url }
				format.json { head :no_content }
			end
		else 
			respond_to do |format|
				format.html { redirect_to posts_url, notice: 'You may only delete your own posts'}
				format.json { render json: @post.error, stats: :unprocessable_entity }
			end	
		end
	end	

	def username
		@post = Post.find(params[:id])
		@post.user.username
	end
end
