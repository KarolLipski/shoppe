# encoding: UTF-8

Dir[File.join(Rails.root,'db','seeds','*.rb')].sort.each { |seed| load seed }