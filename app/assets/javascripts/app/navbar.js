// $(window).scroll((e) => {
//   if( $(window).scrollTop() > $('.navbar-wagon').outerHeight()) {
//     $('.header-fixed').addClass('is-active')
//   } else {
//     $('.header-fixed').removeClass('is-active')
//   }
// })

$(document).ready(() => {
  handleNavbar()
  $(window).scroll(() => {
    handleNavbar()
  })
})

function handleNavbar() {
  if($(window).scrollTop() > $('.navbar-wagon').outerHeight()) {
    $('.header-fixed').addClass('is-active')
  } else {
    $('.header-fixed').removeClass('is-active')
  }
}
