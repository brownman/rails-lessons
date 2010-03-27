
var updateInterval = 5000; // update every 5 seconds
var timestamp = new Date().toUTCString();
var timer;

function go() {
  timer = setInterval('update()', updateInterval);
}

function update() {
  url = "/my_admin/spy/update?model=" + model;
//  alert(url);
  new Ajax.Request(url, {
  asynchronous: true,
  method: "get",
  parameters: "timestamp=" + timestamp,
  onSuccess: function(request) {
  timestamp = new Date().toUTCString();
  }
  });
}

function loading() {
  Element.show('ajax-indicator');
}

function loaded() {
  Element.hide('ajax-indicator');
}

//  Displays and then fades a notice after a period of time.
AlertBox = Class.create() ;
AlertBox.prototype = {
  initialize: function(elementId,timeout) {
    this.elementId = elementId ;
    this.timeout = (timeout==undefined) ? 2 : timeout ;
  },

  show: function(text) {
    $(this.elementId).innerHTML = text;
    new Effect.Appear(this.elementId, {duration: 0.3});
    if (this.timeout != 0) setTimeout(this.fade.bind(this), this.timeout * 1000);
  },

  fade: function() {
    new Effect.Fade(this.elementId, {duration: 0.3});
  }  
} ;

var Notice = new AlertBox('notice') ;
