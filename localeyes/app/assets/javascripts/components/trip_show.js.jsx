var TripShow = React.createClass({
  // getInitialState: function() {
  //   return { trip: this.props.trip }
  // },
  // componentDidMount: function() {
  //   $.ajax({
  //     url: "http://localhost:3000/
  //   })
  // }
  render: function() {
    var trip = this.props.trip
    var locations = this.props.locations
    var comments = this.props.comments

    return (
      <div>
        <div>
          <h2>{ trip.name }</h2>
        </div>

        <div>
          {
            locations.map(function(location) {
            return <Location key={ location.id } locationData={ location } />
            })
          }
        </div>

        <div>
          {
            comments.map(function(comment) {
              return <TripComment key={ comment.id } commentData={ comment } />
            })
          }
        </div>
      </div>
      );
  }
});
