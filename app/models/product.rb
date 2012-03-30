class Product < ActiveRecord::Base
  default_scope :order => 'title'
  has_many :line_items
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  before_destroy :ensure_not_referenced_by_any_line_item

  PUBLISHER = ['pub1','pub2','pub3','pub4','pub5']

  validates :title, :description, :presence => {:message => " can't be empty!"}
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01,:less_than_or_equal_to =>    1000}
  validates :title, :uniqueness => {:message => ". The product with such title already exists. Pick another one, please"}

#  validates :image_url, :format => {
#      :with     =>%r{\.(gif|jpg|png)$}i,
#      :message  => 'must be a URL for GIF, JPG or PNG image.'
#  }
  validates :title, :length => {:minimum => 10,:too_short => "is too short. pick a longer name"}
  validates :description, :length => {:maximum => 1000,:too_long => "is too long. Truncate to 1000 chars please"}

  validates :author, :presence => {:message => " can't pe empty. Each book have an author"}, :length => {:maximum => 100, :too_long => "can't be more than 100 chars. You have probably made a mistake"}
  validates :publisher, :inclusion => {:in => PUBLISHER, :message => " should match with one that is in publisher list."}
  #validates :image_url,    :uniqueness => true



  private
    def ensure_not_referenced_by_any_line_item
      if line_items.count.zero?
        return true
      else
        errors.add(:base, 'Line items present')
        return false
      end
    end
end
