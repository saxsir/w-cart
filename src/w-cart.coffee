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
    @echo 'Captured:' + @getTitle()

    capture @, url, '0-before.png'
    result = @evaluate replaceAllChars
    capture @, url, '1-after.png'

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

###
  開いたページのすべての文字列を〼に置き換える関数
  DOMをbody要素から再帰的にチェックしてTextNodeだったら書き換える
###
replaceAllChars = ->
  replaceTextNode = (node)->
    nodeType = node.nodeType
    nodeName = node.nodeName.toLowerCase()

    if nodeType is Node.TEXT_NODE
      node.nodeValue = node.nodeValue
        .replace /[!-~]/g, '?' #半角文字
        .replace /[^ (!-~\s)]/g, '？' #半角文字、スペース、改行文字以外のすべて
      return null
    else if nodeName is 'script' or nodeName is 'style'
      return null
    else
      for child in node.childNodes
        replaceTextNode child

  # 記号に置換すると全部ひとつづきの単語だと認識されて改行されないので
  # refs http;//8cmp.blog.fc2.com/blog-entry-43.html
  document.body.style.wordBreak = 'break-all'
  replaceTextNode document.body
