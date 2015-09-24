class DayType extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return (
      <div className="container padded">
        <div className="row">
          <h2 className="section-header-big text-center">{this.props.title}</h2>
          <div className="col-xs-12 col-sm-8 col-sm-offset-2">
            <div className="days">
              <div className="days-border"></div>
              <div className="days-container">
                {this.props.steps.map((step) => {
                  return <DayTypeStep {... step} />
                })}
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}
