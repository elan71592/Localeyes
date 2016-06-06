$( document ).ready( function() {
  $( 'span.follow-user-form' ).on( 'submit',  '.follow-submit', function( e ) {
    e.preventDefault();

    var target = e.target;
    var url = target.action;
    var type = target.method;
    var data = $( target ).serialize();

    $.ajax({
      type: type,
      url: url,
      data: data
    }).done( function( response ) {
      $( target ).hide();
      $( target ).parent().append( response );
    });
  });

  $( 'span.follow-user-form' ).on( 'submit', '.unfollow-submit', function( e ) {
    e.preventDefault();
    var target = e.target;
    var url = target.action;
    var type = target.method;
    var data = $( target ).serialize();

    $.ajax({
      type: type,
      url: url,
      data: data
    }).done( function( response ) {
      $( target ).hide();
      $( target ).parent().append( response );
    });
  });
});
