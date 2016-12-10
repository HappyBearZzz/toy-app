class Admin < ActiveRecord::Base
    after_destroy :ensure_an_admin_remains
    validates :name,:presence=>true,:uniqueness=>true
    validates :password,:presence=>true
    attr_accessor :password_confirmation
    attr_reader :password
    validate :password_must_be_present
    
    def password=(password)
        @password=password
        if password.present?
            generate_salt
            self.hashed_password = self.class.encrypt_password(password,salt)
        end
    end

    def Admin.encrypt_password(password,salt)
        Digest::SHA2.hexdigest(password+"wibble"+salt)
    end

    def Admin.authenticate(name,password)
        if admin = find_by_name(name)
            if admin.hashed_password == encrypt_password(password,admin.salt)
                admin
            end
        end
    end
    private
        def password_must_be_present
            errors.add(:password,"missing password") unless hashed_password.present?
        end
        def generate_salt
            self.salt = self.object_id.to_s + rand.to_s
        end
        def ensure_an_admin_remains
            if Admin.count.zero?
                raise "can not delete last admin"
            end
        end
end
