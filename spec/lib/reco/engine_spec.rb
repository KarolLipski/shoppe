# encoding: utf-8
require 'rails_helper'

require "#{Rails.root}/lib/reco/engine.rb"

RSpec.describe Reco::Engine do

  it 'collects top newest items ' do
    FactoryGirl.create(:stored_item, created_at: '2016-01-01')
    FactoryGirl.create_list(:stored_item, 5, created_at: '2015-01-01')

    expect(Reco::Engine.last_added(1,1).first.created_at.strftime("%Y-%m-%d")).to eq('2016-01-01')
  end

  it 'collects recommend items' do
    FactoryGirl.create_list(:stored_item, 3)
    expect(Reco::Engine.reccomend(1).size).to eq(1)
  end

  it 'collects bestseller items' do

  end

end