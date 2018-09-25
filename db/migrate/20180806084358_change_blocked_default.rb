class ChangeBlockedDefault < ActiveRecord::Migration
    def up
      change_column :users, :blocked, :boolean, default: false
    end

    def down
      change_column :users, :blocked, :boolean, default: nil
    end
end
