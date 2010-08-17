package managers
{
	import flash.events.IEventDispatcher;
	
	import views.AlertBubble;
	import views.ConfigWindow;
	import views.NoticeWindow;
	import views.SoundManagerWindow;
	
	public class WindowManager extends ManagerBase
	{
		private var alertBubble:AlertBubble;
		private var configWindow:ConfigWindow;
		private var soundManagerWindow:SoundManagerWindow;
		private var noticeWindow:NoticeWindow;
		
		public function WindowManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function openAlertWindow():void{
			
			if (!alertBubble || alertBubble.closed){
				alertBubble = new AlertBubble();
				alertBubble.open(false);
			}
			
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
		
		public function openSoundManagerWindow():void{
			if (!soundManagerWindow || soundManagerWindow.closed){
				soundManagerWindow = new SoundManagerWindow();
				soundManagerWindow.open();
			}
			soundManagerWindow.activate();
		}
		
		public function openNoticeWindow(message:String):void{
			if (!noticeWindow || noticeWindow.closed){
				noticeWindow = new NoticeWindow();
				noticeWindow.open();
			}
			noticeWindow.message = message;
			noticeWindow.activate();
		}
	}
}