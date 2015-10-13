class CheckListItems extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      isChecked: false
    }
  }
  render() {
    return(
      <div>
        {this.props.items.map((item) => {
          var itemClasses = classNames({
            'check-list-item': true,
            'is-checked': this.state.isChecked
          })
          return(
            <CheckListItem {... item} />
          )
        })}
      </div>
    )
  }

  handleClick() {
    this.setState({ isChecked: true })
  }
}

