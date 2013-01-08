class Asset < ActiveRecord::Base
  has_attached_file :asset, :path => (Rails.root + "files/:id").to_s,
                            :url => "/files/:id"
  attr_accessible :asset
  
  belongs_to :ticket
end
