package managers
{
	import events.IconMenuEvent;
	
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import vo.WarfishConfig;
	
	public class RequestManager extends ManagerBase
	{
		public var warfishConfig:WarfishConfig;
		private var rssXML:XML;
		private var bubbleInterval:int;
		
		public function RequestManager(){
			
		}
		
		public function getRSSFeed():void{
			var urlRequest:URLRequest = new URLRequest(warfishConfig.rssURL);
			urlRequest.contentType = "text/xml";
			urlRequest.method = URLRequestMethod.GET;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onRequestComplete);
			loader.load(urlRequest);
		}
		
		private function onRequestComplete(event:Event):void{
			var e:IconMenuEvent;
			var loader:URLLoader = URLLoader(event.target);
			rssXML = XML(loader.data);
			
			var isTurn:Boolean = false;
			if (rssXML..item.length() > 1){
				isTurn = true;
			}
			
			if (!isTurn){
				
				
				dispatchEvent(new IconMenuEvent(IconMenuEvent.SET_ICON));
				
				e = new IconMenuEvent(IconMenuEvent.REMOVE_MENU_BY_LABEL);
				e.menuLabel = "Games";
				dispatchEvent(e);
				
				if (bubbleInterval){
					clearInterval(bubbleInterval);
				}
			} else {
				var gamesMenuItem:NativeMenuItem = new NativeMenuItem("Games");
				var gamesMenu:NativeMenu = new NativeMenu();
				for (var i:int = 0; i < rssXML..item.length(); i++){
					if (rssXML..item[i].title.toString() != "View Your Turn Games list"){
						var gameMenu:NativeMenuItem = gamesMenu.addItem(new NativeMenuItem(rssXML..item[i].title.toString().replace(" [Your turn]","")));
						gameMenu.data = {url:rssXML..item[i].link.toString()};
						gameMenu.addEventListener(Event.SELECT,function(event:Event):void{
							navigateToURL(new URLRequest(event.target.data.url));
						});
					}
				}
				if (gamesMenu.items.length){
					gamesMenuItem.submenu = gamesMenu;
					e = new IconMenuEvent(IconMenuEvent.ADD_MENU_ITEM);
					e.iconMenu = gamesMenuItem;
					e.iconPosition = 1;
					dispatchEvent(e);
				}
				
				if (warfishConfig.blinkIconOnTurn){
					dispatchEvent(new IconMenuEvent(IconMenuEvent.BLINK_ICON));
					
					
				} else {
					e = new IconMenuEvent(IconMenuEvent.SET_ICON);
					e.iconName = "-red";
					e.toolTip = " - It's your turn!";
					dispatchEvent(e);
				}
				
				if (!bubbleInterval){
					showAlert();
					bubbleInterval = setInterval(showAlert,warfishConfig.bubbleInterval);
				}
			}
		}
		
		private function showAlert():void{
			
		}
	}
}