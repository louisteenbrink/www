class CheckListItems extends React.Component {
  render() {
    return(
      <div>
        {this.props.items.map((item) => {
          return(
            <div className='check-list-item'>
              <div class='check-list-item-label'>
                {item.label}
              </div>
              <div class='check-list-status is-checked'>
                <a href={item.url}>Go</a>
              </div>
            </div>
          )
        })}
      </div>
    )
  }
}
