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

    capture @, url, 'original.png'

casper.run()

###
  @param casper casperオブジェクト
  @param url キャプチャするページのURL
  @param filename 保存するファイルの名称
###
#FIXME ページのロードが遅いとうまく撮影できない時があるが...イベントを把握する術がないのでとりあえず運と回線スピードに任せる
capture = (casper, url, filename)->
  filepath = "logs/
             #{[year, month, date].join('-')}/
             #{[hour, min].join('-')}/
             #{url.replace(/^http.*\/\//, '').split('/').join('_')}/
             #{filename}"

  casper.capture filepath.replace(/\s+/g, '')
