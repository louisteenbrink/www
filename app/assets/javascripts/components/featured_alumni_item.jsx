class FeaturedAlumniItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      active: this.props.active
    }
  }

  render() {
    var componentClasses = classNames({
      'featured-alumni-item': true,
      'is-active': (this.props.index + 1) == this.props.activeItem
    })

    return(
        <div className={componentClasses} onMouseEnter={this.handleClick.bind(this)} onClick={this.handleClick.bind(this)}>
          <div className='featured-alumni-item-name'>
            {this.props.name}
          </div>
          <div className='featured-alumni-item-description'>
            {this.props.description}
          </div>
        </div>
    )
  }

  handleClick() {
    this.setState({ active: true })
    PubSub.publish('updateActiveItem', this.props.index + 1)
  }
}
