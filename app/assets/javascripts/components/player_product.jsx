class PlayerProduct extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    var batch = this.props.batch;
    var apply_to = "http://lewagon.com/apply/" + this.props.batch.city.slug

    return (
      <div className="player-product">
        <PlayerProductDetails technos={this.props.technos} batch={batch} product={this.props.product} i18n={this.props.i18n} />
        <a href={apply_to} className="apply-cta">{this.props.i18n.player_cta}</a>
      </div>
    )
  }
}
