class TodosController < ApplicationController
  include ListsController::Responders

  def index
    return no_list if no_list? params[:list_id]
    respond ARD.attrs Todo.where(:list_id => params[:list_id])
  end

  def show
    return no_list if no_list? params[:list_id]
    attribs = ARD.attrs Todo.find_by_id params[:id]

    return no_todo unless attribs

    respond attribs
  end

  def create
    return no_list if no_list? params[:list_id]
    todo = Todo.create filter_params(Todo, params)
    attribs, errors = ARD.attrs_and_errs todo

    return respond 400, :error => errors if errors.any?

    respond attribs
  end

  def no_todo
    respond(404,  :error => 'todo_not_found')
  end

  def no_todo? id
    not id.blank? and not Todo.exists? id
  end

end
