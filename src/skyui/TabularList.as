﻿import skyui.ConfigLoader;
import skyui.Util;
import Shared.GlobalFunc;
import gfx.ui.NavigationCode;
import skyui.Translator;
import skyui.ListLayout;
import skyui.SortedListHeader;


class skyui.TabularList extends skyui.ScrollingList
{
  /* STAGE ELEMENTS */
  
	public var header: SortedListHeader;
	
	
  /* PROPERTIES */ 
  
	private var _layout: ListLayout;
	
	public function get layout(): ListLayout
	{
		return _layout;
	}
	
	public function set layout(a_layout: ListLayout)
	{
		_layout = a_layout;
	}


  /* CONSTRUCTORS */

	public function TabularList()
	{
		super();
	}
	
	public function onLoad()
	{
		super.onLoad();
		
		if (header != 0)
			header.addEventListener("columnPress", this, "onColumnPress");
	}


  /* PUBLIC FUNCTIONS */
	
	public function onColumnPress(event)
	{
		if (event.index != undefined)
			_layout.selectColumn(event.index);
	}
	
	public function handleInput(details, pathToFocus): Boolean
	{
		var processed = super.handleInput(details, pathToFocus);;

		if (!_bDisableInput && !processed && _platform != 0) {

			if (GlobalFunc.IsKeyPressed(details)) {
				if (details.navEquivalent == NavigationCode.GAMEPAD_L1) {
					_layout.selectColumn(_layout.activeColumnIndex - 1);
					processed = true;					
				} else if (details.navEquivalent == NavigationCode.GAMEPAD_R1) {
					_layout.selectColumn(_layout.activeColumnIndex + 1);
					processed = true;
				} else if (details.navEquivalent == NavigationCode.GAMEPAD_L3) {
					_layout.selectColumn(_layout.activeColumnIndex);
					processed = true;
				}
			}
		}
		return processed;
	}
}