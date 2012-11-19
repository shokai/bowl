
var FishBowl = {};

$(function(){
  var onloaded = function(){
    console.log("load");
      FishBowl.io = new CometIO().connect();
      FishBowl.io.on("connect", function(session_id){
        console.log("connect "+session_id);
      });
  }

  var ele = document.createElement("script");
  ele.src = "<%= cometio_js %>";
  ele.onload = onloaded;
  ele.onreadystatechange = function(){
    if(this.readyState=="loaded"||this.readyState=="complete"){
      onloaded();
    }
  }
  document.body.appendChild(ele);
});
