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
      'day-type-detail hidden-xs': true,
      'is-active': this.props.isActive,
      'is-exiting': this.props.isExiting
    })

    console.log(this.props.isExiting)

    if (this.props.isActive || this.props.isExiting) {
      return(
        <div className={componentClasses} style={pictureStyle} />
      )
    } else {
      return <div/>
    }
  }
}
