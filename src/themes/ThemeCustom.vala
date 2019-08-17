/*
* Copyright (c) 2018 (https://github.com/phase1geo/Minder)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Trevor Williams <phase1geo@gmail.com>
*/

using Gdk;
using Gtk;

public class ThemeCustom : Theme {

  /* Create the theme colors */
  public ThemeCustom() {

    name = _( "Custom" );

    /* Generate the non-link colors */
    set_color( "background",         color_from_string( "#000000" ) );
    set_color( "foreground",         color_from_string( "White" ) );
    set_color( "root_background",    color_from_string( "#d4d4d4" ) );
    set_color( "root_foreground",    color_from_string( "Black" ) );
    set_color( "nodesel_background", color_from_string( "#64baff" ) );
    set_color( "nodesel_foreground", color_from_string( "Black" ) );
    set_color( "textsel_background", color_from_string( "#0d52bf" ) );
    set_color( "textsel_foreground", color_from_string( "White" ) );
    set_color( "text_cursor",        color_from_string( "White" ) );
    set_color( "attachable",         color_from_string( "#9bdb4d" ) );
    set_color( "connection",         color_from_string( "#404040" ) );

    set_color( "link_color0", color_from_string( "#c6262e" ) );
    set_color( "link_color1", color_from_string( "#f37329" ) );
    set_color( "link_color2", color_from_string( "#f9c440" ) );
    set_color( "link_color3", color_from_string( "#68b723" ) );
    set_color( "link_color4", color_from_string( "#3689e6" ) );
    set_color( "link_color5", color_from_string( "#7a36b1" ) );
    set_color( "link_color6", color_from_string( "#715344" ) );
    set_color( "link_color7", color_from_string( "#333333" ) );

    prefer_dark = true;

  }

  /* Allows outside code to change the stored color */
  public void change_color( string name, RGBA color ) {
    set_color( name, color );
  }

  /* Parses the specified XML node for theme coloring information */
  public void load( Xml.Node* n ) {

    string? nn = n->get_prop( "name" );
    if( nn != null ) {
      name = nn;
    }

    var cs = colors();
    for( int i=0; i<cs.length; i++ ) {
      var name = cs.index( i );
      string? s = n->get_prop( name );
      if( s != null ) {
        set_color( name, color_from_string( s ) );
      }
    }

    string? d = n->get_prop( "prefer_dark" );
    if( d != null ) {
      prefer_dark = bool.parse( d );
    }

  }

  /* Returns an XML node containing the contents of this theme color scheme */
  public Xml.Node* save() {

    Xml.Node* n = new Xml.Node( null, "theme" );

    n->new_prop( "name", name );

    var cs = colors();
    for( int i=0; i<cs.length; i++ ) {
      var name = cs.index( i );
      n->new_prop( name, Utils.color_from_rgba( get_color( name ) ) );
    }

    n->new_prop( "prefer_dark", prefer_dark.to_string() );

    return( n );

  }

}
