/*
 * FCKeditor - The text editor for internet
 * Copyright (C) 2003-2004 Frederico Caldeira Knabben
 * 
 * Licensed under the terms of the GNU Lesser General Public License:
 * 		http://www.opensource.org/licenses/lgpl-license.php
 * 
 * For further information visit:
 * 		http://www.fckeditor.net/
 * 
 * File Name: sample06.config.js
 * 	Sample custom configuration settings used in the plugin sample page (sample06).
 * 
 * Version:  2.0 RC3
 * Modified: 2005-02-15 23:18:39
 * 
 * File Authors:
 * 		Frederico Caldeira Knabben (fredck@fckeditor.net)
 */

// Set our sample toolbar.
FCKConfig.ToolbarSets['PluginTest'] = [
	['Source'],
	['My_Find','My_Replace','-','Placeholder'],
	//['Table','-','TableInsertRow','TableDeleteRows','TableInsertColumn','TableDeleteColumns','TableInsertCell','TableDeleteCells','TableMergeCells','TableSplitCell'],
	['Bold','Italic','-','OrderedList','UnorderedList','-','Link','Unlink','-','About']
] ;

// Change the default plugin path.
FCKConfig.PluginsPath = FCKConfig.BasePath.substr(0, FCKConfig.BasePath.length - 7) + '_samples/_plugins/' ;

// Add our plugin to the plugins list.
//		FCKConfig.Plugins.Add( pluginName, availableLanguages )
//			pluginName: The plugin name. The plugin directory must match this name.
//			availableLanguages: a list of available language files for the plugin (separated by a comma).
FCKConfig.Plugins.Add( 'findreplace', 'en,it' ) ;

// If you want to use plugins found on other directories, just use the third parameter.
var sOtherPluginPath = FCKConfig.BasePath.substr(0, FCKConfig.BasePath.length - 7) + 'editor/plugins/' ;
FCKConfig.Plugins.Add( 'placeholder', 'en,it', sOtherPluginPath ) ;
//FCKConfig.Plugins.Add( 'tablecommands', 'en,it', sOtherPluginPath ) ;
