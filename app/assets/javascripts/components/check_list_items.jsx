class CheckListItems extends React.Component {
  render() {
    return(
      <div>
        {this.props.items.map((item) => {
          return(
            <a href={item.href}>
              <div className='check-list-item'>
                <div className='check-list-item-label'>
                  {item.label}
                </div>
                <div className='checklist-status-container'>
                  <div className='check-list-status'>
                  </div>
                </div>
              </div>
            </a>
          )
        })}
      </div>
    )
  }
}

