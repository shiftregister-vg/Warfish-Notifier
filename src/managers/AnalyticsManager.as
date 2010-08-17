package managers
{
	import com.appAnalytics.AppAnalytics;
	import com.appAnalytics.AppAnalyticsType;
	
	import flash.events.IEventDispatcher;
	
	import mx.rpc.Fault;
	
	public class AnalyticsManager extends ManagerBase
	{
		private var apiKey:String = "apiudpx6xdsljq8zz3fdq7poe1d9n2cjz";
		private var appID:String = "appID1v9sxe9zrd0nvhtrtsh9rvp1ztak5w";
		
		public function AnalyticsManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function initAnalytics():void{
			AppAnalytics.start(apiKey,appID,false);
		}
		
		public function trackClick(action:String):void{
			AppAnalytics.track(action,AppAnalyticsType.CLICK);
		}
		
		public function trackError(fault:Fault):void{
			AppAnalytics.track(fault.message,AppAnalyticsType.ERROR);
		}
	}
}