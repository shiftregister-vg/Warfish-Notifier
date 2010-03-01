package managers
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.controls.Alert;

	public class UpdateManager
	{
		public var manifestURL:String;
		private var manifest:XML;
		private var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		
		public function UpdateManager(){
			
		}
		
		public function checkForUpdate():void{
			if (!manifestURL){
				var manifestError:Error = new Error("manifestURL was not supplied");
				throw manifestError;
			} else {
				appUpdater.updateURL = manifestURL + "?rnd=" + Math.random();
				appUpdater.isCheckForUpdateVisible = false;
				appUpdater.addEventListener(UpdateEvent.INITIALIZED,onUpdate);
				appUpdater.addEventListener(ErrorEvent.ERROR,onError);
				appUpdater.initialize();
			}
		}
		
		private function onUpdate(event:UpdateEvent):void{
			appUpdater.checkNow();
		}
		
		private function onError(event:ErrorEvent):void{
			Alert.show(event.toString());
		}
	}
}