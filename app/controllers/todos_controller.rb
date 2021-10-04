class TodosController < ApplicationController
  before_action :find_todo, only: %i[post_update first second destroy]

  # Returns all todos. Filter is optional
  def home
    @todos = Todo.all
    @todos = Todo.ready if params[:todo_filters].eql? 'ready'
    @todos = Todo.not_ready if params[:todo_filters].eql? 'not_ready'
    @todos.order(:created_at)
  end

  # Create a todo with a specific name
  def create
    new_todo = Todo.new(name: params[:name])
    return render json: { error: new_todo.errors }, status: :bad_request unless new_todo.valid?

    new_todo.save!
    redirect_to root_path
  end

  # This method is created because form_tag on html only permits post and get methods
  # Replaces the native update method of todos resources
  def post_update
    @todo.update(name: params[:name])
    @todos = Todo.all.order(:created_at)
    redirect_to root_path
  end

  # Change the state from ready to not_ready
  def first
    @todo.first! if @todo.may_first?
    redirect_to root_path
  end

  # Change the state from not_ready to ready
  def second
    @todo.second! if @todo.may_second?
    redirect_to root_path
  end

  # Delete the requested todo from the database
  def destroy
    @todo.destroy!
    redirect_to root_path
  end

  private

  def find_todo
    @todo = Todo.find_by(id: params[:id])
  end
end
