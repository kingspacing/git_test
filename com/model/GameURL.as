package com.model{
	
	public class GameURL {
		
        private static const GAME_URL_HEAD:String = "com/res/game/";
		private static const GAME_ONE:String = "game1.swf";
		private static const GAME_TWO:String = "game2.swf";
		private static const GAME_THREE:String = "game3.swf";
		private static const SEPARATOR:String = "/"; 
		
		/*
		 *  GAME_FIRST 为啥不行嘞。。。
		 *  变量名重复（死循环）
		 */
		
		private var _chapter:String = "";
		
		public function GameURL() {
			
		}
		
		public function get GAME_FIRST():String
		{
			return GAME_URL_HEAD + chapter + SEPARATOR +  GAME_ONE;
		}
		
		public function get GAME_SECOND():String
		{
			return GAME_URL_HEAD + chapter + SEPARATOR + GAME_TWO;
		}
		
		public function get GAME_THIRD():String
		{
			return GAME_URL_HEAD + chapter + SEPARATOR + GAME_THREE;
		}
		
		public function get chapter():String
		{
			return this._chapter;
		}
		
		public function set chapter(chapter:String):void
		{
			this._chapter = chapter;
		}
	}
	
}
