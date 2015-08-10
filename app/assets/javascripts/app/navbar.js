$(document).ready(function() {
  // navbar transition jQuery script
  $(window).scroll(function(e){
    // if ($(this).scrollTop() > 50) {
    //   $(".navbar-wagon").addClass("navbar-wagon-white");
    // }
    // else {
    //   $(".navbar-wagon").removeClass("navbar-wagon-white");
    // }
    if ($(this).scrollTop() > 100) {
      $(".navbar-wagon").css({
        "margin-top": "-70px"
      });
    }
    else {
      $(".navbar-wagon").css({
        "margin-top": "0",
      });
    }
  });
});