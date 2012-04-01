# -*- encoding: utf-8 -*-

class Term < ActiveRecord::Base
  belongs_to :bbs_group
  has_many :subjects

  validates :title,
    presence: true,
    uniqueness: true,
    format: {with: /^[2-6](年前期|年後期)$/}
  validates :bbs_group_id,
    presence: true,
    uniqueness: true,
    format: {with: /^[0-9]+$/}
end
