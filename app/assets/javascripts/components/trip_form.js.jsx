var TripForm = React.createClass({
  render: function() {
    return (
      <div className="col s12 m12 l12">
        <form class="new-trip-form" action="/trips" method="post">
          <input type="hidden" name="authenticity_token" value={document.head.querySelector("meta[name='csrf-token']").content} />
          <div className="row">
            <div className="input-field col s12 m12 l12">
              <input type="text" name="trip[name]" placeholder="Write a creative title. Ex: Sunday in SoHo, Gluten-free NYC, Museums and Mimosas" />
            </div>
          </div>
          <div className="row">
            <div className="input-field col s12 m12 l12">
              <input type="text" name="trip[tags]" placeholder="Add some tags. Ex: #lowereastside, #food, #nightlife, #nature, #familyfriendly, #culture, #museum"/>
            </div>
          </div>
          <br/>
          <input className="waves-effect waves-light btn-large light-blue darken-2" type="submit" value="Create Trip!"/>
        </form>
      </div>
    )
  }
});
