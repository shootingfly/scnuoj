class RenameProbroblemSamples < ActiveRecord::Migration
  def change
  	rename_column :problems, :samples, :testdata
  end
end
