#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:pizzashop.db"

class Product < ActiveRecord::Base
end

class Order < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3 }
	validates :address, presence: true, length: {maximum: 200 }
end

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Contact < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3 }
	validates :email, presence: true, email: true
	validates :message, presence: true, length: {maximum: 300 }
end

before do
	@products = Product.all
end

get '/' do
	erb :index
end

get '/about' do
	erb :about
end

post '/basket' do
  @orders_input = params[:orderstring]
  @items = parse_orders_input @orders_input

  # выводим сообщение о том, что корзина пуста
  if @items.length == 0
    return erb :basket_is_empty
  end

  @items.each do |item|
    # id, cnt
    item[0] = Product.find(item[0])
  end

	erb :basket
end

post '/place_order' do

  @order = Order.new params[:order]

	if @order.save
		erb :order_placed
	else
		@error = @order.errors.full_messages.first
		erb :basket
	end
end

def parse_orders_input orders_input

  s1 = orders_input.split(/,/)

  arr = []

	s1.each do |x|
    s2 = x.split(/\=/)

    s3 = s2[0].split(/_/)

    id = s3[1]
    cnt = s2[1]

    arr2 =[id, cnt]
    arr.push arr2
  end

  return arr
end

get '/pizzas/:id' do
	@product = Product.find(params[:id])
	erb :pizzas
end

get '/contacts' do
	@d = Contact.new
	erb :contacts
end

post '/contacts' do
	@d = Contact.new params[:contact]
	if @d.save
		erb "<h2>Thank You. We will deal with your message ASAP</h2>"
	else
		@error = @d.errors.full_messages.first
		erb :contacts
	end
end

get '/admin' do
  erb :admin
end

post '/admin' do
	@login = params[:login]
	@password = params[:password]
	@delete = params[:delete]

	if @login == 'admin' && @password == 'admin'
		@file = Order.all
		erb :view_orders
	else
		@error = '<p>Wrong Login or Password</p>'
		erb :admin
	end
end
