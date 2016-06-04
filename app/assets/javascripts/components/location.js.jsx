var Location = React.createClass({

  render: function() {
    return (
      <div>
        <div>
          <h1>{ this.props.locationData.name }</h1>
        </div>
        <div>
          <ul>
            <li>{ this.props.locationData.street_num }</li>
            <li>{ this.props.locationData.street }</li>
            <li>{ this.props.locationData.city }</li>
            <li>{ this.props.locationData.phone_number }</li>
            <li>{ this.props.locationData.website_url }</li>
          </ul>
        </div>
      </div>
    )
  }
});
