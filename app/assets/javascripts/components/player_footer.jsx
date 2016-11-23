class PlayerFooter extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    var products = this.props.products;

    return (
      <div className="player-menu">
        <PlayerNavigationList products={products} selectedProduct={this.props.selectedProduct} />
      </div>
    )
  }
}