class PlayerHeader extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    return (
      <div className="player-header">
        <div className="batch-info">
          <span className="batch-flag">
            // TODO
          </span>
          <div className="batch-details">
            <span className="batch-name">Batch#{this.props.batch.id} <i>{this.props.batch.city.name}</i></span>
            <span className="batch-date">{this.props.batch.schedule_slug}</span>
          </div>
        </div>
        <div className="product-info">
          <i className="product-icon" dangerouslySetInnerHTML={{__html: this.props.product_icon}}></i>
          <span className="product-details">
            {this.props.batch.products.length} <i>{this.props.i18n.product_label}</i>
          </span>
        </div>
      </div>
    )
  }
}