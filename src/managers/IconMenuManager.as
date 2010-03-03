package managers
{
	import com.asfusion.mate.events.Dispatcher;
	
	import events.IconMenuEvent;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import vo.WarfishConfig;

	
	public class IconMenuManager extends EventDispatcher
	{
		private var __iconMenu:NativeMenu;
		public var warfishConfig:WarfishConfig;
		private var dispatcher:Dispatcher = new Dispatcher();
		
		public function IconMenuManager(_iconMenu:NativeMenu=null){
			if (_iconMenu){
				iconMenu = _iconMenu;
			} else {
				iconMenu = new NativeMenu();
			}
		}
		
		[Bindable (Event="valueChanged")]
		public function get iconMenu():NativeMenu{
			return __iconMenu;
		}
		
		public function set iconMenu(value:NativeMenu):void{
			__iconMenu = value;
			dispatchEvent(new Event("valueChanged"));
		}
		
		public function buildIconMenu():void{
			var websiteCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Open Warfish"));
			websiteCommand.addEventListener(Event.SELECT,function(event:Event):void{
				dispatcher.dispatchEvent(new IconMenuEvent(IconMenuEvent.OPEN_WARFISH_SELECTED));
				navigateToURL(new URLRequest("http://warfish.net/war/play/"));
			});
			
			var seperator:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("",true));
			
			var soundCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Enable Sound"));
			soundCommand.addEventListener(Event.SELECT,function(event:Event):void{
				dispatcher.dispatchEvent(new IconMenuEvent(IconMenuEvent.ENABLE_SOUND_SELECTED));
				warfishConfig.playSound = event.target.checked = !event.target.checked;
			});
			soundCommand.checked=warfishConfig.playSound;
			
			var configCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Configure"));
			configCommand.addEventListener(Event.SELECT,function(event:Event):void{
				dispatcher.dispatchEvent(new IconMenuEvent(IconMenuEvent.CONFIG_MENU_SELECTED));
			});
			
			var exitCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Exit"));
			exitCommand.addEventListener(Event.SELECT,function(event:Event):void{
				dispatcher.dispatchEvent(new IconMenuEvent(IconMenuEvent.EXIT_MENU_SELECTED));
				NativeApplication.nativeApplication.icon.bitmaps = [];
				NativeApplication.nativeApplication.exit();
			});
			
			var bottomSeperator:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("",true));
			
			var versionMenu:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Version " + getAppVersion()));
			versionMenu.enabled = false;
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