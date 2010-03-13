package managers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import views.ConfigWindow;
	
	import vo.WarfishConfig;
	
	public class ConfigManager extends ManagerBase
	{
		private var _warfishConfig:WarfishConfig;
		private var _configWindow:ConfigWindow;
		
		public function ConfigManager(target:IEventDispatcher=null)
		{
			super(target);
			
			_warfishConfig = new WarfishConfig();
			dispatchEvent(new Event("ValueChanged"));
		}
		
		[Bindable (Event="ValueChanged")]
		public function get warfishConfig():WarfishConfig{
			return _warfishConfig;
		}
	}
}