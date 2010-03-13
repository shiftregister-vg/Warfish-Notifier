package managers
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.setInterval;
	
	import vo.WarfishConfig;
	
	public class AlertManager extends EventDispatcher
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
			if (!_alertInterval){
				_alertInterval = setInterval(onAlertInterval,warfishConfig.bubbleInterval);
			}
		}
		
		private function onAlertInterval():void{
			
		}
	}
}