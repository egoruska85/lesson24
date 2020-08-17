#encoding: utf-8
require 'rubygems'
require 'sinatra'
 require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/about' do
	@message = "О нас"
	erb :about
end

get '/contacts' do
	@message = "Наши контакты"
	erb :contacts
end

get '/visits' do
	@message = "Запись на сеанс к стилисту"
	erb :visits
end
get '/admins' do
	@message = "Запись на сеанс к стилисту"
	erb :admins
end
post '/visits' do
	@username = params[:username]
	@phone = params[:phone]
	@date = params[:date]
	@time = params[:time]
	@master = params[:master]
    @color = params[:color]
=begin
	if @username == "" or @phone == "" or @date == "" or @time == "" or @color == ""
		@error = "Вы не заполнили все графы"

		erb :visits
	else
	    @message = "#{@username.capitalize} вы записаны на #{@date} время #{@time}, Ваш мастер #{@master}"
	    @title = "Спасибо за запись, назад на главную страницу"
	    f = File.open './public/user.txt', 'a'
	    f.write "Имя: #{@username}, Тел.: #{@phone}, Мастер: #{@master}, Цвет волос: #{@color}, Дата и время: #{@date} #{@time}\n"
	    f.close

		@button = "НАЗАД НА ГЛАВНУЮ"
		erb :message
	end
=end
	# хеш
	hh = {:username => 'Введите имя', 
		:phone => 'Введите номер телефона', 
		:date => 'Укажите дату', 
		:time => 'Укажите время'}
# для каждой пары ключ-значение
=begin		
	hh.each do |key, value|
		#если параметр пуст
		if params[key] == ''
			#переменной error присвоить value из хэша hh 
			# (а value из хэша hh это сообщение об ошибке)
			# т.е переменной error присвоить сообщение об ошибке
			@error = hh[key]
			#Вернуть прдставление visits
			return erb :visits

		end


	end
=end
	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ''
		return erb :visits	
	end	
	@message = "#{@username.capitalize} вы записаны на #{@date} время #{@time}, Ваш мастер #{@master}"
    @title = "Спасибо за запись, назад на главную страницу"
    f = File.open './public/user.txt', 'a'
    f.write "Имя: #{@username}, Тел.: #{@phone}, Мастер: #{@master}, Цвет волос: #{@color}, Дата и время: #{@date} #{@time}\n"
    f.close

	@button = "НАЗАД НА ГЛАВНУЮ"

	erb :message	
end
post '/contacts' do
	@name = params[:name]
	@email = params[:email]
	@coment = params[:coment]

	if @name == "" or @email == "" or @coment == ""
		@error = "Вы не заполнили все графы"
		erb :contacts
	else
		@message = "#{@name} мы раccмотрим Ваше сообщение"
		f = File.open './public/contacts.txt', 'a'
		f.write "#{@name}, #{@email}, #{@coment}\n"
		f.close
		@button = "НАЗАД НА ГЛАВНУЮ"
		erb :message
	end  
end
post '/admins' do
  @login = params[:username]
  @password = params[:password]

  if @login == "opr" && @password == "opr"
    erb :operator
  elsif @login == "admin" && @password == "admin"
    erb :admins_panel
  elsif @login == "" or @password == ""
    @error = 'Все графы должны содержать символы'
    erb :admins
  else
    @error = 'Вы ввели неверный пароль'
    erb :admins
  end
end
 