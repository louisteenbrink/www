class ApplyFormRow extends React.Component {
  render() {
    var row = this.props;


    if (row.type == 'input') {
      return(
        <div
          className="apply-form-row"
        >
          <label>
            <i className={row.icon}></i>{row.label}
          </label>
          <input
            ref='title'
            required={true}
            placeholder={row.placeholder}
            name='resource[title]' />
        </div>
      )
    } else if (row.type == 'text') {
      return(
        <div
          className="apply-form-row"
        >
          <label>
            <i className={row.icon}></i>{row.label}
          </label>
          <textarea
            required={true}
            ref='title'
            placeholder={row.placeholder}
            name={'apply{' + row.param + ']'} />
        </div>
      )
    }
  }
}
