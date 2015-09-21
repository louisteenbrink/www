class LearningCurve extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      active: false,
      size: '100%'
    }
  }

  render() {
    var componentStyle = {
      width: this.state.size,
      overflow: 'hidden'
    };

    return(
      <div className="container padded text-center">
        <div
          onMouseMove={this.handleMouseMove.bind(this)}
          className='learning-curve'
          ref='curve'
        >
          <div
            style={componentStyle}
            className='learning-curve-svg'
            dangerouslySetInnerHTML={{__html: this.props.curve}}
          />
          <div
            className='learning-curve-disable'
            dangerouslySetInnerHTML={{__html: this.props.curve}}
          />


          <div className='learning-curve-hidder'/>
        </div>
      </div>
    )
  }

  handleMouseMove(e) {
    var curve = React.findDOMNode(this.refs.curve);
    var cursorPosition = e.clientX;
    var startingPoint = curve.offsetLeft;
    var endingPoint = curve.offsetLeft + curve.offsetWidth;

    if (startingPoint < cursorPosition < endingPoint) {
      this.setState({ size: (cursorPosition - startingPoint) })
    }
  }
}

