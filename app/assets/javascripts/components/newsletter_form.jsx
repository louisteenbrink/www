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

    if (this.state.valid) {
      var btnValue = <i className="fa fa-check" />;
    } else if (this.state.error) {
      var btnValue = this.props.i18n.retry;
    } else {
      var btnValue = "GO";
    }

    var submitButton = (
      <button type='submit' className='newsletter-input-button' ref="button">
        {btnValue}
      </button>
    );

    if (this.state.error) {
      var hint = (
        <div className="hint text-center">
          this.props.i18n.errors
        </div>
      );
    };

    return(

      <div className={componentClasses}>
        <h2>
          {this.props.i18n.title}
        </h2>

        <form onSubmit={this.onSubmit.bind(this)}>
          <div dangerouslySetInnerHTML={{__html: Csrf.getInput()}} />
          <div className='newsletter-input'>
            <input
              placeholder='you@domain.com'
              ref="email"
              className='newsletter-input-email'
              type='email'
              name="email"
              disabled={this.state.valid}
            />
            {submitButton}
          </div>
        </form>
        {hint}
      </div>
    )
  }

  onSubmit() {
    this.setState({ submitting: true });
    var email = React.findDOMNode(this.refs.email).value;
    $.post(Routes.subscribes_path(), { email: email }, (data) => {
      if (data.ok) {
        this.setState({ valid: true });
        this.setState({ error: false });
      } else {
        this.setState({ error: true });
      }
    });
    return false;
  }
}
