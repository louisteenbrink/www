class ApplyFormRow extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      isFocused: false
    }
  }
  render() {
    var componentClasses = classNames({
      'apply-form-row': true,
      'is-focused': this.state.isFocused,
      'has-error': this.props.error !== null
    });

    var errorDiv = null;
    if (this.props.error) {
      errorDiv = <div className="error">{this.props.error}</div>;
    }

    if (_.includes(['text', 'phone', 'tel', 'email'], this.props.type)) {
      return(
        <div className={componentClasses}>
          <label htmlFor={this.name()}>
            <i className={this.props.icon}></i>{this.props.label}
          </label>
          <input
            required={this.props.required}
            placeholder={this.props.placeholder}
            type={this.props.type}
            onFocus={this.handleFocus.bind(this)}
            onBlur={this.handleBlur.bind(this)}
            defaultValue={this.props.value}
            id={this.props.param}
            name={this.name()} />
          {errorDiv}
        </div>
      )
    } else if (this.props.type === 'textarea') {
      return(
        <div className={componentClasses}>
          <label htmlFor={this.name()}>
            <i className={this.props.icon}></i>{this.props.label}
          </label>
          <textarea
            required={this.props.required}
            onFocus={this.handleFocus.bind(this)}
            onBlur={this.handleBlur.bind(this)}
            placeholder={this.props.placeholder}
            id={this.props.param}
            defaultValue={this.props.value}
            name={this.name()}>
          </textarea>
          {errorDiv}
        </div>
      )
    } else {
      throw `Not implemented type: ${this.props.type}`;
    }
  }

  handleFocus() {
    this.setState({ isFocused: true })
  }

  handleBlur() {
    this.setState({ isFocused: false })
  }

  name() {
    return `application[${this.props.param}]`;
  }
}
