class Activity < ActiveRecord::Base
    CATEGORY_TYPES = ["Outdoor","Indoor"]
    validates :category,:inclusion=>CATEGORY_TYPES
    has_many:participations,:dependent => :destroy
    has_many:users,:through=>:participations
    has_one:user
    has_many:chatinfos
end
