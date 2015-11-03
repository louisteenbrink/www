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
  } else {
    console.log('yo')
  }
})

function handleNavbar() {
  if($(window).scrollTop() > $('.navbar-wagon').outerHeight()) {
    $('.header-fixed').addClass('is-active')
  } else {
    $('.header-fixed').removeClass('is-active')
  }
}
