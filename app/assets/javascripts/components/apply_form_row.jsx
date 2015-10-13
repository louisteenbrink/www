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

    var errorSpan = null;
    if (this.props.error !== null) {
      errorSpan = <span>{this.props.error}</span>;
    }

    if (_.includes(['text', 'phone', 'tel', 'email'], this.props.type)) {
      return(
        <div className={componentClasses}>
          <label htmlFor={this.name()}>
            <i className={this.props.icon}></i>{this.props.label}
          </label>
          <input
            required={true}
            placeholder={this.props.placeholder}
            type={this.props.type}
            onFocus={this.handleFocus.bind(this)}
            onBlur={this.handleBlur.bind(this)}
            defaultValue={this.props.value}
            id={this.props.param}
            name={this.name()} />
          {errorSpan}
        </div>
      )
    } else if (this.props.type === 'textarea') {
      return(
        <div className={componentClasses}>
          <label for={this.name()}>
            <i className={this.props.icon}></i>{this.props.label}
          </label>
          <textarea
            required={true}
            onFocus={this.handleFocus.bind(this)}
            onBlur={this.handleBlur.bind(this)}
            placeholder={this.props.placeholder}
            id={this.name()}
            defaultValue={this.props.value}>
          </textarea>
          {errorSpan}
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
