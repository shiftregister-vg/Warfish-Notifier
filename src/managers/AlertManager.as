package managers
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import vo.WarfishConfig;
	
	public class AlertManager extends EventDispatcher
	{
		[Bindable]
		public var warfishConfig:WarfishConfig;
		
		public function AlertManager(target:IEventDispatcher=null){
			super(target);
		}
		
		public function showAlert(_useInterval:Boolean=true):void{
			
		}
	}
}