class PlayerProductMaker extends React.Component {
  constructor(props) {
    super(props)
  }

  componentDidUpdate(prevProps, prevState) {
    $('[data-toggle="tooltip"]').tooltip();
  }

  render() {
    var title = this.props.maker.name;
    var maker_picture = this.props.maker.official_photo_url.replace('http://', 'https://');
    return (
      <li>
        <img src={maker_picture} className="team-member"
          data-original-title={title} data-toggle="tooltip" />
      </li>
    )
  }
}
