$(function(){
  $(".enterprise-nav img").click(function(){
    $(".enterprise-nav img").removeClass("active");
    $(this).addClass("active");
    $(".enterprise-testimonial").addClass("hidden");
    $($(this).data("target")).removeClass("hidden");
  })
  $(".enterprise-nav .img-card").click(function(){
    $(".enterprise-nav .img-card").removeClass("active");
    $(this).addClass("active");
    $(".alumni-preview").addClass("hidden");
    $($(this).data("target")).removeClass("hidden");
  })
})
