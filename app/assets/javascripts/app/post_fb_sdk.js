document.getElementById('shareBtn').onclick = function() {
  FB.ui({
    method: 'share',
    display: 'popup',
    href: 'http://localhost:3000/blog/krawd-agence-communication-dematerialisee',
  }, function(response){});
}