# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  number      :string(255)
#  name        :string(255)
#  small_wrap  :integer
#  big_wrap    :integer
#  photo       :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  barcode     :string(13)
#  active      :boolean          default(TRUE)
#

class Item < ActiveRecord::Base

  has_many :stored_items
  belongs_to :category

  before_save :generate_barcode
  before_save :fix_name, if: :new_record?
  before_validation :set_empty_wraps

  mount_uploader :photo, PhotoUploader


  validates_presence_of :name, :number, :small_wrap, :big_wrap
  validates_presence_of :category , :if => Proc.new { |item| item.category_id.present? }
  validates_numericality_of :small_wrap, :big_wrap, :only_integer => true, :greater_than_or_equal_to => 0

  scope :active, -> { where({ active: true}) }
  # only items where quantity > 0
  scope :on_stock, -> { joins(:stored_items).group('items.id').having("SUM(stored_items.quantity) > 0") }
  scope :with_photo, -> { where('photo IS NOT NULL')}

  # get max price from all magazines
  def price
    stored_items.max { |item_a,item_b| item_a.price <=> item_b.price}.price
  end

  # returns summary quantity from all magazines
  def quantity
    stored_items.inject(0){ |sum, n| sum += n.quantity}
  end

  # fixes legacy names
  def fix_name
    if(match = self.name.match(/.{14}(\s.\s).+/))
      parts = self.name.rpartition(/#{match[1]}/)
      parts[1].strip!
      self.name = parts.join
    end
    self.name = self.name.mb_chars.capitalize
  end

  # update photo column if photo is reachable
  def update_photo
    begin
      item_number = number[-5,5]
      self.remote_photo_url = RemoteImageChecker.new.get_valid_url(item_number)
    rescue
      path = "public/item_photos/#{item_number}.jpg"
      self.photo = File.open(path) if (File.exist?(path) && photo.filename.nil?)
    end
    save
  end

  # simple search by number or name
  def self.search(query)
    where("number LIKE ? or name LIKE ? or barcode LIKE ?",
          "%#{query}%","%#{query}%", "%#{query}%").order(created_at: :desc)
  end

  # generates EAN13 Barcode
  def generate_barcode
    return unless barcode.blank?
    prefix = "5900851#{number.slice(-5,5)}"
    digits = prefix.chars.map(&:to_i)
    total = 0
    digits.each_with_index { |v,i| total += (i.even? ? v : v*3) }

    checksum = total % 10
    checksum = (10 - checksum) unless checksum == 0

    self.barcode = "#{prefix}#{checksum}"
  end

  def set_empty_wraps
    self.big_wrap = (big_wrap) ? big_wrap : 1
    self.small_wrap = (small_wrap) ? small_wrap : 1
  end

end
