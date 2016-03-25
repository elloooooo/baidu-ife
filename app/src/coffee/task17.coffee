### 数据格式演示
aqiSourceData =
  '北京':
    "2016-01-01": 10
    "2016-01-02": 10
    "2016-01-03": 10
    "2016-01-04": 10
###

getDateStr (dat) ->
  y = dat.getFullYear();
  m = dat.getMonth() + 1;
  m = '0' + m if m < 10
  d = dat.getDate()
  d = '0' + d if d < 10
  y + '-' + m + '-' + d;

randomBuildData (seed) ->
  returnData = {}
  dat = new Data("2016-01-01")
  datStr = ''
  for i in [1..92]
    datStr = getDateStr(dat)
    returnData[datStr] = Math.ceil(Math.random() * seed);
    dat.setDate(dat.getDate() + 1);
  returnData

aqiSourceData =
  "北京": randomBuildData(500)
  "上海": randomBuildData(300)
  "广州": randomBuildData(200)
  "深圳": randomBuildData(100)
  "成都": randomBuildData(300)
  "西安": randomBuildData(500)
  "福州": randomBuildData(100)
  "厦门": randomBuildData(100)
  "沈阳": randomBuildData(500)

# 用于渲染图表的数据
chartData = {}

#记录当前页面的表单选项
pageState =
  nowSelectCity: -1
  nowGraTime: 'day'

# 渲染图表
renderChart ->

# 日、周、月的radio事件点击时处理函数
graTimeChange ->
# 确定是否发生变化
# 设置对应的数据
# 调用图表渲染函数

# select发生变化时的函数
citySelectChange ->
# 确定是否选项发生了变化
# 设置对应数据
# 调用图表渲染函数

# 初始化日、周、月的radio事件，当点击时，调用函数graTimeChange
initGraTimeForm() ->
  document.getElementById("from-gra-time")


# 初始化城市Select下拉选择框中的选项
initCitySelector ()->
#读取aqiSourceData中的城市，然后设置id为city-select的下拉列表中的选项
#给select设置事件，当选项发生变化时调用函数citySelectChange


#初始化图表需要的数据格式
initAqiChartData() ->
# 将原始的源数据处理成图表需要的数据格式
# 处理好的数据存到 chartData 中


#初始化函数
init() ->
  initGraTimeForm()
  initCitySelector()
  initAqiChartData()

init();
