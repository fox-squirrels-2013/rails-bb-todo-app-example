
dbc  = List.create! :name => 'DBC'

dbc.todos.create!(
  :title => 'Learn Rails MVC',
  :status => 'complete'
)

p4  = List.create! :name => 'DBC - Phase 4'

p4.todos.create!(
  :title => 'Unlearn Rails MVC',
  :status => 'in_progress'
)
p4.todos.create!(
  :title => 'Learn BackBone MVC',
  :status => 'incomplete'
)
