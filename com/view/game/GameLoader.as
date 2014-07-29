package com.view.game{
	
	import flash.display.MovieClip;	
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	
	public class GameLoader extends MovieClip {

        public var _loader:Loader;
		private var _gameURL:String;
		private var _request:URLRequest;

		public function GameLoader(url:String) {
			this._gameURL = url;
			if (stage)
			{
				onAdded(null);
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onAdded);
			}
		}
		
		private function onAdded(event:Event=null):void
		{
			_request = new URLRequest();
			_request.url = _gameURL;
			_loader = new Loader();
			_loader.load(_request);
			addChild(_loader);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
		}
		
		private function onComplete(event:Event):void
		{
			trace ("game load complete!");
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			trace (this, event);
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			var progress:String = (event.bytesLoaded / event.bytesTotal) * 100 + "%";
			trace ("游戏加载中。。。已完成 ：" + progress);
		}
	}
	
}
