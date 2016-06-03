var TripComment = React.createClass({

  render: function() {
    var comment = this.props.commentData
    return (
      <div>
      <h3>Comments</h3>
        <div>
          <p>{ comment.body }</p>
          <p>{ comment.user }</p>
        </div>
      </div>
    )
  }
});
