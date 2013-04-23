class Todo < ActiveRecord::Base
  attr_accessible :title, :body, :status
  belongs_to :list

  STATUS = {
    :incomplete   => 0,
    :complete     => 1,
    :in_progress  => 2,
    :moved        => 3,
    :deleted      => 4,
    :postponed    => 5,
    :important    => 6
  }.freeze

  STATUS.keys.each do |status|
    define_method "#{status}?" do
      self.status == STATUS[status]
    end
    define_method "#{status}!" do
      update_attributes :status => STATUS[status]
    end
  end

  class << self
    def group_by_list_names
      self.all.group_by &:list_name
    end

    def method_missing method, *args
      if method.to_s =~ /^all_(.+)$/ and status = STATUS[$1.to_sym]
        self.where :status => status
      elsif method.to_s =~ /^create_by_(.+)$/ and status = STATUS[$1.to_sym]
        self.create :status => status
      else
        super
      end
    end
  end

end
