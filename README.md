# Ruboty::Ragoon

[![Build Status](https://travis-ci.org/kwappa/ruboty-ragoon.svg)](https://travis-ci.org/kwappa/ruboty-ragoon)

[Ragoon](https://github.com/kwappa/ragoon) handler for [Ruboty](https://github.com/r7kamura/ruboty)

## Installation

Add this line to your Ruboty's Gemfile:

```ruby
gem 'ruboty-ragoon'
```

## Variables

Set these variables to connect your Garoon (required by Ragoon)

- `GAROON_ENDPOINT`  : your garoon URL (ends with `?WSDL`)
- `GAROON_USERNAME`  : your garoon username
- `GAROON_PASSWORD`  : your garoon password

## Usage

### Event

- `grn event[ date]`
  - fetch events specified by `date`
  - `date` allows `yesterday`, `today`, `tomorrow` and string that can bs parsed by `Date.parse`
  - default : `today`
- private event
  - mask place and description when replies in channel
  - show place and detail when replies in direct message

### Notification

- `grn notice`
  - show today`s unread notifications
  - replies only first time
    - reminds notified ids in `Ruboty::Brains`
- better to use with `ruboty-cron`
  - e.g) `ruboty add job "*/10 8-22 * * *" grn notice`

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
