# mygames.io

Please note this app was meant to be a quick experiment and a it was never meant to
be maintained.
It only showcases a working API connection between the app and GiantBomb.
For an active development branch, see: https://github.com/Studio51/mygames.io

* Don't use this code in production, it's made to work, it's not pretty
* No tests ^
* CSS is messy
* No JS

##### Installation

``` bash
$ git clone git@github.com:pacMakaveli/mygames.io.git
$ bundle install
$ rake db:create && rake db:migrate && rake db:seed
$ rails s
```

##### Requirements

GiantBomb API key: http://giantbomb.com/api in `config/initializers/giantbomb.rb`

##### Preview

![alt text](http://i.imgur.com/DjYyAlz.jpg 'Preview')
