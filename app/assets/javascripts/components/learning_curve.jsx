class LearningCurve extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      activeItem: 1,
      scrollTop: this._scrollTop(),
      containerHeight: 0
    }
  }

  render() {
    return(
      <div className="container padded text-center flex" ref='container'>
        <div className='features feature-container flow-column'>
          {this.props.modules.map((module, index) => {
            return (
              <ModuleItem
                {... module}
                index={index + 1}
                isActive={index + 1 == this.state.activeItem}
              />)
          })}
        </div>
        <div className='separator' />
        <Curve
          {... this.props}
          scrollTop={this.state.scrollTop}
          containerHeight={this.state.containerHeight}
          activeItem={this.state.activeItem}
        />
      </div>
    )
  }

  componentWillUnmount() {
    window.removeEventListener('scroll', this.handleScroll);

  }

  handleScroll(event) {
     this.setState({scrollTop: this._scrollTop()})
  }

  componentDidMount() {
    window.addEventListener('scroll', this.handleScroll.bind(this));
    this.setState({
      containerHeight: React.findDOMNode(this.refs.container).clientHeight
    })

    PubSub.subscribe('getContainerHeight', () => {
      PubSub.publish('containerHeight', React.findDOMNode(this.refs.container).clientHeight)
    })

    PubSub.subscribe('setActiveItem', (msg, data) => {
      this.setState({ activeItem: data })
    })
  }

  _scrollTop() {
    var doc = document, w = window;
    var y, docEl;

    if ( typeof w.pageYOffset === 'number' ) {
        y = w.pageYOffset;
    } else {
        docEl = (doc.compatMode && doc.compatMode === 'CSS1Compat')?
        doc.documentElement: doc.body;
        y = docEl.scrollTop;
    }
    return y;
}
}

