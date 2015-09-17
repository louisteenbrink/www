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
      backgroundImage: "url('" + this.props.image + "')"
    }
    return(
      <div
        className='user-cascade-item'
        style={componentStyle}
      />
    )
  }

  componentWillReceiveProps() {
    var p = this.props.p;
    var halfWidth = this.props.winWidth/2;
    var halfHeight = this.props.winHeight/2;
    var centerW = p.x - halfWidth;
    var centerH = p.y - halfHeight;
      this.setState({
        p: p,
        centerW: centerW,
        centerH: centerH
      })
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
