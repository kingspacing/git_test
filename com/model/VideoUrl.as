package com.model{
	
	public class VideoUrl {
        
		private static const VIDEO_URL_HEAD:String = "com/res/video/";
		private static const START_VIDEO:String = "start.f4v";
		private static const SING_VIDEO:String = "sing.f4v";
		private static const FOLLOW_VIDEO:String = "magic.f4v";
		private static const MAGIC_VIDEO:String = "magic.f4v";
		private static const SEPARATOR:String = "/"; 
		private var _chapter:String = "";
		 
		public function get StartURL():String
		{
			return VideoUrl.VIDEO_URL_HEAD + chapter + SEPARATOR + START_VIDEO;
		}
		
		public function get SingURL():String
		{
			return VideoUrl.VIDEO_URL_HEAD + chapter + SEPARATOR + SING_VIDEO;
		}
		
		public function get FollowURL():String
		{
			return VideoUrl.VIDEO_URL_HEAD + chapter + SEPARATOR + FOLLOW_VIDEO;
		}
		
		public function get MagicURL():String
		{
			return VideoUrl.VIDEO_URL_HEAD + chapter + SEPARATOR + MAGIC_VIDEO;
		}
		
		public function get chapter():String
		{
			return this._chapter;
		}
		
		public function set chapter(chapter:String):void
		{
			this._chapter = chapter;
		}
		
		public function VideoUrl() {
		
		}
		
	}
	
}
