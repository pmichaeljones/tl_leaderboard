class ChangeContributionsToInteger < ActiveRecord::Migration
  def change
    change_column :users, :contributions, 'integer USING CAST(contributions AS integer)'
  end
end
