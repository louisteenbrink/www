class ModuleNavItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      active: this.props.isActive
    }
  }

  render() {
    var navItemClasses = classNames({
      'module-nav-item': true,
      'is-active'       : this.props.isActive
    })
    return(
      <a
        className = {navItemClasses + ' ' + this.props.color}
        onClick   = {this.handleClick.bind(this)}
      >
        {this.props.title}
        <i className="fa fa-angle-right"></i>
      </a>
    )
  }

  handleClick() {
    PubSub.publish('setActiveItem', this.props.index)
    PubSub.publish('curveSize', this.props.curve_size);

  }
}
