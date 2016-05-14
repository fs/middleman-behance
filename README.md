# Middleman-Behance
Middleman integration of Behance API to create dynamic portfolio and project pages.

## Install

```bash
bin/setup
```

## Quality tools

* `bin/quality` based on [RuboCop](https://github.com/bbatsov/rubocop)
* `.rubocop.yml` describes active checks

## Develop

`bin/build` checks your specs and runs quality tools

## Usage
### Installation
Include this gem to your Gemfile:
`gem "middleman-behance", github: "fs/middleman-behance"`

Then activate middleman extension in `config.rb`:

```ruby
  activate :behance
```

### Configuration
You can setup this project in `config.rb`:

```ruby
  activate :behance do |b|
  	b.access_token = 'behance_api_token' # Use ENV.fetch('BEHANCE_API_TOKEN') in production
    b.user = 'flatstack' # ID or name of portfolio's creator
    b.portfolio_template = 'portfolio.html.slim' # Custom portfolio template
    b.project_template = 'project.html.slim' # Custom project template
    b.tags_whitelist = %w(design RubyOnRails front-end Mobile-Development) # List of allowed tags
    b.index_path = 'projects' # Portfolio page path
    b.pages_count = 2 # Count of fetched pages (25 for each page)
  end
```

### Pages
This plugin creates index projects page *(/projects by default)* and one for each project *(/projects/slug1, /projects/slug2)* .
Slug is based on the *name* property of project.

### Locals
You can access this local variables in **portfolio** template:

* *index_path* - portfolio page path
* *projects* - list of selected user's projects
* *tags* - list of allowed tags

You can access this local variable in **project** template:

* *project* - hash with selected project's data

### Project
Each project is represented by the hash with available project fields:

```ruby
{
  "id" => "project id",
  "name" => "name of the project",
  "description" => "project description",
  "tags" => "filtered by the whitelist tags",
  "slug" => "slugified project name",
  "modules" => "text and images blocks",
  "covers" => "project cover images"
  # ... etc
}
```
You can access this data like this: `project['name'], project['covers']['440']`.



## Credits

It was written by [Flatstack](http://www.flatstack.com) with the help of our
[contributors](http://github.com/fs/middleman-behance/contributors).


[<img src="http://www.flatstack.com/logo.svg" width="100"/>](http://www.flatstack.com)
