var TripForm = React.createClass({
  render: function() {
    return (
      <div>
        <form class="new-trip-form" action="/trips" method="post">
          <input type="hidden" name="authenticity_token" value={document.head.querySelector("meta[name='csrf-token']").content} />
          <div className="input-field">
            <input type="text" name="trip[name]" placeholder="My Awesome Trip" />
          </div>
          <div className="input-field">
          <input type="text" name="trip[tags]" placeholder="Add up to four comma separated tags. Ex: awesome, foodie, artsy"/>
          </div>
          <br/>
          <input className="waves-effect waves-light btn-large light-blue" type="submit" value="Create Trip!"/>
        </form>
      </div>
    )
  }
});
