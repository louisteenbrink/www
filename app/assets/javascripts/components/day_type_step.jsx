class DayTypeStep extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      active: this.props.active
    }
  }

  render() {
    var pictureStyle = {
      background: 'url(' + this.props.image + ')',
      backgroundSize: 'cover',
      backgroundPosition: 'center center'
    };

    var componentClasses = classNames({
      'day-type-step': true,
      'is-active': this.state.active
    })

    if (this.props.image) {
      var picture = <div className="day-picture" style={pictureStyle} />
    }

    return(
      <div
        className={componentClasses}
        onMouseOver={this.handleMouseEnter.bind(this)}
      >
        <div className="day">
          <div className="day-hour">{this.props.hour}</div>
          <div className={'day-circle ' + this.props.circle_color}></div>
          <div className="day-description">
            <p>
              {this.props.description}
            </p>
          </div>
        </div>
        {picture}
      </div>
    )
  }

  handleMouseEnter() {
    this.setState({
      active: true
    })
  }
}
