package managers
{
	import com.asfusion.mate.events.Dispatcher;
	
	import events.ConfigEvent;
	import events.IconMenuEvent;
	import events.SoundManagerEvent;
	
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.Loader;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import vo.Config;

	
	public class IconMenuManager extends ManagerBase
	{
		private var iconMenu:NativeMenu = new NativeMenu();
		private var icon:Loader = new Loader();
		private var iconBlinkInterval:int;
		private var iconIsBlue:Boolean = true;
		public var config:Config;
		
		public function IconMenuManager(){
			
		}
		
		public function buildIconMenu():void{
			var websiteCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Open Warfish"));
			websiteCommand.addEventListener(Event.SELECT,function(event:Event):void{
				dispatchEvent(new IconMenuEvent(IconMenuEvent.OPEN_WARFISH_SELECTED));
				navigateToURL(new URLRequest("http://warfish.net/war/play/"));
			});
			
			var seperator:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("",true));
			
			var soundCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Enable Sound"));
			soundCommand.addEventListener(Event.SELECT,function(event:Event):void{
				dispatchEvent(new IconMenuEvent(IconMenuEvent.ENABLE_SOUND_SELECTED));
				config.playSound = event.target.checked = !event.target.checked;
				var e:ConfigEvent = new ConfigEvent(ConfigEvent.SAVE_CONFIG);
				e.config = config;
				dispatchEvent(e);
			});
			soundCommand.checked=config.playSound;
			
			var configCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Configure"));
			configCommand.addEventListener(Event.SELECT,function(event:Event):void{
				dispatchEvent(new IconMenuEvent(IconMenuEvent.CONFIG_MENU_SELECTED));
			});
			
			var exitCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Exit"));
			exitCommand.addEventListener(Event.SELECT,function(event:Event):void{
				dispatchEvent(new IconMenuEvent(IconMenuEvent.EXIT_MENU_SELECTED));
				NativeApplication.nativeApplication.icon.bitmaps = [];
				NativeApplication.nativeApplication.exit();
			});
			
			var bottomSeperator:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("",true));
			
			var versionMenu:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Version " + getAppVersion()));
			versionMenu.enabled = false;
			
			setIcon();
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
		
		public function setIcon(iconName:String="",tooltip:String=""):void{
			if (NativeApplication.supportsSystemTrayIcon) {
				NativeApplication.nativeApplication.autoExit = false;
				icon.contentLoaderInfo.addEventListener(Event.COMPLETE, iconLoadComplete);
				icon.load(new URLRequest("/assets/icon/warfish" + iconName + "-16.png"));
				
				var systray:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;
				systray.tooltip = "Warfish Notifier" + tooltip;
				systray.menu = iconMenu;
			}
			
			if (NativeApplication.supportsDockIcon){
				icon.contentLoaderInfo.addEventListener(Event.COMPLETE,iconLoadComplete);
				icon.load(new URLRequest("/assets/icon/warfish" + iconName + "-128.png"));
				var dock:DockIcon = NativeApplication.nativeApplication.icon as DockIcon; 
				dock.menu = iconMenu;
			}
		}
		
		private function iconLoadComplete(event:Event):void {
			NativeApplication.nativeApplication.icon.bitmaps =
				[event.target.content.bitmapData];
		}
		
		public function blinkIcon():void{
			if (!iconBlinkInterval){
				iconBlinkInterval = setInterval(function():void{
					if (iconIsBlue){
						setIcon("-red"," - It's your turn!");
					} else {
						setIcon(""," - It's your turn!");
					}
					iconIsBlue = !iconIsBlue;
				},500);
			}
		}
		
		public function stopIconBlink():void{
			if(iconBlinkInterval){
				clearInterval(iconBlinkInterval);
				iconBlinkInterval = 0;
			}
			setIcon();
		}
	}
}