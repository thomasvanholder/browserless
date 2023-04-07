# Browserless Gem

Introducing the "Browserless" gem - a Ruby gem that provides a convenient wrapper around the [Browserless PDF API](https://www.browserless.io/docs/pdf). Browserless relies on puppeteer to convert modern CSS into a PDF. The goal of this gem is to enables developers to easily generate PDF documents from the HTML you already have.

By utilizing a managed service such as [Browserless.io](https://www.browserless.io/), you can concentrate on your core application functionality while relying on a simple API call to address your PDF generation requirements.

The free trial of browerless includes upto 1,000 PDFs a month, 10 concurrent browsers. 

__Benefits__
- turn your existing HTML and CSS into a PDF
- supports modern CSS frameworks such as TailwindCSS
- no need to install, run and maintain puppeteer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'browserless'
```

And then execute:
**
    $ bundle install**

Or install it yourself as:

    $ gem install browserless

## Configuration
Add your Browserless.io API key in an initializer file, like `config/browserless.rb`. You can set default configuration options in the initializer.

```rb
Browserless.configure do |config|
  config.api_key = "your_api_key_here"
  config.emulate_media = "print" # choose between print or screen (default)
  config.style_tag = File.read(Rails.root.join("app/assets/builds/application.css")) # Pass public asset URL or CSS string content  
  config.options = {
    landscape: false # default
    print_background: false,
    format: "A4" # default https://pptr.dev/api/puppeteer.paperformat#remarks
    display_header_footer: false, # default 
    header_template: "<div>...</div>", # ensure display_header_footer is true
    footer_template: "<div>...</div>", # ensure display_header_footer is true
    margin: {
      top: "2cm",
      left: "0.5cm",
      right: "0.5cm",
      bottom: "2cm"
    },
  }
end
```

__api_key__
Make sure to replace `"your_api_key_here"` with your actual Browserless.io API key.

__emulate_media__
You can specify the media type by passing in the optional `emulate_media` keyword argument. Choose between `screen` (default) or `print`. 

>TailwindCSS supports the [print modifier](https://tailwindcss.com/docs/hover-focus-and-other-states#print-styles), so you can conditional add styles to only be displayed with the PDF is being generated.

__style_tag__
You can use both a public URL or pass the CSS as a string to add CSS to your PDF. Note that browserless can't asses any url refering to your local environment. Therefore, in your local environment pass the CSS as a string.

```rb
def css_asset
  if Rails.env.production?
    ActionController::Base.helpers.asset_path("application.css")
  else
    File.read(Rails.root.join("app/assets/builds/application.css"))
  end
end

Browserless.configure do |config|
  # ... 
  config.style_tag = css_asset
end
```

## Usage

Here's an example of how to use the `Browserless::Client` to generate a PDF from HTML content:

```rb
client = Browserless::Client.new(html: "<html></html>")
pdf_data = client.to_pdf
```

You can customize the PDF generation by passing options. Passed in options will overwrite options set in the intializer.

```rb
client = Browserless::Client.new(
  html: "<html>...</html>", 
  emulate_media: "print",
  options: {
    landscape: true
    display_header_footer: true
    }
  )
pdf_data = client.to_pdf
```

You can pass the following options:

- `landscape` default false
- `print_background` default false
- `margin` default none
- `format` default A4
- `header_template` default empty
- `footer_template`default X of X page
- `display_header_footer` default true

Note that the above options are nested in an options hash.

## Rails example

```rb
class Policy
 # ...
 def to_pdf
    html = ApplicationController.render(
      partial: "policies/document",
      locals: { policy: policy}
    )

    Browserless::Client.new(
      html: html,
      options: {
        display_header_footer: true
      }
    ).to_pdf
  end
end

class PoliciesController
   # ...
  def show
    # ... 
    respond_to do |format|
      format.pdf {
        send_data @policy.to_pdf, type: "application/pdf", disposition: "attachment", filename: "privacy_policy.pdf"
      }
  end
end
```

In your view::
```rb
link_to "Download", policy_path(@policy, format: :pdf)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thomasvanholder/browserless. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/thomasvanholder/browserless/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Browserless project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/thomasvanholder/browserless/blob/master/CODE_OF_CONDUCT.md).
