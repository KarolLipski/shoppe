# encoding: UTF-8

#Dir[File.join(Rails.root,'db','seeds','*.rb')].sort.each { |seed| load seed }

load File.join(Rails.root,'db','seeds','01_categories.rb')
load File.join(Rails.root,'db','seeds','02_items.rb')