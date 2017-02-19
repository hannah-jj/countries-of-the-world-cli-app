class CountriesOfTheWorld::Scraper
#scraper class scrape the pages for information to build country info

	def scrape_page
	#this method scrape the page and returns a hash that contains all info for a country
		doc = Nokogiri::HTML(open("http://www.worldbank.org/en/country"))
		list_countries =[]

		doc.css("li.name-country").each do |country|
			url = country.css("a").attr('href').value
			list_countries <<
			{
			:name => country.css("a").text,
			:url => url,
			:details => country_page(url)
			}
			
			
		end

		list_countries
	end

	def country_page(url)
	#this helper method helps to retrive information for a country
	#returns a hash

		doc = Nokogiri::HTML(open(url))
		info = doc.css("td.c01v1-country-amounts").text.gsub("\t","_").split(" ").map {|e| e.gsub("_"," ")}
		#the output from css is in the following format that needs to be parsed into seperate attributes
		#"32.53\tmillion $19.33\tbillion 0.8% -1.5% "
		line = doc.css("div.c01v1-country-banner-text").text.strip
		#this returns a lot of misc texts at the end. need to trim down to description, see following
		description = line[0..line.index(" \n")].strip
		more_info_url =  doc.css("span.c01v1-country-chart-text a").attr('href').value
		# more info is contained in additional page
		more_info_page(more_info_url).each {|e| info<< e}
		# combine all info into one array

		binding.pry
			#:population=>, 
			#:gdp=>, 
			#:gdp_growth=>, 
			#:inflation=>,
			#:income_level=>,
			#:region=>
			#:description=>

	end

	def more_info_page(url)
	#this helper method helps to retrive additonal information for a country
	#return an array {income_level, region}
		doc = Nokogiri::HTML(open(url))
		[doc.css("li.come-level a.toggle strong").text,
		doc.css("li.region a.toggle strong").text
		]
	end

end