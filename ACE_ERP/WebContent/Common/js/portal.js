


/* ���콺 ���� */

	/**
	  * ���콺 TR �Ķ���� ����
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
	  * �� �� �� : tr_post()
	  * �Ű����� : ����
	  * ��    �� : Transation Post
	  */
	function tr_post(a_TR)
	{
		a_TR.post();
	}	
