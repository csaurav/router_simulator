=begin
	Implemented by: Saurav Chakraborty
	Ruby version: ruby 1.9.3p194
=end


class Router
	
	DEFAULT = 'default'
	NO_ROUTE_DEFINED = 'NO ROUTE DEFINED'

	# intializer
	def initialize
		@routing_rules = []
		@default_rule = []
		@routing_rules_collection = []

		@routing_statements = []
		@routing_statements_collection = []

		# This hash will is key, value pair which will store the information 
		# whether a routing statement is true or false upon comparing with the routing rule
		# Format: {10.0.0.0 => true, 10.0.0.1 => false}
		@statement_status = {}

		# In this hash, i am storing the information the routing statement and the associated count at which position it failed.
		# For true, condition count value will always be 3 and for false routing statements, count value will always be less then 3.
		# Format: {10.0.0.0 => 3, 10.0.0.1 => 2}
		@statement_status_count = {}

		# In this hash, I am storing the mapping between routing statements and their final routes.
		# Format: {10.0.0.0 => 192.168.1.1, 10.0.0.1 => NOT DEFINED}
		@statement_to_final_route = {}

	end

	# Function for converting inputs (rule and statements) to Hash
	def convert_input_to_hash(network_values,collection)
		network_values.each do |value|
			a = []
			value.each do |x|
				hash = {}
				x.split('.').each_with_index { |value,index| hash[index] = value }
				a << hash
			end
			collection << a
		end
	end

	# Function for entering input (rules and statements) 
	def enter_statements_and_rules(no_of_inputs, values, collection)
		s = []
		0.upto(no_of_inputs-1).each do |e|
			s = gets.split.to_a
			
			if s[0] == DEFAULT
				@default_rule = s
			else
				values << s	
			end	
			
		end
		
		convert_input_to_hash(values,collection)
	end

	# Function for entering inputs
	def read_input
		puts "Sample Input"

		(0..1).each_with_index do |i|
			no_of_inputs = gets.to_i
			if i == 0
				type_of_object = @routing_rules
				object_collection = @routing_rules_collection
			else
				type_of_object = @routing_statements
				object_collection = @routing_statements_collection
			end
			
			enter_statements_and_rules(no_of_inputs,type_of_object, object_collection)		
		end 
	end

	# Function for checking whether routing statements match with routing rules
	def process_input
		@routing_rules_collection.each do |routing_rule|
			position = ''
			status = false
			@routing_statements_collection.each do |routing_statement|

				result = routing_statement[0].to_a - routing_rule[0].to_a

				if result.empty?
					status = true
					
					statement_status_count status, routing_statement[0], 3, routing_rule[2].map {|k,v| v}.join('.')
					next
				else
					result.each do |res|
						position = res[0].to_i
						status = check_by_netmask? routing_rule[1][position]
						break if status == false
					end
				end
				
				statement_status_count status, routing_statement[0], position, route = routing_rule[2].map {|k,v| v}.join('.')
				
			end
		end
	end

	# Function for  assigning the routing statements with the number of associated counts as well as for assigning the status. If routing 
	# statements match with routing rules, the value will be 3, else it will be less 3. Similarly value of status will be True, if routing
	# statements match with rules, else it will be false.

	def statement_status_count(status, route_statement, count = 3, default_route = '')
		
		key = route_statement.map {|k,v| v}.join('.')
		
		if @statement_status[key].nil?
			@statement_status[key] = status
			@statement_status_count[key] = count

			assign_statement_to_rule status, key, default_route 
		
		elsif (@statement_status[key] == true && (@statement_status_count[key] != 3)) || (status == true && count == 3)
			@statement_status[key] = status
			@statement_status_count[key] = count

			assign_statement_to_rule status, key, default_route
		end	
		
	end

	# Function for mapping routing statements with their corresponding routing rules

	def assign_statement_to_rule(status, key, default_route)
		if status == true
			@statement_to_final_route[key] = default_route
		else
			
			if @default_rule[0] == DEFAULT
				@statement_to_final_route[key] = @default_rule[1]
			else
				@statement_to_final_route[key] = NO_ROUTE_DEFINED
			end
		end
	end

	# Function for checking the value of NETMASK		
	def check_by_netmask? rule
		rule != '255'? true: false
	end

	# Function for displaying the output

	def sample_output
		puts "\nSample Output"
		@statement_to_final_route.map{|k,v| puts v}
	end

	def run
		read_input
		process_input
		sample_output
	end
	
	
end

rs = Router.new
rs.run