class LearningCurve extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      activeItem: 1
    }
  }

  render() {
    return(
      <div className="container text-center" ref='container'>
        <div className='module-overlay'>
          <div className='module-nav hidden-xs'>
            {this.props.modules.map((module, index) => {
              return (
                <ModuleNavItem
                  {...module}
                  index    = {index + 1}
                  isActive = {index + 1 == this.state.activeItem}
                />
              )
            })}
          </div>

          <div className='features feature-container modules'>
            {this.props.modules.map((module, index) => {
              var next = this.props.modules[index + 1];
              var previous = this.props.modules[index - 1];

              return (
                <ModuleItem
                  {... module}
                  index       = {index + 1}
                  moduleCount = {this.props.modules.length}
                  isActive    = {index + 1 == this.state.activeItem}
                  activeItem  = {this.state.activeItem}
                  next        = {next}
                  previous    = {previous}
                />)
            })}
          </div>
        </div>
        <Curve
          {... this.props}
          scrollTop       = {this.state.scrollTop}
          containerHeight = {this.state.containerHeight}
          activeItem      = {this.state.activeItem}
        />
      </div>
    )
  }

  componentDidMount() {
    PubSub.subscribe('setActiveItem', (msg, data) => {
      this.setState({ activeItem: data })
    })
  }
}

