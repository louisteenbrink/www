class ApplyForm extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      activeCity: this.props.cities[0]
    }
  }

  render() {
    var componentClasses = classNames({
      'apply-form': true
    })

    console.log(this.state.activeCity)

    return(
      <div className={componentClasses}>
        <div className="banner-container">
          <div className="container banner-city-container">
            <div className='banner-city-nav'>
              {this.props.cities.map((city) => {
                return (
                  <CityNavItem
                    city={city}
                    setActiveCity={(city) => this.setActiveCity(city)}
                    isActive={this.state.activeCity.slug == city.slug}
                  />
                )
              })}
            </div>
            <div className='apply-form-body'>
              <div className='banner-city-wrapper'>

                {this.props.cities.map((city) => {

                  var bannerClasses = classNames({
                    'banner-city banner banner-top banner-gradient text-center': true,
                    'is-active': this.state.activeCity.slug == city.slug
                  })

                  var bannerCityStyle = {
                    backgroundImage: "url('" + city.pictures.location.cover  + "');"
                  };


                  return(
                    <div className={bannerClasses} style={bannerCityStyle}>
                      <div className="banner-gradient-shadow"></div>
                      <div className="banner-content">
                        <h1 className='glitch'>
                          Postuler à {city.name}
                        </h1>
                      </div>
                    </div>
                  )
                })}
              </div>
              <div className='apply-form-rows-container'>
                <div className="apply-form-row" >
                  <label>
                    <i className='mdi mdi-calendar-multiple-check'></i>Dates
                  </label>
                  <input
                    ref='title'
                    value={this.state.activeCity.next_batch.starts_at + " — " + this.state.activeCity.next_batch.ends_at  }
                    disabled={true}
                    name='resource[title]' />
                </div>
                {this.props.rows.map( (row, index) => {
                  return <ApplyFormRow {... row} />
                })}
                <div className='apply-form-row-submit'>
                  <input type='submit' value='Apply' className='apply-form-submit btn btn-sucsess' />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }

  setActiveCity(city) {
    if (this.state.activeCity !== city) {
      this.setState({ activeCity: city })
    }
  }
}
