class DayType extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      activeDay: 1
    }
  }

  render() {
    return (
      <div>
        <div className="row">
          <div className='timeline-overlay'>
            <div className='day-type-detail-container'>
              <div>
                {this.props.steps.map((step, index) => {
                  return(
                    <DayTypeDetail
                      {... step}
                      index={index + 1}
                      isActive={index + 1 == this.state.activeDay}
                    />
                  )
                })}
              </div>
              <div className="timeline-container container">
                <h2>{this.props.title}</h2>
                <div className="days">
                  <div className="days-border"></div>
                  <div className="days-container">
                    {this.props.steps.map((step, index) => {
                      return(
                        <DayTypeStep
                          {... step}
                          index={index + 1}
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
        activeDay: data
      })
    })
  }
}
