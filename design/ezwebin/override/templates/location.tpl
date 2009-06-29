{**
 * File containing the location template
 *
 * @package bcgmapslocation
 * @version //autogentag//
 * @copyright Copyright (C) 2009 Brookins Consulting. All rights reserved.
 * @license GPL v2 (or later)
 *}{def $locationEventScheduleClass=fetch( 'content', 'class', hash( 'class_id', ezini( 'GMapsLocationSettings', 'LocationEventScheduleClassID', 'bcgmapslocation.ini' ) ) )
     $childrenLocations=fetch( 'content','list',hash(  'parent_node_id',
                 $node.node_id,'priority',true() ) )
     $lang=0
     $langid=0
}
<h1>{$node.name}</h1><div style="{if and( is_set( $node.data_map.image.value.data_map.image.value.original ), $node.data_map.image.value.data_map.image.value.original.url|ne('') )}background-image: url({concat('/ezpublish/',$node.data_map.image.value.data_map.image.value.original.url)}); background-repeat: no-repeat; {/if}padding:0px;margin:0px 5px 5px 0px; float:left; display:inline; width:232px; height:304px;">
</div>

<p>{$node.data_map.address.value}<br />{$node.data_map.city.value},&nbsp;{$node.data_map.state.value},&nbsp;{$node.data_map.zip.value} USA</p>

<p>Phone: {$node.data_map.phone.value}</p>

<p>Email: <a target="_blank" href="mailto:{$node.data_map.email.value}">{$node.data_map.email.value}</a></p>

<p>Website: <a target="_blank" href="{$node.data_map.website.value}">{$node.data_map.website.data_text}</a></p>

<p>Contact: {$node.data_map.contact.value}</p>

<b>Hours</b>{foreach $childrenLocations as $child}{set $langid=$child.data_map.language.value.0}{set $lang=$locationEventScheduleClass.data_map.language.content.options.$langid}{set $lang=$lang.name}<p>{$child.name}: {$child.data_map.time.value.timestamp|datetime('event_datetime')} ({$lang})</p>{/foreach}

<p>{$node.data_map.schedule_anomalies.value}</p>

{include uri='design:location_gmaps.tpl' parent=$node nodes=$node}