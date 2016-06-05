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

  $(".favorite-form-container").on("submit", ".unfavorite-submit", function(e) {
    e.preventDefault();
    var url = e.target.action;
    var type = "DELETE"
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

  $(".attend-form-container").on("submit", ".attend-submit", function(e){
    e.preventDefault();
    var url = e.target.action;
    var type = e.target.method;
    var data = $(e.target).serialize();

    $.ajax({
      url: url,
      type: type,
      data: data
    }).done(function(response){
      $(this).closest(".attend-form-container").html("");
      $(".attend-form-container").append(response);
    }.bind(this));
  });

   $(".attend-form-container").on("submit", ".cancel-submit", function(e){
    e.preventDefault();
    var url = e.target.action;
    var type = "DELETE";
    var data = $(e.target).serialize();

    $.ajax({
      url: url,
      type: type,
      data: data
    }).done(function(response){
      $(this).closest(".attend-form-container").html("");
      $(".attend-form-container").append(response);
    }.bind(this));
  });

   // $(".new-comment-button").on("submit", function(e) {
   //  e.preventDefault();

   //  var url = e.target.action
   //  var type = e.target.method
   //  var data = $(e.target).serialize();

   //  $.ajax({
   //    url: url,
   //    type: type,
   //    data: data
   //  }).done(function(response) {
   //    $(this).find("form").hide();
   //    $(this).append(response);
   //  }.bind(this))
   // });

   // $(".new-comment-button").on("submit", ".comment-submit", function(e) {
   //  e.preventDefault();

   //  var url = e.target.action
   //  var type = e.target.method
   //  var data = $(e.target).serialize();

   //  $.ajax({
   //    url: url,
   //    type: type,
   //    data: data
   //  }).done(function(response) {
   //    debugger;
   //    $(this).siblings().show();
   //    $(this).parent().parent().find(".comments-container").append(response);
   //    $(this).hide();
   //  }.bind(this))
   // });

  $(".comments-container").on("submit", ".delete-comment-button", function(e) {
    e.preventDefault();
    var url = e.target.action
    var type = "DELETE"

    $.ajax({
      url: url,
      type: type
    }).done(function(response){
      $(this).parent().remove();
    }.bind(this));
  })

});