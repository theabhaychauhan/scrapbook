class AddHeadingsToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :headings, :string
  end
end
