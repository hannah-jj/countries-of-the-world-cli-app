######################################################################
#scraper class scrapes the pages for information to build country info
#due to size of country, only name and url for all countries are fully built initially
#details on each country are retrieved as user calls for a country
######################################################################
class CountriesOfTheWorld::Scraper

	def scrape_page
	#this method scrapes the main page builds all the countries with name and url
		doc = Nokogiri::HTML(open("http://www.worldbank.org/en/country"))
		doc.css("li.name-country").each do |country|
			c_name = country.css("a").text
			url = country.css("a").attr('href').value
			c = CountriesOfTheWorld::Country.new(c_name, url)
		end
	end

	def country_page(url)
	#this method returns a hash containing detailed information for a country 
		finance_info =[]

		if url.include?("israel") #israel's link is not pointed to the right page
			info = more_info_page(url)
			{
				:income_level => info[0],
				:region => info[1],
				:description => "BROKEN LINK, NO_INFO"
			}
			
		elsif  url.include?("gcc") #gcc's link doesn't contain financial info
			{:description => "NO_INFO"}

		elsif url.include?("country") #regular link
			doc = Nokogiri::HTML(open(url))

			doc.css("td.c01v1-country-amounts").text.gsub("\t","_").split(" ").map {|e| finance_info << e.gsub("_"," ")}
			#the output from css is in the following format that needs to be parsed into seperate attributes
			#"32.53\tmillion $19.33\tbillion 0.8% -1.5% "

			raw_text = doc.css("div.c01v1-country-banner-text").text.strip
			description = raw_text[0..raw_text.index(" \n")].strip
			#description of the country returns a lot of misc texts at the end. need to trim down to description
			
			info_url =  doc.css("span.c01v1-country-chart-text a").attr('href').value
			info_url[0]== "/"? info_url = "http://www.worldbank.org"+ info_url : info_url
			more_info_page(info_url).each {|e| finance_info<< e}
			# region and income_level info are contained in additional page
			# the url for more info is not consistent between different countries
			# some links are absolute, some are relative
			
			{
				:population => finance_info[0],
				:gdp => finance_info[1],
				:gdp_growth => finance_info[2],
				:inflation => finance_info[3],
				:income_level => finance_info[4],
				:region => finance_info[5],
				:description => description
			} #return hash
		end
	end

	def more_info_page(url)
	#this helper method returns an array [income_level, region]

		#below handles broken links
		uri = URI.parse(url)
		result = Net::HTTP.start(uri.host, uri.port) { |http| http.get(uri.path) }

		if url.include?("capeverde") #cape verde page will return 302, but the link is actually broken
			[nil,nil]
		elsif result.code.to_i >= 200 && result.code.to_i < 400
			doc = Nokogiri::HTML(open(url))
			[doc.css("li.come-level a.toggle strong").text,
			doc.css("li.region a.toggle strong").text
			]	
		else
			[nil,nil]
		end
	end

end