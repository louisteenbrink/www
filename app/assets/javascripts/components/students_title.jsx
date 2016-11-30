class StudentsTitle extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    return (
      <h2 className="demoday-title">{this.props.counter} {this.props.i18n.batch_title}</h2>
    )
  }
}