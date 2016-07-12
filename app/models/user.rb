class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :reminders

  before_save :ensure_authentication_token

  validates :firstname, :lastname, :email, presence: true

  def to_s
    %Q(#{self.firstname} #{self.lastname})
  end

  # Generate API token
  def ensure_authentication_token
    self.authentication_token = generate_token if authentication_token.blank?
  end

  private
    def generate_token
      loop do
        token = Devise.friendly_token
        break token unless User.find_by authentication_token: token
      end
    end
end
