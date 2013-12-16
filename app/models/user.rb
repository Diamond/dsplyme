class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :projects
  belongs_to :group

  validates_confirmation_of :password
  validates :password, presence: true, on: :create
  validates :email, presence: true, uniqueness: true
end
