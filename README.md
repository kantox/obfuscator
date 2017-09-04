# obfuscator
Obfuscate strings and hashes for logging purposes

# Usage

Add gem in your Gemfile:

    gem 'kantox-obfuscator', github: 'kantox/obfuscator'

Then use it on strings or numbers:

    Kantox::Obfuscator.new.call('1234567890') # => '12xxxx7890'
    Kantox::Obfuscator.new.call(1234567890) # => '12xxxx7890'


To use on hashes, add a key blacklist:

    my_hash = {
      "some" => "Lorem ipsum",
      "other" => "Donor quit etiam"
    }
    Kantox::Obfuscator.new(keys: %w[some string keys]).call(my_hash)

    # => { "some" => "Loxxx xpsum", "other" => "Donor quit etiam"}

You can configure the replacement character:

    Kantox::Obfuscator.new(replacement: '-').call('1234567890') # => '12----7890'

and also the number of characters kept:

    Kantox::Obfuscator.new(1, 3).call('1234567890') # => '1xxxxxx890'
