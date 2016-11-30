class PlayerBatchSelector extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedLocale: this.props.locales.filter((locale) => { return locale.code === this.props.selectedBatch.city.course_locale })[0],
      selectedBatch: this.props.selectedBatch
    }
  }

  render() {
    var otherLocales = this.props.locales.filter((locale) => { return locale.code !== this.state.selectedLocale.code });
    var otherBatches = this.props.batches.filter((batch) => { return batch.city.course_locale === this.state.selectedLocale.code && (!this.state.selectedBatch || batch.slug !== this.state.selectedBatch.slug) });

    var languageSelector =
      <ReactBootstrap.Dropdown id="languageSelector" ref="languageSelector">
        <ReactBootstrap.Dropdown.Toggle className="dropdown-batch">
          <span dangerouslySetInnerHTML={{__html: this.state.selectedLocale.icon + '<i>' + this.state.selectedLocale.name + '</i>'}}></span>
        </ReactBootstrap.Dropdown.Toggle>
        <ReactBootstrap.Dropdown.Menu>
          {otherLocales.map((locale, index) => {
            return <li key={index} onClick={() => this.changeLanguage(locale)}>
              <span dangerouslySetInnerHTML={{__html: locale.icon}}></span>
              {locale.name}
            </li>
          })}
        </ReactBootstrap.Dropdown.Menu>
      </ReactBootstrap.Dropdown>;

    var batchSelectorToggle = <ReactBootstrap.Dropdown.Toggle className="dropdown-batch">
        <span>{this.props.i18n.choose_batch}</span>
      </ReactBootstrap.Dropdown.Toggle>;

    if (this.state.selectedBatch) {
        var batchSelectorToggle = <ReactBootstrap.Dropdown.Toggle className="dropdown-batch">
            <img src={this.state.selectedBatch.city.city_picture.replace('development', 'production')} className="city-thumbnail" />
            <div>
              <div>{this.state.selectedBatch.city.name} <i className="city-batch">Batch#{this.state.selectedBatch.slug}</i></div>
              <small>{this.state.selectedBatch.starts_at} - {this.state.selectedBatch.ends_at}</small>
            </div>
          </ReactBootstrap.Dropdown.Toggle>;
    }

    var batchSelector =
      <ReactBootstrap.Dropdown id="batchSelector" ref="batchSelector">
        {batchSelectorToggle}
        <ReactBootstrap.Dropdown.Menu>
          {otherBatches.map((batch, index) => {
            return <li key={index} onClick={() => this.changeBatch(batch)}>
              <img src={batch.city.city_picture.replace('development', 'production')} className="city-thumbnail" />
              <div>
                <div>{batch.city.name} <i className="city-batch">Batch#{batch.slug}</i></div>
                <small>{batch.starts_at} - {batch.ends_at}</small>
              </div>
            </li>
          })}
        </ReactBootstrap.Dropdown.Menu>
      </ReactBootstrap.Dropdown>;

    return <div className="dropdown-section">
      <div className="dropdown-container">
        {languageSelector}
      </div>
      <div className="dropdown-container">
        {batchSelector}
      </div>
    </div>;
  }

  changeLanguage(locale) {
    this.setState({ selectedLocale: locale, selectedBatch: null });
    this.refs.languageSelector._values.open = false; // toggle dropdown
  }

  changeBatch(batch) {
    this.setState({ selectedBatch: batch });
    this.refs.batchSelector._values.open = false; // toggle dropdown

    var path = this.props.demodayPath.replace(':slug', batch.slug);
    $.getScript(path);

    var title = this.props.i18n.page_title.replace('%{batch_slug}', batch.slug)
                                          .replace('%{city_name}', batch.city.name);
    document.title = title;
    history.replaceState({}, title, path);
  }
}
