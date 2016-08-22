class Todo < ApplicationRecord

  default_scope -> { order(sort: :desc) }

  acts_as_paranoid
  paginates_per 8

  belongs_to :account

  validates :text, presence: true

  after_create :auto_increment_completed_count
  after_destroy :auto_decrement_completed_count

  scope :uncompleted, ->{ where(completed: false) }
  scope :completed, ->{ where(completed: true) }

  class << self
    # 拖动排序
    def move(account, id, target_id)
      todo = account.todos.find id
      target = account.todos.find target_id
      origin_sort = todo.sort
      transaction do
        if origin_sort > target.sort
          todo.sort = target.sort + 1
          account.todos.where(sort: (target.sort + 1)..(origin_sort - 1)).update_all('sort=sort + 1')
        else
          todo.sort = target.sort
          account.todos.where(sort: (origin_sort + 1)..target.sort).update_all('sort=sort - 1')
        end
        todo.save!
      end
    end
  end

  def completed!
    update! completed: true
    account.decrement! :uncompleted_count
  end

  def uncompleted!
    update! completed: true
    account.increment! :uncompleted_count
  end

  private
  def auto_increment_completed_count
    account.increment! :uncompleted_count
  end
  def auto_decrement_completed_count
    unless self.completed?
      account.decrement! :uncompleted_count
    end
  end
end
