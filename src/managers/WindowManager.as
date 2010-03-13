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