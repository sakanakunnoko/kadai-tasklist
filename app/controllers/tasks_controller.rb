class TasksController < ApplicationController
 def index#レコードの一覧表示
   @task = Task.all
 end

 def show#レコード一つ表示
  set_message
 end

 def new#新規作成ページ
   @task = Task.new
 end

 def create#newを処理する
  set_message

    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render :new
    end
 end

 def edit
    set_message
 end

 def update
  set_message

    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
 end

 def destroy
   set_message
   @task.destroy

   flash[:success] = 'タスクは正常に削除されました'
   redirect_to tasks_url
 end
 
 private
  # Strong Parameter
 def task_params
    params.require(:task).permit(:content)
 end
 
 def set_task
   @message = Message.find(params[:id])
 end

end