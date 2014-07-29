package com.event {
	import flash.events.Event;
	
	public class FerrisEvent extends Event {
        
		
		/*
		 * 单元选择界面，选择其中一个单元
		 */
        public static const CHAPTER_CHANGE_EVENT:String = "chapterChangeEvent";
		
		/*
		 * 退出模块选择场景(进入单元选择场景)
		 */
		public static const EXIT_MODULE_SELECT_SCENE_EVENT:String = "exitModuleSelectSceneEvent";
		
		/*
		 * 退出游戏选择场景（进入模块选择场景）
		 */
		public static const EXIT_GAME_SELECT_SCENE_EVENT:String = "exitGameModuleEvent";
		 
		/*
		 * 进入游戏子模块
		 */
		public static const ENTER_SUB_GAME_EVENT:String = "enterSubGameEvent";
		
		/*
		 * 退出游戏子模块（退出其中一个游戏，返回游戏选择模块场景）
		 */
		 public static const EXIT_SUB_GAME_EVENT:String = "exitSubGameEvent";
		
		
		
		
		
		private var _data:*;
		
		public function FerrisEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		public function set data(data:*):void
		{
			this._data = data;
		}
		
		public function get data():*
		{
			return this._data;
		}
		
		override public function clone():Event
		{
			return new FerrisEvent(type, data, bubbles, cancelable);
		}
		
		override public function toString():String
		{
			return formatToString("FerrisEvent", "type", "data", "bubbles", "cancelable", "eventPhase"); 
		}
	}
	
}
