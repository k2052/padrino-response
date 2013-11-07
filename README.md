# padrino-response

Simplifies the repetitive response code in your [Padrino](http://www.padrinorb.com/) controllers

## Installation

Via rubygems:

    $ gem install padrino-responders

Or add add the following to your Gemfile:

    gem 'padrino-response'

Now register it in your application:

```ruby
class App < Padrino::Application
  register Padrino::Response
end
```

## Usage Examples

Basic:

```ruby
get :user, map: '/user' do
  respond @user
end
```

With a status code:

```ruby
post :unauthorized_user, map: => '/unauthurized-user' do
  respond :unauthorized
end
```

Skip the object:

```ruby
get :not_found, map: '/not-found' do
  respond :not_found 
end
```

### Customizing the responder:

Via options:

```ruby
class CustomResponder < Padrino::Responders::Default
end

get :custom_responder, map: '/custom-responder' do
  respond responder: "CustomResponder"
end
```

Specify a responder for the controller:

```
class Padrino::Responders::Main < Padrino::Responders::Default
end
```

# Five Second Contributions Guide

  - Fork
  - Make changes in a branch
  - Write tests
  - Commit
  - Pull Request
