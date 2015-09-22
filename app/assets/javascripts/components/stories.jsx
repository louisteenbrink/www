class Stories extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      activeItem: 1,
      transition: false
    }
  }


  render() {
    var detailClasses = classNames({
      'story-detail': true,
      'is-active': this.state.transition
    })

    return (
      <div className='story-overlay'>
        <div className='container'>
          <h2 className='section-title-home'>
            <div className='section-title-home-content'>
              The funny thing is, it works
            </div>
          </h2>
          <div className='story'>
            <div className='story-list'>
              {this.props.stories.map((story, index) => {
                return <StoriesItem {... story}
                  index={index}
                  activeItem={this.state.activeItem} />
              })}
            </div>
            {this.props.stories.map((story, index) => {
              var backgroundStyle = {
                backgroundImage: "url('" + story.picture + "')"
              }
              var roundStyle = {
                backgroundImage: "url('" + story.alumni.thumbnail + "')"
              }


              var detailClasses = classNames({
                'story-detail hidden-sm hidden-xs': true,
                'is-active': index + 1 == this.state.activeItem
              })

              return(
                <div className={detailClasses}>
                  <div className='story-detail-background' style={backgroundStyle}>
                    <div className='story-detail-extended' style={roundStyle}/>
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
