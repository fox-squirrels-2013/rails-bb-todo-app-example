require_relative '../config/environment'

# Destroy old data

List.destroy_all

Rails.logger.debug "-- done destroying"

# Make some sample data

list = List.create! name: "A list"

Rails.logger.debug "-- done making a list"

Todo.create!(
  title: "A todo",
  :status => "incomplete",
  :list_id => list.id
)

Rails.logger.debug "-- done making todo"

# Print all the sample data

for list in List.all
  puts list.inspect
  for todo in list.todos
    puts '  ' + todo.inspect
  end
end
