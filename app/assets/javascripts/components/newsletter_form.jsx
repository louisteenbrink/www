class NewsletterForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      submitting: false,
      valid: false,
      already_subscribed: false,
      error: false
    }
  }

  render() {

    var componentClasses = classNames({
      'newsletter': true,
      'submitting': this.state.submitting,
      'valid': this.state.valid
    })

    var btnValue = this._getBtnValue();

    var submitButton = (
      <button type='submit' className='newsletter-input-button' ref="button" disabled={this.state.submitting || this.state.valid}>
        {btnValue}
      </button>
    );

    if (this.state.error) {
      var hint = (
        <div className="hint text-center">
          {this.props.i18n.error}
        </div>
      );
    };

    return(

      <div className={componentClasses}>
        <h2>
          {this.props.i18n.title}
        </h2>
        <p  dangerouslySetInnerHTML={{__html: this.props.i18n.subtitle}} />

        <form onSubmit={this.onSubmit.bind(this)}>
          <input type='hidden' name='authenticity_token' value={this.props.token} />
          <div className='newsletter-input'>
            <input
              placeholder='you@gmail.com'
              ref="email"
              className='newsletter-input-email'
              type='email'
              name="email"
              required={true}
              disabled={this.state.valid}
            />
            {submitButton}
          </div>
        </form>
        {hint}
      </div>
    )
  }

  onSubmit(e) {
    e.preventDefault();
    this.setState({ submitting: true });
    var email = this.refs.email.value;
    $.post(Routes.subscribes_path(), { email: email, city_id: this.props.city_id }, (data) => {
      if (data.ok) {
        this.setState({ valid: true, submitting: false });
        this.setState({ error: false, submitting: false });
      } else {
        this.setState({ error: true, submitting: false });
      }
    });
  }

  _getBtnValue() {
    if (this.state.valid) {
      return <i className="fa fa-check" />;
    } else if (this.state.error) {
      return this.props.i18n.retry;
    } else if (this.state.submitting) {
      return this.props.i18n.subscribing;
    } else {
      return this.props.i18n.subscribe;
    }
  }
}
