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

    var description = this.props.description[this.props.locale]

    if (this.props.company) {
      var logo = <img className='pull-right story-item-batch' src={this.props.company.logo} />;
      var link = <a href={this.props.company.url} target="_blank" className="story-company-link"></a>;
    }



    return(
        <div className={componentClasses} onMouseEnter={this.handleClick.bind(this)} onClick={this.handleClick.bind(this)}>
          <div className='story-item-name'>
            {this.props.alumni.first_name} {this.props.alumni.last_name}
            {logo}
          </div>
          <div className='story-item-description'>
            {description}
          </div>
          {link}
        </div>
    )
  }

  handleClick() {
    if(this.props.activeItem !== this.props.index + 1) {
      PubSub.publish('updateActiveItem', {new: this.props.index + 1, old: this.props.activeItem})
    }
  }
}
