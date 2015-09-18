class FeaturedAlumni extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      activeItem: 1,
      transition: false
    }
  }


  render() {
    var detailClasses = classNames({
      'featured-alumni-detail': true,
      'is-active': this.state.transition
    })

    return (
      <div className='featured-alumni-overlay'>
        <div className='container'>
          <h2 className='section-title-home'>
            <div className='section-title-home-content'>
              The funny thing is, it works
            </div>
          </h2>
          <div className='featured-alumni'>
            <div className='featured-alumni-list'>
              {this.props.alumni.map((alumni, index) => {
                return <FeaturedAlumniItem {... alumni}
                  index={index}
                  activeItem={this.state.activeItem} />
              })}
            </div>
            {this.props.alumni.map((alumni, index) => {
              var backgroundStyle = {
                backgroundImage: "url('" + alumni.background + "')"
              }
              var roundStyle = {
                backgroundImage: "url('" + alumni.extended + "')"
              }


              var detailClasses = classNames({
                'featured-alumni-detail hidden-sm hidden-xs': true,
                'is-active': index + 1 == this.state.activeItem
              })

              return(
                <div className={detailClasses}>
                  <div className='featured-alumni-detail-background' style={backgroundStyle}>
                    <div className='featured-alumni-detail-extended' style={roundStyle}/>
                  </div>
                </div>
              )
            })}
          </div>
        </div>
      </div>
    )
  }

  componentDidMount() {
    PubSub.subscribe('updateActiveItem', (msg, index) => {
      this.setState({
        activeItem: index
      })
    })
  }
}
