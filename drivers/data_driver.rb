require_relative '../config/environment'

# Destroy old data

List.destroy_all
Todo.destroy_all

# Make some sample data

default_list = List.new name: "Default List"
default_list.save

default_list.todos.create(
  :title => "first todo",
  :status => Todo::STATUS[:incomplete]
)

default_list.todos.create(
  :title => "second todo",
  :status => Todo::STATUS[:incomplete]
)

# Print all the sample data

for list in List.all
  puts "List: #{list.name}"
  for todo in list.todos
    puts "Todo: < title: #{todo.title} ; body: #{todo.body} ; status: #{todo.status} >"
  end
end
