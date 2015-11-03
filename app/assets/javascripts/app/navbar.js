// $(window).scroll((e) => {
//   if( $(window).scrollTop() > $('.navbar-wagon').outerHeight()) {
//     $('.header-fixed').addClass('is-active')
//   } else {
//     $('.header-fixed').removeClass('is-active')
//   }
// })

$(document).ready(() => {
  if ($('.header-fixed:visible').length) {
    handleNavbar()
    $(window).scroll(() => {
      handleNavbar()
    })
  }
})

function handleNavbar() {
  if($(window).scrollTop() > $('.navbar-wagon').outerHeight()) {
    $('.header-fixed').addClass('is-active');
    $('.navbar-wagon-side .dropdown').removeClass('open')
  } else {
    $('.header-fixed').removeClass('is-active');
    $('.full-item').removeClass('open');
  }
}
