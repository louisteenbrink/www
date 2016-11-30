class StudentsListItem extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    var student_picture = this.props.student["thumbnail"];
    var student_first_name = this.props.student["first_name"];
    var student_last_name = this.props.student["last_name"];

    return (
      <div className="student-info">
        <img src={student_picture} className="student-picture"/>
        <p className="student-name">{student_first_name} {student_last_name}</p>
      </div>
    )
  }
}