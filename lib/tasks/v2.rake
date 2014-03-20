namespace :v2 do

	task :default do

	end

	namespace :hooks do
		desc "Get a list of all the hooks."
		task :all, [:public_key, :private_key] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			hook = TrustedSearch::V2::Hook.new
			begin
				puts hook.all().data.to_json
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end

		desc "Get a single hook."
		task :show, [:public_key, :private_key, :id] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			hook = TrustedSearch::V2::Hook.new
			begin
				puts hook.show(args.id).data.to_json
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end
	end

	namespace :hooksubscriptions do
		desc "Get a list of all the subscriptions you are subscribed to."
		task :all, [:public_key, :private_key] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			subscription = TrustedSearch::V2::HookSubscription.new
			begin
				puts subscription.all().data.to_json
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end

		desc "Get a single subscription."
		task :show, [:public_key, :private_key, :id] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			subscription = TrustedSearch::V2::HookSubscription.new
			begin
				puts subscription.show(args.id).data.to_json
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end


		desc "Add a single subscription."
		task :add, [:public_key, :private_key, :hook, :target_url] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			subscription = TrustedSearch::V2::HookSubscription.new
			begin
				data = {
					:hook => args.hook,
					:target_url => args.target_url
				}
				puts subscription.add(data).data.to_json
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end

		desc "Edit a single subscription."
		task :edit, [:public_key, :private_key, :id, :hook, :target_url] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			subscription = TrustedSearch::V2::HookSubscription.new
			begin
				data = {
					:hook => args.hook,
					:target_url => args.target_url
				}
				puts subscription.edit(args.id, data).data.to_json
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end

		desc "Edit a single subscription."
		task :destroy, [:public_key, :private_key, :id] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			subscription = TrustedSearch::V2::HookSubscription.new
			begin
				puts subscription.destroy(args.id).data.to_json
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end
	end

end