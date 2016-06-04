$(document).ready(function() {
  $("#card").on("submit", "form", function(e) {
  e.preventDefault();
  var target = e.target
  var url = target.action
  var method = "PUT"
  var data = $(target).serialize()
    $.ajax({
      type: method,
      url: url,
      data: data
    })
    .done(function(response){
      $("#saved-location-holder").append(response);
      $("#card").html("")
    })
  })
})
