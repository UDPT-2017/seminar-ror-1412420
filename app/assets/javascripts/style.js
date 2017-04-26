document.addEventListener("turbolinks:load", function() {
   function getViewport() {
    var viewPortWidth;
    var viewPortHeight;
    // the more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight
    if (typeof window.innerWidth != 'undefined') {
      viewPortWidth = window.innerWidth,
      viewPortHeight = window.innerHeight
    }

    // IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
    else if (typeof document.documentElement != 'undefined'
      && typeof document.documentElement.clientWidth !=
      'undefined' && document.documentElement.clientWidth != 0) {
      viewPortWidth = document.documentElement.clientWidth,
    viewPortHeight = document.documentElement.clientHeight
  }

    // older versions of IE
    else {
      viewPortWidth = document.getElementsByTagName('body')[0].clientWidth,
      viewPortHeight = document.getElementsByTagName('body')[0].clientHeight
    }
    return [viewPortWidth, viewPortHeight];
  }

  function initDisplay() {
    var display = getViewport();
    var width = display[0];
    var height = display[1];
    console.log(width + 'x' + height);
    $("body").css({"width":width + "px", "height": height + "px"});
    var hHeight = height - $(".header").outerHeight();
    $(".sidebar-links").css("height", hHeight + "px");
    $(".charts").css("height", hHeight + "px");
    return height;
  }

  function initDisplayInput() {
    var h = initDisplay();
    $(".short-link").css("margin-top", (h / 2 - 125) + "px");
  }

  initDisplayInput();

  $(window).resize(function(){
    initDisplayInput();
  });

})


$(document).ready(function(){

  // prevent submit link
  $("#shorten").submit(function(e){
    if(!$("#shorten-link").val()) {
      e.preventDefault();
    }
  });
  $("#shorten-submit").click(function(e){
    if(!$("#shorten-link").val()) {
      e.preventDefault();
    }
  });

});
