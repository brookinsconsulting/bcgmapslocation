{default attribute_base=ContentObjectAttribute}
<div class="block">
<div class="element">
  <div class="block">
    <label>{'Latitude'|i18n('/extension/bcgmapslocation/datatypes/bcgmapslocation')}:</label>
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_latitude" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_bcgmapslocation_latitude_{$attribute.id}" value="{$attribute.content.latitude}" />
  </div>
  <div class="block">
    <label>{'Longitude'|i18n('/extension/bcgmapslocation/datatypes/bcgmapslocation')}:</label>
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_longitude" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_bcgmapslocation_longitude_{$attribute.id}" value="{$attribute.content.longitude}" />
  </div>
  <div class="block">
    <label>&nbsp;</label>
    <br />
  </div>
  <div class="block">
    <label>{'Update Location'|i18n('/extension/bcgmapslocation/datatypes/bcgmapslocation')}:</label>
    <br /><input type="button" id="button_update_{$attribute.id}" value="Update values" onClick="javascript:void( null ); return false" />
  </div>
</div>
<div class="element">
<script src="http://maps.google.com/maps?file=api&amp;v=2.x&amp;key={ezini('GMapsLocationSettings','GMapsKey','bcgmapslocation.ini')}" type="text/javascript"></script>
<script type="text/javascript">
    function MapControl_{$attribute.id}()
    {literal} 
    {
    {/literal}
        var attribid = {$attribute.id}
        var mapid = 'map_{$attribute.id}';
        var addressid = 'address_{$attribute.id}';
        var buttonid = 'button_{$attribute.id}';
        var buttonupdateid = 'button_update_{$attribute.id}';
        var latid = 'ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_latitude';
        var longid = 'ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_longitude';
        {literal}
        
        var map = null;
        var geocoder = null;
        var gmapExistingOnload = null;
        var marker = null;
        var me = this;
    
        var showAddress=function() {
          var addrObj = document.getElementById(addressid);
          var address = addrObj.value;
          if (geocoder) {
            geocoder.getLatLng(
              address,
              function(point) {
                if (!point) {
                  alert(address + " not found");
                } else {
                  map.setCenter(point, 13);
                  marker = new GMarker(point);
                  map.addOverlay(marker);
                  // updateLatLngFields(point);
                }
              }
            );
          }
        };

        /*
        if (window.onload)
        {
                //Hang on to any existing onload function.
                gmapExistingOnload = window.onload;
        }
        */
        
        var updateLatLngFields=function(point){
                  document.getElementById(latid).value = point.lat(); 
                  document.getElementById(longid).value = point.lng(); 
        };

        var updateLatLngFieldsWrapper=function(){
		  var point = new GLatLng( map.getCenter().lat(), map.getCenter().lng() );
		  updateLatLngFields( point );
        };    
        //window.onload=function(ev){
        //Run any onload that we found.
        /*
        if (gmapExistingOnload)
        {
                gmapExistingOnload(ev);
        }
        */
        if (GBrowserIsCompatible()) {
          var startPoint = null;
          var zoom = 0;
          if (document.getElementById(latid).value)
          {
              startPoint = new GLatLng(document.getElementById(latid).value, document.getElementById(longid).value);
              zoom=13;
          }
          else
          {
              startPoint = new GLatLng(0,0);
          }
          
          map = new GMap2(document.getElementById(mapid));
          map.addControl(new GSmallMapControl());
          map.addControl(new GMapTypeControl());
          map.setCenter(startPoint, zoom);
          map.addOverlay(new GMarker(startPoint));
          geocoder = new GClientGeocoder();
          GEvent.addListener(map, "click", function(newmarker, point) {
              map.clearOverlays();
              map.addOverlay(new GMarker(point));
              map.panTo(point);
              // updateLatLngFields(point);
              document.getElementById(addressid).value='';
          });
          
          
          document.getElementById(buttonid).onclick = showAddress;
          document.getElementById(buttonupdateid).onclick = updateLatLngFieldsWrapper;
        }
    }
    
  if (window.addEventListener)
  {
  {/literal}
    window.addEventListener('load', MapControl_{$attribute.id}, false);
  {literal}
  }
  else if (window.attachEvent)
  {
  {/literal}
    window.attachEvent('onload', MapControl_{$attribute.id});
  {literal}
  }

    {/literal}
</script>

<div id="map_{$attribute.id}" style="width: 340px; height: 200px"></div>
<input type="text" id="address_{$attribute.id}" size="42"/><input type="button" id="button_{$attribute.id}" value="Find Address"/>
</div>

<div class="break"></div>
</div>
{* fin *}