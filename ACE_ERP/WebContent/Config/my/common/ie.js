document.writeln('<table width='+width_num+' height='+height_num+' border="0" cellpadding="0" cellspacing="0">');
document.writeln('<tr><td>');
document.writeln('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" ');
document.writeln('codebase="http://fpdownload.macromedia.com/1/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="'+width_num+'"height="'+height_num+'" id="flashVar">');
document.writeln('	<param name="movie" value=../common/MAIN.swf?t1='+loca+'>');
document.writeln('	<param name="quality" value="high">');
document.writeln('	<param name="wmode" value="transparent">');
document.writeln('	<param name="allowScriptAccess" value="always" />');
document.writeln('	<embed src=../common/MAIN.swf?t1='+loca+' quality="high" menu="false" pluginspage="http://www.macromedia.com/go/getflashplayer" ');
document.writeln('	type="application/x-shockwave-flash" width="'+width_num+'"height="'+height_num+'"></embed></object>');
document.writeln('</td></tr>');
document.writeln('</table>');