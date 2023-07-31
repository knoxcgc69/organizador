# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: "User"
  has_many :participating_users, class_name: "Participant"
  has_many :participants, through: :participating_users, source: :user
  #ojo .. la siguiente linea se modifico con WEC para que funcione, pero presense es true
  validates :participating_users, presence: false 
  validates :name, :description, presence: true 
  validates :name, uniqueness: true
  validate :due_date_validity

  validates :name, uniqueness: { case_sensitive: false }
  accepts_nested_attributes_for :participating_users, allow_destroy: true

  def due_date_validity
    return if due_date.blank?
    return if due_date > Date.today
    errors.add :due_date, I18n.t("task.errors.invalid_due_date")
  end
  
end
