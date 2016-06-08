$(document).ready(function() {
  $("#new-location").on("submit", "form", function(e) {
  e.preventDefault();
  var target = e.target;
  var url = target.action;
  var method = "PUT";
  var data = $(target).serialize();
    $.ajax({
      type: method,
      url: url,
      data: data
    })
    .done(function(response){
      $("#saved-location-holder").append(response);
      $("#new-location").find(".card").closest(".row").remove();
      $('input').val('');
      if($("#saved-location-holder").children().length >= 4) {
        $(".finish-trip-message").hide();
        $(".finish-trip-button").show();
      } else {
        $(".location-number").text(4 - $("#saved-location-holder").children().length);
      };
      $('input').focus();
    });
  });

  $( '#new-location' ).on( 'click', '.card-action a', function( e ) {
    e.preventDefault();
    var target = e.target;
    var urlArr = target.href.split("%2F")
    var type = 'DELETE';
    var url = urlArr[urlArr.length - 1]

    $.ajax({
      type: type,
      url: url
    }).done( function( response ) {
      $( this ).closest( '#new-location' ).html( '' )
    }.bind( this ))
  });

  $( "#saved-location-holder" ).on( 'click', '.card-action a', function( e ) {
    e.preventDefault();
    var target = e.target;
    var urlArr = target.href.split("%2F")
    var type = 'DELETE';
    var url = urlArr[urlArr.length - 1]

    $.ajax({
      type: type,
      url: url
    }).done( function( response ) {
      $( this ).closest('.row').remove();
      if($("#saved-location-holder").children().length >= 4) {
        $(".finish-trip-message").html("");
        $(".finish-trip-button").show();
      } else {
        $(".finish-trip-message").show();
        $(".location-number").text(4 - $("#saved-location-holder").children().length);
        $(".finish-trip-button").hide();
      };
    }.bind( this ))
  });
})
