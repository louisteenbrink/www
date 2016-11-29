class PlayerContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      jump: false,
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
      main = <PlayerVideo
                jump={this.state.jump}
                youtubeVideoId={this.props.batch.youtube_id}
                selectedProduct={this.state.selectedProduct}
                reportCurrentTime={this.reportCurrentTime} />
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

  goToProduct = (product, jump) => {
    this.setState({ selectedProduct: product, jump: jump });
    if (product === null) {
      var path = this.props.demodayPath;
      var title = this.props.i18n.page_title.replace('%{batch_slug}', this.props.batch.slug)
                                            .replace('%{city_name}', this.props.batch.city.name);
    } else {
      var path = this.props.withSlugDemodayPath.replace(':slug', product.slug);
      var title = this.props.i18n.page_title_with_selected_product
        .replace('%{product_name}', product.name)
        .replace('%{batch_slug}', this.props.batch.slug)
        .replace('%{city_name}', this.props.batch.city.name);
    }

    document.title = title;
    history.replaceState({}, title, path);
  }

  reportCurrentTime = (time) => {
    var currentProduct = null;
    var products = this.props.batch.products;
    for (var i = 0; i < products.length; i++) {
      var product = products[i];
      if (product.demoday_timestamp <= time && (i == products.length - 1 || time < products[i + 1].demoday_timestamp)) {
        currentProduct = product;
        break;
      }
    }

    if (this.state.selectedProduct !== currentProduct) {
      this.goToProduct(currentProduct, false);
    }
  }
}
