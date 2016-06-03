var LocationForm = React.createClass({

  render: function() {
    debugger;
    return(
      <div>
        <p>Name of Place:</p>
        <input type="text" name="name" />
        <p>Expected Duration:</p>
        <input type="text" name="duration" />
        <p>Personalized Note:</p>
        <input type="text" name="note" />
      </div>
    );
  }
});
