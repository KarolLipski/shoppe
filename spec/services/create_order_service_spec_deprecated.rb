require 'rails_helper'

RSpec.describe  CreateOrderService do

  it 'initialization sets user and cart' do
    service = CreateOrderService.new(:cart, :user, {})
    expect(service.cart).to eq(:cart)
    expect(service.user).to eq(:user)
  end

  context 'call' do
    before(:each) do
      @cart = FactoryGirl.create(:cart)
      @user = @cart.user
      @cart_items = FactoryGirl.create_list(:cart_item, 3, cart: @cart)
      @quantities = @cart_items.map { |i| [i.id.to_s, "1"]}.to_h
      @cart.reload
    end
    context 'when all items are valid' do
      it 'ommit 0 quantityty items' do
        @cart_items.first.update_attribute(:quantity, 0)
        @quantities[@cart_items.first.id.to_s] = 0
        service = CreateOrderService.new(@cart, @user, @quantities)
        result = service.call
        expect(result[:order].order_items.count).to eq 2
      end
      it 'save order' do
        service = CreateOrderService.new(@cart, @user, @quantities)
        result = service.call
        expect(result[:order].id).not_to eq nil
      end
      it 'save all order items' do
        service = CreateOrderService.new(@cart, @user, @quantities)
        result = service.call
        expect(result[:order].order_items.count).to eq 3
      end
      it 'assing return to success' do
        service = CreateOrderService.new(@cart, @user, @quantities)
        result = service.call
        expect(result[:success]).to eq true
      end
      context 'when all items have 0 quantity' do
        it 'doesnt create order' do
          @quantities = @cart_items.map { |i| [i.id.to_s, "0"]}.to_h
          @cart.reload
          service = CreateOrderService.new(@cart, @user, @quantities)
          result = service.call
          expect(result[:order].id).to eq nil
        end
      end
    end
    context 'when some items is not valid' do
      before(:each) do
        @cart_items.first.item.stored_items.first.update(quantity: 0)
      end
      it 'doesnt create order' do
        service = CreateOrderService.new(@cart, @user, @quantities)
        result = service.call
        expect(result[:order].id).to eq nil
      end
      it 'assigns return to false' do
        service = CreateOrderService.new(@cart, @user, @quantities)
        result = service.call
        expect(result[:success]).to eq false
      end
    end
  end

end