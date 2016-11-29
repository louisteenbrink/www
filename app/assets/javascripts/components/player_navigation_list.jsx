class PlayerNavigationList extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    var products = this.props.products;

    var componentClasses = classNames({
      'player-menu-item': true,
      'player-menu-item-active': this.props.selectedProduct === null,
    })

    return (
      <div className="player-menu">
        <ul className="player-menu-summary">
          <li className={componentClasses} onClick={() => this.props.handleProductClick(null)}>Intro</li>
          { products.map((product, index) => {
              return <PlayerNavigationListItem
                        key={index}
                        product={product}
                        selected={product === this.props.selectedProduct}
                        goToProduct={this.props.goToProduct} />;
            })
          }
        </ul>
      </div>
    )
  }
}