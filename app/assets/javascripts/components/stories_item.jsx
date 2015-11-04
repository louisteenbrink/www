class StoriesItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      active: this.props.active
    }
  }

  render() {
    var componentClasses = classNames({
      'story-item': true,
      'is-active': (this.props.index + 1) == this.props.activeItem
    })

    var title = this.props.title[this.props.locale];
    var summary = this.props.summary[this.props.locale];

    console.log(title);
    console.log(summary);

    if (this.props.company) {
      var logo = <img className='pull-right story-item-batch' src={this.props.company.logo} />
      var link = <a href={this.props.company.url} target="_blank" className="story-company-link"></a>
    }


    return(

      <div className="story-container" onMouseEnter={this.handleClick.bind(this)} onClick={this.handleClick.bind(this)}>
        <div className="story-card">
          <main>
            <div className="story-card-title">
              {title}
            </div>
            <div className="story-card-summary">
              <div dangerouslySetInnerHTML={{__html: summary}} />
            </div>
            <div className='story-card-footer'>
              <div className="story-banner-user">
                <div className="story-user-avatar">
                  <img src={this.props.alumni.thumbnail} />
                </div>
                <div className="story-banner-infos">
                  <div className="story-user-name">
                    <span>Featuring</span> {this.props.alumni.first_name} {this.props.alumni.last_name}
                  </div>
                  <div className="story-user-batch">
                    Batch #{this.props.alumni.slug}, {this.props.alumni.city}
                  </div>
                  <div className="story-link">
                    <a href="#">
                      Read {this.props.alumni.first_name}'s story
                    </a>
                    <i className="fa fa-arrow-right"></i>
                  </div>
                </div>
              </div>
            </div>
          </main>
        </div>
      </div>

    )
  }

  handleClick() {
    if(this.props.activeItem !== this.props.index + 1) {
      PubSub.publish('updateActiveItem', {new: this.props.index + 1, old: this.props.activeItem})
    }
  }
}
