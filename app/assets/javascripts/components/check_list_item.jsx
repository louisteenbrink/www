class CheckListItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      isChecked: false
    }
  }
  render() {
    var componentClasses = classNames({
      'check-list-item': true,
      'is-checked': this.state.isChecked
    })

    var stateText = this.state.isChecked ? 'DONE' : 'TO DO'
    return(
        <a href={this.props.href} target='_blank'>
          <div className={componentClasses} onClick={this.handleClick.bind(this)}>
            <div className='check-list-item-label'>
              {this.props.label}
            </div>
            <div className='checklist-status-container hidden-xs hidden-sm'>
              <span className='check-list-todo'>{stateText}</span>
              <div className='check-list-status'>
                <i className='fa fa-check'></i>
              </div>
            </div>
          </div>
        </a>
    )
  }

  handleClick() {
    setTimeout(() => {
      this.setState({ isChecked: true })
    }, 1000)
  }
}

