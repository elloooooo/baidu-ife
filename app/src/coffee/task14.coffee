apiData = [
  ["北京", 90],
  ["上海", 50],
  ["福州", 10],
  ["广州", 50],
  ["成都", 90],
  ["西安", 100]
]
apiData.sort((x, y)->
  y[1] - x[1]
)
listBuilder =
  index: 0
  list: ""
  tryAddToList: (elem)->
    this.index++
    this.list += "<li>第" + this.index + "名:" + elem[0] + "污染指数：" + elem[1] + "</li>"

for city in apiData
  if city[1] < 60
    break
  listBuilder.tryAddToList city

document.getElementById("aqi-list").innerHTML = listBuilder.list