class PlayerProductMaker extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    var maker_picture = this.props.maker["thumbnail"];

    return (
      <li>
        <img src={maker_picture} className="team-member"/>
      </li>
    )
  }
}