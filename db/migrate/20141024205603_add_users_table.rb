class AddUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :github_username, :contributions, :streak
      t.timestamps
    end
  end
end
