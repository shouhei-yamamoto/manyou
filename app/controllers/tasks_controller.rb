class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  # skip_before_action :login_required, only: [:new, :create]

  # GET /tasks or /tasks.json
  def index
    
    # @tasks = Task.all
    # @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
    if params[:sort_expired]
      @tasks = current_user.tasks.order(deadline: "desc")
    else
      @tasks = current_user.tasks.order(created_at: "desc")
    end  

    if params[:sort_priority]
      @tasks = Task.all
      @tasks = @tasks.order(priority: "asc")
    end

    if params[:task].present?
      if params[:task][:name].present? && params[:task][:status].present?
        #両方name and statusが成り立つ検索結果を返す
        @tasks = @tasks.where('name LIKE ?', "%#{params[:task][:name]}%")
        @tasks =@tasks.where(status: params[:task][:status])
        
        #渡されたパラメータがtask nameのみだったとき
      elsif params[:task][:name].present?
        @tasks = @tasks.where('name LIKE ?', "%#{params[:task][:name]}%")
      
       #渡されたパラメータがステータスのみだったとき
      elsif params[:task][:status].present?
        @tasks =@tasks.where(status: params[:task][:status])
      end
    end

    #渡されたパラメータがラベルのみだったとき
    #
    if params[:label_id].present?
      @tasks = Task.all
      @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] })
      # 途中、後日検証　@tasksと@lavelling連結方法。それぞれ取得はできている
      # @labelling = Labelling.where(label_id: params[:label_id])
      # @tasks = Task.all
      # binding.pry
      # @tasks = @tasks.joins(:labels).where(id: @labelling) 
    end
    @tasks = @tasks.page(params[:page]).per(10)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :content, :deadline, :status, :priority, { label_ids: [] })
    end
end
