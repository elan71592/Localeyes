$(document).ready(function() {
  $("#card").on("submit", "form", function(e) {
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
      $("#card").html("");
      $('input').val('');
      $('input').focus();
    });
  });

  $( '#card' ).on( 'click', '.card-action a', function( e ) {
    e.preventDefault();
    var target = e.target;
    var urlArr = target.href.split("%2F")
    var type = 'DELETE';
    var url = urlArr[urlArr.length - 1]

    $.ajax({
      type: type,
      url: url
    }).done( function( response ) {
      $( this ).closest( '#card' ).html( '' )
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
    }.bind( this ))
  });
})
