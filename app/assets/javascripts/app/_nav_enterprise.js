$(function(){
  $(".enterprise-nav img").click(function(){
    $(".enterprise-nav img").removeClass("active");
    $(this).addClass("active");
    $(".enterprise-testimonial").addClass("hidden");
    $($(this).data("target")).removeClass("hidden");
  })
})
