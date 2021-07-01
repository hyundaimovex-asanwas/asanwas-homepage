function GetHttpRequest( URL, Param )
{ 
	var xmlhttp = null; 
	// FF일 경우 window.XMLHttpRequest 객체가 존재한다. 
	if( window.XMLHttpRequest )
		// FF 로 객체선언 
		xmlhttp = new XMLHttpRequest(); 
	else 
		// IE 경우 객체선언 
		xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP" ); 

	// 값을 가져 왔을경우 호출할 메소드를 바로 선언 
	xmlhttp.onreadystatechange = function()
	{ 
		// readyState 가 4 고 status 가 200 일 경우 올바로 가져옴
		if( xmlhttp.readyState == 4 && xmlhttp.status == 200 )
			// responseText 에 값을 저장 
			var responseText = xmlhttp.responseText;
	}

	// POST 모드로 HTTP 요청을 전송함
	xmlhttp.open( "POST", URL, false );
	xmlhttp.setRequestHeader( "Content-Type", "application/x-www-form-urlencoded" ); 
	xmlhttp.send( Param ); 
	responseText = xmlhttp.responseText;

	// 가져온 xmlhttp 객체의 responseText 값을 반환
	return responseText;
}

String.prototype.trim = function()
{
    return this.replace( /(^\s*)|(\s*$)/gi, "" );
}