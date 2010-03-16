package managers
{
	import events.AlertEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import vo.WarfishConfig;
	
	public class AlertManager extends ManagerBase
	{
		[Bindable]
		public var warfishConfig:WarfishConfig;
		private var _alertInterval:int;
		
		public function AlertManager(target:IEventDispatcher=null){
			super(target);
		}
		
		public function showAlert(_useInterval:Boolean=true):void{
			
		}
		
		public function setupAlertInterval():void{
			if (_alertInterval){
				clearInterval(_alertInterval);
				_alertInterval = 0;
			}
			_alertInterval = setInterval(onAlertInterval,warfishConfig.bubbleInterval);
		}
		
		private function onAlertInterval():void{
			dispatchEvent(new AlertEvent(AlertEvent.SHOW_ALERT));
		}
	}
}