# HelloSign API SDK

This gem provides all mechanisms needed to interact with the [Dropbox HelloSign API](https://developers.hellosign.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hello_sign-client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hello_sign-client

## Usage


### Routes

All routes will be defined in the `data/routes.json` file. These are then available via the FileStore within the client.

```ruby
>> routes = HelloSign::Client.routes
=> #<RestlessRouter::Routes:0x00007fa23c176048 @routes=[#<RestlessRouter::Route:0x00007fa23c175da0 @name="signature-requests", @path="{version}/signature_request/list", @options={:templated=>true}>, #<RestlessRouter::Route:0x00007fa23c175b70 @name="signature-request", @path="{version}/signature_request/{id}", @options={:templated=>true}>]>

>> route = routes.route_for('signature-request')
=> #<RestlessRouter::Route:0x00007fa23c175b70 @name="signature-request", @path="{version}/signature_request/{id}", @options={:templated=>true}>

>> route.url_for(version: 'v3', id: '122323')
=> "v3/signature_request/122323"
```

All routes can then be inspected with `bundle exec rake routes`


### Configuration

You can configure the client for your own needs:

```ruby
HelloSign::Client.configure do |c|
  c.api_key = '1234'
  c.logger = HelloSign::Logger.new(File.expand_path('../log/rake.log', __FILE__))
  c.request_logger = HelloSign::Logger.new(File.expand_path('../log/requests.log', __FILE__))
end
```

### Connection
Once you've configured the client you can establish a connection.

```ruby
>> connection = HelloSign::Client.connection
=> #<Faraday::Connection:0x00007fa23c1f48f8>

>> connection.get('/')
I, [2022-08-23T13:55:46.463490 #79881]  INFO -- request: GET https://api.hellosign.com/
I, [2022-08-23T13:55:46.463536 #79881]  INFO -- request: Authorization: "Basic {redacted}"
User-Agent: "HelloSign Ruby Gem 0.1.0"
Accept: "application/json"
Content-Type: "application/json"
I, [2022-08-23T13:55:46.645627 #79881]  INFO -- response: Status 302
I, [2022-08-23T13:55:46.645696 #79881]  INFO -- response: date: "Tue, 23 Aug 2022 17:55:46 GMT"
content-type: "text/html; charset=utf-8"
content-length: "100"
connection: "keep-alive"
set-cookie: "AWSALB=8HKIIef1KaSXpLejqP57+izK5jD6x1l2jt0+FZT3ccZECSF29ai7xhAJhOGNWY6QyAmZdLL5M4cmGYWW7pKuJO33tOBxOs0cflZvZi4L9VZ/l5TSlcEGJY9LOBU8; Expires=Tue, 30 Aug 2022 17:55:46 GMT; Path=/, AWSALBCORS=8HKIIef1KaSXpLejqP57+izK5jD6x1l2jt0+FZT3ccZECSF29ai7xhAJhOGNWY6QyAmZdLL5M4cmGYWW7pKuJO33tOBxOs0cflZvZi4L9VZ/l5TSlcEGJY9LOBU8; Expires=Tue, 30 Aug 2022 17:55:46 GMT; Path=/; SameSite=None; Secure"
server: "Apache"
strict-transport-security: "max-age=31536000"
vary: "Origin"
location: "https://app.hellosign.com/api"
p3p: "CP=\"NOP3PPOLICY\""
access-control-allow-origin: "*"
access-control-allow-headers: "Authorization, Origin, X-Requested-With, Content-Type, Accept, Request-URL, Referrer-Policy, Referer, Sec-CH-UA, Sec-CH-UA-Mobile, Sec-CH-UA-Platform, Sec-Fetch-Site, User-Agent, X-User-Agent"
access-control-allow-methods: "GET, POST, OPTIONS, PUT, DELETE"
=> #<Faraday::Response:0x00007fa23c2b6110>
```

> Note: Response cut for brevity

### Request
Once you've established a connection, then you can begin making
requests:

```ruby
>> request = HelloSign::Requests::SignatureRequests.list
I, [2022-08-23T14:09:51.678102 #79881]  INFO -- request: GET https://api.hellosign.com/v3/signature_request/list
I, [2022-08-23T14:09:51.678155 #79881]  INFO -- request: Authorization: "Basic {redacted}"
User-Agent: "HelloSign Ruby Gem 0.1.0"
Accept: "application/json"
Content-Type: "application/json"
I, [2022-08-23T14:09:52.472150 #79881]  INFO -- response: Status 200
I, [2022-08-23T14:09:52.472227 #79881]  INFO -- response: date: "Tue, 23 Aug 2022 18:09:52 GMT"
content-type: "application/json"
content-length: "1466"
connection: "keep-alive"
set-cookie: "AWSALB=a3Xjq7HIpdpDcunX82a8a206v6od7cseDAGHeDY084+EPY8NkAC8svjn/1QJxtY6WuFEa2UC9dV4M54LmmTjCJ4PHwJpq/9ivM1f7zXkKD37rks8gLbhg6G9ZhgW; Expires=Tue, 30 Aug 2022 18:09:52 GMT; Path=/, AWSALBCORS=a3Xjq7HIpdpDcunX82a8a206v6od7cseDAGHeDY084+EPY8NkAC8svjn/1QJxtY6WuFEa2UC9dV4M54LmmTjCJ4PHwJpq/9ivM1f7zXkKD37rks8gLbhg6G9ZhgW; Expires=Tue, 30 Aug 2022 18:09:52 GMT; Path=/; SameSite=None; Secure"
server: "Apache"
strict-transport-security: "max-age=31536000"
vary: "Origin,Accept-Encoding"
x-ratelimit-limit: "100"
x-ratelimit-limit-remaining: "99"
x-ratelimit-reset: "1661278192"
access-control-allow-origin: "*"
access-control-allow-headers: "Authorization, Origin, X-Requested-With, Content-Type, Accept, Request-URL, Referrer-Policy, Referer, Sec-CH-UA, Sec-CH-UA-Mobile, Sec-CH-UA-Platform, Sec-Fetch-Site, User-Agent, X-User-Agent"
access-control-allow-methods: "GET, POST, OPTIONS, PUT, DELETE"
user-agent: "HelloSign API"
p3p: "CP=\"NOP3PPOLICY\""
=> #<Faraday::Response:0x00007fa23a82c830>
>> 
```

> Note: Response cut for brevity

### Response
The requests will all return a delegated response object (`Faraday` as
the default adapter)

```ruby
>> response = HelloSign::Requests::SignatureRequests.retrieve('26d7fd1303666b4697a9b1a67a948aa8a81a7686')
=> #<Faraday::Response:0x00007fa23c0ed2e8

>> response.status
=> 200

>> response.headers
=> {"date"=>"Tue, 23 Aug 2022 18:18:47 GMT", "content-type"=>"application/json", "content-length"=>"705", "connection"=>"keep-alive", "set-cookie"=>"AWSALB=jTko1+Ygl3RjEWOnpy08NExWkQIq66sUDJtuOznTpqswZNDAnP1tfWBFzKFON4iw0fVeVitCe0vOTBTY+kwzJ3sNOMAnPtDuBCAt+6s8QiWf5qPaldRcxo0E4Svq; Expires=Tue, 30 Aug 2022 18:18:47 GMT; Path=/, AWSALBCORS=jTko1+Ygl3RjEWOnpy08NExWkQIq66sUDJtuOznTpqswZNDAnP1tfWBFzKFON4iw0fVeVitCe0vOTBTY+kwzJ3sNOMAnPtDuBCAt+6s8QiWf5qPaldRcxo0E4Svq; Expires=Tue, 30 Aug 2022 18:18:47 GMT; Path=/; SameSite=None; Secure", "server"=>"Apache", "strict-transport-security"=>"max-age=31536000", "vary"=>"Origin,Accept-Encoding", "x-ratelimit-limit"=>"100", "x-ratelimit-limit-remaining"=>"99", "x-ratelimit-reset"=>"1661278727", "access-control-allow-origin"=>"*", "access-control-allow-headers"=>"Authorization, Origin, X-Requested-With, Content-Type, Accept, Request-URL, Referrer-Policy, Referer, Sec-CH-UA, Sec-CH-UA-Mobile, Sec-CH-UA-Platform, Sec-Fetch-Site, User-Agent, X-User-Agent", "access-control-allow-methods"=>"GET, POST, OPTIONS, PUT, DELETE", "user-agent"=>"HelloSign API", "p3p"=>"CP=\"NOP3PPOLICY\""}

>> response.body
=> {"signature_request"=>{"signature_request_id"=>"26d7fd1303666b4697a9b1a67a948aa8a81a7686", "test_mode"=>true, "title"=>"NDA with Acme Co.", "original_title"=>"The NDA we talked about", "subject"=>"The NDA we talked about", "message"=>"Please sign this NDA and then we can discuss more. Let me know if you\nhave any questions.", "metadata"=>{"custom_id"=>1234, "custom_text"=>"NDA #9"}, "created_at"=>1661256889, "is_complete"=>false, "is_declined"=>false, "has_error"=>false, "custom_fields"=>[], "response_data"=>[], "signing_url"=>"https://app.hellosign.com/sign/26d7fd1303666b4697a9b1a67a948aa8a81a7686", "signing_redirect_url"=>nil, "final_copy_uri"=>"/v3/signature_request/final_copy/26d7fd1303666b4697a9b1a67a948aa8a81a7686", "files_url"=>"https://api.hellosign.com/v3/signature_request/files/26d7fd1303666b4697a9b1a67a948aa8a81a7686", "details_url"=>"https://app.hellosign.com/home/manage?guid=26d7fd1303666b4697a9b1a67a948aa8a81a7686", "requester_email_address"=>"external-integrations@edpaymentsystems.com", "signatures"=>[{"signature_id"=>"df23f5a693ec300d2c235952c54d05e9", "has_pin"=>false, "has_sms_auth"=>false, "has_sms_delivery"=>false, "sms_phone_number"=>nil, "signer_email_address"=>"jack@example.com", "signer_name"=>"Jack", "signer_role"=>nil, "order"=>0, "status_code"=>"awaiting_signature", "signed_at"=>nil, "last_viewed_at"=>nil, "last_reminded_at"=>nil, "error"=>nil}, {"signature_id"=>"8aef47c83e6d167763706f46f1e92817", "has_pin"=>false, "has_sms_auth"=>false, "has_sms_delivery"=>false, "sms_phone_number"=>nil, "signer_email_address"=>"jill@example.com", "signer_name"=>"Jill", "signer_role"=>nil, "order"=>1, "status_code"=>"awaiting_signature", "signed_at"=>nil, "last_viewed_at"=>nil, "last_reminded_at"=>nil, "error"=>nil}], "cc_email_addresses"=>["lawyer@hellosign.com", "lawyer@example.com"], "template_ids"=>nil}}
```

The response object will have helper methods for you to typecast the
body. For now it will handle `application/json`.

The response object will also provide you methods to handle various
responses however you would like to target:

```ruby
>> response.on(:success) { puts "OK!" }
OK!
=> nil

>> response.on(200) { puts "OK!" }
OK!
=> nil

>> response.on(201) { puts "OK!" }
=> nil

>> response.on(200, 201) { puts "OK!" }
OK!
=> nil
```

These can be targed by HTTP status codes or keywords that encompass the
full ranges.

* `:success` (200-299)
* `:redirect` (300-399)
* `:error` (400-499)
* `:server_error` (500-599)

### Models
Once you've made requests, then you can begin composing and using the
domain models.

```ruby
>> records = HelloSign::Models::SignatureRequests.list
=> #<HelloSign::Models::SignatureRequests:0x00007fa23b00cf78>

>> records.count
=> 5

>> records.first
=> #<HelloSign::Models::SignatureRequest:0x00007fa25d8e55b0>

>> record = HelloSign::Models::SignatureRequest.retrieve('26d7fd1303666b4697a9b1a67a948aa8a81a7686')
=> #<HelloSign::Models::SignatureRequest:0x00007fa25d91d9b0

>> record.id
=> "26d7fd1303666b4697a9b1a67a948aa8a81a7686"
>> record.title
=> "NDA with Acme Co."
>> record.subject
=> "The NDA we talked about"
>> record.message
=> "Please sign this NDA and then we can discuss more. Let me know if you\nhave any questions."
>> record.complete?
=> false
>> record.declined?
=> false
>> record.error?
=> false
```

### Loggers
The library has a delegated logger that you can use as you see fit.  The
client itself will use logging for:

* Request (Raw HTTP requests and responses)
* Application
* Cache

```ruby
>> logger = HelloSign::Logger.new(File.expand_path('../log/my_log.log', __FILE__))
=> #<Logger:0x00007fa25a97ece0>
```

From there you can use all standard library logging.

### Errors
The library has several errors and Exceptions that may be encountered
throughout.

> The library should always trap underlying exceptions and
bubble them up with our named errors and full stack trace.

For instance, we can create `bang!` methods that will raise exceptions
when trying to retrieve records:

```ruby
>> raise HelloSign::Errors::RecordNotFoundError.new('Record Not Found')
Traceback (most recent call last):
        2: from bin/console:15:in `<main>'
        1: from (irb):21
HelloSign::Errors::RecordNotFoundError (Record Not Found)
```

This way the consumer of this library will only ever deal with the
subset of exceptions defined in this library.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ElectronicDataPaymentSystems/hello_sign-client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
