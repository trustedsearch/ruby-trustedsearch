namespace :v1 do
	task :default do

	end

	desc "Get the directory listings updates. [uuid] if not specified, returns all."
	task :updates, [:public_key, :private_key, :uuid, :since] do |t, args|
		TrustedSearch.public_key = args.public_key
		TrustedSearch.private_key = args.private_key
		TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
		uuid = ( args.uuid.nil? ? nil : args.uuid)
		if(uuid == "")
			uuid = nil
		end
		since = ( args.since.nil? ? nil : args.since)
		api = TrustedSearch::V1.new
		begin
			puts api.getBusinessUpdate(uuid, since).data.to_s
		rescue Exception => e
			puts "Message: " + e.message
			puts "Body:"
			puts e.body
			puts "Code: " + e.code.to_s
		end

	end

	desc "Submit a listings to be enhanced and created."
	task :submit, [:public_key, :private_key, :file] do |t, args|
		TrustedSearch.public_key = args.public_key
		TrustedSearch.private_key = args.private_key
		TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
		body_file = ( args.file ? args.file : nil)
		if(body_file.nil?)
			puts "You must specify a valid body file."
			next
		end

		file = File.open(body_file, "rb")
		begin
			api = TrustedSearch::V1.new
			contents = file.read
			response = api.postBusiness(JSON.parse(contents))
			puts response.code
			puts response.data
		rescue Exception => e
			puts "Message: " + e.message
			puts "Body:"
			puts e.body
			puts "Code: " + e.code.to_s
		end

		file.close

	end

	task :test_fulfillment, [:public_key, :private_key, :uuid] do |t, args|
		TrustedSearch.public_key = args.public_key
		TrustedSearch.private_key = args.private_key
		TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')

		location_id = args.uuid
		location_id = ( args.uuid ? args.uuid : nil)

		if(location_id.nil?)
			puts "You must specify a uuid of the business you wish to test."
			next
		end

		api = TrustedSearch::V1.new

		begin
			response = api.putTestFulfillment(location_id)
			puts response.code
			puts response.data
		rescue Exception => e
			puts e.body
		end


	end
end