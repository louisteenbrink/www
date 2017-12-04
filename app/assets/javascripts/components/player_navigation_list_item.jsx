class PlayerNavigationListItem extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    var product_name = this.props.product.name;

    var componentClasses = classNames({
      'player-menu-item': true,
      'player-menu-item-active': this.props.selected,
    })

    return (
      <li className={componentClasses} onClick={this.handleClick.bind(this)}>{product_name}</li>
    )
  }

  handleClick() {
    this.props.goToProduct(this.props.product, true);
  }
}
