package events
{
	import flash.events.Event;
	
	public class AnalyticsEvent extends Event
	{
		public static const INIT:String = "InitAnalyticsEvent";
		public static const TRACK_CLICK:String = "TrackClickAnalyticsEvent";
		public static const TRACK_ERROR:String = "TrackErrorAnalyticsEvent";
		
		public var action:String;
		public var error:Error;
		
		public function AnalyticsEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}