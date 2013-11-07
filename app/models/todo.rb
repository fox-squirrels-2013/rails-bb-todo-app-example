class Todo < ActiveRecord::Base

  # Foreign key constraint handled at the db level
  belongs_to :list
  attr_accessible :list_id
  validates :list_id, :presence => {
    :message => 'cant_be_null'
  }

  # ---

  attr_accessible :title
  validates :title,
    :presence => { :message => 'cant_be_blank' }

  # ---

  STATUSES = %w{ incomplete complete in_progress }.freeze
  attr_accessible :status
  validates :status,
    :inclusion => {
      :in => STATUSES,
      :message => 'invalid_status'
    }

end
