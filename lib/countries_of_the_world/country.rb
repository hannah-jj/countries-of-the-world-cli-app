class CountriesOfTheWorld::Country
attr_accessor :name, :url, :population, :gdp, :gdp_growth, :inflation, :description, :region, :income_level
@@all =[]

def initialize(name, url) # initialize with name & url, other info are added only when called
	@name = name
	@url = url
	#self.add_info
	@@all << self
end

def self.all
	@@all
end

def add_info (hash_info)
	hash_info.each{|k, v| self.send(("#{k}="), v)}
end

def self.list_countries (n) #print n-items per row
	max_num = @@all.max_by{ |c| c.name.length}.name.length
	#find the country name with longest name
	@@all.each.with_index(1) do |c, i|
		print "#{i.to_s.ljust(5)}".bold.light_blue.on_cyan
		print "#{c.name.ljust(max_num)}".on_cyan
		print "\n" if i%n == 0 || i == @@all.size #print \n every nth row
	end
end

def list_detail
	puts "\n"
	puts "Name:         ".bold.magenta+"#{@name}".bold
	puts "********************************************************".colorize(:red)
	puts "Population:   ".bold.light_blue+"#{@population}"
	puts "GDP:          ".bold.light_blue+"#{@gdp}"
	puts "GDP Growth:   ".bold.light_blue+"#{@gdp_growth}"
	puts "Inflation:    ".bold.light_blue+"#{@inflation}"
	puts "Region:       ".bold.light_blue+"#{@region}"
	puts "Income_level: ".bold.light_blue+"#{@income_level}"
	puts "Overview:     ".bold.light_blue+"#{@description}"
	puts "URL:          ".bold.light_blue+"#{@url}".bold.light_blue
	puts "********************************************************".colorize(:red)
	puts ""
end



end