{**
 * File containing the location_gmaps template
 *
 * @package bcgmapslocation
 * @version //autogentag//
 * @copyright Copyright (C) 2009 Brookins Consulting. All rights reserved.
 * @license GPL v2 (or later)
 *}{def $uniqueLocationEventScheduleClass=fetch( 'content', 'class', hash( 'class_id', ezini( 'GMapsLocationSettings', 'LocationEventScheduleClassID', 'bcgmapslocation.ini' ) ) )
     $mapPointIconUrlSetting=ezini( 'GMapsLocationSettings', 'LocationIconUrl', 'bcgmapslocation.ini' )
     $displayMapLocationInfoHoursSetting=ezini( 'GMapsLocationSettings', 'LocationDisplayHours', 'bcgmapslocation.ini' )
     $displayMapPointInfoMapLinksSetting=ezini( 'GMapsLocationSettings', 'LocationDisplayMapLinks', 'bcgmapslocation.ini' )
     $defaultMapZoomSetting=ezini( 'GMapsLocationSettings', 'DefaultMapZoomInt', 'bcgmapslocation.ini' )
     $defaultMapClickZoomSetting=ezini( 'GMapsLocationSettings', 'DefaultMapClickZoomInt', 'bcgmapslocation.ini' )
}{if is_set( $nodes )}{def $children=$nodes}{else}{def $children = fetch( 'content','list',hash(  'parent_node_id',
                 $node.node_id,'priority',true() ) )}{/if}{if count($children)|ne(0)}
{def $map_link_url=0
     $map_iframe_url=0}
{if is_set($parent.data_map.location)}
{def $lat=$parent.data_map.location.value.latitude
     $lon=$parent.data_map.location.value.longitude}
{else}
{def $lat=37.81846319511331
     $lon=-122.574462890625}
{/if}
{set $map_iframe_url=concat('http://maps.google.com/maps/ms?ie=UTF8&amp;hl=en&amp;msa=0&amp;ll=', $lat ,',', $lon, '&amp;z=10&amp;spn=0.860749,0.725347&amp;msid=113426737583328078887.000449fbbd3538ebd9a19&amp;output=embed&amp;s=AARTsJriWb15VGLAL9Iio-j9GcLmGR7PjA')
     $map_link_url=concat('http://maps.google.com/maps/ms?ie=UTF8&amp;hl=en&amp;msa=0&amp;ll=', $lat ,',', $lon , '&amp;z=10&amp;spn=0.860749,0.725347&amp;msid=113426737583328078887.000449fbbd3538ebd9a19&amp;source=embed')}
{* $node.data_map.location.value|attribute(show,1) *}
{* <div id="sidenav_middle">
<ul >
{foreach $children as $child}
<li id="fir"><a href={$child.url|ezurl()}>{$child.name}</a></li>
{/foreach}
</ul>
</div>
*}{* $children.0.data_map|attribute(show,1) *}
<div>
<script src="http://maps.google.com/maps?file=api&amp;v=2.x&amp;key={ezini('GMapsLocationSettings','GMapsKey', 'bcgmapslocation.ini')}" type="text/javascript"></script>
<script type="text/javascript">
{literal}
var mapid = 'map';
var map = null;
var gmapExistingOnload = null;
var zoom = {/literal}{$defaultMapZoomSetting}{literal};
var clickZoom = {/literal}{$defaultMapClickZoomSetting}{literal};

if (window.onload)
{
       //Hang on to any existing onload function.
       gmapsExistingOnload = window.onload;
}

