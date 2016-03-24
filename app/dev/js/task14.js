var apiData, city, i, len, listBuilder, tab;

apiData = [["北京", 90], ["上海", 50], ["福州", 10], ["广州", 50], ["成都", 90], ["西安", 100]];

tab = document.getElementById("aqi-list");

listBuilder = {
  index: 0,
  list: "",
  tryAddToList: function(elem) {
    if (elem > 60) {
      this.index++;
      return this.list += "<li>第" + this.index + "名:" + elem[0] + "污染指数：" + elem[1] + "</li>";
    }
  }
};

for (i = 0, len = apiData.length; i < len; i++) {
  city = apiData[i];
  listBuilder.tryAddToList(city);
}

tab.innerHTML = listBuilder.list;

//# sourceMappingURL=.maps/task14.js.map
