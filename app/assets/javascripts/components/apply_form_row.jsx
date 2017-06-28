class ApplyFormRow extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      value: null,
      error: props.error,
      charCounter: 0
    }
  }

  componentWillUpdate(nextProps, nextState) {
    if (nextProps.error != this.state.error) {
      this.setState({
        error: nextProps.error
      })
    }
  }

  render() {
    var componentClasses = classNames({
      'apply-form-row': true,
      'is-mandatory': this.props.mandatory,
      'has-error': this.state.error !== "",
      'is-validated': this.state.error === "" && (this.props.value || "").toString().length > 0
    });

    var errorDiv = null;
    if (this.state.error) {
      errorDiv = <div className="error" dangerouslySetInnerHTML={{__html: this.state.error}}></div>;
    }

    var charCounterDiv = null;
    if (this.props.minMotivLength != null && this.state.charCounter < this.props.minMotivLength) {
      var deltaChars = this.props.minMotivLength - this.state.charCounter;
      var motivationTip = null;
      if (deltaChars == 1) {
        motivationTip = this.props.singular_motivation_tip;
      } else if (deltaChars > 1) {
        motivationTip = this.props.plural_motivation_tip.replace(/(\d+)/, deltaChars);
      }
      charCounterDiv = <div className="input-tip">{motivationTip}</div>
    }

    if (_.includes(['text', 'phone', 'tel', 'email'], this.props.type)) {
      return(
        <div className={componentClasses}>
          <label htmlFor={this.name()}>
            <i className={this.props.icon}></i><span dangerouslySetInnerHTML={{__html: this.props.label}}></span>
          </label>
          <input
            ref="input"
            tabIndex={this.props.tabindex}
            placeholder={this.props.placeholder}
            type={this.props.type}
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
            <i className={this.props.icon}></i><span dangerouslySetInnerHTML={{__html: this.props.label}}></span>
            {charCounterDiv}
          </label>
          <textarea
            ref="input"
            tabIndex={this.props.tabindex}
            onBlur={this.handleBlur.bind(this)}
            onChange={this.handleChange.bind(this)}
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

  handleChange() {
    this.setState({ charCounter: this.value().length });
  }

  handleBlur() {
    var newValue = this.value();
    if (newValue.length > 0) {
      if (this.state.value != newValue) {
        this.setState({ value: newValue });
        this.props.validate(this.name(), newValue);
      }
    }
  }

  name() {
    return `application[${this.props.param}]`;
  }

  value() {
    return ReactDOM.findDOMNode(this.refs.input).value;
  }
}
