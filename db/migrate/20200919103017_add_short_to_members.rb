class AddShortToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :short, :string
  end
end
