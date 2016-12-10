class Participation < ActiveRecord::Base
    belongs_to:user
    belongs_to:activity 
    STATUS_TYPES =     ["APPLE_FOR","APPROVED","REFUSED"]
    validates :status,:inclusion=>STATUS_TYPES
end
