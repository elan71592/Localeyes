var LocationList = React.createClass({

  render: function() {
    var countArr = [1,2,3,4,5]
    return (
      <div id="location-holder">
      <form className="location-form">
      <input type="hidden" name="authenticity-token" value= {document.head.querySelector("meta[name='csrf-token']").content} />
      <div>
        {
          countArr.map(function(integer, idx) {
            return <LocationForm data={integer} key={idx}/>
          })
        }
      </div>
        <input type="submit" value="Create Locations"/>
        </form>
      </div>
    )
  }
});
