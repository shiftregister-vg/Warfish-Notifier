package managers
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import vo.WarfishConfig;

	
	public class IconMenuManager extends EventDispatcher
	{
		private var iconMenu:NativeMenu;
		public var warfishConfig:WarfishConfig;
		
		public function IconMenuManager(_iconMenu:NativeMenu){
			iconMenu = _iconMenu;
		}
		
		public function buildIconMenu():void{
			var websiteCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Open Warfish"));
			websiteCommand.addEventListener(Event.SELECT,onMenuSelect);
			
			var seperator:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("",true));
			
			var soundCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Enable Sound"));
			soundCommand.addEventListener(Event.SELECT,onMenuSelect);
			soundCommand.checked=warfishConfig.playSound;
			
			var configCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Configure"));
			configCommand.addEventListener(Event.SELECT,onMenuSelect);
			
			var exitCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Exit"));
			exitCommand.addEventListener(Event.SELECT,onMenuSelect);
			
			var bottomSeperator:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("",true));
			
			var versionMenu:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Version " + getAppVersion()));
			versionMenu.enabled = false;
		}
		
		public function onMenuSelect(event:Event=null):void{
			var nativeMenuItem:NativeMenuItem = event.target as NativeMenuItem;
			dispatchEvent(new Event(nativeMenuItem.label));
		}
		
		public function addMenuItemAt(_menuItem:NativeMenuItem,_position:Number,_removeDuplicate:Boolean=true):void{
			if (_removeDuplicate){
				for (var i:int = 0; i  < iconMenu.items.length; i++){
					if (iconMenu.items[i].label == _menuItem.label){
						iconMenu.removeItemAt(i);
					}
				}
			}
			iconMenu.addItemAt(_menuItem,_position);
		}
		
		public function removeMenuByLabel(_menuLabel:String):void{
			if (_menuLabel.length){
				for (var i:int = 0; i  < iconMenu.items.length; i++){
					if (iconMenu.items[i].label == _menuLabel){
						iconMenu.removeItemAt(i);
					}
				}
			}
		}
		
		private function getAppVersion():String {
			var appXml:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXml.namespace();
			var appVersion:String = appXml.ns::version[0];
			return appVersion;
		}
	}
}