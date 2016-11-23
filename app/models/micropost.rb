class Micropost < ApplicationRecord
  belongs_to :user

  default_scope -> { order(created_at: :desc ) }
  #CarrieWave join between image wirt the model
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  # Custom validations are called valdate as oposite, 
  # to predefined validates
  validate :picture_size


  private
    def picture_size
      if picture.size > 5.megabytes
        errors.size(:picture, 'should be less than 5MB')
      end
    end
end
