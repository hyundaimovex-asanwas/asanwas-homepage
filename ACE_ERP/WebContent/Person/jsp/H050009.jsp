<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�
+ ���α׷� ID	: h050009.html
+ �� �� �� ��	: ���½�û����
+ �� �� �� ��	: ������
+ �� �� �� ��	: ������ -- ����������Ȳ ������ȯ �߰�
-----------------------------------------------------------------------------
+ �� �� �� �� :	���ڰ���� ���� �� process����
+ ��   ��  �� : ������
+ �� �� �� �� : 2007.09.21
-----------------------------------------------------------------------------
+ �� �� �� ��	: h050005_s1, h050005_s2, h050005_t1, h050001_s1_time
------------------------------------------------------------------------------>

<html>
<head>    
	<jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
get_cookdata();
lfn_init();
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

  ln_SetDataHeader()
	
	gcem_fr.text = gcurdate.substring(0,7) + "01";	//��������
	gcem_to.text = gcurdate;												//��������
	//gcem_empno_1.value = gusrid;									//�����ID
	//txt_NAME.value	= gusrnm;											//����ڸ�

	ln_Query2();
  ln_Enable("F");

	gclx_closeyn.index=0;
	gclx_gubun.index=0;

	//SGNM.value="����ȯ";
  //txt_SGNID.value="1990098";

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";

	var v_str1=fn_trim(gcem_fr.text);
	var v_str2=fn_trim(gcem_to.text);
	var v_str4="";  
	var v_str5="";  

	gcds_data.DataID = "/servlet/Person.h050009_s2?v_str1=" + gcem_fr.text  // from ����
									 + "&v_str2=" + gcem_to.text                                     // to ����
									 + "&v_str3=" + fn_trim(gcem_empno_fr.text)                      // from ���
							  	 + "&v_str4=" + fn_trim(gcem_empno_to.text)                      // to ���
									 + "&v_str5=" + fn_trim(txt_empnmmk.value)                       // ����  
                   + "&v_str6=" + gclx_lazcd_0.bindcolval                          // ���±���
									 + "&v_str7=" + gclx_deptcd_0.bindcolval    		                 // �μ� 
                   + "&v_str8=" + gclx_paygrd_0.bindcolval  	                     // ����		
									 + "&v_str9=" + gclx_closeyn.bindcolval 	                       // �������		
									 + "&v_str10=" + gclx_gubun.bindcolval; 	                       // ����		
	gcds_data.Reset();

  //prompt('',gcds_data.DataID);
	//gcem_frdt.enabled = false; //������
	gclx_LAZCD.enable = false;	 //�ް�����
}

/*-----------------------------------------------------------------------------
		Description : �ް� �����ڵ� ��ȸ
-----------------------------------------------------------------------------*/
function ln_Query2(){
	
	//�Ҽ�,����,����
	//gcds_data2.DataID = "/servlet/Person.h050005_s2?v_str1="+gusrid;
	//gcds_data2.Reset();

	//�ް�����
	gcds_holfee.DataID = "/servlet/Person.hclcode_s1?v_str1=1124&v_str2=C";
	gcds_holfee.Reset();

	gcds_holfee_0.DataID = "/servlet/Person.hclcode_s1?v_str1=1124&v_str2=C";
	gcds_holfee_0.Reset();

	//�Ҽ��ڵ�[��ȸ����]
	gcds_deptcd_0.DataID = "/servlet/Person.hcdept_s1?v_str1=";
	gcds_deptcd_0.Reset();

  //�����ڵ�[�˻�����]
	gcds_paygrd_0.DataID = "/servlet/Person.hclcode_s1?v_str1=2002";
	gcds_paygrd_0.Reset();

}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

	ln_SetDataHeader();
	gcds_data.addrow();	
	ln_Enable("T");

	//gcem_to.text = gcurdate;			//������
	txt_appdt.value= gs_date2;	    //��û��
	gcem_frdt.text = gcurdate;			//������
	gcem_todt.text = gcurdate;			//������

 	gclx_LAZCD.index=0;
	gclx_closeyn_1.bindcolval ="N"; //������  
}

/******************************************************************************
	Description : ���� ���۽ð�����
******************************************************************************/
function ln_CurTime1() {

	if (txt_deptnm.value == "") { 
		alert("�Ҽӵ� �ҼӰ� �����Ƿ� ����� �� �����ϴ�.");
		return false;
	} 

	FRTIME.enabled = false;
	gcds_curtime.DataID = "/servlet/Person.h050001_s1_time";
	gcds_curtime.Reset();

	var h_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(0,2);
	var m_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(3,5);
	var s_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(6,8);

	FRTIME.text = h_time+m_time+s_time;

}

