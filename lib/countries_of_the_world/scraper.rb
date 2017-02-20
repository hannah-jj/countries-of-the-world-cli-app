class CountriesOfTheWorld::Scraper
#scraper class scrape the pages for information to build country info

	def scrape_page
	#this method scrape the page and returns an array that contains all info for a country
		doc = Nokogiri::HTML(open("http://www.worldbank.org/en/country"))
		list_countries =[]
		doc.css("li.name-country").each do |country|

			url = country.css("a").attr('href').value
			
			if url.include?("country") && !url.include?("israel") && !url.include?("gcc")
			 	country_info = country_page(url)
			#israel's link is pointed to more data page instead
			else 
				next
			# some urls are broken, when that happens, skip over
			end
			#puts country_info
			#puts "======================="
			list_countries << country_info if !list_countries.include?(country_info)
		end
		list_countries
	end

	def country_page(url)
	#this helper method helps to retrive information for a country
		doc = Nokogiri::HTML(open(url))
		

		info = []
		info << doc.css("div.c01v1-page-title").text.strip #get country name

		doc.css("td.c01v1-country-amounts").text.gsub("\t","_").split(" ").map {|e| info << e.gsub("_"," ")}
		#the output from css is in the following format that needs to be parsed into seperate attributes
		#"32.53\tmillion $19.33\tbillion 0.8% -1.5% "

		line = doc.css("div.c01v1-country-banner-text").text.strip
		#description of the country returns a lot of misc texts at the end. need to trim down to description, see following

		info << line[0..line.index(" \n")].strip
		
		info_url =  doc.css("span.c01v1-country-chart-text a").attr('href').value
		# more info is contained in additional page, the url is not consistent between different countries
		#some links are broken, put in an error handler in the method

		info_url[0]== "/"? info_url = "http://www.worldbank.org"+ info_url : info_url
		
		
		more_info_page(info_url).each {|e| info<< e} if more_info_page(info_url)!=nil
		# combine all info into one array
		
		#return the array that currently contains
		#population, gdp, gdp_growth%, inflation%, description,income_level, region
		info
	end

	def more_info_page(url)
	#this helper method helps to retrive additonal information for a country
	#return an array [income_level, region]

		uri = URI.parse(url)
		result = Net::HTTP.start(uri.host, uri.port) { |http| http.get(uri.path) }
		puts "#{url} & #{result.code}" if result.code=="404"

		if url.include?("capeverde")
			nil
		elsif result.code.to_i >= 200 && result.code.to_i < 400
			doc = Nokogiri::HTML(open(url))
			[doc.css("li.come-level a.toggle strong").text,
			doc.css("li.region a.toggle strong").text
			]	
		else
			nil
		end
	end

	def null_country_page(country)
		[country.css("a").text.downcase, "BROKEN_LINK"]
	end

end