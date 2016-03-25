apiData = [
  ['北京', 90]
  ['上海', 50]
  ['福州', 10]
  ['广州', 50]
  ['成都', 90]
  ['西安', 100]
]
apiData.sort((x, y)->
  y[1] - x[1]
)
listBuilder =
  index: 0
  list: ""
  tryAddToList: (elem)->
    @index++
    @list += "<li>第#{@index}名:#{elem[0]}; 污染指数：#{elem[1]}</li>"

listBuilder.tryAddToList city for city in apiData when city[1] > 60

document.getElementById("aqi-list").innerHTML = listBuilder.list