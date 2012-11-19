
var fishbowl = new (function(){
  var self = this;
  this.io = null;

  this.load_script_tag = function(url, onload){
    var script = document.createElement("script");
    script.src = url;
    if(typeof onload === "function"){
      script.onload = onload;
      script.onreadystatechange = function(){
        if(readyState=="loaded" || readyState=="complete"){
          onload();
        }
      };
    }
    document.body.appendChild(script);
  };

  this.init = function(){
    self.load_script_tag("<%= cometio_js %>", function(){
      console.log("load");
      self.io = new CometIO().connect();
      self.io.on("connect", function(session_id){
        console.log("connect "+session_id);
      });
    });
  };

  this.plugin = function(name, data){
    self.io.push("plugin_"+name, data);
  };
})();

$(function(){
  fishbowl.init();
});
