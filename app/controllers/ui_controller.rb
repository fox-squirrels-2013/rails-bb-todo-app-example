class UiController < ApplicationController

  def server
    todo_lists = List.all
    ui_html = UIPresenters::ScreenPresenter.new(:lists_data => todo_lists).render
    render :text => ui_html, :layout => 'server'
  end

end
