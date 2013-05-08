class UiController < ApplicationController

  def server
    todo_lists = List.all
    ui_html = UIPresenters::ScreenPresenter.new(:lists_data => todo_lists).render
    render :text => ui_html, :layout => 'server'
  end

  def client
    client_program = ClientTemplateCompiler.compile
    render :text => client_program, :layout => 'client'
  end

end
