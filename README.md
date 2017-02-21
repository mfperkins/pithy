# Pithy

[Pithy](https://www.itspithy.com) Pithy is a witty bot which inserts quotes from your favorite leaders straight into your [Slack](http://www.slack.com) conversations. For example, if you type `/pithy churchill`, Pithy might respond:

> As Winston Churchill would say ...
> History will be kind to me for I intend to write it.

Other commands you can give Pithy in Slack are:

* `/pithy help` - For a list of commands within you can use in Slack
* `/pithy people` - For a list of people you can get quotes from

To contribute to this project, please fork this repo and make a pull request with changes.

---

## Development Setup

### Installation Prerequisites

First, you will need to install [Homebrew](http://brew.sh/).

Once installed, you can run the following via the Homebrew package manager in the command line.

Ruby

	$ brew install ruby

PostgreSQL

	$ brew install postgres

Bundler

	$ gem install bundler

### Run the app

Clone the repository on GitHub:

	$ git clone https://github.com/mfperkins/pithy.git

Enter your new project folder:

	$ cd pithy

Create a .env file by copying from the example template and updating with your own secret Slack and AWS keys:

	$ cp .env.example .env

Install all the dependencies from the Gemfile using Bundler:

	$ bundle install

Create the necessary Pithy databases, run the migrations and seed with data:

	$ rails db:create db:migrate db:seed

Run the Rails server:

	$ rails s

### Running Tests

Run tests through RSpec.

	$ rspec
