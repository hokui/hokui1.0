class Summary < ActiveRecord::Base
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
  validates :file_name,
    presence: true,
    uniqueness: true,
    format: {with: /^[a-z_]+\-summary\-[0-9]+\.(pdf|jpg|png|gif|tif|doc|docx|ppt|pptx|txt|rtf)$/}
  validates :uploaded_by,
    presence: true,
    format: {with: /^[0-9]+$/}
end
