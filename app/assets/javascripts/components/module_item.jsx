class ModuleItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      active: this.props.active,
      opened: true,
      height: 0
    }
  }

  render() {
    var componentClasses = classNames({
      'module-container': true,
      'is-active': this.props.isActive
    })
    if (this.props.next) {
      var next = (
        <div
          className={'module-arrow-right ' + this.props.next.color}
          onClick={this.onNextClick.bind(this)}
        >
          {this.props.next.title} <i className='fa fa-long-arrow-right'/>
        </div>
      )
    }

    if (this.props.previous) {
      var previous = (
        <div
          className = {'module-arrow-left ' + this.props.previous.color}
          onClick   = {this.onPreviousClick.bind(this)}
        >
          <i className='fa fa-long-arrow-left'/> {this.props.previous.title}
        </div>
      )
    }


    return(
      <div className={componentClasses}>
        <div
          className='feature module'
          ref='module'
        >
          <div className='feature-header'>
            <div className='feature-icon'>
              <i className={this.props.icon}/>
            </div>
            <div className='feature-title'>
              {this.props.title}
            </div>
            <div className='module-weeks'>
              {this.props.weeks}
            </div>
          </div>
          <div className='feature-body text-left'>
            {this.props.description}
          </div>
        </div>
      </div>
    )
  }

  handleClick() {
    PubSub.publish('setActiveItem', this.props.index);
    PubSub.publish('curveSize', this.props.curve_size);
  }

  onNextClick() {
    PubSub.publish('setActiveItem', this.props.index + 1)
    PubSub.publish('curveSize', this.props.next.curve_size);
  }

  onPreviousClick() {
    PubSub.publish('setActiveItem', this.props.index - 1)
    PubSub.publish('curveSize', this.props.previous.curve_size);
  }
}
