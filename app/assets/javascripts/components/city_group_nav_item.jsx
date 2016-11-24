class CityGroupNavItem extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    var cityGroupItemClasses = classNames({
      'city-group-nav-item': true
    })

    return(
      <li className={cityGroupItemClasses} onClick={this.handleClick.bind(this)}>
        {this.props.cityGroup.group}
        <span dangerouslySetInnerHTML={{__html: this.props.cityGroup.icon}}></span>
      </li>
    )
  }

  handleClick() {
    this.props.setActiveCityGroup(this.props.cityGroup);
  }
}
