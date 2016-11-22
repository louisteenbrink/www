class StudentsList extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    var students = this.props.students;

    return (
      <div className="students-container">
      { students.map(function(student, index){
          return <StudentsListItem key={index} student={student} />;
        })
      }
      </div>
    )
  }
}