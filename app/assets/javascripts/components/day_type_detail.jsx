class DayTypeDetail extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      active: this.props.isActive
    }
  }

  render() {
    var pictureStyle = {
      background: 'url(' + this.props.image + ')',
      backgroundSize: 'cover',
      backgroundPosition: 'center center'
    };

    var componentClasses = classNames({
      'day-type-detail': true,
      'is-active': this.props.isActive
    })

    return(
      <div className={componentClasses} style={pictureStyle} />
    )
  }
}
