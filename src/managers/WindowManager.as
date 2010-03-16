package managers
{
	import flash.events.IEventDispatcher;
	
	import views.AlertBubble;
	import views.ConfigWindow;
	
	public class WindowManager extends ManagerBase
	{
		private var alertBubble:AlertBubble;
		private var configWindow:ConfigWindow;
		
		public function WindowManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function openAlertWindow():void{
			
			if (!alertBubble || alertBubble.closed){
				alertBubble = new AlertBubble();
				alertBubble.open();
			}
			
			//alertBubble.addEventListener(AIREvent.WINDOW_ACTIVATE,playSound);
			alertBubble.open();
			alertBubble.activate();
		}
		
		public function openConfigWindow():void{
			if (!configWindow || configWindow.closed){
				configWindow = new ConfigWindow();
				configWindow.open();
			}
			configWindow.activate();
		}
	}
}