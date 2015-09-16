class UserCascade extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      mousePosition: 0
    }
  }
  render() {
    return (
      <div onMouseMove={this.handleMouseMove.bind(this)} className='user-cascade-overlay'>
        <div className='container'>
        <h2 className='section-title-home negative'>
          <div className='section-title-home-content'>
            The funny thing is, it actually works.
          </div>
        </h2>
        </div>
        <div className='user-cascade'>
          {this.props.users.map((user, index) => {
            var i = index + 1;
            return (
              <UserCascadeItem
                p={this.state.mousePosition}
                winHeight={window.innerWidth}
                winWidth={window.innerHeight}
                index={i}
                {... user}
              />
            )
          })}
        </div>
      </div>
    )
  }

  componentDidMount() {

  }

  handleMouseMove(e) {
    this.setState({mousePosition: this._mousePosition(e)})
  }

  _mousePosition(e) {
    return {
      'x': e.pageX,
      'y': e.pageY
    }
  }
}
