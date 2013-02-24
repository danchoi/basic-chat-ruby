var name, w, url;  


function updateName() {
  name = $("input#name").val();
  if (name.length > 0) {
    w.send(name + " joined!");
  }
}
function postMsg() {
  var msg = $("#msg").val();
  if (msg.length > 0) {
    w.send(name + " says: " + msg);
  }
  return false;
}

$(document).ready(function() {

  if (!window.WebSocket) {
    alert("websockets not supported");
    return;
  }

  url = "ws://localhost:9395/";
  w = new WebSocket(url);

  w.onopen = function(e) {
    updateName();
  }
  w.onmessage = function(e) {
    $("#messages").append("<br/>"+e.data);
  }

  $("input#name").change(updateName);
  $("form#postMsg").submit(postMsg);



});
