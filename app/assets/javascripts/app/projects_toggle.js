$(function(){
  $(".project-toggle").on("click", function(){
    var targetId = $(this).data("target");
    $(targetId).toggleClass("hidden");
  });
})