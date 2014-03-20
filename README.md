ruby-trustedsearch
==================
trustedSEARCH Ruby Gem


Full Documentation: [http://developers.trustedsearch.org](http://developers.trustedsearch.org)

Ruby Gems: [https://rubygems.org/gems/trustedsearch](https://rubygems.org/gems/trustedsearch)

## <a id="requirement"></a>Requirements

[Ruby](http://www.ruby-lang.org/en/downloads/) 1.9 or above.


## <a id="installation"></a>Installation

Add this line to your application's Gemfile:

    gem 'trustedsearch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trustedsearch

Once you have your credentials you can manually run rake tasks to access the the api, or you can integrate direction.

## <a id="usage"></a>Usage

The gem is designed to support all existing and future [TRUSTEDSearch API's](http://developers.trustedsearch.org) resources.

To start using the gem, you need to be given your sandbox and production public & private keys.


## API V1 Examples

Include the required libs & set your public and private keys

```ruby

require "trustedsearch"

TrustedSearch.public_key = "PUBLIC_KEY"
TrustedSearch.private_key = "PRIVATE_KEY"
TrustedSearch.environment = "production"  #default is 'sandbox'

```


#### Get All Business for all users locations
See the [API documentation](http://developers.trustedsearch.org/#/get-business-updates) for a list of parameters for each API resource.

```ruby
api = TrustedSearch::V1.new
puts api.getBusinessUpdate().data.to_s
```
##### Rake

```ruby
rake v1:updates[YourPublicKey,YourPrivateKey]
```


#### Get Business Updates for single location
See the [API documentation](http://developers.trustedsearch.org/#/get-business-updates) for a list of parameters for each API resource.

```ruby
api = TrustedSearch::V1.new
puts api.getBusinessUpdate(534f95e8-1de1-558f-885c-3962f22c9a28).data.to_s
```

##### Rake
Get update for location 534f95e8-1de1-558f-885c-3962f22c9a28

```ruby
rake v1:updates[YourPublicKey,YourPrivateKey,534f95e8-1de1-558f-885c-3962f22c9a28]
```


#### Get Business Updates since epoch 1380611103
See the [API documentation](http://developers.trustedsearch.org/#/get-business-updates) for a list of parameters for each API resource.

```ruby
api = TrustedSearch::V1.new
puts api.getBusinessUpdateSince(1380611103).data.to_s
```

##### Rake
Get update  since 1380611103
```ruby
rake v1:updates_since[YourPublicKey,YourPrivateKey,1380611103]
```

#### Submit New Business Listings

See the [API documentation](http://developers.trustedsearch.org/#/submitting-a-business) for a list of parameters for each API resource.

```ruby
business_data = [
	{
		:externalId => 'ABC123',
		:order => {
			:onBehalfOf => 'Sample Partner',
			:packages => [
				9,10
			]
		},
		:contact => {
			:firstName => "Albert",
			:lastName => "Einstein",
			:email => "albert@trustedsearch.org",
			:phone => "5555555555"
		},
		:business => {
			:name => "Albert's Relativity Lane",
			:street => "123 Cherry Tree Lane",
			:city => "Santa Barbara",
			:state => "CA",
			:postalCode => "93041",
			:phoneTollFree =>"(800) 555-5555",
			:website => "http://www.relativitylane.com",
			:email => "info@relativitylane.com",
		}
	},
	{
		:externalId => 'ABC456',
		:order => {
			:onBehalfOf => 'Sample Partner',
			:packages => [
				9,10
			]
		},
		:contact => {
			:firstName => "Albert",
			:lastName => "Einstein",
			:email => "albert@trustedsearch.org",
			:phone => "4444444444"
		},
		:business => {
			:name => "Albert's Relativity Lane",
			:street => "456 Cherry Tree Lane",
			:city => "Santa Barbara",
			:state => "CA",
			:postalCode => "93041",
			:phoneTollFree =>"(800) 555-5555",
			:website => "http://www.relativitylane.com/mc2",
			:email => "info@relativitylane.com",
		}
	}
]

api = TrustedSearch::V1.new
response = api.postBusiness(business_data)

# # Ex: v1/directory-listings/:uuid
uuid = response.data[0]["uuid"]
```

##### Rake

Submit a new location using JSON data in file relative path "examples/body.json"

```ruby
rake v1:submit[YourPublicKey,YourPrivateKey,"examples/body.json"]
```

### Testing

#### Testing / Simulating a change in a business listing

```ruby

uuid = '534f95e8-1de1-558f-885c-3962f22c9a28'
api = TrustedSearch::V1.new
response = api.putTestFulfillment(uuid)

```
##### Rake

SANDBOX ONLY: Test the fulfilment process for development & testing purposes

```ruby
rake v1:test_fulfillment[YourPublicKey,YourPrivateKey,534f95e8-1de1-558f-885c-3962f22c9a28]
```

## V2 Api Examples

### Hooks

#### Index: Retrieve an array of hooks that can be subscribed to.
[API documentation](http://developers.trustedsearch.org/#/v2-subscriptions-index)

```ruby
hook = TrustedSearch::V2::Hook.new
puts hook.index().data.to_json
```

##### Response
```ruby
{
	:status=>"success",
 	:code=>200,
 	:message=>"",
 	:data=>
  		[
  			{
				:id          =>	1,
				:name        =>	"location.updates",
				:description => "Data for the location has been update within TRUSTEDSearch ecosystem.",
				:product_id  =>	nil,
				:created_at  =>	"0000-00-00 00:00:00",
				:updated_at  =>	"0000-00-00 00:00:00"
	    	},
	   		{
				:id          =>	2,
				:name        =>	"location.audit",
				:description =>	"Results of an audit.",
				:product_id  =>	63,
				:created_at  =>	"0000-00-00 00:00:00",
				:updated_at  =>	"0000-00-00 00:00:00"
	    	},
	   		{
				:id          =>	3,
				:name        =>	"location.report",
				:description =>	"Results of a recurring reporting for a given location and its listings.",
				:product_id  =>	64,
				:created_at  =>	"0000-00-00 00:00:00",
				:updated_at  =>	"0000-00-00 00:00:00"
	    	}
	    ]
}
```

#### Show: Show a single hook record.
[API documentation](http://developers.trustedsearch.org/#/v2-subscriptions-show)

```ruby
hook = TrustedSearch::V2::Hook.new
puts hook.show("1").data.to_json
```

##### Reponse

```ruby
{
	:status =>	"success",
	:code =>	200,
	:message =>	"",
	:data=>
		{
			:id          =>	1,
			:name        =>	"location.updates",
			:description =>	"Data for the location has been update within TRUSTEDSearch ecosystem.",
			:product_id  =>	nil,
			:created_at  =>	"0000-00-00 00:00:00",
			:updated_at  =>	"0000-00-00 00:00:00"
		}
}
```

### Subscriptions

#### Index: Retrieve an array of all hook subscriptions you are subscribed to.

[API documentation](http://developers.trustedsearch.org/#/v2-subscriptions-index)

```ruby
subscription = TrustedSearch::V2::HookSubscription.new
pp subscription.index().data

```

##### Rake

```ruby
rake v2:hooksubscriptions:index[0e2e66593bd4e7423ab83b2ded17acfa,pakaThe3rupHuprEnupraCha]
```

##### Response

```ruby
{
	:status=>"success",
 	:code=>200,
 	:message=>"",
 	:data=>	[
 		{
			:id         =>	"624c83f1-3c0d-4b27-86e1-c80d88dbf8e2",
			:hook_id    =>	1,
			:user_id    =>	94,
			:target_url =>	"http://api.myendpoint.com/trustedsearch/location-updates",
			:created_at =>	"2014-03-20 18:32:45",
			:updated_at =>	"2014-03-20 18:32:45"
		},
   		{
			:id         =>	"bdd46e50-669a-49cf-93ce-db682f6e9008",
			:hook_id    =>	2,
			:user_id    =>	94,
			:target_url =>	"http://api.myendpoint.com/trustedsearch/location-audits",
			:created_at =>	"2014-03-20 18:33:21",
			:updated_at =>	"2014-03-20 18:33:21"
    	}
    ]
}
```


#### Create: Create a new hook subscription

[API documentation](http://developers.trustedsearch.org/#/v2-subscriptions-create)

```ruby

subscription = TrustedSearch::V2::HookSubscription.new
data = {
	:hook => "location.updates",
	:target_url => "http://api.myendpoint.com/trustedsearch/location-updates"
}
pp subscription.create(data).data	
```

##### Rake

```ruby
rake v2:hooksubscriptions:create[0e2e66593bd4e7423ab83b2ded17acfa,pakaThe3rupHuprEnupraCha,location.update,http://api.myendpoint.com/trustedsearch/location-updates]
```

##### Response
```ruby
{
	:status  =>	"success",
	:code    =>	200,
	:message =>	"",
 	:data=>	{
		:hook_id    =>	1,
		:target_url =>	"http://api.myendpoint.com/trustedsearch/location-updates",
		:user_id    =>	94,
		:id         =>	"bdd46e50-669a-49cf-93ce-db682f6e9008",
		:updated_at =>	"2014-03-20 18:33:21",
		:created_at =>	"2014-03-20 18:33:21"
	}
}
```

#### Show: Show a hook subscription record

[API documentation](http://developers.trustedsearch.org/#/v2-subscriptions-show)

```ruby
subscription = TrustedSearch::V2::HookSubscription.new
pp subscription.show("bdd46e50-669a-49cf-93ce-db682f6e9008").data
```

##### Rake

```ruby
rake env=local v2:hooksubscriptions:show[0e2e66593bd4e7423ab83b2ded17acfa,pakaThe3rupHuprEnupraCha,bdd46e50-669a-49cf-93ce-db682f6e9008]
```

##### Response

```ruby
{
	:status  =>	"success",
	:code    =>	200,
	:message =>	"",
	:data    =>	{
		:id         =>	"bdd46e50-669a-49cf-93ce-db682f6e9008",
		:hook_id    =>	1,
		:user_id    =>	94,
		:target_url =>	"http://api.myendpoint.com/trustedsearch/location-updates",
		:created_at =>	"2014-03-20 18:33:21",
		:updated_at =>	"2014-03-20 18:33:21"
	}
}
```

#### Update: Update an existing hook subscription record.

[API documentation](http://developers.trustedsearch.org/#/v2-subscriptions-update)

```ruby
subscription = TrustedSearch::V2::HookSubscription.new
data = {
	:hook => "loocation.audit",
	:target_url => "http://api.myendpoint.com/trustedsearch/location-audit"
}
pp subscription.update("bdd46e50-669a-49cf-93ce-db682f6e9008", data).data
```

##### Rake

```ruby
rake v2:hooksubscriptions:update[0e2e66593bd4e7423ab83b2ded17acfa,pakaThe3rupHuprEnupraCha,bdd46e50-669a-49cf-93ce-db682f6e9008,location.audit,http://api.myendpoint.com/trustedsearch/location-audit]
```

##### Response
```ruby
{
	:status  =>	"success",
	:code    =>	200,
	:message =>	"",
	:data    =>	{
		:id         =>	"bdd46e50-669a-49cf-93ce-db682f6e9008",
		:hook_id    =>	2,   ###<----- Notice this changed to a 2
		:user_id    =>	94,
		:target_url =>	"http://api.myendpoint.com/trustedsearch/location-audit",   ####<----Notice this updated.
		:created_at =>	"2014-03-20 18:33:21",
		:updated_at =>	"2014-03-20 18:35:11"
	}
}

```

#### Destroy: Destroy an existing hook-subscription record.

[API documentation](http://developers.trustedsearch.org/#/v2-subscriptions-destroy)

```ruby
subscription = TrustedSearch::V2::HookSubscription.new
pp subscription.destroy(args.id).data
```
##### Rake

```ruby
rake v2:hooksubscriptions:destroy[0e2e66593bd4e7423ab83b2ded17acfa,pakaThe3rupHuprEnupraCha,bdd46e50-669a-49cf-93ce-db682f6e9008]
```

##### Response

```ruby
{
	:status  =>	"success",
	:code    =>	200,
	:message => "Successfully removed subscription : bdd46e50-669a-49cf-93ce-db682f6e9008",
	:data    =>	[]
}
```

### Error Handling
Exceptions are thrown when there is an api issue.

```ruby

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

```

Output: (Body is formatted for readability.)

```javascript

Message: Bummer, we couldn't save this record. You might have to fix a few things first and try again.
Body:
{	
	"status"=>"error", 
	"code"=>409, 
	"message"=>"Bummer, we couldn't save this record. You might have to fix a few things first and try again.", 
	"error"=>"ModelSaveFailedException", 
	"debug"=>"Model was unable to save, check validation errors.", 
	"validations"=>{"uuid"=>["The uuid field is required."], 
	"business_name"=>["The business name field is required."]}, 
	"data"=>[]
}
Code: 409

```

