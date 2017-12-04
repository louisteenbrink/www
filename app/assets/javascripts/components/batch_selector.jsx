class BatchSelector extends React.Component {

  render() {
    var batch = this.props.batch;

    var componentClasses = classNames({
      'input-selector-item': true,
      'is-selected': this.props.isActive,
      'is-full': batch.apply_status === 'full'
    });

    if (batch.special_message) {
      var right_item = <div className='last-seats'>{batch.special_message}</div>;
    }
    else if (batch.apply_status === 'full') {
      var right_item = <div className='last-seats'>FULL</div>;
    }
    else if (batch.apply_status === 'waiting_list') {
      if (this.props.isActive) {
        var right_item = <div className='last-seats'>waiting list <i className='fa fa-check'/></div>;
      } else {
        var right_item = <div className='last-seats'>waiting list</div>;
      }
    }
    else if (batch.apply_status === 'last_seats') {
      if (this.props.isActive) {
        var right_item = <div className='last-seats'>last seats! <i className='fa fa-check'/></div>;
      } else {
        var right_item = <div className='last-seats'>last seats!</div>;
      }
    }
    else if (this.props.isActive) {
      var right_item = <div className='last-seats'><i className='fa fa-check'/></div>;
    }
    return(
      <div
        className={componentClasses}
        ref='selectType'
        value={batch.id}
        onClick={this.handleClick.bind(this)}
      ><strong>{ moment(batch.starts_at).locale(this.props.locale).format('LL') }</strong><span> - </span><strong>{ moment(batch.ends_at).locale(this.props.locale).format('LL') }</strong>{right_item}</div>
    )
  }


  handleClick(e) {
    if (this.props.batch.apply_status != "full" && !this.props.isActive) {
      PubSub.publish('setActiveBatch', this.props.batch)
    }
  }
}
