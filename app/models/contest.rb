class Contest < ActiveRecord::Base
	has_many :contest_problems, dependent: :destroy
	has_many :contest_statuses, dependent: :destroy
	has_many :contest_ranks, dependent: :destroy
	has_many :contest_codes, dependent: :destroy
end