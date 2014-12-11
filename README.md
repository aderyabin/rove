# Rove
Rove - visual online Vagrant configurator. [![Code Climate](https://codeclimate.com/github/aderyabin/rove.png)](https://codeclimate.com/github/aderyabin/rove)

## Usage

Run `rake server` to bootstrap Sinatra or `rake console` to have some command line fun.

## Please contribute

We are doing our best to add more useful packages to Rove. But that's not enough. If you are an author of a nice Vagrant cookbook – you are very welcome to add its support!

To make this job easier we wrapped packages and patterns into a tiny DSL described below. You can find all the packages located at `/packages` directory, patterns at `/patterns` and vagrant configuration in `vagrant_settings` accordingly.

**Feel free to add some more and create a shiny pull request!**

## DSL Description

### Packages

Packages are atomic parts of the config. They are, typically, either one recipe or a single tool/service be it a programming language like Ruby or a database like PostgreSQL.

Each package consists of nested options, switches and inputs that will affect resulting Vagrant configuration and also the set of cookbooks that will be added to resulting Cheffile.

Here is the base of a package:

```ruby
Rove.package :foobar do
  title 'FooBar' # can be skipped and will be defaulted to :foobar.to_s.humanize
  category 'Something'
end
```

This is the least possible description. You need to specify an unique keyword for the package you work on (`:foobar`) and also a category. Omitting any of those will result into an exception.

#### Options

To make configuration possible, Rove defines three kinds of possible user inputs: options, inputs and selects. Each of them can be nested into any other.

`option` is your infantry:

```ruby
Rove.package :foobar do
  category 'Something'

  option :important_flag do
    title 'Set important flag' # can be skipped and will be defaulted to :important_flag.to_s.humanize

    # This option will become available as soon as the parent is enabled
    option :important_subflag
  end

  option :enable_autostart
end
```

Options give you ability to make particular features switchable. On the other hand `select` gives an ability to force user to choose between possible options:

```ruby
Rove.package :foobar do
  category 'Something'

  option :enable_autostart do
    select 'Select launcher to use' do
      option :launcher1 do
        option :deliver_crash_reports do
          title 'Deliver crash reports?'
        end
      end
      option :launcher2
    end
  end
end
```

As you can see you can freely nest options in any order. Note however that **options have to have unique keywords in the context of package** no matter how deeply they nested.

Sometimes you might want to get some custom textual user input. It's possible with `input` method. It behaves absolutely identical to `option`.

```ruby
Rove.package :foobar do
  category 'Something'

  option :enable_autostart do
    select 'Select launcher to use' do
      option :launcher1 do
        option :deliver_crash_reports do
          title 'Deliver crash reports?'

          input :deliver_email do
            title 'Deliver to'
          end
        end
      end
      option :launcher2
    end
  end
end
```

Additionaly you can specify a default value like this:

```ruby
Rove.package :foobar do
  category 'Something'

  input :password do
    default 'ololo'

    config do |value|
      # this block runs with any configuration: default value is used if input was not enabled manually
    end
  end
end
```

In case you know list of all possible values you can specify them using `enum`:

```ruby
Rove.package :foobar do
  category 'Something'

  input :log_type do
    default 'warning'
    enum 'info', 'warning', 'error'

    config do |value|
      # ...
    end
  end
```

### Configuration

Now that you described your package's options we can use them to affect the resulting configuration. Rove defines three methods that will help you to achieve that: `cookbook`, `recipe` and `config`. They can be called from any option, select or input and also from the package itself.

```ruby
Rove.package :foobar do
  category 'Something'

  # Adds cookbook dependency. Every given option will be proxied to Librarian as-is.
  cookbook 'foobar', :option => 'value'

  # Activates recipe at provisioning
  recipe 'foobar'

  option :enable_autostart do
    # A hash returning from this method will be merged into provisioning configuration
    # Note that this is going to happen only while `:enable_autostart` option is enabled.
    config do
      {
        :foobar => {
          :user => 'ololo'
        }
      }
    end

    select 'Select launcher to use' do
      option :launcher1 do
        option :deliver_crash_reports do
          # Another cookbook that will be required as long as `:deliver_crash_reports` is enabled
          cookbook 'foobar_emails'

          title 'Deliver crash reports?'
        end
      end
      option :launcher2
    end
  end
end
```

While `cookbook` and `recipe` methods are pretty straightforward, the `config` method has some overloads to handle tough cases.

```ruby
Rove.package :foobar do
  category 'Something'

  # Typically it can accept up to two arguments
  config do |config, build|
    config # contains current config condition at the moment of block evaluation
    build  # details of build that was requested by user: complete list of required packages and options
  end

  # While being called from an input it gets up to three parameters
  input :option do
    config do |value, config, build|
      value  # a textual input that was provided by user
      config # contains current config condition at the moment of block evaluation
      build  # details of build that was requested by user: complete list of required packages and options
    end
  end
end
```

Sometimes it might be useful to define a helper:

```ruby
Rove.package :foobar do
  category 'Something'

  config do
    specific_configurator
  end

  def specific_configurator
  end
end
```

An order of merge between options is not declared. They have to be isolated and it plays well in most cases. But sometimes it doesn't. In these dark times `finalizer` comes to save you. Consider it an after-filter of a package configuration.

```ruby
Rove.package :foobar do
  category 'Something'

  config
    {:a => 'b'}
  end

  input :option do
    config do
      {:b => 'c'}
    end
  end

  finalizer do |config|
    config # {:a => 'b', :b => 'c'}
  end
end
```

Finalizer can only be defined at a package level.


### Vagrant Settings

Vagrant Settings are also atomic parts of the config, follow a similar pattern to Packages and support altering the default Vagrant configuration. They inherit the same user input options as Packages along with default values.

Here is an example of a setting taking two input values and being applied to create a line of configuration for Vagrant:

```ruby
Rove.vagrant_setting :my_setting do

  # Provide a block returning a line of config.
  # Values appear in the order of input specification below
  config do |first_value, second_value|
    "vagrant.config :i_want_to_set, this: #{first_value}, and_this: #{second_value}"
  end

  input :option_1 do
    title 'Please set me'
    default 'foo'
    config do |value|
      {
        my_setting: {
          config: {
            option_1: value
          }
        }
      }
    end
  end

  input :option_2 do
    title 'I need to be set too'
    default 'bar'
    config do |value|
      {
        my_setting: {
          config: {
            option_2: value
          }
        }
      }
    end
  end

end
```


### Patterns

Pattern is a build template. It lists pre-enabled packages and corresponding internal options for each of them. Patterns are powered by the configuration objects listed previously as commands such as `package` or `vagrant_setting`.

```ruby
Rove.pattern :rails do
  title 'Rails' # can be skipped and will be defaulted to :rails.to_s.humanize

  # First argument is a keyword of package
  # Other arguments are options that should be enabled
  package :ruby, 'rbenv', 'rbenv_193', 'rbenv_200'

  # Note that sometimes you might require to pass values for inputs
  # Here is the alternative syntax for options
  package :ruby, {:ruby => true, :rbenv => true, :something_to_input => 'Yes, I do!'}

  # And some other packages
  package :postgresql
  package :redis
  package :git

  # Add Vagrant configuration if necessary
  vagrant_setting :port_forward, {:guest_port => 3000, :host_port => 3000}
end
```

## Examples

Since Rove is a working service – just go and look through `packages`, `patterns` or `vagrant_settings` directories. It's full of packages we already use.

## Credits

* Andrey Deryabin ([@aderyabin](http://github.com/aderyabin)) [![endorse](http://api.coderwall.com/aderyabin/endorsecount.png)](http://coderwall.com/aderyabin)
* Boris Staal ([@inossidabile](http://staal.io)) [![endorse](http://api.coderwall.com/inossidabile/endorsecount.png)](http://coderwall.com/inossidabile)

## Special Thanks
* Ravil Bayramgalin ([@brainopia](http://github.com/brainopia))
* Kirill Kouznetsov ([@dragonsmith](http://github.com/dragonsmith))

[! [Sponsored by Evil Martians] (https://evilmartians.com/badges/sponsored-by-evil-martians.svg) ](http://evilmartians.com/)

