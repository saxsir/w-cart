'use strict'
casper = require('casper').create {
  verbose: true
  logLevel: 'warning' # debug,info,warning,error(default)
  viewportSize:
    width: 2560
    height: 1600
}

casper.start()
urls = require '../config/target.json'

startTime = new Date
year = startTime.getFullYear()
month = startTime.getMonth() + 1
date = startTime.getDate()
hour = startTime.getHours()
min = startTime.getMinutes()

casper.each urls, (casper, url, i) ->
  @thenOpen url, ->
    @echo @getTitle()

    #FIXME ページのロードが遅いとうまく撮影できない時があるが...イベントを把握する術がないのでとりあえず運と回線スピードに任せる
    @capture "logs/#{[year, month, date].join('-')}/#{[hour, min].join('-')}/
              #{url.replace(/^http.*\/\//, '').split('/').join('_')}/
              original.png"

casper.run()