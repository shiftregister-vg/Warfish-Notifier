package vo
{
	import flash.data.EncryptedLocalStore;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public class WarfishConfig extends EventDispatcher
	{	
		public function WarfishConfig(){
			
		}
		
		[Bindable (event="valueChanged")]
		public function get rssURL():String{
			var _rssURL:String = "";
			
			try {
				_rssURL = getProperty("rssURL");
			} catch (error:Error) {}
			
			return _rssURL;
		}
		
		[Bindable (event="valueChanged")]
		public function get playSound():Boolean{
			var _playSound:Boolean = true;
			
			try {
				if (getProperty("playSound") == "false"){
					_playSound = false;
				}
			} catch (error:Error) {}
			
			return _playSound;
		}
		
		[Bindable (event="valueChanged")]
		public function get startOnLogin():Boolean{
			var _startOnLogin:Boolean = true;
			
			try {
				if (getProperty("startOnLogin") == "false"){
					_startOnLogin = false;
				}
			} catch (error:Error) {}
			
			return _startOnLogin;
		}
		
		[Bindable (event="valueChanged")]
		public function get bubbleInterval():Number{
			var _bubbleInterval:Number = 600000;
			
			try {
				_bubbleInterval = Number(getProperty("bubbleInterval"));
			} catch (error:Error) {}
			
			return _bubbleInterval;
		}
		
		[Bindable (event="valueChanged")]
		public function get alertColor():uint{
			var _alertColor:Number = 0x3D004F;
			
			try {
				_alertColor = uint(getProperty("alertColor"));
			} catch (error:Error) {}
			
			return _alertColor;
		}
		
		[Bindable (event="blinkIconOnTurn")]
		public function get blinkIconOnTurn():Boolean{
			var _blinkIconOnTurn:Boolean = true;
			
			try {
				if (getProperty("blinkIconOnTurn") == "false"){
					_blinkIconOnTurn = false;
				}
			} catch (error:Error) {}
			
			return _blinkIconOnTurn;
		}
		
		private function saveProperty(name:String,value:String):void{
			var bytes:ByteArray = new ByteArray();
				bytes.writeUTFBytes(value.toString());
			EncryptedLocalStore.setItem(name,bytes);
		}
		
		private function getProperty(name:String):String{
			var storedValue:ByteArray = EncryptedLocalStore.getItem(name);
			var valString:String = storedValue.readUTFBytes(storedValue.length);
			return valString;
		}
	}
}