{**
 * File containing the location line template
 *
 * @package bcgmapslocation
 * @version //autogentag//
 * @copyright Copyright (C) 2009 Brookins Consulting. All rights reserved.
 * @license GPL v2 (or later)
 *}{def $eventClassID=ezini( 'GMapsLocationSettings', 'LocationEventScheduleClassID', 'bcgmapslocation.ini' )}{def $c=fetch( 'content', 'class', hash( 'class_id', $eventClassID ) )
        $childrenLocations=fetch( 'content','list',hash(  'parent_node_id',
        $node.object.main_node.node_id,'priority',true() ) )
        $displayMapPointInfoHoursSetting=ezini( 'GMapsLocationSettings', 'LocationDisplayHours', 'bcgmapslocation.ini' )
        $displayMapPointInfoMapLinksSetting=ezini( 'GMapsLocationSettings', 'LocationDisplayMapLinks', 'bcgmapslocation.ini' )
}
<table border=0><tr><td colspan=2><div>
<h1><a href={$node.object.main_node.url|ezurl()}>{$node.object.name}</a></h1>
</td></tr><tr><td>
<div style="float:left; display:inline; width:232px; height:304px; {if is_set( $node.object.data_map.image.value.data_map.image.value.original )}background-image: url({$node.object.data_map.image.value.data_map.image.value.original.url|ezurl('no')}) ; background-repeat: no-repeat; {/if}padding:0px;margin:0px 5px 5px 0px; ">
{if is_set( $node.object.data_map.image.value.data_map.image.value.original )|not()}<br><br><p>[No Image]</p>{/if}
</div>
</td><td>
<p>{$node.object.data_map.address.value}<br />
{$node.object.data_map.city.value},&nbsp;{$node.object.data_map.state.value},&nbsp;{$node.object.data_map.zip.value}</p>

<p>Phone: {$node.object.data_map.phone.value}</p>

<p>Email: <a target="_blank" href="mailto:{$node.object.data_map.email.value}">{$node.object.data_map.email.value}</a></p>
<p>Website: <a target="_blank" href="{$node.object.data_map.website.value}">{$node.object.data_map.website.data_text}</a></p>

<p>Contact: {$node.object.data_map.contact.value}</p>

{if $displayMapPointInfoHoursSetting|ne('disabled')}
<b>Hours</b>
{def $lang=0
     $langid=0}
{* $childrenLocations.0|attribute(show,1) *}
{foreach $childrenLocations as $child}{set $langid=$child.data_map.language.value.0}{set $lang=$c.data_map.language.content.options.$langid}{set $lang=$lang.name}<p>{$child.name}: {$child.data_map.time.value.timestamp|datetime('event_datetime')}{if is_set( $child.data_map.end_time.value )} - {$child.data_map.end_time.value.timestamp|datetime('event_datetime')}{/if} ({$lang})</p>{/foreach}{undef $lang}{undef $langid}{/if}
<p>{$node.object.data_map.schedule_anomalies.value}</p>

{if and( is_set( $node.object.object.data_map.location.content.latitude), is_set( $node.object.object.data_map.location.content.longitude ), $node.object.object.data_map.location.content.latitude|ne(''), $node.object.object.data_map.location.content.longitude|ne('') )}
{include uri='design:location_gmaps.tpl' parent=$node.object nodes=$node.object}
{/if}

{if and( $displayMapPointInfoMapLinksSetting|ne('disabled'), is_set( $node.object.data_map.address ) )}
{* <b>Maps</b> *}
{* 20+West+Kinzie+St.+Chicago,+IL+60610+USA *}
{def $address=concat( $node.object.data_map.address.value, '+', $node.object.data_map.city.value, ',+', $node.object.data_map.state.value, '+', $node.object.data_map.zip.value, '+USA' )}
{def $gmaps_driving_url=concat('http://maps.google.com/maps?f=d&source=s_d&saddr=&daddr=', $address, '&hl=en&geocode=&mra=ls&sll=41.889474,-87.628912&sspn=0.009313,0.022745&ie=UTF8&z=16')}
<p><a target="_blank" href={$gmaps_driving_url}>Get directions to location</a></p>
{/if}
</div> <div class="clear"> </div>
</td></tr></table>{undef $childrenLocations}