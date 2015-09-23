class ModuleItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      active: this.props.active,
      opened: this.props.active
    }
  }

  render() {
    var componentClasses = classNames({
      'feature module': true,
      'is-active': this.props.isActive,
      'is-opened': this.state.opened
    })
    return(
      <div
        className={componentClasses}
        onMouseLeave={this.handleMouseLeave.bind(this)}
        onMouseEnter={this.handleMouseEnter.bind(this)}
      >
        <div className='feature-header'>
          <div className='feature-icon yellow'>
            <i className='mdi mdi-laptop'/>
          </div>
          <div className='feature-title'>
            {this.props.title}
          </div>
          <div className='module-weeks'>
            {this.props.weeks}
          </div>
        </div>
        <div className='feature-body text-left'>
          {this.props.description}
        </div>
      </div>
    )
  }

  handleMouseEnter() {
    PubSub.publish('setActiveItem', this.props.index)
    PubSub.publish('curveSize', this.props.curve_size)
    PubSub.publish('getContainerHeight')
    this.setState({ opened: true })
  }

  handleMouseLeave() {
    this.setState({active: false})
  }
}
