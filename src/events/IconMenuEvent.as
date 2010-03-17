package events
{
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	
	public class IconMenuEvent extends Event
	{
		public static const BUILD_ICON_MENU:String = "BuildIconMenuIconMenuEvent";
		public static const EXIT_MENU_SELECTED:String = "ExitMenuSelectedIconMenuEvent";
		public static const CONFIG_MENU_SELECTED:String = "ConfigMenuSelectedIconMenuEvent";
		public static const OPEN_WARFISH_SELECTED:String = "OpenWarfishSelectedIconMenuEvent";
		public static const ENABLE_SOUND_SELECTED:String = "EnableSoundSelectedIconMenuEvent";
		public static const SET_ICON:String = "SetIconIconMenuEvent";
		public static const REMOVE_MENU_BY_LABEL:String = "RemoveMenuByLabelIconMenuEvent";
		public static const BLINK_ICON:String = "BlinkIconIconMenuEvent";
		public static const STOP_ICON_BLINK:String = "StopIconBlinkIconMenuEvent";
		public static const ADD_MENU_ITEM:String = "AddMenuItemIconMenuEvent";
		
		public var iconName:String;
		public var toolTip:String;
		public var menuLabel:String;
		public var iconMenu:NativeMenuItem;
		public var iconPosition:int;
		
		public function IconMenuEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}