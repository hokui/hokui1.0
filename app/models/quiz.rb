class Quiz < ActiveRecord::Base
  belongs_to :subject

  validates :subject_id,
    presence: true,
    format: {with: /^[0-9]+$/}
  validates :number,
    presence: true,
    format: {with: /^[0-9]+$/}
  validates :content_type,
    presence: true,
    format: {with: /^(text|image|application)\/[a-z0-9_\-\.]+$/}
  validates :q_a,
    presence: true,
    format: {with: /^(q|a)$/}
  validates :file_name,
    presence: true,
    uniqueness: true,
    format: {with: /^[a-z_]+\-quiz\-[0-9]+\-(q|a)\.(pdf|jpg|png|gif|tif|doc|docx|ppt|pptx|txt|rtf)$/}
  validates :uploaded_by,
    presence: true,
    format: {with: /^[0-9]+$/}
  validates :deleted,
    presence: true,
    format: {with: /^[0-1]$/}
  validates :deleted_by,
    format: {with: /^[0-9]+$/}
end
