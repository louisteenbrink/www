class ApplyFormRow extends React.Component {
  render() {
    if (_.includes(['text', 'phone', 'tel', 'email'], this.props.type)) {
      return(
        <div className="apply-form-row">
          <label>
            <i className={this.props.icon}></i>{this.props.label}
          </label>
          <input
            required={true}
            placeholder={this.props.placeholder}
            type={this.props.type}
            name={this.name()} />
        </div>
      )
    } else if (this.props.type === 'textarea') {
      return(
        <div className="apply-form-row">
          <label>
            <i className={this.props.icon}></i>{this.props.label}
          </label>
          <textarea
            required={true}
            placeholder={this.props.placeholder}
            name={this.name()} />
        </div>
      )
    } else {
      throw `Not implemented type: ${this.props.type}`;
    }
  }

  name() {
    return `apply[${this.props.param}]`;
  }
}
