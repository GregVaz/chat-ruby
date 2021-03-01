class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  VALID_STATUS = ['public', 'private']
  validates :status, presence: true, inclusion: { in: VALID_STATUS }

  scope :only_public, -> { where(status: 'public') }
  scope :exclude, ->(ids) { where.not(id: ids) }

  def public?
    status == 'public'
  end

  def title
    name.blank? ? id : name
  end

  def number_of_messages
    messages.count
  end
end
