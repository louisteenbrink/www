class BatchCover extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    var coverStudents = {
      backgroundImage: "url(" + this.props.cover.replace('development', 'production') + ")"
    }

    if (this.props.cover.match(/missing\.png/)) {
      cover = ""
    } else {
      cover = <div className="cover-students" style={coverStudents}></div>
    }

    return (
      <div>{cover}</div>
    )
  }
}