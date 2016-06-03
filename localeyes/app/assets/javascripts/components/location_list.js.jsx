var LocationList = React.createClass({
  getInitialState: function() {
    var metas = document.getElementsByTagName('meta');
    var csrf
    for (var i=0; i<metas.length; i++) {
      if (metas[i].getAttribute("name") == "csrf-token") {
        csrf =  metas[i].getAttribute("content");
        break
      }
    }
    console.log("csrf", csrf)
    return {csrfToken: {csrf}}
  },
  handleSubmit: function(event) {
    event.preventDefault();
    debugger;
    // var inputs = event.target.elements
    //
    // for(var inputKey in inputs) {
    //   if(input)
    // }

    $.ajax({
      url: "/locations",
      method: "POST",
      data: {
        "location": {
          "location-1-name": "bagels",
          "location-1-duration": "2 hours",
          "location-1-note": "it's great"
        },
        "authenticity_token": this.state.csrfToken
      }
    }).done(function(response){
      console.log(response)
    })


  },
  render: function() {
    var countArr = [1,2,3,4,5]
    return (
      <div id="location-holder">
      <form className="location-form" onSubmit={this.handleSubmit} ref="locationsForm" method="post" action="/locations">
      <input type="hidden" name="authenticity-token" value= {this.state.csrfToken} />
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
