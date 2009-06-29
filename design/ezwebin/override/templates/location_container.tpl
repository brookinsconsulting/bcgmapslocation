{**
 * File containing the location_container template
 *
 * @package bcgmapslocation
 * @version //autogentag//
 * @copyright Copyright (C) 2009 Brookins Consulting. All rights reserved.
 * @license GPL v2 (or later)
 *}{def $locationClassID=ezini( 'GMapsLocationSettings', 'LocationClassID', 'bcgmapslocation.ini' )}{def $classLocation=fetch( 'content', 'class', hash( 'class_id', $locationClassID ) )
     $locations = fetch( 'content', 'list', hash(  'parent_node_id',
                  $node.node_id,
                  'sort_by', array( 'priority', true() ),
                  'depth', 4,
                  'class_filter_type', 'include',
                  'class_filter_array', array( 'location' ) ) )
}{include uri='design:location_gmaps.tpl' parent=$node nodes=$locations class=$classLocation}