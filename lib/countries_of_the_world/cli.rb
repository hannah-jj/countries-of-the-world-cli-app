class CountriesOfTheWorld::CLI

def call
	display_header
	scraper = CountriesOfTheWorld::Scraper.new
	scraper.scrape_page
	input = keep_going
	
	while input.downcase != "exit"
		if input.to_i > 0 && input.to_i <= CountriesOfTheWorld::Country.all.size
		#if input is a number 
			display_detail(scraper, input.to_i-1)

			puts "Would you like to view another country? Y/N"
			input = gets.strip.downcase
			if input == "n"
				puts "All right, see you next time!".bold.green
				exit
			else
				input = keep_going
			end
		elsif input.downcase == "list"
			list_all_country
			input = keep_going
		else 
			puts "Please enter a valid response".bold.red
			input = keep_going
		end
	end
	puts "OKIE DOKIE! SEE YOU NEXT TIME!!! GO RUBY!!!".bold.green
end

def display_header
	puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++".bold.on_cyan.blink
	puts "++++++++++++*****".bold.on_cyan.blink+"Welcome to the country data from World Bank".upcase.bold+"*****++++++++++++".bold.on_cyan.blink
	puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++".bold.on_cyan.blink
end

def keep_going
	puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++".green
	puts "+".green+"Due to the size of data, please maximize your screen for optimal experiences".red.on_yellow+"+".green
	puts "+".green+"Enter exit to exit the program                                              "+"+".green
	puts "+".green+"Enter list to list all countries                                            "+"+".green
	puts "+".green+"Enter a number to see a country's detail                                    "+"+".green
	puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++".green
	
	gets.strip
end

def list_all_country
	CountriesOfTheWorld::Country.list_countries(4) #display 4 in a row
	end

def display_detail(scraper, input)
	info = scraper.country_page(CountriesOfTheWorld::Country.all[input].url)
	CountriesOfTheWorld::Country.all[input].add_info(info)
	CountriesOfTheWorld::Country.all[input].list_detail
end

end