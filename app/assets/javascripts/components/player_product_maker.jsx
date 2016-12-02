class PlayerProductMaker extends React.Component {
  constructor(props) {
    super(props)
  }

  componentDidUpdate(prevProps, prevState) {
    $('[data-toggle="tooltip"]').tooltip();
  }

  render() {
    var title = this.props.maker["first_name"] + " " + this.props.maker["last_name"];
    return (
      <li>
        <img src={this.props.maker["thumbnail"]} className="team-member"
          data-original-title={title} data-toggle="tooltip" />
      </li>
    )
  }
}
