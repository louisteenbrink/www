class PlayerProductDetails extends React.Component {
  constructor(props) {
    super(props)
  }

  componentDidUpdate(prevProps, prevState) {
    $('[data-toggle="tooltip"]').tooltip();
  }

  render() {
    if (this.props.product === null || this.props.product === ':intro:') {
      var text = this.props.i18n.batch_intro.replace('%{count}', this.props.students.length)
                                            .replace('%{city_name}', this.props.batch.city.name)
                                            .replace('%{batch_start_date}', this.props.batch.starts_at)
                                            .replace('%{batch_end_date}', this.props.batch.ends_at);

      return  (
        <div className="product-details">
          <h3 className="project-name">DemoDay <small>Batch#{this.props.batch.slug}</small></h3>
          <span className="project-tagline">{text}</span>
        </div>
      )
    } else {
      var product_name = this.props.product.name;
      var tagline = this.props.product.tagline;
      var product_url = this.props.product.url;
      var makers = this.props.product.makers

      var technos = null;

      if (this.props.product.technos && this.props.product.technos.length >= 1) {
        technos = <div className="project-techno">
            <span>{this.props.i18n.project_techno}</span>
            <ul>
              {this.props.product.technos.map((techno, index) => {
                return <span key={index} dangerouslySetInnerHTML={{__html: this.props.technos[techno].icon }} data-toggle="tooltip" data-placement="bottom" data-original-title={this.props.technos[techno].name}></span>
              })}
            </ul>
          </div>;
      }

      return (
        <div className="product-details">
          <ul className="product-team">
            { makers.map(function(maker, index){
              if (maker.hide_public_profile === false) {
                return <PlayerProductMaker key={index} maker={maker}/>
              }
            })
          }
          </ul>
          <h3 className="project-name">{product_name}</h3>
          <span className="project-tagline">{tagline}</span>
          <a href={product_url} target="_blank" className="project-link">{this.props.i18n.project_link}</a>
          {technos}
        </div>
      )
    }
  }
}
