package vo
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class WarfishConfig extends EventDispatcher
	{
		private var __prefsFile:File = new File();
		private var __prefsXML:XML = new XML();
		
		public function WarfishConfig()
		{
			__prefsFile = File.applicationStorageDirectory;
			__prefsFile = __prefsFile.resolvePath("settings.xml");
			readXML();
		}
		
		public function set rssURL(value:String):void{
			
			__prefsXML = XML('<settings>\n<rssURL>' + value + '</rssURL>\n</settings>');
			saveXML();
			
			dispatchEvent(new Event("valueChanged"));
		}
		
		[Bindable (event="valueChanged")]
		public function get rssURL():String{
			return __prefsXML.rssURL.toString();
		}
		
		private function readXML():void{
			var stream:FileStream;
			
			if (!__prefsFile.exists){
				var starterXML:String = '<settings>\n<rssURL></rssURL>\n</settings>';
				__prefsXML = XML(starterXML);
				saveXML();
			}
			
			stream = new FileStream();
			stream.open(__prefsFile,FileMode.READ);
			__prefsXML = XML(stream.readUTFBytes(stream.bytesAvailable));
			stream.close();
		}
		
		private function saveXML():void{
			var outputString:String = '<?xml version="1.0" encoding="utf-8"?>\n';
				outputString += __prefsXML.toXMLString();
				outputString = outputString.replace(/\n/g, File.lineEnding);
			var stream:FileStream;
			stream = new FileStream();
			stream.open(__prefsFile,FileMode.WRITE);
			stream.writeUTFBytes(outputString);
			stream.close();
		}
	}
}