$(document).ready(function() {
  $(".favorite-form-container").on("submit", ".favorite-submit", function(e){
    e.preventDefault();
    var url = e.target.action;
    var type = e.target.method;
    var data = $(e.target).serialize();

    $.ajax({
      url: url,
      type: type,
      data: data
    }).done(function(response){
      $(this).closest(".favorite-form-container").html("");
      $(".favorite-form-container").append(response);
    }.bind(this));
  });

});