class PlayerProductMaker extends React.Component {
  constructor(props) {
    super(props)
  }

  componentDidUpdate(prevProps, prevState) {
    $('[data-toggle="tooltip"]').tooltip();
  }

  render() {
    var title = this.props.maker["first_name"] + " " + this.props.maker["last_name"];
    var maker_picture = this.props.maker["thumbnail"].replace('http://', 'https://');
    return (
      <li>
        <img src={maker_picture} className="team-member"
          data-original-title={title} data-toggle="tooltip" />
      </li>
    )
  }
}