/******************************************************************************
	Description : ���� ��ٽð�����
******************************************************************************/
function ln_CurTime() {

	if (txt_deptnm.value == "") { return false; } 

	TOTIME.enabled = false;
	gcds_curtime.DataID = "/servlet/Person.h050001_s1_time";
	gcds_curtime.Reset();

	var h_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(0,2);
	var m_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(3,5);
	var s_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(6,8);

	TOTIME.text = h_time+m_time+s_time;

	ln_Save();

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

	if (txt_deptnm.value == "") { 
		alert("�Ҽӵ� �ҼӰ� �����Ƿ� ����� �� �����ϴ�.");
		return false;
	} 
	
	if (!ln_Valchk()) return;

	var row = gcds_data.rowposition;

	gcds_data.namevalue(row,"DEPTCD")		=		fn_trim(txt_deptcd.value);		//�Ҽ��ڵ�
	gcds_data.namevalue(row,"EMPNO")		=		gcem_empno_1.text;						//���
	gcds_data.namevalue(row,"DEPTNM")		=		fn_trim(txt_deptnm.value);		//�ҼӸ�
	gcds_data.namevalue(row,"PAYSEQ")		=		txt_paygrdcd.value;						//����
	gcds_data.namevalue(row,"EMPNMK")		=		txt_empnmk_1.value;						//����
	gcds_data.namevalue(row,"SGNID")		=		fn_trim(txt_SGNID.value);			//������ID
	//gcds_data.namevalue(row,"AGRID")		=		txt_AGRID.value;						//������ID
	gcds_data.namevalue(row,"DTYREM")		=		txt_DTYREM.value;							//���»���
  gcds_data.namevalue(row,"BEFYEAR") = BEFYEAR.value;
	gcds_data.namevalue(row,"CURYEAR") = CURYEAR.value;
	gcds_data.namevalue(row,"USEYEAR") = USEYEAR.value;
	gcds_data.namevalue(row,"PAYYEAR") = PAYYEAR.value;

	var v_str1 = txt_appdt.value;
	var v_str2 = gcem_empno_1.text ;					//���
	var v_str3 = fn_trim(txt_SGNID.value);	  //������
	//var v_str4 = txt_AGRID.value;						//������

	if (gcds_data.IsUpdated) {
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){	
		gctr_pyo.Action = "/servlet/Person.h050005_t1?v_str1="+ v_str1+"&v_str2="+v_str2 + "&v_str3=" + v_str3;
		//prompt('',gcds_data.text);
		gctr_pyo.post();
		ln_Query();
		}	
	}
}

/******************************************************************************
	Description : �Է°� üũ[���°���]
******************************************************************************/
function ln_Valchk() {

	var row = gcds_data.rowposition;

	txt_SGDT.value = gcds_data.namevalue(row, "SGDT");
	txt_AGRDT.value = gcds_data.namevalue(row, "AGRDT");

	if (((txt_SGDT.value != "") && (txt_SGDT.value != "99999999")) || ((txt_AGRDT.value != "") && (txt_AGRDT.value != "99999999"))) { 
		alert("������ / ��������  ó�� �� �׸���  ���� �� �� �����ϴ�."); 
		return false;
	}
	
	if (gcem_frdt.text == "") { 
		alert("��Ȯ�� ��û �������� �Է��� �ֽʽÿ�."); 
		gcem_frdt.focus()
		return false;
	}

	if (gcem_todt.text == "") { 
		alert("��Ȯ�� ��û �������� �Է��� �ֽʽÿ�."); 
		gcem_todt.focus()
		return false;
	}
	
	/**
	if (fn_trim(SGNM.value) == "") { 
		alert("��Ȯ�� �����ڸ� �Է��� �ֽʽÿ�."); 
		SGNM.value ="";
		SGNM.focus()
		return false;
	}
	**/

	return true;
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
  /*
	if (((txt_SGDT.value != "") && (txt_SGDT.value != "99999999")) || ((txt_AGRDT.value != "") && (txt_AGRDT.value != "99999999"))) { 
		alert("������ / ��������  ó�� �� �׸���  ���� �� �� �����ϴ�."); 
		return false;
	}
	*/
	if(!ln_Chk_Delete())return;
	if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
	  gcds_data.ClearAllMark();
		for(i=1;i<=gcds_data.countrow;i++){
			if(gcds_data.namevalue(i,"CHK")=="T"){
				gcds_data.MarkRows(i,i);
			}
		}
		gcds_data.DeleteMarked();
		gctr_pyo.action = "/servlet/Person.h050005_t1?v_str1=" + gcem_to.text+ "&v_str2=" + gcem_empno_1.text;
		
		gctr_pyo.post();
		ln_Query();
	}
 }

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

  gcgd_pyo.GridToExcel("���½�û����","",2);

  /***?????????????????????????
  var THeader = "EMPNO:String(8),USEDT:String(7)";
	gcds_useduty.SetDataHeader(THeader);								//Header Set

	//gcds_holday.DataID = "/servlet/Person.h050004_s2?v_str1=" + arg;
	gcds_holday.DataID = "/servlet/Person.h050004_s2?v_str1=200507";
	gcds_holday.Reset();

	//�������� �� ������ȸ
	gcds_duty.DataID = "/servlet/Person.h050009_s1?v_str1=200507";
	gcds_duty.Reset();
  
	//�űԵ���Ÿ ����
	//gcds_useduty
  //''gcds_duty
	//������ ����Ÿ�� ���� ��ȯ 
	????????????????************/
}


