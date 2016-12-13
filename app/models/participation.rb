class Participation < ActiveRecord::Base
    belongs_to:user
    belongs_to:activity 
    # STATUS_TYPES =     ["APPLE_FOR","APPROVED","REFUSED"]
    STATUS_TYPES =     ["apply_for","approved","refused"]
    validates :status,:inclusion=>STATUS_TYPES
end
