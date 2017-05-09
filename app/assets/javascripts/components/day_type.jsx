class DayType extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      activeDay: 1,
      exitingDay: null
    }
  }

  render() {
    return (
      <div>
        <div className="row">
          <div className='timeline-overlay'>
            <div className='story-label-container story-label-container-program'>
              <div className='story-label yellow'>
                <i className="fa fa-sun-o"></i>
              </div>
              <span style={{color: "white",paddingLeft: "10px"}}>{this.props.title}</span>
            </div>
            <div className='day-type-detail-container'>
              <div>
                {this.props.steps.map((step, index) => {
                  return(
                    <DayTypeDetail
                      {... step}
                      key={index + 1}
                      index={index + 1}
                      isActive={index + 1 == this.state.activeDay}
                      activeItem={this.state.activeDay}
                      isExiting={this.state.exitingDay == index + 1}
                    />
                  )
                })}
              </div>
              <div className="timeline-container">
                <div className="days">
                  <div className="days-border hidden-xs"></div>
                  <div className="days-container">
                    {this.props.steps.map((step, index) => {
                      return(
                        <DayTypeStep
                          {... step}
                          key={index + 1}
                          index={index + 1}
                          activeItem={this.state.activeDay}
                          isActive={index + 1 == this.state.activeDay}
                          isLast={index == this.props.steps.length - 1}
                        />
                      )
                    })}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }

  componentDidMount() {
    PubSub.subscribe('setActiveDay', (msg, data) => {
      this.setState({
        activeDay: data.new,
        exitingDay: data.old
      })
    })
  }
}
