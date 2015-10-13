class BatchSelector extends React.Component {

  render() {
    var batch = this.props.batch;

    var componentClasses = classNames({
      'input-selector-item': true,
      'is-selected': this.props.isActive,
      'is-full': batch.full
    });

    if (batch.full) {
      var right_item = <div className='last-seats'>FULL</div>;
    }
    else if (this.props.isActive  ) {
      var right_item = <div className='last-seats'><i className='fa fa-check'/></div>;
    }
    else if (batch.last_seats) {
      var right_item = <div className='last-seats'>last seats!</div>;
    }

    return(
      <div
        className={componentClasses}
        ref='selectType'
        value={batch.id}
        onClick={this.handleClick.bind(this)}
      >
        from <strong>{ batch.starts_at }</strong> to <strong>{ batch.ends_at  }</strong>
        {right_item}
      </div>
    )
  }


  handleClick(e) {
    if (!this.props.batch.full && !this.props.isActive) {
      PubSub.publish('setActiveBatch', this.props.batch)
    }
  }
}
