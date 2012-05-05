﻿import gfx.events.EventDispatcher;
import gfx.ui.NavigationCode;
import Shared.GlobalFunc;
import gfx.io.GameDelegate;
import skyui.Config;
import skyui.EntryClipManager;
import skyui.IEntryClipFactory;
import skyui.BasicEntryFactory;
import skyui.IEntryEnumeration;
import skyui.BasicEnumeration;
import skyui.IEntryFormatter;
import skyui.IDataFetcher;
import skyui.IListComponentInitializer;

class skyui.BasicList extends skyui.BSList
{
  /* CONSTANTS */
  
	public static var PLATFORM_PC = 0;

	public static var SELECT_MOUSE = 0;
	public static var SELECT_KEYBOARD = 1;

	
	
  /* STAGE ELEMENTS */

	public var anchorEntriesBegin: MovieClip;
	public var anchorEntriesEnd: MovieClip;
	
	
  /* PRIVATE VARIABLES */

	private var _entryClipManager: EntryClipManager;
	
	public function set entryClipFactory(a_factory: IEntryClipFactory)
	{
		_entryClipManager.entryClipFactory = a_factory;
	}
	
	private var _listEnumeration: IEntryEnumeration;
	
	public function set listEnumeration(a_enumeration: IEntryEnumeration)
	{
		_listEnumeration = a_enumeration;
	}
	
	private var _entryFormatter: IEntryFormatter;
	
	public function set entryFormatter(a_entryFormatter: IEntryFormatter)
	{
		_entryFormatter = a_entryFormatter;
	}
	
	private var _dataFetcher: IDataFetcher;
	
	public function set dataFetcher(a_dataFetcher: IDataFetcher)
	{
		_dataFetcher = a_dataFetcher;
	}
	

  /* PROPERTIES */
  
	private var _platform: Number;
	
	public function get platform(): Number
	{
		return _platform;
	}
  
	public function set platform(a_platform: Number)
	{
		_platform = a_platform;
		_bMouseDrivenNav = _platform == PLATFORM_PC;
	}
	
	private var _bMouseDrivenNav: Boolean;
	
	function get isMouseDrivenNav(): Boolean
	{
		return _bMouseDrivenNav;
	}

	function set isMouseDrivenNav(a_bFlag: Boolean)
	{
		_bMouseDrivenNav = a_bFlag;
	}
	
	private var _bListAnimating: Boolean;
	
	function get listAnimating(): Boolean
	{
		return _bListAnimating;
	}

	function set listAnimating(a_bFlag: Boolean)
	{
		_bListAnimating = a_bFlag;
	}

	private var _bDisableInput: Boolean;

	function get disableInput()
	{
		return _bDisableInput;
	}

	function set disableInput(a_bFlag: Boolean)
	{
		_bDisableInput = a_bFlag;
	}
	
	private var _bDisableSelection: Boolean;
	
	function get disableSelection(): Boolean
	{
		return _bDisableSelection;
	}
	
	function set disableSelection(a_bFlag: Boolean)
	{
		_bDisableSelection = a_bFlag;
	}

	// @override skyui.BSList
	public function get selectedIndex(): Number
	{
		return _selectedIndex;
	}
	
	// @override skyui.BSList
	function set selectedIndex(a_newIndex: Number)
	{
		doSetSelectedIndex(a_newIndex, SELECT_MOUSE);
	}
	
	
  /* CONSTRUCTORS */
  
	public function BasicList()
	{
		super();

		_bDisableSelection = false;
		_bDisableInput = false;
		_bMouseDrivenNav = false;
		_platform = PLATFORM_PC;
		
		_entryClipManager = new EntryClipManager();

		EventDispatcher.initialize(this);
		Mouse.addListener(this);
	}

	
  /* PUBLIC FUNCTIONS */
  
	// @mixin by gfx.events.EventDispatcher
	public var dispatchEvent: Function;
	
	// @mixin by gfx.events.EventDispatcher
	public var addEventListener: Function;
	
	// @override skyui.BSList
	public function InvalidateData(): Void
	{
		if (_dataFetcher)
			_dataFetcher.processEntries(this);
		
		_listEnumeration.invalidate();
		
		if (_selectedIndex >= _listEnumeration.size())
			_selectedIndex = _listEnumeration.size() - 1;

		UpdateList();
	}

	// @override skyui.BSList
	public function UpdateList(): Void
	{
		// abstract
	}
	
	public function onItemPress(a_index: Number, a_keyboardOrMouse: Number): Void
	{
		// abstract
	}

	private function onItemPressAux(a_index: Number, a_keyboardOrMouse: Number, a_buttonIndex: Number): Void
	{
		// abstract
	}
	
	public function onItemRollOver(a_index: Number): Void
	{
		// abstract
	}
	
	public function onItemRollOut(a_index: Number): Void
	{
		// abstract
	}
	
	
  /* PRIVATE FUNCTIONS */

	private function doSetSelectedIndex(a_newIndex: Number, a_keyboardOrMouse: Number)
	{
		// abstract
	}
	
	private function getClipByIndex(a_index: Number): MovieClip
	{

		
		var result = _entryClipManager.getClipByIndex(a_index);
				skse.Log("INVALIDATE " + _entryClipManager);
		return result;
	}
	
	private function setEntry(a_entryClip: MovieClip, a_entryObject: Object)
	{
		_entryFormatter.setEntry(a_entryClip, a_entryObject);
	}
}