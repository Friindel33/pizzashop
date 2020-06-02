#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:pizzashop.db"

class Product < ActiveRecord::Base
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

get '/contacts' do
	@products = Product.all
	@d = Contact.new
	erb :contacts
end

post '/contacts' do
	@products = Product.all
	@d = Contact.new params[:contact]
	if @d.save
		erb "<h2>Thank You. We will deal with your message ASAP</h2>"
	else
		@error = @d.errors.full_messages.first
		erb :contacts
	end
end

get '/' do
	@products = Product.all
	erb :index
end

get '/about' do
	@products = Product.all
	erb :about
end

get '/basket' do
	@products = Product.all
	erb :basket
end

post '/basket' do
	@products = Product.all
	erb :basket
end

get '/pizzas/:id' do
	@product = Product.find(params[:id])
	@products = Product.all
	erb :pizzas
end
