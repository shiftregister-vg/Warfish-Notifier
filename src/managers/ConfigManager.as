package managers
{
	import events.ConfigEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import views.ConfigWindow;
	
	import vo.Config;
	import vo.WarfishConfig;
	
	public class ConfigManager extends ManagerBase
	{
		private var _warfishConfig:WarfishConfig;
		private var _config:Config;
		private var _configWindow:ConfigWindow;
		private var _updateBtnLbl:String = "Check for Update";
		
		public function ConfigManager(target:IEventDispatcher=null){
			super(target);
			
			NativeApplication.nativeApplication.autoExit = true;
			
			loadConfig();
			
			if (!config){
				config = new Config();
				_warfishConfig = new WarfishConfig();
				if (_warfishConfig.rssURL.length){
					config.rssURL = _warfishConfig.rssURL;
					config.alertColor = _warfishConfig.alertColor;
					config.blinkIconOnTurn = _warfishConfig.blinkIconOnTurn;
					config.bubbleInterval = _warfishConfig.bubbleInterval;
					config.playSound = _warfishConfig.playSound;
					config.startOnLogin = _warfishConfig.startOnLogin;
				}
				saveConfig(config);
			}
			
			if (!config.rssURL.length){
				dispatchEvent(new ConfigEvent(ConfigEvent.OPEN_CONFIG_WINDOW));
			}
		}
		
		public function set config(value:Config):void{
			_config = value;
			dispatchEvent(new Event("configChanged"));
		}
		
		[Bindable (event="configChanged")]
		public function get config():Config{
			return _config;
		}
		
		public function setUpdateBtnLbl(value:String):void{
			_updateBtnLbl = value;
			dispatchEvent(new Event("updateBtnLblValueChanged",false));
		}
		
		[Bindable (Event="updateBtnLblValueChanged")]
		public function get updateBtnLbl():String{
			return _updateBtnLbl;
		}
		
		public function loadConfig():void{
			var file:File = File.applicationStorageDirectory.resolvePath('warfishConfig.ri');
			if (file.exists){
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				config = fileStream.readObject();
				fileStream.close();
			}
		}
		
		public function saveConfig(value:Config):void{
			var timer:Timer = new Timer(100,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,function(event:TimerEvent):void{
				var file:File = File.applicationStorageDirectory.resolvePath('warfishConfig.ri');
				var fileStream:FileStream = new FileStream();
				var byteArray:ByteArray = new ByteArray();
				byteArray.writeObject(value);
				fileStream.open(file, FileMode.WRITE);
				fileStream.writeBytes( byteArray );
				fileStream.close();
				dispatchEvent(new Event("configChanged"));
			});
			timer.start();
		}
	}
}