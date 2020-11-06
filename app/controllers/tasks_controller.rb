class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user #,only: [:destroy]
 #レコードの一覧表示
 def index
   @tasks = current_user.tasks.order(id: :desc).page(params[:page])
 end
 #レコード一つ表示
 def show
   @task = current_user.tasks.find_by(id: params[:id])
 end
 #新規作成ページ
 def new
   @task = current_user.tasks.build
 end
 #newを処理する
 def create
  @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render :new
    end
 end

 def edit
  @task = current_user.tasks.find_by(id: params[:id])
 end

 def update
  @task = current_user.tasks.find_by(id: params[:id])
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
 end

 def destroy
   @task = current_user.tasks.find_by(id: params[:id])
   @task.destroy
   flash[:success] = 'タスクは正常に削除されました'
   redirect_to tasks_url
 end
 
 private
  # Strong Parameter
 def task_params
    params.require(:task).permit(:content, :status)
 end
 
 def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
 end

end