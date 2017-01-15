class AddLanguageToContestStatus < ActiveRecord::Migration
  def change
    add_column :contest_statuses, :language, :string
  end
end
