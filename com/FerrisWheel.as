package com
{

	import flash.external.ExternalInterface;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	import com.view.common.CommonPlayer;
	import com.model.VideoUrl;
	import com.event.FerrisEvent;
	import com.view.player.VideoState;
	import com.view.game.GameLoader;
	import com.model.GameURL;
	import com.control.GameController;


	public class FerrisWheel extends MovieClip
	{
        private var _seekTimer:Timer = new Timer(1000,2);

		private var commonPlayer:CommonPlayer;
		private var currentChapter:String;
		private var _videoURL:VideoUrl = new VideoUrl();
		private var gameLoader:GameLoader;
		private var _gameURL:GameURL = new GameURL();
		
		//退出小游戏
		[Event("EXIT_GAME")]
		
		public function FerrisWheel()
		{
			ExternalInterface.addCallback("iCall", iCall);      
			init();    
		}

		private function init():void
		{
			tabEnabled = false;
			tabChildren = false;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			addChapterSelectSceneListener();
		}

        /*
		 * 键盘事件处理
		 */
		private function keyDownHandler(event:KeyboardEvent):void
		{
			if (!commonPlayer)
			{
				return;
			}

			var keycode:uint = event.keyCode;
			switch (keycode)
			{
				case Keyboard.LEFT :
				    commonPlayer._videoplayer.fadeIn();
					commonPlayer._videoplayer.seekVideo(VideoState.SEEK_BACK);
					seekHandler();
					break;
					
				case Keyboard.RIGHT :
				    commonPlayer._videoplayer.fadeIn();
					commonPlayer._videoplayer.seekVideo(VideoState.SEEK_FRONT);
					seekHandler();
					break;
					
				case Keyboard.UP :
					removeCommonPlayer();
					break;
					
				case Keyboard.SPACE :
					commonPlayer._videoplayer.changeVideoState();
					break;
					
				default :
					break;
			}
		}
		
		private function seekHandler():void
		{
			if (_seekTimer.running){
				_seekTimer.stop();
				_seekTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onSeekComplete);
			}
			_seekTimer.reset();
			_seekTimer.start();
			_seekTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onSeekComplete);
		}
		
		private function onSeekComplete(event:TimerEvent):void
		{
			if (commonPlayer)
			{
				commonPlayer._videoplayer.fadeOut();
			    _seekTimer.stop();
			    _seekTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onSeekComplete);
			}
		}

		private function removeCommonPlayer():void
		{
			if (commonPlayer)
			{
				if (this.contains(commonPlayer))
				{
					this.removeChild(commonPlayer);
					commonPlayer = null;
				}
			}
		}

		private function addChapterSelectSceneListener():void
		{
			chapterBtn1.addEventListener(MouseEvent.CLICK, chapterSelectHandler);
			chapterBtn2.addEventListener(MouseEvent.CLICK, chapterSelectHandler);
			chapterBtn3.addEventListener(MouseEvent.CLICK, chapterSelectHandler);
			chapterBtn4.addEventListener(MouseEvent.CLICK, chapterSelectHandler);
			chapterBtn5.addEventListener(MouseEvent.CLICK, chapterSelectHandler);
			chapterBtn6.addEventListener(MouseEvent.CLICK, chapterSelectHandler);
			chapterBtn7.addEventListener(MouseEvent.CLICK, chapterSelectHandler);
			chapterBtn8.addEventListener(MouseEvent.CLICK, chapterSelectHandler);
			chapterBtn9.addEventListener(MouseEvent.CLICK, chapterSelectHandler);
			chapterBtn10.addEventListener(MouseEvent.CLICK, chapterSelectHandler);

			addEventListener(FerrisEvent.CHAPTER_CHANGE_EVENT, chapterChangeHandler);
		}

		private function addModuleSelectSceneListener():void
		{
			startBtn.addEventListener(MouseEvent.CLICK, moduleSelectHandler);
			singBtn.addEventListener(MouseEvent.CLICK, moduleSelectHandler);
			followBtn.addEventListener(MouseEvent.CLICK, moduleSelectHandler);
			magicBtn.addEventListener(MouseEvent.CLICK, moduleSelectHandler);
			playBtn.addEventListener(MouseEvent.CLICK, moduleSelectHandler);
			backBtn.addEventListener(MouseEvent.CLICK, onBackToChapterSelectScene);

			addEventListener(FerrisEvent.EXIT_MODULE_SELECT_SCENE_EVENT, exitModuleSelectSceneHandler);
		}

		private function addGameSelectSceneListener():void
		{
			gameBtn1.addEventListener(MouseEvent.CLICK, gameSelectHandler);
			gameBtn2.addEventListener(MouseEvent.CLICK, gameSelectHandler);
			gameBtn3.addEventListener(MouseEvent.CLICK, gameSelectHandler);
			backBtn.addEventListener(MouseEvent.CLICK, onBackToModuleSelectScene);

            addEventListener("EXIT_GAME", exitGame);

			addEventListener(FerrisEvent.EXIT_GAME_SELECT_SCENE_EVENT, onExitGameModule);//退出游戏选择场景
			addEventListener(FerrisEvent.EXIT_SUB_GAME_EVENT, onBackToGameSelectScene);//退出当前游戏进入游戏选择场景
		}
		
		private function exitGame(event:Event):void
		{
			removeGameLoader();
		}

		private function gameSelectHandler(event:MouseEvent):void
		{
			var btnName:String = event.target.name;
			var url:String;
			switch (btnName)
			{
				case "gameBtn1" :
					url = _gameURL.GAME_FIRST;
					break;
				case "gameBtn2" :
					url = _gameURL.GAME_SECOND;
					break;
				case "gameBtn3" :
					url = _gameURL.GAME_THIRD;
					break;
				default :
					break;
			}
			createGameLoader(url);
		}

		private function createGameLoader(url:String):void
		{
			removeGameLoader();
			gameLoader = new GameLoader(url);
			addChild(gameLoader);
			this.setChildIndex(gameLoader, numChildren - 1);   
		}

		/*
		 * 退出游戏场景事件派发
		 */
		private function onBackToModuleSelectScene(event:MouseEvent):void
		{
			dispatchEvent(new FerrisEvent(FerrisEvent.EXIT_GAME_SELECT_SCENE_EVENT,null,false,false));
		}

		/*
		 * 退出模块选择场景进入单元选择场景事件派发
		 */
		private function onBackToChapterSelectScene(event:MouseEvent):void
		{
			dispatchEvent(new FerrisEvent(FerrisEvent.EXIT_MODULE_SELECT_SCENE_EVENT,null,false,false));
		}

		/*
		 * 退出当前游戏进入游戏选择场景（相当于同一场景中移除子游戏）
		 */
		private function onBackToGameSelectScene(event:FerrisEvent):void
		{
			removeGameLoader();
		}

		/*
		 * 退出游戏选择场景进入模块选择场景
		 */
		private function onExitGameModule(event:FerrisEvent):void
		{
			this.gotoAndStop(1, "subScene");
			addModuleSelectSceneListener();
		}

		private function removeGameLoader():void
		{
			if (gameLoader)
			{
				if (contains(gameLoader))
				{
					gameLoader._loader.unloadAndStop(true);
					this.removeChild(gameLoader);
					gameLoader = null;
				}
			}
		}

		/****************************************************************************************/

		/*
		 * 模块选择处理
		 */
		private function moduleSelectHandler(event:MouseEvent):void
		{
			var btnName:String = event.target.name;

			if (btnName != "playBtn")
			{
				createCommonPlayer();
			}

			switch (btnName)
			{
				case "startBtn" :
					commonPlayer.videoURL = _videoURL.StartURL;
					break;
				case "singBtn" :
					commonPlayer.videoURL = _videoURL.SingURL;
					break;
				case "followBtn" :
					commonPlayer.videoURL = _videoURL.FollowURL;
					break;
				case "magicBtn" :
					commonPlayer.videoURL = _videoURL.MagicURL;
					break;
				case "playBtn" :
					this.gotoAndStop(1, "gameScene");
					addGameSelectSceneListener();
					break;
				default :
					break;
			}

		}

		/*
		 * 创建通用播放器
		 */
		private function createCommonPlayer():void
		{
			if (commonPlayer)
			{
				if (this.contains(commonPlayer))
				{
					removeChild(commonPlayer);
					commonPlayer = null;
				}
			}
			commonPlayer = new CommonPlayer();
			commonPlayer.x = 0;
			commonPlayer.y = 0;
			addChild(commonPlayer);
		}

		/**
		 * 退出模块选择场景，跳转到单元选择界面
		 */
		private function exitModuleSelectSceneHandler(event:FerrisEvent):void
		{
			this.gotoAndStop(1, "mainScene");
			addChapterSelectSceneListener();
		}

		/*****************************************************************************************/


		/*
		 * 单元选择事件派发
		 */
		private function chapterSelectHandler(event:MouseEvent):void
		{
			var btnName:String = event.target.name;
			dispatchEvent(new FerrisEvent(FerrisEvent.CHAPTER_CHANGE_EVENT, btnName, false,false));
		}

		/*
		 * 单元选择事件处理
		 */
		private function chapterChangeHandler(event:FerrisEvent):void
		{
			var name:String = event.data;
			switch (name)
			{
				case "chapterBtn1" :
					currentChapter = "chapter1";
					break;

				case "chapterBtn2" :
					currentChapter = "chapter2";
					break;

				case "chapterBtn3" :
					currentChapter = "chapter3";
					break;

				case "chapterBtn4" :
					currentChapter = "chapter4";
					break;

				case "chapterBtn5" :
					currentChapter = "chapter5";
					break;

				case "chapterBtn6" :
					currentChapter = "chapter6";
					break;

				case "chapterBtn7" :
					currentChapter = "chapter7";
					break;

				case "chapterBtn8" :
					currentChapter = "chapter8";
					break;

				case "chapterBtn9" :
					currentChapter = "chapter9";
					break;

				case "chapterBtn10" :
					currentChapter = "chapter10";
					break;

				default :
					break;
			}
			_videoURL.chapter = currentChapter;
			_gameURL.chapter = currentChapter;
			this.gotoAndStop(1, "subScene");
			
			//跳转场景到模块选择场景;
			addModuleSelectSceneListener();//添加模块选择场景事件监听
		}

		public function iCall(param:String):void
		{
			if (gameLoader)
			{
				if (gameLoader._loader.content)
				{
					(gameLoader._loader.content as MovieClip).setData(param);
				}
			}
		}
	}

}