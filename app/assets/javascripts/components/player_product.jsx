class PlayerProduct extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    return (
      <div className="player-product">
        <div className="product-details">
        </div>
        <div className="apply-cta">
          <span>{this.props.i18n.player_cta}</span>
        </div>
      </div>
    )
  }
}