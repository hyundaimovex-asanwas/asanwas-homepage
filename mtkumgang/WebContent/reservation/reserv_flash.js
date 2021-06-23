function printReservFlash()
{
    var str = "";
    str += "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0\" width=\"884\" height=\"529\" id=\"Reservation_Check5\" align=\"middle\">\n";      
    str += "<param name=\"allowScriptAccess\" value=\"sameDomain\" />\n";
    str += "<param name=\"movie\" value=\"Reservation.swf\" />\n";
    str += "<param name=\"quality\" value=\"high\" />\n";
    str += "<param name=\"bgcolor\" value=\"#ffffff\" />\n";
    str += "<embed src=\"Reservation.swf\" quality=\"high\" bgcolor=\"#ffffff\" width=\"884\" height=\"529\" name=\"Reservation_Check5\" align=\"middle\" allowScriptAccess=\"sameDomain\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" />\n";
    str += "</object>\n";
    document.write(str);
}