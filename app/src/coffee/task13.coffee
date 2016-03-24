input = document.getElementById("aqi-input");
display = document.getElementById("aqi-display");
btn = document.getElementById("button");
btn.onclick = ()->
if input.value.length > 0
  display.innerHTML = input.value
else
  display.innerHTML = "请输入"

