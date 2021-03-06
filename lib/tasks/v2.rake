require 'pp'
namespace :v2 do

	task :default do

  end

  namespace :locations do

    desc "Get all listings for a location"
    task :listings, [:public_key, :private_key, :location_id] do |t, args|
      TrustedSearch.public_key = args.public_key
      TrustedSearch.private_key = args.private_key
      TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
      location = TrustedSearch::V2::Location.new
      begin
        pp location.listings(args.location_id).data
      rescue Exception => e
        puts "Message: " + e.message.to_s
        #puts "Body:"
        puts e.backtrace
        #puts "Code: " + e.code.to_s
      end
    end
  end

	namespace :hooks do
		desc "Get a list of all the hooks."
		task :index, [:public_key, :private_key] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			hook = TrustedSearch::V2::Hook.new
			begin
				pp hook.index().data
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				puts e.backtrace
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
				pp hook.show(args.id).data
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
		task :index, [:public_key, :private_key] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			subscription = TrustedSearch::V2::HookSubscription.new
			begin
				pp subscription.index().data
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end

		desc "Show a single subscription."
		task :show, [:public_key, :private_key, :id] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			subscription = TrustedSearch::V2::HookSubscription.new
			begin
				pp subscription.show(args.id).data
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end

		desc "Create a single subscription."
		task :create, [:public_key, :private_key, :hook, :target_url] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			subscription = TrustedSearch::V2::HookSubscription.new
			begin
				data = {
					:hook => args.hook,
					:target_url => args.target_url
				}
				pp subscription.create(data).data
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end

		desc "Update a single subscription."
		task :update, [:public_key, :private_key, :id, :hook, :target_url] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			subscription = TrustedSearch::V2::HookSubscription.new
			begin
				data = {
					:hook => args.hook,
					:target_url => args.target_url
				}
				pp subscription.update(args.id, data).data
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end

		desc "Destroy a single subscription."
		task :destroy, [:public_key, :private_key, :id] do |t, args|
			TrustedSearch.public_key = args.public_key
			TrustedSearch.private_key = args.private_key
			TrustedSearch.environment = ( ENV['env'] ? ENV['env'] : 'sandbox')
			
			subscription = TrustedSearch::V2::HookSubscription.new
			begin
				pp subscription.destroy(args.id).data
			rescue Exception => e
				puts "Message: " + e.message.to_s
				#puts "Body:"
				#puts e.backtrace
				#puts "Code: " + e.code.to_s
			end

		end
	end

end