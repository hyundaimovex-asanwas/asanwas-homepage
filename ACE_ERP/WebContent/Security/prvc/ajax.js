function GetHttpRequest( URL, Param )
{ 
	var xmlhttp = null; 
	// FF�� ��� window.XMLHttpRequest ��ü�� �����Ѵ�. 
	if( window.XMLHttpRequest )
		// FF �� ��ü���� 
		xmlhttp = new XMLHttpRequest(); 
	else 
		// IE ��� ��ü���� 
		xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP" ); 

	// ���� ���� ������� ȣ���� �޼ҵ带 �ٷ� ���� 
	xmlhttp.onreadystatechange = function()
	{ 
		// readyState �� 4 �� status �� 200 �� ��� �ùٷ� ������
		if( xmlhttp.readyState == 4 && xmlhttp.status == 200 )
			// responseText �� ���� ���� 
			var responseText = xmlhttp.responseText;
	}

	// POST ���� HTTP ��û�� ������
	xmlhttp.open( "POST", URL, false );
	xmlhttp.setRequestHeader( "Content-Type", "application/x-www-form-urlencoded" ); 
	xmlhttp.send( Param ); 
	responseText = xmlhttp.responseText;

	// ������ xmlhttp ��ü�� responseText ���� ��ȯ
	return responseText;
}

String.prototype.trim = function()
{
    return this.replace( /(^\s*)|(\s*$)/gi, "" );
}