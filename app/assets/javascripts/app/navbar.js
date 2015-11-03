// $(window).scroll((e) => {
//   if( $(window).scrollTop() > $('.navbar-wagon').outerHeight()) {
//     $('.header-fixed').addClass('is-active')
//   } else {
//     $('.header-fixed').removeClass('is-active')
//   }
// })

(function() {
  var headerFixed = $('.header-fixed');

  $(document).ready(() => {
    if (headerFixed.is(':visible')) {
      handleNavbar()
      $(window).scroll(() => {
        handleNavbar()
      })
    }
  })

  function handleNavbar() {
    if($(window).scrollTop() > $('.navbar-wagon').outerHeight()) {
      headerFixed.addClass('is-active');
      $('.navbar-wagon-side .dropdown').removeClass('open')
    } else {
      headerFixed.removeClass('is-active');
      $('.full-item').removeClass('open');
    }
  }
})();
