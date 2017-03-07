function truncateTestimonials() {
  var THRESHOLD = 120;  // How many characters are shown by default
  var ellipsis = "...";
  var readMore = " Read more"; // TODO: i18n
  var lesstext = "Show less";

  $('.testimonial-content:not(.truncated)').each(function() {
    var fullContent = $(this).addClass('truncated').html();

    if(fullContent.length > THRESHOLD) {
      var truncatedContent = fullContent.substr(0, THRESHOLD);

      var content = "<span class='full-content hidden'>" + fullContent + "</span>";
      content += "<span class='truncated-content'>" + truncatedContent + ellipsis + "</span>";
      content += "<a class='read-more' href='#'>" + readMore + "</a>";

      $(this).html(content).find('.read-more').click(function (e) {
        e.preventDefault(); // Don't scroll to top.
        var $parent = $(e.target).parents('.testimonial-content');
        $parent.find('.full-content').removeClass('hidden');
        $parent.find('.truncated-content').addClass('hidden');
        $(e.target).remove();
      });
    }
  });
}

$(document).ready(function() {
  truncateTestimonials();
});