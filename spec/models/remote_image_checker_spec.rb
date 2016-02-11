# encoding: utf-8
require 'rails_helper'

RSpec.describe RemoteImageChecker do

  it 'checks if file_exist?' do
    remote = RemoteImageChecker.new
    expect(remote.file_exist?('http://madej.com.pl/zdjecia/73523.jpg')).to eq true
    expect(remote.file_exist?('http://madej.com.pl/zdjecia/73523.png')).to eq false
    expect(remote.file_exist?('http://madej.com.pl/zdjecia/73523.JPG')).to eq false
  end

  context 'depends on product number' do
    context 'if image exists' do
      it 'return valid url' do
        remote = RemoteImageChecker.new
        expect(remote.get_valid_url('73523')).to eq('http://madej.com.pl/zdjecia/73523.jpg')
      end
    end
    context 'if image doesnt exist' do
      it 'throws exception' do
        remote = RemoteImageChecker.new
        expect{remote.get_valid_url('7352343')}.to raise_error(Exceptions::RemoteFileNotFound)
      end
    end
  end

end