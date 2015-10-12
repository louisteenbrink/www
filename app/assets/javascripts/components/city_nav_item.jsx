class CityNavItem extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    var cityItemClasses = classNames({
      'banner-city-nav-item': true,
      'is-active': this.props.isActive
    })

    var miniatureStyle = {
      backgroundImage: "url('" + this.props.city.pictures.city.thumbnail + "');"
    }

    return(
      <div className={cityItemClasses} onClick={this.handleClick.bind(this)}>
        <div className='city-nav-item-infos'>
          <div className='city-nav-item-title'>
            {this.props.city.slug}
          </div>
        </div>
        <div className='banner-city-miniature' style={miniatureStyle} />
      </div>
    )
  }

  handleClick() {
    this.props.setActiveCity(this.props.city);
  }
}
