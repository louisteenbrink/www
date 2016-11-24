class PlayerVideo extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      youtube_player: null
    }
  }

  componentWillReceiveProps(nextProps) {
    if (this.state.youtube_player) {
      if (nextProps.selectedProduct === null) {
        this.state.youtube_player.seekTo(0);
      } else {
        this.state.youtube_player.seekTo(demoday_timestamp);
      }
    }
  }

  componentDidMount() {
    var tag = document.createElement('script');

    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    window.onYouTubeIframeAPIReady = () => {

      player = new YT.Player('youtube-player', {
        height: '413',
        width: '640',
        videoId: this.props.youtube_video_id,
        events: {
          'onReady': ((event) => event.target.playVideo()),
        }
      });

      this.setState({ youtube_player: player });
    }
  }

  render() {

    return (
      <div className="player-video" id="youtube-player">

      </div>
    )
  }
}