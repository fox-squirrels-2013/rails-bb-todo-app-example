class ListsController < ApplicationController

  def index
    respond ARD.attrs List.all
  end

  def show
    attribs = ARD.attrs List.find params[:id]

    return no_list unless attribs

    respond attribs
  end

  def create
    list = List.create filter_params(List, params)
    attribs, errors = ARD.attrs_and_errs list

    return respond 400, errors if errors.any?

    respond attribs
  end

  def update
    return no_list if no_list? params[:id]

    list = List.update params[:id], filter_params(List, params)
    attribs, errors = ARD.attrs_and_errs list

    return respond 400, errors if errors.any?

    respond attribs
  end

  def destroy
    return no_list if no_list? params[:id]

    list = ARD.attrs List.destroy params[:id]

    respond list
  end

  module Responders

    def no_list
      respond_with({:error => 'list_not_found'}, {:status => 404})
    end

    def no_list? id
      not id.blank? and not List.exists? id
    end

  end

  include Responders

end
