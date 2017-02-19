class CountriesOfTheWorld::CLI

def call
	puts "Welcome to the country data from World Bank"
	scraper = CountriesOfTheWorld::Scraper.new
	scraper.scrape_page

	#country = CountriesOfTheWorld::Country.new
	#country.list_countries
	#country.list_detail
end

end