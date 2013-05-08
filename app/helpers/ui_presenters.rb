module UIPresenters

  module MustacheRenderHelper

    def template_source
      File.read(template_path)
    end

    def template_path
      Rails.root.join("app/views/ui/#{template_name}.html.mustache")
    end

    def render
      Mustache.render(template_source, self)
    end

  end

  class ScreenPresenter
    include MustacheRenderHelper

    def initialize(args)
      @lists_data = args[:lists_data]
    end

    def render
      super + js
    end

    def js
      "<script>$('body').removeClass('loading')</script>"
    end

    def template_name
      'ui'
    end

    def lists
      @lists_data.map { |list_data| ListPresenter.new(list_data).render }
    end

    def createListEndpoint
      '/lists'
    end
  end

  class ListPresenter
    include MustacheRenderHelper

    def initialize(list)
      @list = list
    end

    def template_name
      'todoList'
    end

    def name
      @list.name
    end

    def completedTodoItems
      render_todo_items('complete')
    end

    def wipTodoItems
      render_todo_items('in_progress')
    end

    def incompleteTodoItems
      render_todo_items('incomplete')
    end

    def render_todo_items(status)
      TodoItemsPresenter.new(@list.todos.where(:status => status).all).render
    end
  end

  class TodoItemsPresenter
    include MustacheRenderHelper

    def initialize(items)
      @items = items
    end

    def items
      @items.map do |todo_item|
        TodoItemPresenter.new(todo_item).render
      end
    end

    def template_name
      'todoItemList'
    end

  end

  class TodoItemPresenter
    include MustacheRenderHelper

    def initialize(item)
      @item = item
    end

    def title
      @item.title
    end

    def id
      @item.id
    end

    def template_name
      'todoItem'
    end
  end

end
