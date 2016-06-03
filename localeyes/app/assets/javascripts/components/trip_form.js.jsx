var TripForm = React.createClass({
  render: function() {
    return (
      <div>
        <form class="new-trip-form" action="/trips" method="post">
          <input type="hidden" name="authenticity_token" value={document.head.querySelector("meta[name='csrf-token']").content} />
          <input type="text" name="trip[name]" placeholder="My Awesome Trip"/>
          <br/>
          <input type="text" name="trip[tags]" placeholder="Add up to four comma separated tags. Ex: awesome, foodie, artsy"/>
          <br/>
          <input type="submit" value="Create Trip!"/>
        </form>
      </div>
    )
  }
});
