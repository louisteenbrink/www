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
      <div className={componentClasses}>
        {this.props.skills.map((skill) => {
          return (
            <i className={'devicons ' + skill.icon}  />
          )
        })}
      </div>
    )
  }

  componentWillReceiveProps() {
    this.setState({
      active: this.props.isActive
    })
  }
}
