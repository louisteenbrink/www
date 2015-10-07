class ApplyForm extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      activeCity: this.props.city,
      batch: _.filter(this.props.city.batches, (n) => { return !n.full })[0] // to take the first not full batch.
    }
  }

  render() {

    var batches = this.state.activeCity.batches;

    var componentClasses = classNames({
      'apply-form': true
    })
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
                          Postuler à <span className='city'>{city.name}</span>
                        </h1>
                      </div>
                    </div>
                  )
                })}
              </div>
              <div className='apply-form-rows-container'>
                <form action={Routes.apply_path()} method='post'>
                  <div dangerouslySetInnerHTML={{__html: Csrf.getInput()}} />
                  <div className="apply-form-row apply-form-row-first" >
                    <label>
                      <i className='mdi mdi-calendar-multiple-check'></i>Dates
                    </label>
                    <div className="apply-form-row-item">
                      <div className='post-submissions-select'>
                        <ReactBootstrap.DropdownButton ref='selectType' title={'from ' + batches[0].starts_at + ' to ' + batches[0].ends_at}>
                          {batches.map((batch) => {
                            if (batch.full) {
                              var right_item = <div className='last-seats'>FULL</div>
                            }
                            else if (this.state.batch == batch) {
                              var right_item = <div className='last-seats'><i className='fa fa-check'/></div>
                            }
                            else if (batch.last_seats) {
                              var right_item = <div className='last-seats'>4 seats!</div>
                            }
                            var selectorClasses = classNames({
                              'input-selector-item': true,
                              'is-selected': this.state.batch == batch,
                              'is-full': batch.full
                            })
                            return(
                              <div
                                className={selectorClasses}
                                ref='selector'
                                value={batch}
                                onClick={this.handleDateClick.bind(this)}
                              >
                                from <strong>{ batch.starts_at }</strong> to <strong>{ batch.ends_at  }</strong>
                                {right_item}
                              </div>
                            )
                          })
                          }
                        </ReactBootstrap.DropdownButton>
                        <input type='hidden' name='apply[batch]' value={'batch.id'} />
                      </div>
                    </div>
                  </div>
                  {this.props.rows.map( (row, index) => {
                    return <ApplyFormRow {... row} />
                  })}
                  <div className='apply-form-row-submit'>
                    <div className='apply-form-price'>
                      Price : 4500 € Incl. Tax. Payment in three installments, free of charge.
                    </div>
                    <input type='submit' value={'Apply for a 9 weeks bootcamp in ' + this.state.activeCity.name} className='apply-form-submit btn btn-sucsess' />
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }

  handleDateClick(e) {
    this.setState({ batch: e.target.getAttribute("value") })
    React.findDOMNode(this.refs.selectType).className = "btn-group";
  }


  setActiveCity(city) {
    if (this.state.activeCity !== city) {
      this.setState({ activeCity: city })
    }
  }
}
