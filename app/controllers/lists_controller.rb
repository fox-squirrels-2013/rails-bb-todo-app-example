class ListsController < ApplicationController

  def create
    list = List.create filter_params(List, params)
    attribs, errors = ARD.attrs_and_errs list

    return respond 400, errors if errors.any?

    redirect_to server_ui_path
  end

  def update
    return no_list if no_list? params[:id]

    list = List.update params[:id], filter_params(List, params)
    attribs, errors = ARD.attrs_and_errs list

    return respond 400, errors if errors.any?

    redirect_to server_ui_path
  end

  def destroy
    return no_list if no_list? params[:id]

    list = ARD.attrs List.destroy params[:id]

    redirect_to server_ui_path
  end

end
