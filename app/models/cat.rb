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
    now = DateTime.now.to_date
    age = now.year  - birth_date.year
    if (now.month == birth_date.month && now.day >= birth_date.day) ||
        now.month > birth_date.month
        age += 1
    end
    age
    # time_ago_in_words(birth_date)
  end
end
