// lo: source url
// w: source width
// h: source height
// t: wmode ("" none, transparent, opaque ...)
function view_flash(url,width,height,t)
{
	document.write("<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='" + width + "' height='" + height + "'>");
	document.write("<param name='movie' value='" + url + "'>");
	document.write("<param name='wmode' value='" + t + "'>");
	document.write("<param name='quality' value='high'>");
	document.write("<param name='allowScriptAccess' value='always'>");
	document.write("<embed src='" + url + "' quality='high' allowScriptAccess='always' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='" + width + "' height='" + height + "' Wmode='"+t+"'></embed></object>");
}

function view_flash2(Lo,W,H){
document.write('<object Classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" Codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="'+W+'" height="'+H+'">');
document.write('<param Name="movie" Value="'+Lo+'">');
document.write('<param Name="quality" Value="high">');
document.write('<param Name="wmode" Value="transparent">');
document.write("<param name='allowScriptAccess' value='always'>");
document.write('<embed Src="'+Lo+'" width="'+W+'" height="'+H+'" Quality="high" allowScriptAccess="always" Pluginspage="http://www.macromedia.com/go/getflashplayer" Type="application/x-shockwave-flash" Wmode="transparent"></embed>');
document.write('</object>');
}