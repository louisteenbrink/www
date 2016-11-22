class PlayerContainer extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    var batch = this.props.batch;
    var i18n = this.props.i18n;
    var product_icon = this.props.product_icon;

    return (
      <div className="player-container">
        <PlayerHeader batch={batch} i18n={i18n} product_icon={product_icon} />
        <div className="player-content">
          <PlayerVideo />
          <PlayerProduct i18n={i18n} />
        </div>
      </div>
    )
  }
}