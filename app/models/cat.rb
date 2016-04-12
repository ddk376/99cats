class Cat < ActiveRecord::Base
  GENDERS = ['M', 'F']
  CAT_COLORS = [ '',
             'Black',
             'White',
             'Calico',
             'Brown Tabby',
             'Orange Tabby',
             'Grey',
             'Blue',
             'Other']

  validates :birth_date, :color, :name, :sex, presence: true

  validates :sex, inclusion: { in: GENDERS, message: "%{value} is not a valid gender" }

  validates :color, inclusion: { in: CAT_COLORS, message: "%{value} is not a valid color"}

  has_many :rental_requests,
    class_name: "CatRentalRequest",
    dependent: :destroy

  def age
    time_ago_in_words(birth_date)
  end
end
