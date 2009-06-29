<?php
class bcgmapslocationInfo
{
    function info( )
    {
	$BCCurrentYearString = date('Y');
        return array(
	    'Name' => "<a href='http://projects.ez.no/bcgmapslocation'>BC GMaps Location</a>",
            'Version' => '1.0.0',
            'Copyright' => "Copyright (C) 2008 - $BCCurrentYearString <a href='http://brookinsconsulting.com/'>Brookins Consulting</a>",
            'License' => "GNU General Public License v2.0 (or later)",
            'Author' => "Brookins Consulting"
	    );
    }
}
?>