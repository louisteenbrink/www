class DayType extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      activeDay: 1
    }
  }

  render() {
    return (
      <div className="container padded">
        <div className="row">
          <h2 className="section-header-big text-center section-title-home"><div className='section-title-home-content'>{this.props.title}</div></h2>
          <div className='timeline-overlay'>
            <div className="timeline-container">
              <div className="days">
                <div className="days-border"></div>
                <div className="days-container">
                  {this.props.steps.map((step, index) => {
                    return(
                      <DayTypeStep
                        {... step}
                        index={index + 1}
                        isActive={index + 1 == this.state.activeDay}
                      />
                    )
                  })}
                </div>
              </div>
            </div>
            <div className='day-type-detail-container hidden-xs'>
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
