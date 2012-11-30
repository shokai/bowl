
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
      self.io = new CometIO().connect();
      self.io.on("connect", function(session_id){
        console.log("fishbowl connect : "+session_id);
      });
    });
  };

  this.plugin = function(name, data, callback){
    if(typeof callback === "function"){
      var callback_name = "plugin_"+name+'_callback_'+Date.now();
      self.io.once(callback_name, callback);
      data["__callback"] = callback_name;
    }
    self.io.push("plugin_"+name, data);
  };
})();

$(function(){
  fishbowl.init();
});
