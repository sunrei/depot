class Product < ActiveRecord::Base
  PUBLISHER = ['pub1','pub2','pub3','pub4','pub5']

  validates :title, :description, :image_url, :presence => {:message => " can't be empty!"}
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => {:message => ". The product with such title already exists. Pick another one, please"}
  validates :image_url, :format => {
      :with     =>%r{\.(gif|jpg|png)$}i,
      :message  => 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, :length => {:minimum => 10,:too_short => "is too short. pick a longer name"}
  validates :description, :length => {:maximum => 1000,:too_long => "is too long. Truncate to 1000 chars please"}

  validates :author, :presence => {:message => " can't pe empty. Each book have an author"}, :length => {:maximum => 100, :too_long => "can't be more than 100 chars. You have probably made a mistake"}
  validates :publisher, :inclusion => {:in => PUBLISHER, :message => " should match with one that is in publisher list."}

end
