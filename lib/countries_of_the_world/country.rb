class CountriesOfTheWorld::Country
attr_accessor :name, :population, :gdp, :gdp_growth, :description, :region, :income_level
@@all =[]

def initialize(name)
	@name = name
	self.add_info
	@@all << self
end


def list_countries
	puts "1. "+"Name:         ".colorize(:light_blue)+"#{@name}"
	puts "2. "+"Name:         ".colorize(:light_blue)+"#{@name}"
	
end

def list_detail
	puts "COUNTRY AT A GLANCE"
	puts "Name:         ".colorize(:magenta)+"#{@name}"
	puts "**************".colorize(:red)
	puts "Region:       ".colorize(:light_blue)+"#{@region}"
	puts "Income_level: ".colorize(:light_blue)+"#{@income_level}"
	puts "Population:   ".colorize(:light_blue)+"#{@population}"
	puts "GDP:          ".colorize(:light_blue)+"#{gdp}"
	puts "GDP Growth:   ".colorize(:light_blue)+"#{gdp_growth}"
	puts "Overview:     ".colorize(:light_blue)+"#{description}"
end

def self.all
	@@all
end

def self.add_info
end

end