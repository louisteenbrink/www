(function($) {
  var headerFixed = null;
  var dropDown = null;
  var fullItem = null;
  var lastScrollTop = 0;

  $(document).ready(function() {
    headerFixed = $('.header-fixed');
    dropDown = $('.navbar-wagon-side .dropdown');
    fullItem = $('.full-item');
    if (headerFixed.is(':visible')) {
      handleNavbar();
      $(window).scroll(handleNavbar);
    }
  });

  function handleNavbar() {
    var st = $(window).scrollTop();
    if((st > lastScrollTop) && (st > 150)) {
      headerFixed.addClass('is-active');
      dropDown.removeClass('open');
    } else {
      headerFixed.removeClass('is-active');
      fullItem.removeClass('open');
    }
    lastScrollTop = st;
  }
})(window.jQuery);
