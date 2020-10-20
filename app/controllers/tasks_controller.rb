class TasksController < ApplicationController
 def index#レコードの一覧表示
   @tasks = Task.all
 end

 def show#レコード一つ表示
 　@tasks = Task.find(params[:id])
 end

 def new#新規作成ページ
   @tasks = Task.new
 end

 def create#newを処理する
   @tasks = Task.new(task_params)

    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render :new
    end
 end

 def edit
    @task = Task.find(params[:id])
 end

 def update
   @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
 end

 def destroy
   @task = Task.find(params[:id])
   @task.destroy

   flash[:success] = 'タスクは正常に削除されました'
   redirect_to tasks_url
 end
 
 private
  # Strong Parameter
 def task_params
    params.require(:task).permit(:content)
 end
