var LocationForm = React.createClass({

  render: function() {
    // debugger;
    var index = this.props.data
    return(
      <div>
        <p>Name of Place:</p>
        <input type="text" name={"location-" + index + "[name]"} />
        <p>Expected Duration:</p>
        <input type="text" name={"location-" + index + "[duration]"} />
        <p>Personalized Note:</p>
        <input type="text" name={"location-" + index + "[note]"} />
      </div>
    );
  }
});
