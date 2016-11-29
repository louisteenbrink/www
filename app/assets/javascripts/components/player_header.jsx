class PlayerHeader extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    var productDetails = null;
    if (this.props.batch.products.length > 0) {
      productDetails = <span className="product-details">
        {this.props.batch.products.length} <i>{this.props.i18n.product_label}</i>
      </span>
    }

    return (
      <div className="player-header">
        <div className="batch-info">
          <span className="batch-flag" dangerouslySetInnerHTML={{__html: this.props.flag_icon}}></span>
          <div className="batch-details">
            <span className="batch-name">Batch#{this.props.batch.id} <i>{this.props.batch.city.name}</i></span>
            <span className="batch-date">{this.props.batch.starts_at} - {this.props.batch.ends_at}</span>
          </div>
        </div>
        <div className="product-info">
          <i className="product-icon" dangerouslySetInnerHTML={{__html: this.props.product_icon}}></i>
          {productDetails}
        </div>
      </div>
    )
  }
}