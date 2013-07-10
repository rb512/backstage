class Menu < ActiveRecord::Base
  belongs_to :owner
  has_many :menu_items
  has_many :categories

  accepts_nested_attributes_for :menu_items, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :categories, :reject_if => :all_blank, :allow_destroy => true
  attr_accessible :menu_type, :name, :menu_items_attributes, :categories_attributes
  validates_uniqueness_of :name
  validates_presence_of :menu_type, :name
  
  attr_writer :current_step
  
  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[category_step menu_items_step]
  end
  
  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end
  
  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end
  
  def first_step?
    self.current_step == steps.first
  end
    
  def last_step?
    self.current_step == steps.last
  end
  
end
