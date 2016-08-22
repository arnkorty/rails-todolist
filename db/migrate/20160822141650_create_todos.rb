class CreateTodos < ActiveRecord::Migration[5.0]
  def migrate direction
    super
    if direction == :up
      execute <<-SQL
        CREATE SEQUENCE sort_seq START 1;
        ALTER SEQUENCE sort_seq OWNED BY todos.sort;
        ALTER TABLE todos ALTER COLUMN sort SET DEFAULT nextval('sort_seq');
      SQL
    elsif direction == :down
      #execute <<-SQL
        #DROP SEQUENCE sort_seq;
      #SQL
    end
  end
  def change
    create_table :todos do |t|
      t.text :text
      t.boolean :completed, default: false
      t.integer :sort, index: true
      t.references :account, foreign_key: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