window.onload=function(ev){
   //Run any onload that we found.
        if (gmapExistingOnload)
        {
            gmapExistingOnload(ev);
        }
        if (GBrowserIsCompatible()) {
	    var markers = [];
	    var infos = [];
            map = new GMap2(document.getElementById(mapid));

	    // Create our "tiny" marker icon
	    var blueIcon = new GIcon(G_DEFAULT_ICON);
            {/literal}{if $mapPointIconUrlSetting|ne('disabled')}blueIcon.image = "{$mapPointIconUrlSetting}";

	    blueIcon.iconSize = new GSize(28, 34);
            blueIcon.shadowSize = new GSize(38, 34);
            blueIcon.iconAnchor = new GPoint(9, 34);
	    blueIcon.infoWindowAnchor = new GPoint(9, 2);{/if}{literal}


	    // Set up our GMarkerOptions object
	    markerOptions = { icon:blueIcon };


{/literal}{def $count=0
$gmaps_directions_map_url_part0='http://maps.google.com/maps?f=d&source=s_d&saddr=&daddr='
$gmaps_directions_map_url_part1='&hl=en&geocode=&mra=ls&sll=41.889474,-87.628912&sspn=0.009313,0.022745&ie=UTF8&z=16'
$gmaps_larger_map_url_part0='http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q='
$gmaps_larger_map_url_part1='&sll=37.0625,-95.677068&sspn=40.324283,93.164063&ie=UTF8&z=4'
$address=0
$address_map_url=0
$language=0
$languageid=0
$times=0}{if is_object($children)}{if and( $children.object.data_map.location.value.latitude|ne(''), $children.object.data_map.location.value.longitude|ne('') )}markers.push( new GMarker( new GLatLng( {$children.object.data_map.location.value.latitude}, {$children.object.data_map.location.value.longitude}{literal} ), markerOptions ) );
            infos[{/literal}{$count}] = '{literal}<div class="msinfotitle" dir="ltr" align="left" style="text-size:16px;font-weight:bolder">{/literal}<a style="text-decoration:none;color:#535548" href={$children.url|ezurl}>{$children.object.name}{literal}</a></div><div class="description" dir="ltr" align="left"><table><tbody><tr><td valign="top">{/literal}{if is_set( $children.object.data_map.image.value.data_map.image.value.original  )}<img src="{$children.object.data_map.image.value.data_map.image.value.original.url|ezurl('no')}">{else} {/if}</td><td valign="top">{$children.object.data_map.address.value}<br>{$children.object.data_map.city.value}, {$children.object.data_map.state.value} {$children.object.data_map.zip.value}<p>Phone: {$children.object.data_map.phone.value}</p><p>Email: <a target="_blank" href="mailto:{$children.object.data_map.email.value}">{$children.object.data_map.email.value}</a></p><p>Website: <a target="_blank" href="{$children.object.data_map.website.value}">{$children.object.data_map.website.data_text}</a></p><p>Contact: {$children.object.data_map.contact.value}</p>{if $displayMapLocationInfoHoursSetting|ne('disabled')}{literal}<p><b>Hours</b></p>{/literal}{set $language=0}{set $languageid=0}{set $times = fetch( 'content','list',hash( 'parent_node_id', $children.node_id,'priority',true() ) )}{foreach $times as $mass}{set $languageid=$mass.data_map.language.value.0}{set $language=$uniqueLocationEventScheduleClass.data_map.language.content.options.$languageid}{set $language=$language.name}<p>{$mass.name}: {$mass.data_map.time.value.timestamp|datetime('event_datetime')} ({$language})</p>{/foreach}{/if}{set $address=concat( $children.object.data_map.address.value, '+', $children.object.data_map.city.value, ',+', $children.object.data_map.state.value, '+', $children.object.data_map.zip.value, '+USA' )}{set $map_link_url=concat( $gmaps_directions_map_url_part0, $address, $gmaps_directions_map_url_part1 )}{if and( is_set( $children.object.data_map.scheduleanomalies ), $children.object.data_map.scheduleanomalies.value|ne('') )}<p>{$children.object.data_map.scheduleanomalies.value}</p>{/if}{if $displayMapPointInfoMapLinksSetting|ne('disabled')}{literal}<p><b>Maps</b></p><p><a target="_blank" style="text-size:small; color: rgb(0,0,255); text-align: left" href="{/literal}{$map_link_url}">Get Directions to Parish</a></p>{set $address=concat( $children.object.data_map.address.value, '+', $children.object.data_map.city.value, ',+', $children.object.data_map.state.value, '+', $children.object.data_map.zip.value, '+USA' )}{set $address_map_url=concat( $gmaps_larger_map_url_part0, $address, $gmaps_larger_map_url_part1 )}<p><a target="_blank" style="text-size:small; color: rgb(0,0,255); text-align: left" href="{$address_map_url}">View larger map of Parish</a></p>{/if}{literal}</td></tr></tbody></table></div>';
            map.addOverlay( markers[{/literal}{$count}{literal}] );{/literal}

	    {set $count=$count|sum(1)}{/if}{else}{foreach $children as $child}{if and( $child.object.data_map.location.value.latitude|ne(''), $child.object.data_map.location.value.longitude|ne('') )}markers.push( new GMarker( new GLatLng( {$child.object.data_map.location.value.latitude}, {$child.object.data_map.location.value.longitude}{literal} ), markerOptions ) );
            infos[{/literal}{$count}] = '{literal}<div><div class="msinfotitle" dir="ltr" align="left" style="text-size:16px;font-weight:bolder">{/literal}<a style="text-decoration:none;color:#535548" href={$child.url|ezurl}>{$child.name}</a>{literal}</div><div class="description" dir="ltr" align="left"><table border=0 width=100%><tbody><tr><td valign="top">{/literal}{if is_set( $child.object.data_map.image.value.data_map.image.value.original )}<img src="{$child.object.data_map.image.value.data_map.image.value.original.url|ezurl('no')}">{else} {/if}</td><td valign="top">{$child.object.data_map.address.value}<br>{$child.object.data_map.city.value}, {$child.object.data_map.state.value} {$child.object.data_map.zip.value}<p>Phone: {$child.data_map.phone.value}</p><p>Email: <a target="_blank" href="mailto:{$child.data_map.email.value}">{$child.data_map.email.value}</a></p><p>Website: <a target="_blank" href="{$child.data_map.website.value}">{$child.data_map.website.data_text}</a></p><p>Contact: {$child.data_map.contact.value}</p>{if $displayMapLocationInfoHoursSetting|ne('disabled')}{literal}<p><b>Hours</b></p>{/literal}{set $language=0}{set $languageid=0}{set $times = fetch( 'content','list',hash( 'parent_node_id', $child.node_id,'priority',true() ) )}{foreach $times as $mass}{set $languageid=$mass.data_map.language.value.0}{set $language=$uniqueLocationEventScheduleClass.data_map.language.content.options.$languageid}{set $language=$language.name}<p>{$mass.name}: {$mass.data_map.time.value.timestamp|datetime('event_datetime')} ({$language})</p>{/foreach}{/if}{set $address=concat( $child.object.data_map.address.value, '+', $child.object.data_map.city.value, ',+', $child.object.data_map.state.value, '+', $child.object.data_map.zip.value, '+USA' )}{set $map_link_url=concat( $gmaps_directions_map_url_part0, $address, $gmaps_directions_map_url_part1 )}{if and( is_set( $child.data_map.scheduleanomalies ), $child.data_map.scheduleanomalies.value|ne('') )}<p>{$child.data_map.scheduleanomalies.value}</p>{/if}{if $displayMapPointInfoMapLinksSetting|ne('disabled')}{literal}<p><b>Maps</b></p><p><a target="_blank" style="text-size:small;color: rgb(0,0,255); text-align: left" href="{/literal}{$map_link_url}">Get directions to location</a></p>{set $address=concat( $child.object.data_map.address.value, '+', $child.object.data_map.city.value, ',+', $child.object.data_map.state.value, '+', $child.object.data_map.zip.value, '+USA' )}{set $address_map_url=concat( $gmaps_larger_map_url_part0, $address, $gmaps_larger_map_url_part1 )}<p><a target="_blank" style="text-size:small; color: rgb(0,0,255); text-align: left" href="{$address_map_url}">View larger map of location</a></p>{/if}{literal}</td></tr></tbody></table></div></div>';
            map.addOverlay( markers[{/literal}{$count}{literal}] );{/literal}

	    {set $count=$count|sum(1)}{/if}{/foreach}{/if}
            {literal}
	    for (var i=0;i<markers.length;i=i+1)
            {
 	 	markers[i]._html_popup_info = infos[ i ];
   	        GEvent.addListener( markers[ i ], "click", function( ) {
          	    // m.openInfoWindowHtml("<b>Park</b>");
 		    this.openInfoWindowHtml( this._html_popup_info );
  	   	    map.setCenter( markers[ i ], clickZoom );
	        });
	    }
	    map.setCenter(new GLatLng({/literal}{if is_object($children)}{$children.object.data_map.location.value.latitude},{$children.object.data_map.location.value.longitude}{else}{$children.0.object.data_map.location.value.latitude},{$children.0.object.data_map.location.value.longitude}{/if}{literal}), 0);
            map.setZoom( zoom );
            map.setMapType(G_NORMAL_MAP);
	    {/literal}{* map.addControl(new GLargeMapControl());
	    map.addControl(new GMapTypeControl()); *}{literal}
            map.setUIToDefault();{/literal}{* var marker = markers[markers.length-1];
	    GEvent.addListener( marker, "click", function() {
          	marker.openInfoWindowHtml("<b>Park</b>");
	    }); *}{literal}
        }
};
{/literal}
</script>
<div>
 <div id="map" style="width:578px;height:460px;float:left"></div>
{if and( $displayMapPointInfoMapLinksSetting|ne('disabled'), is_set( $node.data_map.address ) )}
<b>Maps</b>
{set $address=concat( $node.data_map.address.value, '+', $node.data_map.city.value, ',+', $node.data_map.state.value, '+', $node.data_map.zip.value, '+USA' )}
{set $address_map_url=concat( $gmaps_larger_map_url_part0, $address, $gmaps_larger_map_url_part1 )}<p><a target="_blank" style="text-size:small; color: rgb(0,0,255); text-align: left" href="{$address_map_url}">View larger map of location</a></p>
{* <small><a style="color: rgb(0,0,255); text-align: left" href="{$map_link_url}">View Larger Map</a></small> *}
{def $address_directions_url=concat( $gmaps_directions_map_url_part0, $address, $gmaps_directions_map_url_part1 )}<p><a target="_blank" style="text-size:small; color: rgb(0,0,255); text-align: left" href="{$address_directions_url}">Get directions to location</a></p>
{/if}
</div> <div class="clear"> </div>

</div>
{/if}{* <iframe marginwidth="0" marginheight="0" src={$map_iframe_url}" frameborder="0" width="613" scrolling="no" height="860"></iframe> *}