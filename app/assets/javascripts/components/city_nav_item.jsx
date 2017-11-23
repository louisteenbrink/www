class CityNavItem extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    var cityItemClasses = classNames({
      'banner-city-nav-item': true,
      'is-active': this.props.isActive
    })

    var city = this.props.city;

    var miniatureStyle = {
      backgroundImage: "url(" + city.city_background_picture_url + ")"
    }

    return(
      <div className={cityItemClasses} onClick={this.handleClick.bind(this)}>
        <div className='city-nav-item-infos'>
          <div className='city-nav-item-title'>
            {city.name}
          </div>
          <div className='city-nav-item-first-batch'>
            {
              moment(this.props.firstBatch.starts_at).locale(this.props.locale).format('ll').replace(/, \d{4}/, '')
              + " / "
              + this.props.i18n.pre_course_language
              + (this.props.i18n.course_language[city.slug] || this.props.i18n['language_' + city.locale])
            }
          </div>
        </div>
        <div className='banner-city-miniature' style={miniatureStyle} />
      </div>
    )
  }

  handleClick(e) {
    e.preventDefault();
    this.props.setActiveCity(this.props.city);
  }
}