/******************************************************************************
	Description : �˾�
******************************************************************************/
function ln_Popup(gbn){
	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

	if(gbn=="1"){
	  if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
			return false;
		}
	}
	arrSend[0]="H050005";
	strURL = "../../Person/html/H030003_popup.html"
	strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

	if(gbn=="0"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_empnmmk.value = arrParam[0]; //����
			
		} else {
			txt_empnmmk.value ="";			//����
		}
	}else if(gbn=="1"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			eval("txt_empnmk_"+gbn).value = arrParam[0]; //����
			eval("gcem_empno_"+gbn).text = arrParam[1];  //���
			eval("txt_deptcd").value=arrParam[4];   //
			eval("txt_deptnm").value=arrParam[2];   //
			eval("txt_paygrdcd").value=arrParam[5];   //
			eval("txt_paygrdnm").value=arrParam[3]; //
			//ln_Paygrd_info(eval("gcem_empno_"+gbn).text);
			//ln_Amt_Setting();//�ݾ׼���
		} else {
			eval("txt_empnmk_"+gbn).value  ="";			//����
			eval("gcem_empno_"+gbn).text="";
			eval("txt_deptcd").value="";   //
			eval("txt_deptnm").value="";   //
			eval("txt_paygrdcd").value="";   //
			eval("txt_paygrdnm").value=""; //
		}
	}
}

/******************************************************************************
	Description : enable / disable
******************************************************************************/
function ln_Enable(p){

	if (p=="T"){
		//gcem_empno_1.enable = true;
		//txt_empnmk_1.disabled = false ;
		//txt_deptnm.disabled = false ;
		//txt_paygrdnm.disabled = false ;
		gclx_LAZCD.enable = true;	//�ް�����
		gcem_frdt.enable = true;
		gcem_todt.enable = true;
		txt_DTYREM.disabled = false ;

	}else if (p=="F") {
		//gcem_empno_1.enable = false;
		gcem_empno_1.ReadOnly = true;
		txt_empnmk_1.ReadOnly = true ;
		//txt_deptnm.disabled = true ;
		//txt_paygrdnm.disabled = true ;
    gclx_LAZCD.enable = false;	//�ް�����
	//	gcem_frdt.enable = false;
	//	gcem_todt.enable = false;
		txt_DTYREM.disabled = true ;
	}
}


/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_Clear(){

		gcem_empno_1.text = "";
		txt_empnmk_1.value= "" ;
		txt_deptnm.value = "" ;
		txt_paygrdnm.value = "" ;
		gclx_LAZCD.bindcolval = "";	//�ް�����
		gcem_frdt.text = "";
		gcem_todt.text = "";
		txt_DTYREM.value = "" ;	
}

/******************************************************************************
	Description : �����˾�
	Parameter :
******************************************************************************/
function ln_Submit(){

	var arrMst	= new Array();
	var arrDtl	= new Array();
	var m=0; //
	var cnt=0;
	var strFrdt="";
	var strTodt="";
	var yy="";
	var mm="";
	var dd="";
	var strFrtime="";
	var strTotime="";

	if(!ln_Chk_Submit()) return;
  
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			 arrMst[0]="HA4";                              //����ڵ�
			 arrMst[1]=gusrid;                             //����ڻ��
			 arrMst[2]=fn_trim(gcds_data.namevalue(i,"DIVNM"))  //+" / "+gcds_data.namevalue(i,"DEPTNM"); //�ٹ��μ���
			 arrMst[3]=gcds_data.namevalue(i,"EMPNO");    //���
			 arrMst[4]=gcds_data.namevalue(i,"PAYGRDNM"); //����
			 arrMst[5]=gcds_data.namevalue(i,"EMPNMK");   //����
			 break;
		}
  }

	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			cnt+=1;
		}
	}
	arrMst[6]=cnt;                                      //���ϱٹ��� �� 

	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			strFrdt = gcds_data.namevalue(i,"FRDT");       //������
			yy = strFrdt.substring(0,4);
			mm = strFrdt.substring(4,6);
			dd = strFrdt.substring(6,8);
			arrDtl[0+m]=yy+"/"+mm+"/"+dd+" "+gf_dayOfWeek(yy,mm,dd);  

			strTodt = gcds_data.namevalue(i,"FRDT");       //������
			yy = strTodt.substring(0,4);
			mm = strTodt.substring(4,6);
			dd = strTodt.substring(6,8);
			arrDtl[1+m]=yy+"/"+mm+"/"+dd+" "+gf_dayOfWeek(yy,mm,dd); 

			arrDtl[2+m]=gcds_data.namevalue(i,"LAZFEENM"); //���±���
			arrDtl[3+m]=gcds_data.namevalue(i,"DTYREM");   //��û����
			arrDtl[4+m]=gcds_data.namevalue(i,"HLNO");    //���¹�ȣ
			m+=5;
		}
  }
	
	//���ȣ��
	//document.all("ifrm").src ="../../Person/html/GP_form.html";
	ifrm.ln_Popup('HA4',arrMst,arrDtl);
}



