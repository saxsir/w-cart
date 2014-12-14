'use strict'
casper = require('casper').create {
  verbose: true
  logLevel: 'warning' # debug,info,warning,error(default)
  viewportSize:
    width: 2560
    height: 1600
}

casper.start()
url = 'http://loilo.tv/jp/product/ipad_edu_note'

casper.thenOpen url, ->
  @echo @getTitle()

casper.run()
