class Short < ApplicationRecord
  UNIQUE_ID_LENGTH = 6
  validates :original_url,format: URI::regexp(%w[http https]) ,presence:true , on: :create
  before_create :generate_short_url
  before_create :sanitize

  def generate_short_url
    url = ([*('a'..'z'), *('0'..'9') ]).sample(UNIQUE_ID_LENGTH).join
    old_url = Short.where(short_url: url).last
    if old_url.present?
      self .generate_short_url
    else
      self.short_url=url
    end
  end
  def find_duplicate
    Short.find_by_sanitize_url(self.sanitize_url)
  end
  def new_url?
    find_duplicate.nil?
  end
  def sanitize
    self.original_url.strip!
    self.sanitize_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/,"")
    self.sanitize_url = "https://#{self.sanitize_url}"
  end
end
