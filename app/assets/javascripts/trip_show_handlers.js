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

    $(".new-comment-creator-button").on("submit", ".new_comment", function(e) {
    e.preventDefault();

    var url = e.target.action
    var type = e.target.method
    var data = $(e.target).serialize();

    $.ajax({
      url: url,
      type: type,
      data: data
    }).done(function(response) {
      $(this).parent().append(response);
      $(this).hide();
    }.bind(this))
   });

   $(".new-comment-creator-button").on("submit", ".comment-submit", function(e) {
    e.preventDefault();

    var url = e.target.action
    var type = e.target.method
    var data = $(e.target).serialize();

    $.ajax({
      url: url,
      type: type,
      data: data
    }).done(function(response) {
      if ($(".creator-comments-container").children().length === 2) {
        $(this).parent().parent().find(".creator-comments-container").find(".no-comments-message").hide();
      }
      $(this).siblings().show();
      $(this).parent().parent().find(".creator-comments-container").append(response);
      $(this).remove();
    }.bind(this))
   });

   $(".new-comment-creator-button").on("click", ".close-comment", function(e) {
      e.preventDefault();
      $(".new-comment-creator-button").children().eq(0).show();
      $(".new-comment-creator-button").children().eq(1).remove();
   });

  $(".creator-comments-container").on("submit", ".d-button", function(e) {
    e.preventDefault();
    var url = e.target.action
    var type = "DELETE"

    $.ajax({
      url: url,
      type: type
    }).done(function(response){
      $(this).closest("div").remove();
      if ($(".creator-comments-container").children().length === 2) {
        $(".creator-comments-container").find(".no-comments-message").show();
      };
    }.bind(this));
  });

   $(".new-comment-not-creator-button").on("submit", ".new_comment", function(e) {
    e.preventDefault();

    var url = e.target.action
    var type = e.target.method
    var data = $(e.target).serialize();

    $.ajax({
      url: url,
      type: type,
      data: data
    }).done(function(response) {
      $(this).parent().append(response);
      $(this).hide();
    }.bind(this))
   });

   $(".new-comment-not-creator-button").on("submit", ".comment-submit", function(e) {
    e.preventDefault();

    var url = e.target.action
    var type = e.target.method
    var data = $(e.target).serialize();

    $.ajax({
      url: url,
      type: type,
      data: data
    }).done(function(response) {
      if ($(".not-creator-comments-container").children().length === 2) {
        $(this).parent().parent().find(".not-creator-comments-container").find(".no-comments-message").hide();
      }
      $(this).siblings().show();
      $(this).parent().parent().find(".not-creator-comments-container").append(response);
      $(this).remove();
    }.bind(this))
   });

   $(".new-comment-not-creator-button").on("click", ".close-comment", function(e) {
      e.preventDefault();
      $(".new-comment-not-creator-button").children().eq(0).show();
      $(".new-comment-not-creator-button").children().eq(1).remove();
   });

  $(".not-creator-comments-container").on("submit", ".d-button", function(e) {
    e.preventDefault();
    var url = e.target.action
    var type = "DELETE"

    $.ajax({
      url: url,
      type: type
    }).done(function(response){
      $(this).closest("div").remove();
      if ($(".not-creator-comments-container").children().length === 2) {
        $(".not-creator-comments-container").find(".no-comments-message").show();
      };
    }.bind(this));
  });
});