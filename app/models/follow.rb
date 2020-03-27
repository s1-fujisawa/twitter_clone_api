class Follow < ApplicationRecord

    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    belongs_to :follow_user, class_name: 'User', foreign_key: 'follow_user_id'
end
