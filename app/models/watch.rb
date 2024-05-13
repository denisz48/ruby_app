class Watch < ApplicationRecord
  belongs_to :user
  validates :category, inclusion: { in: ["standard", "premium", "premium+"] }

  def self.ransackable_attributes(auth_object = nil)
    %w[category created_at created_user_id description id id_value image_url name price updated_at user_id]
    # Add attributes that you want to be searchable by Ransack here.
    # For example:
    # %w[category name description]
  end

  def self.ransackable_associations(auth_object = nil)
    []
    # Add associations that you want to be searchable by Ransack here.
    # For example:
    # %w[user]
  end

end
