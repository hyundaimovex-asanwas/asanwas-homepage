<script language=javascript>
// 스크립트가 적용될 태그를 지정하세요
var tgs = new Array( 'div','td','tr');

var szs = new Array( 'xx-small','x-small','small','medium','large','x-large','xx-large' );
var startSz = 1;

function resizeText( trgt,inc ) {
        if (!document.getElementById) return
        var d = document,cEl = null,sz = startSz,i,j,cTags;
        
        sz += inc;
        if ( sz < 0 ) sz = 0;
        if ( sz > 4 ) sz = 4;
        startSz = sz;
                
        if ( !( cEl = d.getElementById( trgt ) ) ) cEl = d.getElementsByTagName( trgt )[ 0 ];

        cEl.style.fontSize = szs[ sz ];

        for ( i = 0 ; i < tgs.length ; i++ ) {
                cTags = cEl.getElementsByTagName( tgs[ i ] );
                for ( j = 0 ; j < cTags.length ; j++ ) cTags[ j ].style.fontSize = szs[ sz ];
        }
}

</script>

<table border="0" cellpadding="0" cellspacing="0" width="644">
<tr><td height="7"></td></tr>
<tr>
	<td align="right" style="padding-right:7">
		
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="70"><img src="/img/common/textsize_img.gif"></td>
			<td width="14"><a href="javascript:resizeText('tarea',1)"><img src="/img/common/textsize_big.gif"></a></td>
			<td><a href="javascript:resizeText('tarea',-1)"><img src="/img/common/textsize_small.gif"></a></td>
		</tr>
		</table>
	</td>
</tr>
</table>

