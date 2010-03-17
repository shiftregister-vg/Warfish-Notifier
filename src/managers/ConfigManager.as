package managers
{
	import events.ConfigEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import views.ConfigWindow;
	
	import vo.WarfishConfig;
	
	public class ConfigManager extends ManagerBase
	{
		private var _warfishConfig:WarfishConfig;
		private var _configWindow:ConfigWindow;
		private var _updateBtnLbl:String = "Check for Update";
		
		public function ConfigManager(target:IEventDispatcher=null){
			super(target);
			
			_warfishConfig = new WarfishConfig();
			dispatchEvent(new Event("ValueChanged",false));
			
			NativeApplication.nativeApplication.autoExit = true;
			
			if (!warfishConfig.rssURL.length){
				dispatchEvent(new ConfigEvent(ConfigEvent.OPEN_CONFIG_WINDOW));
			}
		}
		
		[Bindable (Event="ValueChanged")]
		public function get warfishConfig():WarfishConfig{
			return _warfishConfig;
		}
		
		public function setUpdateBtnLbl(value:String):void{
			_updateBtnLbl = value;
			dispatchEvent(new Event("updateBtnLblValueChanged",false));
		}
		
		[Bindable (Event="updateBtnLblValueChanged")]
		public function get updateBtnLbl():String{
			return _updateBtnLbl;
		}
	}
}