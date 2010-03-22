package events
{
	import flash.events.Event;
	
	public class RequestManagerEvent extends Event
	{
		public static const GET_TURNS_FEED:String = "GetTurnsFeedRequestManagerEvent";
		public static const START_REQUEST_INTERVAL:String = "StartRequestIntervalRequestManagerEvent";
		public static const HAS_TURNS:String = "HasTurnsRequestManagerEvent";
		public static const NO_TURNS:String = "NoTurnsRequestManagerEvent";
		public static const REQUEST_ERROR:String = "RequestErrorRequestManagerEvent";
		
		public var message:String;
		
		public function RequestManagerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}