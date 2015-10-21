class DayTypeStep extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      active: this.props.isActive
    }
  }

  render() {
    console.log(this.props.isLast)
    var pictureStyle = {
      background: 'url(' + this.props.image + ')',
      backgroundSize: 'cover',
      backgroundPosition: 'center center'
    };

    var componentClasses = classNames({
      'day-type-step': true,
      'is-active': this.props.isActive
    })

    if (this.props.image) {
      var picture = <div className="day-picture hidden-lg hidden-md hidden-sm" style={pictureStyle} />
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
    if (this.props.activeItem !== this.props.index){
      PubSub.publish('setActiveDay', {new: this.props.index, old: this.props.activeItem})
    }
  }
}
