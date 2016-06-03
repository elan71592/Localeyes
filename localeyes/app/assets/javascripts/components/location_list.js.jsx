var LocationList = React.createClass({

  render: function() {
    return (
      <div id="location-holder">
      <form className="location-form">
      <input type="hidden" name="authenticity-token" value= {document.head.querySelector("meta[name='csrf-token']").content} />
      <div>
        {
          for( var i = 0; i < 6; i++ ) {
            return <LocationForm />
          }
        }
      </div>
        <input type="submit" value="Create Locations"/>
        </form>
      </div>
    )
  }
});
