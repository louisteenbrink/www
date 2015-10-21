class Stories extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      activeItem: 1,
      transition: false,
      exitingItem: null
    }
  }


  render() {
    var detailClasses = classNames({
      'story-detail': true,
      'is-active': this.state.transition
    })

    return (
      <div className='story-overlay'>
        {this.props.stories.map((story, index) => {
          var backgroundStyle = {
            backgroundSize: "cover !important",
            backgroundImage: "url('" + story.picture + "')"
          }

          var detailClasses = classNames({
            'story-detail hidden-sm hidden-xs': true,
            'is-active':  index + 1 == this.state.activeItem,
            'is-exiting': index + 1 == this.state.exitingItem
          })

          return(
            <div className={detailClasses}>
              <div className='story-detail-background' style={backgroundStyle}>
              </div>
            </div>
          )
        })}
        <div className='container'>
          <h2>
              {this.props.title}
          </h2>
          <div className='story'>
            <div className='story-list'>
              {this.props.stories.map((story, index) => {
                return <StoriesItem {... story}
                  index={index}
                  activeItem={this.state.activeItem}
                  locale={this.props.locale}/>
              })}
            </div>
          </div>
        </div>
      </div>
    )
  }

  componentDidMount() {
    PubSub.subscribe('updateActiveItem', (msg, index) => {
      this.setState({
        activeItem: index.new,
        exitingItem: index.old
      })
    })
  }
}
