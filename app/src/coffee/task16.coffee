### aqiData，存储用户输入的空气指数数据
# 示例格式：
# aqiData = {
#    "北京": 90,
#    "上海": 40
# };
###
aqiData = {}

###
# 从用户输入中获取数据，向aqiData中增加一条数据
###
addAqiData = ->
  city_name = document.getElementById('aqi-city-input').value.trim()
  city_value = document.getElementById('aqi-value-input').value.trim()

  if not /^[\u4e00-\u9fa5a-zA-Z]+$/.test(city_name)
    alert('请输入正确的城市名称!')
    document.getElementById('aqi-city-input').focus()
    return

  if not /^\d+$/.test(city_value)
    alert('请输入正整数!');
    document.getElementById('aqi-value-input').focus();
    return

  aqiData[city_name] = city_value

# 渲染aqi-table表格
renderAqiList = ->
  tab = document.getElementById('aqi-table')
  tabContent = []
  tabContent.push '<thead><td>城市</td><td>空气质量</td><td>操作</td></thead>'
  for city_name,city_value of aqiData
    tabContent.push "<tr>"
    tabContent.push "<td>#{city_name}</td><td>#{city_value}</td>"
    tabContent.push "<td><button data-city=#{city_name}>删除</button></td>"
    tabContent.push "</tr>"
  tab.innerHTML = tabContent.join('')

# 点击add-btn时的处理逻辑
# 获取用户输入，更新数据，并进行页面呈现的更新
addBtnHandle = ->
  addAqiData()
  renderAqiList()


# 点击各个删除按钮的时候的处理逻辑
# 获取哪个城市数据被删，删除数据，更新表格显示
delBtnHandle = (city_name) ->
  delete aqiData[city_name]
  renderAqiList()

init = ->
# 在这下面给add-btn绑定一个点击事件，点击时触发addBtnHandle函数
# 想办法给aqi-table中的所有删除按钮绑定事件，触发delBtnHandle函数
  document.getElementById('aqi-btn').onclick = addBtnHandle
  tab = document.getElementById('aqi-table')
  # addEventListener的回调函数将在该对象的作用域下执行函数，
  # 也只有在其作用域下才有event对象，如果回调函数不想通过匿名函数的方式传入，
  # 则必须要考虑如何将其作用域传出！
  tab.addEventListener('click', (event)->
    if(event.target.nodeName == 'BUTTON' and event.target.innerHTML == '删除')
      delBtnHandle(event.target.dataset.city)
  , false)

###
# 原形扩展的方式去除字符串两头空格及中间空白
###
String::trim = ()->
  this.replace(/[(^\s+)(\s+$)]/g, "")

init();