/******************************************************************************
	Description : �޷°���
  parameter   : �������� ��� ������� key���̶� ���� ���ϰ� ����.
******************************************************************************/
function ln_Calendar(gbn){
	if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
		return false;
	}
	if(gbn=="fr"){
		__GetCallCalendar('gcem_frdt','Text');
	}else if(gbn=="to"){
		__GetCallCalendar('gcem_todt','Text');
	}
}

/******************************************************************************
	Description : �����üũ
	Parameter :
******************************************************************************/
function ln_Chk_Submit(){
	var cnt=0;
	_aa:
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"CLOSYN")!=""&&gcds_data.namevalue(i,"CLOSYN")!="N"){
				alert("������ �� �����ϴ�. ������¸� Ȯ���Ͻʽÿ�.");
				return false;
  		}
			cnt+=1;

			//������ ��� 1�θ� ���� ����...
			for(j=1;j<=gcds_data.countrow;j++){
				if(gcds_data.namevalue(j,"CHK")=="T"){
					if(gcds_data.namevalue(i,"EMPNO")!=gcds_data.namevalue(j,"EMPNO")){
						alert("������ ����� ���� �����մϴ�.");
						return false;
						break _aa;
					}
				}
			}
		}
	}

	if(cnt==0){
		alert("������ ����� �����Ͻʽÿ�.");
		return false;
	}
	return true;
}


/******************************************************************************
	Description : ������ üũ
	Parameter :   N-������, R-ȸ��, B-�ݼ�, H-ȸ�� �� ����������.
******************************************************************************/
function ln_Chk_Delete(){
	var cnt=0;
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(fn_trim(gcds_data.namevalue(i,"CLOSYN"))!=""&&gcds_data.namevalue(i,"CLOSYN")!="N"&&gcds_data.namevalue(i,"CLOSYN")!="R"&&gcds_data.namevalue(i,"CLOSYN")!="B"&&gcds_data.namevalue(i,"CLOSYN")!="H"){
				alert("�ش���� ���� �� �� �����ϴ�.");
				return false;
  		}
			cnt+=1;
		}
	}

	if(cnt==0){
		alert("������ ����� �����Ͻʽÿ�.");
		return false;
	}
	return true;
}


