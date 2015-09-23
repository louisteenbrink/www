class Curve extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      active: false,
      size: 100 / this.props.modules.length,
      topValue: false,
      initialBreakPoint: false,
      containerHeight: this.props.containerHeight
    }
  }
  render() {

    var svgContainerStyle = {
      width: this.state.size + '%',
      overflow: 'hidden'
    };

    var containerStyle = {
      'top': this.state.topValue
    }

    var wrapperStyle = {
      transform: 'translateX(' + (-(this.state.size - 25)) + '%)',
      webkitTransform: 'translateX(' + (-(this.state.size - 25)) + '%)'
    }

    return (
      <div className='learning-curve-helper' ref='helper'>
        <div className='learning-curve-helper-inner' style={containerStyle}>
          <div className='learning-curve-container' ref='curveContainer'>
            <div className='learning-curve-wrapper' style={wrapperStyle}>
              <div
                className='learning-curve'
                ref='curve'
              >
                <div
                  style={svgContainerStyle}
                  className='learning-curve-svg'
                  dangerouslySetInnerHTML={{__html: this.props.curve}}
                />
                <div
                  className='learning-curve-disable'
                  dangerouslySetInnerHTML={{__html: this.props.curve}}
                />
              </div>
              <div className='learning-curve-items'>
                {this.props.modules.map((module, index) => {
                  return (
                    <LearningCurveItem
                      {... module}
                      isActive={index + 1 == this.props.activeItem}
                    />
                  )
                })}
              </div>
            </div>
          </div>
          <div className='learning-curve-miniature'>
            <div
              style={svgContainerStyle}
              className='learning-curve-svg'
              dangerouslySetInnerHTML={{__html: this.props.curve + "<div class='magnifying-glass'></div>"}}
            />
            <div
              className='learning-curve-disable'
              dangerouslySetInnerHTML={{__html: this.props.curve}}
            />
          </div>
        </div>
      </div>
    )
  }

  componentWillReceiveProps() {
    var curveContainer = React.findDOMNode(this.refs.curveContainer);
    var helper = React.findDOMNode(this.refs.helper);
    var breakPoint = {
      top: helper.offsetTop,
      bottom: this.state.containerHeight - curveContainer.offsetHeight
    }
    if (this.props.scrollTop - breakPoint.top > 0  && (this.props.scrollTop - breakPoint.top) < (breakPoint.bottom - 100)  ) {
      this.setState({ topValue: this.props.scrollTop - breakPoint.top })
    }
  }

  componentDidMount() {
    PubSub.subscribe('curveSize', (msg, data) => {
      this.setState({ size: data })
    })

    PubSub.subscribe('containerHeight', (msg, data) => {
      this.setState({
        containerHeight: data
      })
    })
  }

}
