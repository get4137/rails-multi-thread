class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  # POST /posts.json
  def create
    start_time = Time.now
    cpu_cores_number = check_cpu
    do_something(cpu_cores_number)
    end_time = Time.now
    @post = Post.new(body: end_time - start_time, title: "cores were used: #{cpu_cores_number}")
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    start_time = Time.now
    cpu_cores_number = check_cpu
    do_something(cpu_cores_number)
    end_time = Time.now
    respond_to do |format|
      if @post.update(body: end_time - start_time, title: "cores were used: #{cpu_cores_number}")
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def do_something(cpu_cores_number)
    Parallel.each(Post::ARR, in_processes: cpu_cores_number) do |arr|
      math_operation(arr)
    end
  end

  def check_cpu
    physical_cpu_core_number = Concurrent.physical_processor_count
    @cpu = if post_params['title'].to_i < 2
             1
           elsif post_params['title'].to_i > physical_cpu_core_number
             physical_cpu_core_number
           else
             post_params['title'].to_i
           end
  end

  def math_operation(arr)
    arr.each do |c|
      c.even?
      c % 111 == 0
      c.odd?
      puts c if c % 25_239_357 == 0
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
