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
			
			var configFile:File = new File();
				configFile = File.applicationStorageDirectory;
				configFile = configFile.resolvePath("settings.xml");
			
			if (configFile.exists){
				var stream:FileStream = new FileStream();
					stream.open(configFile,FileMode.READ);
				var xml:XML = new XML(stream.readUTFBytes(stream.bytesAvailable));
				
				stream.close();
				
				this.rssURL = xml..rssURL.toString();
				
				configFile.deleteFile();
			}
			
		}
		
		public function set rssURL(value:String):void{
			saveProperty("rssURL",value);
			dispatchEvent(new Event("valueChanged"));
		}
		
		[Bindable (event="valueChanged")]
		public function get rssURL():String{
			var _rssURL:String = "";
			
			try {
				_rssURL = getProperty("rssURL");
			} catch (error:Error) {}
			
			return _rssURL;
		}
		
		public function set playSound(value:Boolean):void{
			saveProperty("playSound",value.toString());
			dispatchEvent(new Event("valueChanged"));
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
		
		public function set startOnLogin(value:Boolean):void{			
			saveProperty("startOnLogin",value.toString());
			dispatchEvent(new Event("valueChanged"));
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
		
		public function set bubbleInterval(value:Number):void{	
			saveProperty("bubbleInterval",value.toString());
			dispatchEvent(new Event("valueChanged"));
		}
		
		[Bindable (event="valueChanged")]
		public function get bubbleInterval():Number{
			var _bubbleInterval:Number = 600000;
			
			try {
				_bubbleInterval = Number(getProperty("bubbleInterval"));
			} catch (error:Error) {}
			
			return _bubbleInterval;
		}
		
		public function set alertColor(value:uint):void{	
			saveProperty("alertColor",value.toString());
			dispatchEvent(new Event("valueChanged"));
		}
		
		[Bindable (event="valueChanged")]
		public function get alertColor():uint{
			var _alertColor:Number = 0x3D004F;
			
			try {
				_alertColor = uint(getProperty("alertColor"));
			} catch (error:Error) {}
			
			return _alertColor;
		}
		
		public function set blinkIconOnTurn(value:Boolean):void{			
			saveProperty("blinkIconOnTurn",value.toString());
			dispatchEvent(new Event("valueChanged"));
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
		
		public function set sounds(value:Array):void{
			saveProperty("soundArray",value.toString());
			dispatchEvent(new Event("valueChanged"));
		}
		
		[Bindable (Event="valueChanged")]
		public function get sounds():Array{
			var _soundsArray:Array = ["test_file.mp3","test_file2.mp3"];
			
			try {
				_soundsArray = getProperty("soundArray") as Array;
			} catch (error:Error){}
			return _soundsArray;
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