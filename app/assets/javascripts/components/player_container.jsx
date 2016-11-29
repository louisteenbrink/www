class PlayerContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      selectedProduct: this.props.selectedProdutSlug === null ? null :
        _.filter(this.props.batch.products, (p) => { return p.slug == this.props.selectedProdutSlug })[0]
    }
  }

  render() {

    var batch = this.props.batch;
    var products = this.props.batch.products;
    var i18n = this.props.i18n;
    var product_icon = this.props.product_icon;

    var main = null;
    if (this.props.batch.youtube_id) {
      main = <PlayerVideo youtube_video_id={this.props.batch.youtube_id} selectedProduct={this.state.selectedProduct} />
    } else {
      main = "";
    }

    var footerNavigation = null;
    if (products.length > 0) {
      footerNavigation = <PlayerNavigationList products={products} selectedProduct={this.state.selectedProduct}
           goToProduct={this.goToProduct} />;
    }

    return (
      <div className="player-container">
        <PlayerHeader batch={batch} i18n={i18n} product_icon={product_icon} flag_icon={this.props.flag_icon} />
        <div className="player-content">
          {main}
          <PlayerProduct batch={batch} product={this.state.selectedProduct} i18n={i18n} />
        </div>
        {footerNavigation}
      </div>
    )
  }

  goToProduct = (product) => {
    this.setState({ selectedProduct: product })
  }
}