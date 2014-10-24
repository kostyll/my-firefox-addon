ok_button = document.getElementById("submit_text_selection");
text_area = document.getElementById("selected_text");

ok_button.onclick = function(){
    console.log("Clicked!");
    text_area.value = '';
    test_func();
};

self.port.on("show", function onShow() {
  console.log("Entered!");
});

self.port.on("text-update",function (data){
    console.log("Handling text-update ...");
    text_area.value = data.text;
    console.log(data);
});
