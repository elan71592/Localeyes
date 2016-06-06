var TripForm = React.createClass({
  render: function() {
    return (
      <div>
        <form class="new-trip-form" action="/trips" method="post">
          <input type="hidden" name="authenticity_token" value={document.head.querySelector("meta[name='csrf-token']").content} />
          <div className="input-field">
            <input type="text" name="trip[name]" placeholder="Write a creative title. Ex: Sunday in SoHo, Gluten-free NYC, Museums and Mimosas" />
          </div>
          <div className="input-field">
          <input type="text" name="trip[tags]" placeholder="Add some tags. Ex: #lowereastside, #food, #nightlife, #nature, #familyfriendly, #culture, #museum"/>
          </div>
          <br/>
          <input className="waves-effect waves-light btn-large light-blue darken-2" type="submit" value="Create Trip!"/>
        </form>
      </div>
    )
  }
});
