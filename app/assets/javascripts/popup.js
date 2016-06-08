function popup() {
  $( '.popup' ).show( 'slow' )
}

$( document ).ready( function() {
  setTimeout(popup, 15000);

  $( '.popup' ).on( 'submit', '.follow-submit-trip', function( e ) {
    e.preventDefault();
    var target = e.target;
    var type = target.method;
    var url = target.action;
    var data = $( target ).serialize();

    $.ajax({
      type: type,
      url: url,
      data: data
    }).done( function( response ) {
      $( '.popup' ).hide();
    });
  });

  $( '.close-popup' ).click( function() {
    $( '.popup' ).hide( 'slow' );
  });
});