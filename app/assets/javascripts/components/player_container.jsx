class PlayerContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      selectedProduct: null
    }
  }

  render() {

    var batch = this.props.batch;
    var products = this.props.batch.products;
    var i18n = this.props.i18n;
    var product_icon = this.props.product_icon;

    return (
      <div className="player-container">
        <PlayerHeader batch={batch} i18n={i18n} product_icon={product_icon} flag_icon={this.props.flag_icon} />
        <div className="player-content">
          <PlayerVideo youtube_video_id={this.props.batch.youtube_id} selectedProduct={this.state.selectedProduct} />
          <PlayerProduct batch={batch} product={this.state.selectedProduct} i18n={i18n} />
        </div>
        <PlayerNavigationList products={products} selectedProduct={this.state.selectedProduct}
           handleProductClick={this.handleProductClick} />
      </div>
    )
  }

  handleProductClick = (product) => {
    this.setState({ selectedProduct: product })
  }
}