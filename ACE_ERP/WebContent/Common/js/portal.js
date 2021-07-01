


/* 가우스 관련 */

	/**
	  * 가우스 TR 파라미터 세팅
	  */
	function ln_TRSetting(a_TR, a_TR_ACTION,a_TR_KEYVALUE, a_TR_PARAMETERS )
	{
	
		a_TR.ServerIP   = ""              ;
	   	a_TR.Action     = a_TR_ACTION     ;
	   	a_TR.KeyName    = "Toinb_dataid4" ;
	   	a_TR.KeyValue   = a_TR_KEYVALUE   ;
	   	a_TR.Parameters = a_TR_PARAMETERS ;
	
	}
	
	/**
	  * 함 수 명 : tr_post()
	  * 매개변수 : 없슴
	  * 설    명 : Transation Post
	  */
	function tr_post(a_TR)
	{
		a_TR.post();
	}	