/******************************************************************************
	Description : Dataset Head ���� -  
  parameter   : 1 - 
	              2 - 
******************************************************************************/
function ln_SetDataHeader(){
	if(gcds_data.countrow<1){
		var THeader = "APPDT:String(8),EMPNO:String(7),LAZCD:String(4),DEPTCD:String(4),PAYSEQ:String(4),"
								+ "FRDT:String(8),TODT:String(8),DTYREM:String(100),"
								+ "CLOSYN:String(1),SGDT:String(8),SGNID:String(7),AGRDT:String(8),AGRID:String(7),"
								+ "PAYDT:String(8),AMT:Decimal(7),DEPTNM:String(50), PAYGRDNM:String(30),EMPNMK:String(20),"
								+ "LAZFEENM:String(20),BEFYEAR:String(3),CURYEAR:String(3),USEYEAR:String(3),PAYYEAR:String(3),"
								+ "SGNM:String(20),AGNM:String(20),DIVNM:String(50),CHK:String(1),HLNO:STRING(14)";
		gcds_data.SetDataHeader(THeader);								//Header Set
	}
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_holfee classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">			<!-- �ް����� -->
	<PARAM NAME="SortExpr"	VALUE="+MINORNM">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_curtime classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- ���� �ð����� -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_duty classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"> <!-- ������Ȳ -->
</object></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><object id=gcds_useduty classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"> <!-- ���ں� ������� -->
</object></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><object id=gcds_holday classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- ���� -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_holfee_0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">			<!-- �ް�����(�˻�����) -->
	<PARAM NAME="SortExpr"	VALUE="+MINORNM">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptcd_0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+treecd">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_paygrd_0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050005_t1(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script>

 <comment id="__NSID__"><object id=gctr_useduty classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="useduty_t1(I:USER=gcds_useduty)">
</object></comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//������ ��ȸ �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
		ln_Query2();
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";

	if (CURYEAR.value == "" || CURYEAR.value == null || CURYEAR.value == 'undefinde') {
		CURYEAR.value = "";
		USEYEAR.value = "";
		PAYYEAR.value = "";
	}

</script>

<!-- ������ ���� -->
<script language=JavaScript  for=gcds_duty event=OnLoadCompleted(Row)>
   var tempdt = ""; usedt="",useyymm="", usedd="" ,gubun="", tcnt=0;

	 for (i=1;i<=Row;i++) { /*�������̺��� ��� �Ǽ�*/
	    tempdt = gcds_duty.namevalue(i,"FRDT");
			useyymm = tempdt.substring(0,6);
			userdd = tempdt.substring(6,8);
			for(j=1;j<=gcds_duty.namevalue(i,"CNT");j++){ /*���Ǽ����� ����*/
				usedd = parseInt(userdd)+j-1 ; 
				userdt = useyymm+usedd;
				for(k=1;k<=gcds_holday.CountRow;k++){  /*�������̺��� �������� ����*/
					if (userdt!= gcds_holday.namevalue(k,"HOLDT")){
						gubun="yes";
					}else{
            gubun="no";
						break;
					}
				}
				if (gubun=="yes"){
					gcds_useduty.addrow();
					tcnt=tcnt+1
					gcds_useduty.namevalue(tcnt,"EMPNO") = gcds_duty.namevalue(i,"EMPNO");
					gcds_useduty.namevalue(tcnt,"USEDT") = userdt;
				}
			}
	 }

		gctr_useduty.action = "/servlet/Person.useduty_t1? " ; 
		//prompt("",gcds_useduty.text); 
		gctr_useduty.post();
</script>

<script language="javascript" for="gcds_holfee_0" event="onloadCompleted(row,colid)">
		gcds_holfee_0.insertrow(1);
		gcds_holfee_0.namevalue(1,"MINORCD") = "";
		gcds_holfee_0.namevalue(1,"MINORNM") = "��ü";
		gclx_lazcd_0.index = 0;
</script>

<script language="javascript" for="gcds_deptcd_0" event="onloadCompleted(row,colid)">
	gcds_deptcd_0.insertrow(1);
	gcds_deptcd_0.namevalue(1,"DEPTCD") = "";
	gcds_deptcd_0.namevalue(1,"DEPTNM") = "��ü";
	gclx_deptcd_0.index = 0;
</script>

<script language="javascript" for="gcds_paygrd_0" event="onloadCompleted(row,colid)">
	//����[�˻�����]
	gcds_paygrd_0.insertrow(1);
	gcds_paygrd_0.namevalue(1,"MINORCD") = "";
	gcds_paygrd_0.namevalue(1,"MINORNM") = "��ü";
	gclx_paygrd_0.index = 0;
	
</script>

<!-- <script language="javascript"  for="gcds_data2"  event=onLoadCompleted(rowcount)>

	var row = gcds_data2.rowposition;

	if (txt_deptnm.value != "" && MINORNM.value != "" || gcds_data2.namevalue(row,"DEPTNM") != null) {
		txt_deptnm.value	= gcds_data2.namevalue(row,"DEPTNM");		//�ҼӸ�
		MINORNM.value = gcds_data2.namevalue(row,"MINORNM");	    //����
		txt_empnmk2.value	= gusrnm;																//����	
	} else {
		txt_deptnm.value	= "";
		MINORNM.value = "";
		txt_empnmk2.value	= gusrnm;	
	}

</script>
 -->
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_pyo event=OnClick(Row,Colid)>

	if(Row>0){
	  gcem_empno_1.text = gcds_data.namevalue(Row, "EMPNO");
		if(fn_trim(gcds_data.namevalue(Row,"CLOSYN"))!=""&&gcds_data.namevalue(Row,"CLOSYN")!="N"&&gcds_data.namevalue(Row,"CLOSYN")!="R"&&gcds_data.namevalue(Row,"CLOSYN")!="B"&&gcds_data.namevalue(Row,"CLOSYN")!="H"){
			ln_Enable("F");
		}else{
      ln_Enable("T");
		}
	}
</script>

<script language=JavaScript for=gcem_frdt event=onKillFocus()>
  var yyyymmdd = fn_trim(gcem_frdt.text); 
	var stryyyy="" ,strmm="",strdd="" ;
  
	stryyyy= yyyymmdd.substring(0,4);
	strmm = yyyymmdd.substring(4,6);
	strdd = yyyymmdd.substring(6,8);


  //�� ����
	if(parseInt(strmm)==1 && parseInt(strdd)==1)	{
		stryyyy=(parseInt(stryyyy)-1)+"";
	}
	else {
		stryyyy=stryyyy;
	}

	if (strdd=="01"){
	   //���ں���
		if (strmm== "01" || strmm=="02" || strmm=="04" ||strmm=="06" ||strmm=="08"|| strmm=="09" ||strmm=="11"){
			strdd="31"
		}else if (strmm=="03"){
      strdd="29"
    }else{
			strdd="30"
		}
    
		//������
		if(Number(strmm)==1) strmm="12";
		else
		{
			strmm=(Number(strmm)-1)+"";
		}

		if(strmm.length ==1)
			strmm ="0" + strmm ;
	}else{
		strdd=(Number(strdd)-1)
		if (strdd>=1&&strdd<=9){
		//if(strdd.length==1){
		  strdd ="0" + strdd ;
		}
	}

	gcds_data.namevalue(gcds_data.RowPosition,"APPDT") = stryyyy+strmm+strdd; 

</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h050009_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <img src="../../Common/img/btn/com_b_result.gif"	style="cursor:hand" onclick="ln_Submit()">
		  <img src="../../Common/img/btn/com_b_excel.gif"   style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" ><nobr>�˻�����</nobr></td>
			<td width="210px" class="tab18"><nobr>&nbsp;<comment id="__NSID__"><nobr> 
				<object id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:1px;top:2px;width:70px;height:20px;" >
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> 
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
			 ~&nbsp;
				<comment id="__NSID__"><object id=gcem_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:1px;top:2px; width:70px; height:20px;">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
			</td>
			<td width="80px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>���</nobr></td>
			<td width="130px" class="tab18" ><nobr>&nbsp;<comment id="__NSID__">
			<object id=gcem_empno_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:50px;height:20px;  ">
					<param name=Text          value="">
					<param name=Alignment	    value=0>
					<param name=Border	      value=True>
					<param name=Format	      value="0000000">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=ReadOnly      value=false>
				</object></comment><script>__ws__(__NSID__);</script>
		    ~&nbsp;			
				<comment id="__NSID__"><object id=gcem_empno_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px;width:50px;height:20px;" >
					<param name=Text          value="">
					<param name=Alignment	    value=0>
					<param name=Border	      value=True>
					<param name=Format	      value="0000000">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=ReadOnly      value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</td>
			<td width="80px" align=center  class="tab18"  bgcolor="#eeeeee" ><nobr>����</nobr></td>
			<td class="tab18" >&nbsp;
				<input id="txt_empnmmk" name="txt_empnmmk" type="text"  class="txtbox"  style= "position:relative;left:-5px;top:-2px;width:90px;height:20px;"  maxlength="20" onBlur="bytelength(this,this.value,20);" onkeydown="if(event.keyCode==13) ln_Query();">
			  <img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-5px;top:2px;" onclick="ln_Popup('0')" >
			</td> 
			<td width="80px"  bgcolor="#eeeeee" class="tab18" align=center><nobr>�������</nobr></td>
				<td class="tab18" style="width:140px;" align=center><nobr>&nbsp;
						<comment id="__NSID__">
						<object id=gclx_closeyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:-8px;top:2px;" >
							<param name=CBData			    value="''^��ü,N^������,I^������,Y^����Ϸ�,J^�����Ϸ�,S^���Ű���Ϸ�,R^ȸ��,B^�ݼ�,H^ȸ��">
							<param name=CBDataColumns	  value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORNM">
							<param name=Sort						value="FALSE">
							<param name=ListExprFormat	value="MINORNM^0^100">
							<param name=BindColumn			value="MINORCD">
							<param name=Enable          value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</nobr>
				</td> 
		</tr>
		<tr> 
			<td height="30" align=center class="tab17"  bgcolor="#eeeeee"><nobr>���±���</nobr></td>
			<td width="10" class="tab19" ><nobr>
				<comment id="__NSID__"><object id=gclx_lazcd_0  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  
				  style="position:relative;left:6px;top:0px;font-size:12px;width:173px;"  >
					<param name=ComboDataID			value="gcds_holfee_0">
					<param name=SearchColumn		value="MINORNM">
					<param name=Sort						value="false">
					<param name=ListExprFormat	value="MINORNM^0^173">
					<param name=BindColumn			value="MINORCD">
				</object></comment><script>__ws__(__NSID__);</script>
        </nobr>
			</td>
			<td align=center class="tab19" bgcolor="#eeeeee"><nobr>�Ҽ�</nobr></td>
			<td width="10px" class="tab19" >&nbsp<nobr>
			 	<comment id="__NSID__"><OBJECT id=gclx_deptcd_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-4px;top:2px;font-size:12px;width:130px;">
					<param name=ComboDataID			value="gcds_deptcd_0">
					<param name=SearchColumn		value="DEPTNM">
					<param name=Sort						value="false">
					<param name=ListExprFormat	value="DEPTNM^0^130">
					<param name=BindColumn			value="DEPTCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script> 
				</nobr>
			</td>			
			<td width="80px"   align=center  class="tab19"  bgcolor="#eeeeee" ><nobr>����</nobr></td>
			<td class="tab19">&nbsp;
				<comment id="__NSID__"><OBJECT id=gclx_paygrd_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:-5px;top:2px;font-size:12px;width:150px;">
							<param name=ComboDataID			value="gcds_paygrd_0">
							<param name=CBDataColumns		value="MINORCD, MINORNM">
							<param name=SearchColumn		value=MINORNM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="MINORNM^0^150">
							<param name=BindColumn			value=MINORCD>
					</OBJECT></comment><script>__ws__(__NSID__);</script> 
			</td>
			<td width="80px"  bgcolor="#eeeeee" class="tab19" align=center><nobr>����</nobr></td>
			<td class="tab19" style="width:140px;" align=center><nobr>&nbsp;
					<comment id="__NSID__">
					<object id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:-8px;top:2px;" >
						<param name=CBData			    value="''^��ü,R^������,T^�����">
						<param name=CBDataColumns	  value="MINORCD,MINORNM">
						<param name=SearchColumn		value="MINORNM">
						<param name=Sort						value="FALSE">
						<param name=ListExprFormat	value="MINORNM^0^100">
						<param name=BindColumn			value="MINORCD">
						<param name=Enable          value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</nobr>
			</td> 
		</tr> 
	</table>

	<tr>
	<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-3px;width:280px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:641px;HEIGHT:397px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="indwidth"		value ='0'>
							<param name="Fillarea"		VALUE="true">
              <param name=SortView      value="Left">
							<param name="ColSizing"   value="true">
							<param name=MultiRowSelect	value=true>
							<param name="editable"    value="true">
							<PARAM NAME="Format"			VALUE="  
								<F> Name='����'		    ID=CHK      HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center	sort=false SumBgColor=#C3D0DB EditStyle=CheckBox </F> 
								<F> Name='��û��'			ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER	Mask='XXXX/XX/XX' BgColor='#f5f5f5' Edit=None  sort= true </F> 
								<F> Name='�ҼӸ�'			ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	  Edit=None  sort= true</F>
								<F> Name='����'				ID=PAYGRDNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=LEFT		Edit=None  sort= true </F>
								<F> Name='�̸�'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=LEFT		Edit=None  sort= true</F>
								<F> Name='���±���'		ID=LAZCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  Editstyle=lookup data='gcds_holfee:MINORCD:MINORNM' align=LEFT		Edit=None    BgColor='#f5f5f5'  sort= true </F> 
								<C> Name='������'			ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER	Mask='XXXX/XX/XX' Edit=None  sort= true</C>
								<C> Name='������'			ID=TODT			HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER	Mask='XXXX/XX/XX' Edit=None  sort= true</C>
								<C> Name='��û��'		  ID=EMPNMK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=LEFT		Edit=None  sort= true   show=false</C>
								<C> Name='���³���'	  ID=DTYREM		HeadAlign=Center HeadBgColor=#B9D4DC Width=90  	align=LEFT		Edit=None </C>
								<C> Name='�������'	  ID=CLOSYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=LEFT		Edit=None EditStyle=Combo Data='N:������,I:������,Y:����Ϸ�,J:�����Ϸ�,S:���Ű���Ϸ�,R:ȸ��,B:�ݼ�,H:ȸ��'</C>
							">
            </object></comment><script>__ws__(__NSID__);</script>
			  </td>
			  </tr>
			 </table>

			</td>
			<td>
				<!--�Է�â -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:230px;height:402px;border:1 solid #708090;">
				<tr>
					<td style="width:90px;height:25px;" bgcolor="#eeeeee" align=center class="tab19" >����</td> 
					<td class="tab13"><nobr>
						<comment id="__NSID__">
						<object id=gcem_empno_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:6px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Format	      value="0000000">
							<param name=PromptChar	  value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=ReadOnly      value=false>
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;
						<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-3px;top:2px;" onclick="ln_Popup('1')" >
						<input id="txt_empnmk_1" type="text" class="txt21" style="position:relative;left:-5px;top:-3px;width:70px;"  ReadOnly> 
					</nobr>
					</td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�Ҽ�</nobr></td>
					<td class="tab13"><nobr> 
						<input id="txt_deptcd"  type="text"   class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;" ReadOnly>
						<input id="txt_deptnm"  type="text"   class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
					</nobr></td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
					<td class="tab13"><nobr>
						<input id="txt_paygrdcd"    type="text"   class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;"  ReadOnly>
						<input id="txt_paygrdnm"    type="text"   class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
						<input id="txt_appdt"	  		type="hidden" style="height:20px"  readonly>
					</nobr></td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>���±���</nobr></td>
						<td class="tab13" ><nobr>
						<comment id="__NSID__">
						<object id=gclx_LAZCD classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=150 class="txtbox"  style="position:relative;left:-9px;" >
								<param name=ComboDataID			value=gcds_holfee>
								<param name=SearchColumn		value="MINORNM">
								<param name=Sort						value="FALSE">
								<param name=ListExprFormat	value="MINORNM^0^120">
								<param name=BindColumn			value="MINORCD">
								<param name=Enable          value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>������</nobr></td>
              <td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Format        value="YYYY/MM/DD">
										<param name=PromptChar    value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar('fr')" style="position:relative;width:20px;left:7px;cursor:hand;">  
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="35px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>������</nobr></td>
              <td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Format        value="YYYY/MM/DD">
										<param name=PromptChar    value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar('to')" style="position:relative;width:20px;left:7px;cursor:hand;">  
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�������</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object id=gclx_closeyn_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:5px;" >
									<param name=CBData			    value="N^������,I^������,Y^����Ϸ�,J^�����Ϸ�,S^���Ű���Ϸ�,R^ȸ��,B^�ݼ�,H^ȸ��">
									<param name=CBDataColumns	  value="MINORCD,MINORNM">
									<param name=SearchColumn		value="MINORNM">
									<param name=Sort						value="FALSE">
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value="MINORCD">
									<param name=Enable          value="false">
								</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
							<td width="80px" height="50px" bgcolor="#eeeeee" class="tab19" align=center >���³���</td>
							<td class="tab13" style="text-align:left"><nobr>&nbsp;
								<textarea id="txt_DTYREM" class="txtbox"  style= "width:160px; height:50px; overflow:auto;position:relative;left:-6px" maxlength="100" ></textarea>&nbsp;</nobr>
								<input id="txt_SGNID" name="txt_SGNID"	type="hidden" style= "width:0px; height:1px;" >
								<input id="txt_SGDT"	name="txt_SGDT"		type="hidden" style= "width:0px; height:1px;" >
								<input id="txt_AGRDT"	name="txt_AGRDT"	type="hidden" style= "width:0px; height:1px;" >
							</td>
						</tr>
						<tr>
							<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�������</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<input id="BEFYEAR" name="BEFYEAR" type="text"  class="txtbox" style= "width:30px;height:20px; border=0;background-color:#f1f1f1;position:relative;left:6px;text-align:right"  ReadOnly>
							</nobr></td>
						</tr>
						<tr>
							<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�ݳ����</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<input id="CURYEAR" name="CURYEAR" type="text"  class="txtbox" style= "width:30px;height:20px; border=0;background-color:#f1f1f1;position:relative;left:6px;text-align:right"  ReadOnly>
							</nobr></td>
						</tr>
						<tr>
							<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>������</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<input id="USEYEAR" name="USEYEAR" type="text"  class="txtbox" style= "width:30px; height:20px; border=0;background-color:#f1f1f1;position:relative;left:6px;text-align:right"  ReadOnly>
							</nobr></td>
						</tr>
						<tr>
							<td width="80px" height="25px" bgcolor="#eeeeee" class="tab12" align=center ><nobr>�ܿ�����</nobr></td>
							<td style="text-align:left"><nobr>
								<input id="PAYYEAR" name="PAYYEAR" type="text"  class="txtbox" style= "width:30px;height:20px; border=0;background-color:#f1f1f1;position:relative;left:6px;text-align:right"  ReadOnly>
							</nobr></td>
						</tr>
			  </table>
		 </td>
		 </tr>
		</table>

	<tr>
		<td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search">
		</label></td>
  </tr>	
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=APPDT        Ctrl=txt_appdt		Param=value			</C>
		<C>Col=EMPNO        Ctrl=gcem_empno_1 Param=text			</C>
		<C>Col=LAZCD        Ctrl=gclx_LAZCD	  Param=BindColVal</C>
		<C>Col=LAZFEENM     Ctrl=LAZFEENM			Param=BindColVal</C>
		<C>Col=DEPTCD       Ctrl=txt_deptcd	  Param=value			</C>
		<C>Col=PAYSEQ       Ctrl=txt_paygrdcd Param=value			</C>
		<C>Col=FRDT					Ctrl=gcem_frdt		Param=Text			</C>
		<C>Col=FRTIME				Ctrl=FRTIME				Param=Text			</C>
		<C>Col=TODT					Ctrl=gcem_todt		Param=Text			</C>
		<C>Col=TOTIME				Ctrl=TOTIME			  Param=Text			</C>
		<C>Col=DTYREM				Ctrl=txt_DTYREM		Param=value			</C>
		<C>Col=CLOSYN				Ctrl=gclx_closeyn_1 Param=BindColVal </C>
		<C>Col=SGNID				Ctrl=txt_SGNID		Param=value			</C>
		<C>Col=SGDT					Ctrl=txt_SGDT			Param=value			</C>
		<C>Col=AGRID				Ctrl=AGRID				Param=value			</C>
		<C>Col=AGRDT				Ctrl=txt_AGRDT		Param=value			</C>
		<C>Col=PAYDT				Ctrl=PAYDT				Param=Text			</C>
		<C>Col=AMT					Ctrl=AMT					Param=value			</C>
		<C>Col=PAYGRDNM			Ctrl=txt_paygrdnm Param=value			</C>
		<C>Col=DEPTNM				Ctrl=txt_deptnm		Param=value			</C>
		<C>Col=EMPNMK				Ctrl=txt_empnmk_1	Param=value			</C>
		<C>Col=SGNM					Ctrl="" 					Param=value			</C>
		<C>Col=BEFYEAR			Ctrl=BEFYEAR			Param=value			</C>
		<C>Col=CURYEAR			Ctrl=CURYEAR			Param=value			</C>
		<C>Col=USEYEAR			Ctrl=USEYEAR			Param=value			</C>
		<C>Col=PAYYEAR			Ctrl=PAYYEAR			Param=value     </C>
	'>
</object></comment><script>__ws__(__NSID__);</script>


<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 
<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html><jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>



