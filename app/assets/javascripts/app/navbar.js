(function($) {
  var headerFixed = null;
  var dropDown = null;
  var fullItem = null;

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
    if($(window).scrollTop() > $('.navbar-wagon').outerHeight()) {
      headerFixed.addClass('is-active');
      dropDown.removeClass('open');
    } else {
      headerFixed.removeClass('is-active');
      fullItem.removeClass('open');
    }
  }
})(window.jQuery);
