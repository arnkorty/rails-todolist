require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'Move todo sort' do
     let(:account) { create :account }
     context 'move closed todo' do
       it 'should change sort variable' do
         todo = create(:todo, account: account)
         todo1 = create(:todo, account: account)
         todo.reload
         todo1.reload
         Todo.move(account, todo.id, todo1.id)
         expect(todo.sort == todo.reload.sort).to eq(false)
         expect(todo1.sort == todo1.reload.sort).to eq(false)
         expect(todo.reload.sort > todo1.reload.sort).to eq(true)
       end

       it 'should not change sort variable' do
         todo = create(:todo, account: account)
         todo1 = create(:todo, account: account)
         todo.reload
         todo1.reload
         Todo.move(account, todo1.id, todo.id)
         expect(todo.sort == todo.reload.sort).to eq(true)
         expect(todo1.sort == todo1.reload.sort).to eq(true)
       end
     end
  end
end
