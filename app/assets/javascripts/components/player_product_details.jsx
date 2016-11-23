class PlayerProductDetails extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    if (this.props.product === null) {
      return  (
        <div className="product-details">
          <h3 className="project-name">DemoDay <small>Batch#{this.props.batch.id}</small></h3>
          <span className="project-tagline">{this.props.i18n.batch_intro}</span>
        </div>
      )
    } else {
      var product_name = this.props.product["name"];
      var tagline = this.props.product["tagline_en"];
      var product_url = this.props.product["url"];
      var makers = this.props.product.makers

      return (
        <div className="product-details">
          <ul className="product-team">
            { makers.map(function(maker, index){
              return <PlayerProductMaker key={index} maker={maker}/>
            })
          }
          </ul>
          <h3 className="project-name">{product_name}</h3>
          <span className="project-tagline">{tagline}</span>
          <a href={product_url} target="_blank" className="project-link">{this.props.i18n.project_link}</a>
          <div className="project-techno">
            <span>{this.props.i18n.project_techno}</span>
            <ul>
              {/* <li><span>render "shared/icon_react"<i>React</i></span></li> */}
            </ul>
          </div>
        </div>
      )
    }
  }
}