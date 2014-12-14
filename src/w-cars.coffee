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

startTime = new Date
year = startTime.getFullYear()
month = startTime.getMonth() + 1
date = startTime.getDate()
hour = startTime.getHours()
min = startTime.getMinutes()

casper.thenOpen url, ->
  @echo @getTitle()
  @capture "logs/#{[year, month, date].join('-')}/#{[hour, min].join('-')}/
            #{url.replace(/^http.*\/\//, '').split('/').join('_')}/
            original.png"

casper.run()
