class StudentsTitle extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    var counter = this.props.counter;

    return (
      <h2 className="demoday-title">{counter} amazing humans right here</h2>
    )
  }
}