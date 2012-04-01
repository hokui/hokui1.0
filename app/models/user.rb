class User < ActiveRecord::Base
  has_many :bbs_topics
  has_many :bbs_bodies

  has_secure_password

  validates :full_name,
    uniqueness: true,
    length: {in: 2..8}
  validates :handle_name,
    uniqueness: true,
    length: {in: 2..10}
  validates :birthday,
    format: {with: /^19[8-9][0-9]\-[0-1][0-9]\-[0-3][0-9]$/}
  validates :mail,
    presence: true,
    uniqueness: true,
    format: {with: /^[a-zA-Z0-9_\-\.]+@[a-zA-Z0-9_\-\.]+$/}
  validates :authority,
    presence: true,
    format: {with: /^(system|admin|guest)$/}
  validates :invited_by,
    presence: true,
    format: {with: /^[0-9]+$/}
end
