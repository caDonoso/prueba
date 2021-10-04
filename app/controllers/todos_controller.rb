class TodosController < ApplicationController
  before_action :find_todo, only: %i[post_update first second destroy]

  def home
    @todos = Todo.all
    @todos = Todo.ready if params[:todo_filters].eql? 'ready'
    @todos = Todo.not_ready if params[:todo_filters].eql? 'not_ready'
    @todos.order(:created_at)
  end

  def create
    new_todo = Todo.new(name: params[:name])
    return render json: { error: new_todo.errors }, status: :bad_request unless new_todo.valid?

    new_todo.save!
    redirect_to root_path
  end

  def post_update
    @todo.update(name: params[:name])
    @todos = Todo.all.order(:created_at)
    redirect_to root_path
  end

  def first
    @todo.first!
    redirect_to root_path
  end

  def second
    @todo.second!
    redirect_to root_path
  end

  def destroy
    @todo.destroy!
    redirect_to root_path
  end

  private

  def find_todo
    @todo = Todo.find_by(id: params[:id])
  end
end
