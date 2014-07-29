package com.control{
	import com.view.game.GameLoader;
	import flash.display.MovieClip;
	
	public class GameController {

        public var gameLoader:GameLoader;

		public function GameController() {
			gameLoader = new GameLoader("");
		}
		
		public function control(param:String):void
		{
			(gameLoader._loader.content as MovieClip).getData(param);
		}
	}
	
}
