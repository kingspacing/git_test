package com.view.common {
	import flash.display.MovieClip;
	import com.view.player.VideoPlayer;
	import flash.events.Event;
	
	public class CommonPlayer extends MovieClip {

        private var _videoURL:String;
		public var _videoplayer:VideoPlayer;
        
		public function CommonPlayer() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			if (!_videoplayer)
			{
				_videoplayer = new VideoPlayer();
				_videoplayer.x = 0;
				_videoplayer.y = 0;
				addChild(_videoplayer);
			}
		}
		
		public function set videoURL(value:String):void
		{
			this._videoURL = value;
			_videoplayer.videoURL = this._videoURL;
		}

	}
	
}
