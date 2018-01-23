class EdhecApplyForm extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      submitting: false
    }
  }

  render() {
    var submitButton = null;

    if (this.state.submitting) {
      submitButton = (
        <input id='apply_btn' type='submit' value={this.props.i18n.please_wait} disabled className='apply-form-submit btn' />
      );
    } else {
      submitButton = (
        <input id='apply_btn' type='submit' value='Postulez au Wagon Lille & Edhec' className='apply-form-submit btn' />
      );
    }

    var bannerCityStyle = {
      backgroundImage: "url(" + this.props.banner + ")",
      height: 300,
    };

    return (
      <div className="banner-container">
        <div className="banner-city-container">
          <div className='apply-form-body'>
            <div className='banner-city-wrapper'>
              <div className="banner-city banner banner-top banner-gradient is-active text-center" style={bannerCityStyle}>
                <div className="banner-gradient-shadow"></div>
                <div className="banner-content">
                  <h1 className='glitch'>
                    Postulez au Wagon Lille & Edhec
                  </h1>
                </div>
              </div>
            </div>
            <div className='apply-form-rows-container'>
              <form id='apply' action={this.props.apply_path} method='post' onSubmit={this.onSubmit.bind(this)}>
                <input type='hidden' name='authenticity_token' value={this.props.token} />
                {this.props.rows.map( (row, index) => {
                  return <ApplyFormRow key={index} {... row} />
                })}
                <div className='apply-form-row-submit'>
                  <div className='apply-form-price'>
                    {this.props.i18n.price}: <strong>{this.props.price}</strong>
                  </div>
                  {submitButton}
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>);
  }

  onSubmit() {
    this.setState({ submitting: true });
  }
}
