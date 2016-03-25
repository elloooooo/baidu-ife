# getData方法
# 读取id为source的列表，获取其中城市名字及城市对应的空气质量
# 返回一个数组，格式见函数中示例
# Node有多种，1.Element 2.Attribute 3.Text
# childNodes 将返回所有的子Node，对于ul的childNodes，很可能包含一个text类型的node（列表前面那个点），然后才是li（Element类型的Node）
# children 返回的是Element类型的Node->li
# firstChild 返回第一个Node，如果是text类型，要想对其进行字符串操作，需要用nodeValue去访问他的数据
# firstElementChild 返回的是第一个Element类型的Node
# innerHTML 返回里面的所有内容，包括text和Element
# innerText 将返回所有text
getData = ->
  data = ([item.firstChild.nodeValue.substring(0, 2),
    item.firstElementChild.innerHTML] for item in document.getElementById("source").children)
  return data

# sortAqiData
# 按空气质量对data进行从小到大的排序
# 返回一个排序后的数组
sortAqiData = (data)->
  data.sort((x, y)->
    y[1] - x[1]
  )

# render
# 将排好序的城市及空气质量指数,输出显示到id位resort的列表中
# 格式见ul中的注释的部分
render = (data)->
  listBuilder =
    index: 0
    list: ""
    tryAddToList: (elem)->
      @index++
      @list += "<li>第#{@index}名:#{elem[0]}; 污染指数：#{elem[1]}</li>"

  listBuilder.tryAddToList item for item in data
  document.getElementById("resort").innerHTML = listBuilder.list

btnHandle = ->
  data = getData()
  sortAqiData data
  render data

# 在这下面给sort-btn绑定一个点击事件，点击时触发btnHandle函数
init = ()->
  document.getElementById("sort-btn").onclick = btnHandle

init();