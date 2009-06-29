{**
 * File containing the location_event_schedule line template
 *
 * @package bcgmapslocation
 * @version //autogentag//
 * @copyright Copyright (C) 2009 Brookins Consulting. All rights reserved.
 * @license GPL v2 (or later)
 *}{def $c=fetch( 'content', 'class', hash( 'class_id', ezini( 'GMapsLocationSettings', 'LocationEventScheduleClassID', 'bcgmapslocation.ini' ) ) )
        $childrenLocation=fetch( 'content', 'list', hash(  'parent_node_id',
        $node.parent.object.main_node.node_id,'priority',true() ) )
}<table border=0><tr><td colspan=2><div>
<h1><a href={$node.parent.object.main_node.url|ezurl()}>{$node.parent.object.name}</a></h1>
</td></tr><tr><td>
<div style="float:left; display:inline; width:232px; height:304px; {if is_set($node.parent.object.data_map.image.value.data_map.image.value.original)}background-image: url({$node.parent.object.data_map.image.value.data_map.image.value.original.url|ezurl('no')}{/if}) ; background-repeat: no-repeat; padding:0px;margin:0px 5px 5px 0px; "> {if is_set($node.parent.object.data_map.image.value.data_map.image.value.original)|not()}<p>[No Picture]</p>{/if}
</div>	
</td><td>
<p>{$node.parent.object.data_map.address.value}<br />
{$node.parent.object.data_map.city.value},&nbsp;{$node.parent.object.data_map.state.value},&nbsp;{$node.parent.object.data_map.zip.value}</p>

<p>Phone: {$node.parent.object.data_map.phone.value}</p>

<p>Email: <a target="_blank" href="mailto:{$node.parent.object.data_map.email.value}">{$node.parent.object.data_map.email.value}</a></p>

<p>Website: <a target="_blank" href="{$node.parent.object.data_map.website.value}">{$node.parent.object.data_map.website.data_text}</a></p>

<p>Contact: {$node.parent.object.data_map.contact.value}</p>

<b>Hours</b>
{def $lang=0
     $searchLang=$#full_search_text
     $langid=0}
{* $childrenLocation|attribute(show,1) *}
{foreach $childrenLocation as $child}{set $langid=$child.data_map.language.value.0}{set $lang=$c.data_map.language.content.options.$langid}{set $lang=$lang.name}{if $searchLang|eq($lang)}<p>{$child.name}: {$child.data_map.time.value.timestamp|datetime('event_datetime')} ({$lang})</p>{/if}{/foreach}{undef $lang}{undef $langid}
<p>{$node.parent.object.data_map.scheduleanomalies.value}</p>

{if and( is_set( $node.parent.object.object.data_map.location.content.latitude), is_set( $node.parent.object.object.data_map.location.content.longitude ), $node.parent.object.object.data_map.location.content.latitude|ne(''), $node.parent.object.object.data_map.location.content.longitude|ne('') )}
{include uri='design:location_gmaps.tpl' parent=$node.parent.object nodes=$node.parent.object}
{/if}
{* 20+West+Kinzie+St.+Chicago,+IL+60610+USA *}
{def $address=concat( $node.parent.object.data_map.address.value, '+', $node.parent.object.data_map.city.value, ',+', $node.parent.object.data_map.state.value, '+', $node.parent.object.data_map.zip.value, '+USA' )}
{def $gmaps_driving_url=concat('http://maps.google.com/maps?f=d&source=s_d&saddr=&daddr=', $address, '&hl=en&geocode=&mra=ls&sll=41.889474,-87.628912&sspn=0.009313,0.022745&ie=UTF8&z=16')}
<p><b>Maps</b></p>
<p><a href={$gmaps_driving_url}>Get directions to location</a></p>

</div> <div class="clear"> </div>
</td></tr></table>{undef $childrenLocation}