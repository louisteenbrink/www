class LearningCurveItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      active: this.props.isActive
    }
  }

  render() {
    var componentClasses = classNames({
      'learning-curve-item': true,
      'is-active': this.state.active
    })
    return (
      <div className={componentClasses} onClick={this.handleClick.bind(this)}>
        {this.props.skills.map((skill) => {
          return (
            <i className={'devicons ' + skill.icon}  />
          )
        })}
      </div>
    )
  }

  handleClick() {
    PubSub.publish('setActiveItem', this.props.index)
    PubSub.publish('curveSize', this.props.curve_size);
  }

  componentWillReceiveProps() {
    this.setState({
      active: this.props.isActive
    })
  }
}
