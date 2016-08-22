json.extract! todo, :id, :text, :completed, :sort, :account_id, :created_at, :updated_at
json.url todo_url(todo, format: :json)
json.html render(partial: 'todo', locals: {todo: todo}, formats: 'html')
json.uncompleted_count current_account.uncompleted_count
