class ApplyForm extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      activeCityGroup: this.props.city_group,
      rows: this.props.rows,
      activeCity: this.props.city,
      activeBatch: this.firstBatch(this.props.city),
      submitting: false
    }
  }

  render() {

    var cities = this.state.activeCityGroup.cities;
    var otherCityGroups = this.props.city_groups.filter((cityGroup) => { return cityGroup.group !== this.state.activeCityGroup.group });
    var batches = this.state.activeCity.batches;
    var componentClasses = classNames({ 'apply-form': true });
    var submitButton = null;

    if (this.state.submitting) {
      submitButton = (
        <input id='apply_btn' type='submit' value={this.props.i18n.please_wait} disabled className='apply-form-submit btn' />
      );
    } else {
      submitButton = (
        <input id='apply_btn' type='submit' value={this.props.i18n.apply_btn + this.state.activeCity.name} className='apply-form-submit btn' />
      );
    }

    return (
      <div className={componentClasses}>
        <div className="banner-container">
          <div className="container banner-city-container">
            <div className='banner-city-nav'>
              <ReactBootstrap.Dropdown id='cityGroupSelector' ref="cityGroupSelector">
                <ReactBootstrap.Dropdown.Toggle>
                  {this.state.activeCityGroup.group}
                  <span dangerouslySetInnerHTML={{__html: this.state.activeCityGroup.icon}}></span>
                </ReactBootstrap.Dropdown.Toggle>
                <ReactBootstrap.Dropdown.Menu>
                  {otherCityGroups.map((cityGroup, index) => {
                    return(
                      <CityGroupNavItem
                        key={index}
                        cityGroup={cityGroup}
                        setActiveCityGroup={(cityGroup) => this.setActiveCityGroup(cityGroup)}
                      />
                    )
                  })}
                </ReactBootstrap.Dropdown.Menu>
              </ReactBootstrap.Dropdown>
              {cities.map((city, index) => {
                return (
                  <CityNavItem
                    key={index}
                    city={city}
                    i18n={this.props.i18n}
                    firstBatch={this.firstBatch(city)}
                    setActiveCity={(city) => this.setActiveCity(city)}
                    isActive={this.state.activeCity.slug == city.slug}
                  />
                )
              })}
            </div>
            <div className='apply-form-body'>
              <div className='banner-city-wrapper'>
                {this.props.cities.map((city, index) => {

                  var bannerClasses = classNames({
                    'banner-city banner banner-top banner-gradient text-center': true,
                    'is-active': this.state.activeCity.slug == city.slug
                  })

                  var bannerCityStyle = {
                    backgroundImage: "url(" + city.pictures.city.cover  + ")"
                  };

                  return(
                    <div key={index} className={bannerClasses} style={bannerCityStyle}>
                      <div className="banner-gradient-shadow"></div>
                      <div className="banner-content">
                        <h1 className='glitch'>
                          {this.props.i18n.title} <span className='city'>{city.name}</span>
                        </h1>
                      </div>
                    </div>
                  )
                })}
              </div>
              <div className='apply-form-rows-container'>
                <form id='apply' action={Routes.apply_path({ city: this.state.activeCity.slug })} method='post' onSubmit={this.onSubmit.bind(this)}>
                  <input type='hidden' name='authenticity_token' value={this.props.token} />
                  <div className='apply-form-row apply-form-row-first'>
                    <label>
                      <i className='mdi mdi-calendar-multiple-check'></i>Dates
                    </label>
                    <div className='apply-form-row-item'>
                      <div className='post-submissions-select'>
                        <ReactBootstrap.DropdownButton id='batchSelector' ref='selectType' title={this.state.activeBatch.starts_at + ' - ' + this.state.activeBatch.ends_at}>
                          {batches.map((batch, index) => {
                            return(
                              <BatchSelector
                                key={index}
                                batch={batch}
                                isActive={batch.id == this.state.activeBatch.id}
                              />
                            )
                          })
                          }
                        </ReactBootstrap.DropdownButton>
                        <input type='hidden' name='application[batch_id]' value={this.state.activeBatch.id} />
                        <input type='hidden' name='application[city_id]' value={this.state.activeCity.id} />
                        <input type='hidden' name='locale' value={this.props.locale} />
                      </div>
                    </div>
                  </div>
                  {this.state.rows.map( (row, index) => {
                    return <ApplyFormRow key={index} {... row} validate={this.validate.bind(this)} />
                  })}
                  <div className='apply-form-row-submit'>
                    <div className='apply-form-price'>
                      <div>
                        {this.props.i18n.pre_course_language}
                        <strong>{this.props.i18n.course_language[this.state.activeCity.slug] || this.props.i18n['language_' + this.state.activeCity.course_locale]}</strong>
                      </div>
                      {this.props.i18n.price}: <strong>{this.state.activeBatch.price}</strong> {this.props.i18n.post_price[this.state.activeCity.slug]}
                    </div>
                    {submitButton}
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>)
  }

  componentDidMount() {
    this.setBatchCodeCademyCompletedModalParagraph();

    PubSub.subscribe('setActiveBatch', (msg, data) => {
      this.setState({
        activeBatch: data
      });

      this.setBatchCodeCademyCompletedModalParagraph();
    });
  }

  validate(param, value) {
    payload = {};
    payload[param] = value;
    payload['application[batch_id]'] = this.state.activeBatch.id;

    $.ajax({
      url: Routes.validate_apply_path({ format: 'json' }),
      type: 'POST',
      data: payload,
      success: (data) => {
        var newStateRows = _.map(this.state.rows, (row) => {
          if (`application[${row.param}]` == param) {
            var testedRow = _.find(data.rows, (row) => `application[${row.param}]` === param)
            return testedRow;
          } else {
            return row;
          }
        });
        this.setState({ rows: newStateRows });
      }
    })
  }

  setBatchCodeCademyCompletedModalParagraph(batch) {
    var $paragraph = $('.can-apply-without-codecademy-completed');
    if ((batch || this.state.activeBatch).force_completed_codecademy_at_apply) {
      $paragraph.hide();
    } else {
      $paragraph.show();
    }
  }

  setActiveCity(city) {
    if (this.state.activeCity !== city) {
      batch = this.firstBatch(city);
      this.setState({ activeCity: city, activeBatch: batch });
      history.replaceState({}, '', this.props.apply_path.replace(':city', city.slug));
      document.title = this.props.i18n.page_title.replace('%{city}', city.name);
      this.setBatchCodeCademyCompletedModalParagraph(batch);
    }
  }

  setActiveCityGroup(cityGroup) {
    if (this.state.activeCityGroup !== cityGroup) {
      this.setState({ activeCityGroup: cityGroup });
      this.setActiveCity(cityGroup.cities[0]);
      // toggle dropdown
      this.refs.cityGroupSelector._values.open = false;
    }
  }

  firstBatch(city) {
    return _.filter(city.batches, (n) => { return !n.full && !n.waiting_list })[0] || city.batches[0]
  }

  onSubmit() {
    this.setState({ submitting: true });
  }
}

