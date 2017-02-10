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
                <ReactBootstrap.Dropdown.Toggle noCaret={true}>
                  <span dangerouslySetInnerHTML={{__html: this.state.activeCityGroup.group + ' ' + this.state.activeCityGroup.icon}}></span>
                </ReactBootstrap.Dropdown.Toggle>
                <ReactBootstrap.Dropdown.Menu>
                  {otherCityGroups.map((cityGroup, index) => {
                    return(
                      <CityGroupNavItem
                        key={`city_group_${index}`}
                        cityGroup={cityGroup}
                        setActiveCityGroup={(cityGroup) => this.setActiveCityGroup(cityGroup)}
                      />
                    )
                  })}
                </ReactBootstrap.Dropdown.Menu>
              </ReactBootstrap.Dropdown>
              {cities.map((city, _) => {
                return (
                  <CityNavItem
                    key={`city_nav_item_${city.id}`}
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
                {this.props.cities.map((city, _) => {

                  var bannerClasses = classNames({
                    'banner-city banner banner-top banner-gradient text-center': true,
                    'is-active': this.state.activeCity.slug == city.slug
                  })

                  var bannerCityStyle = {};

                  if (city.pictures.cover) {
                    var bannerCityStyle = {
                      backgroundImage: "url(" + city.pictures.cover  + ")"
                    };
                  }

                  return(
                    <div key={`city_${city.id}`} className={bannerClasses} style={bannerCityStyle}>
                      <div className="banner-gradient-shadow"></div>
                      <div className="banner-content">
                        <h1 className='glitch'>
                          <span>{this.props.i18n.title}</span> <span className='city'>{city.name}</span>
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
                      <i className='mdi mdi-calendar-multiple-check'></i><span>Dates</span>
                    </label>
                    <div className='apply-form-row-item'>
                      <div className='post-submissions-select'>
                        <div className="dropdown btn-group">
                          <button id="batchSelector" ref="selectType" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" type="button" className="dropdown-toggle btn btn-default">
                            <span>{this.state.activeBatch.starts_at + ' - ' + this.state.activeBatch.ends_at}</span>
                            <span className="caret"></span>
                          </button>
                          <ul role="menu" className="dropdown-menu" aria-labelledby="batchSelector">
                            {batches.map((batch, _) => {
                              return(
                                <BatchSelector
                                  key={`batch_${batch.id}`}
                                  batch={batch}
                                  isActive={batch.id == this.state.activeBatch.id}
                                />
                              )
                            })}
                          </ul>
                        </div>
                        <input type='hidden' name='application[batch_id]' value={this.state.activeBatch.id} />
                        <input type='hidden' name='application[city_id]' value={this.state.activeCity.id} />
                        <input type='hidden' name='locale' value={this.props.locale} />
                      </div>
                    </div>
                  </div>
                  {this.state.rows.map( (row, index) => {
                    return <ApplyFormRow key={`apply_form_row_${index}`} {... row} validate={this.validate.bind(this)} />
                  })}
                  <div className='apply-form-row-submit'>
                    <div className='apply-form-price'>
                      <div>
                        <span>{this.props.i18n.pre_course_language}</span>
                        <strong>{this.props.i18n.course_language[this.state.activeCity.slug] || this.props.i18n['language_' + this.state.activeCity.course_locale]}</strong>
                      </div>
                      <div>
                        <span>{this.props.i18n.price + ": "}</span>
                        <strong>{this.state.activeBatch.price}</strong>
                        <span dangerouslySetInnerHTML={{__html: this.props.i18n.post_price[this.state.activeCity.slug]}}></span>
                      </div>
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

