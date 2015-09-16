class UserCascadeItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      winWidth: null,
      winHeight: null,
      centerW: null,
      centerH: null,
      scale: 1,
      p: this.props.p
    }
  }
  render() {
    var xTranslate = Math.round(this.state.centerW/20);
    var yTranslate = Math.round(this.state.centerH/20);
    var xShadow = -xTranslate*10;
    var yShadow = -yTranslate*10;

    var componentStyle = {
      transform: "translate3d(" + xShadow + "px, " + yShadow + "px, 0px) scale(" + this.state.scale + ")",
      opacity: this.state.scale == 1 ? ".8" : "1"
    }
    return(
      <div
        className='user-cascade-item'
        style={componentStyle}
        onMouseEnter={this.handleMouseEnter.bind(this)}
        onMouseLeave={this.handleMouseLeave.bind(this)}
      />
    )
  }

  componentWillReceiveProps() {
    var p = this.props.p;
    var halfWidth = this.props.winWidth/2;
    var halfHeight = this.props.winHeight/2;
    var centerW = p.x - halfWidth;
    var centerH = p.y - halfHeight;
    setTimeout(()=>{
      this.setState({
        p: p,
        centerW: centerW,
        centerH: centerH
      })
    }, this.props.index*2 )
  }

  handleMouseEnter() {
    this.setState({
      scale: 1.1
    })
  }

  handleMouseLeave() {
    this.setState({
      scale: 1
    })
  }
}
