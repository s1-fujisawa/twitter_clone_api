# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :tweets
  has_many :follow, class_name: 'Follow', foreign_key: 'user_id'
  has_many :follow_user_id, class_name: 'Follow', foreign_key: 'follow_user_id'

end
