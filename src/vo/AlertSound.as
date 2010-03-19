package vo
{
	import info.noirbizarre.airorm.ActiveRecord;

	[Bindable]
	public dynamic class AlertSound extends ActiveRecord
	{
		public var file_name:String;
		public var pretty_name:String;
		public var isSelected:Boolean;
		public var canBeDeleted:Boolean;
	}
}