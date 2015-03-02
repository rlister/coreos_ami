# coreos_ami

Ruby gem to discover CoreOS AMIs for AWS.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coreos_ami'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install coreos_ami
```

## Library usage

### Get AMI for a given channel and release

```ruby
require 'coreos_ami'
CoreOS.channel('stable').ami
=> "ami-8297d4ea"
```

Default region will be set to environment variable
`AWS_DEFAULT_REGION` (or `us-east-1` if empty). Virtualization type
will default to `hvm`, and release will default to `current`.

Different channels, releases, and virtualization type may be
requested:

```ruby
CoreOS.channel('beta').ami(release: '522.5.0', virtualization: 'pv')
=> "ami-3ed7a456"
```

### Get list of AMIs

Return a hash of all AMIs for requested channel and release:

```ruby
CoreOS.channel('stable').amis
=> {"amis"=>[{"name"=>"eu-central-1", "pv"=>"ami-88c1f295", "hvm"=>"ami-8ec1f293"}, {"name"=>"ap-northeast-1", "pv"=>"ami-ea5c46eb", "hvm"=>"ami-e85c46e9"}, {"name"=>"sa-east-1", "pv"=>"ami-2fe95632", "hvm"=>"ami-2de95630"}, {"name"=>"ap-southeast-2", "pv"=>"ami-4fd3a775", "hvm"=>"ami-4dd3a777"}, {"name"=>"ap-southeast-1", "pv"=>"ami-70dcf622", "hvm"=>"ami-72dcf620"}, {"name"=>"us-east-1", "pv"=>"ami-8097d4e8", "hvm"=>"ami-8297d4ea"}, {"name"=>"us-west-2", "pv"=>"ami-f3702bc3", "hvm"=>"ami-f1702bc1"}, {"name"=>"us-west-1", "pv"=>"ami-26b5ad63", "hvm"=>"ami-24b5ad61"}, {"name"=>"eu-west-1", "pv"=>"ami-5b911f2c", "hvm"=>"ami-5d911f2a"}]}
```

### Command-line client

A simple command-line tool is included to perform the same requests,
with similar defaults:

```
$ coreos_ami -c beta -r 522.5.0 -v pv
ami-3ed7a456
```

Use `-a` or `--all` to list all AMIs:

```
$ coreos_ami -a -c stable
NAME            PV              HVM
eu-central-1    ami-88c1f295    ami-8ec1f293
ap-northeast-1  ami-ea5c46eb    ami-e85c46e9
sa-east-1       ami-2fe95632    ami-2de95630
ap-southeast-2  ami-4fd3a775    ami-4dd3a777
ap-southeast-1  ami-70dcf622    ami-72dcf620
us-east-1       ami-8097d4e8    ami-8297d4ea
us-west-2       ami-f3702bc3    ami-f1702bc1
us-west-1       ami-26b5ad63    ami-24b5ad61
eu-west-1       ami-5b911f2c    ami-5d911f2a
```
