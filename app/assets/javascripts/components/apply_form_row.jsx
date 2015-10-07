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
      'is-focused': this.state.isFocused
    });
    if (_.includes(['text', 'phone', 'tel', 'email'], this.props.type)) {
      return(
        <div className={componentClasses}>
          <label for={this.name()}>
            <i className={this.props.icon}></i>{this.props.label}
          </label>
          <input
            required={true}
            placeholder={this.props.placeholder}
            type={this.props.type}
            onFocus={this.handleFocus.bind(this)}
            onBlur={this.handleBlur.bind(this)}
            id={this.name()}
            name={this.name()} />
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
            name={this.name()} />
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
    return `apply[${this.props.param}]`;
  }
}
