<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* �� �� �� ��	: �ڿ�>�ڿ�����>��������>������û
* ���α׷� ID	: lc020.jsp
* �� �� �� ��	: ������û
* ��  ��   �� : �� �� ��
* �� �� �� �� : 2017.5.12
-----------------------------------------------------------------------------
*	S1, S2 ��Ÿ����     - 2020.03.24 ��Ȱ��ȭ
*	A1, A2 �ڳ�_0989
*	A3, A4 �ڳ�CS_3260  - 2020.03.24 �߰���
*   T1, T2 ��Ÿ��_0796
*   C1, C2 ī�Ϲ�1_0623
*   C3, C4 ī�Ϲ�2_0887
*   C5, C6 ī�Ϲ�3_0702
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="security.common.*" %>

<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath ���� ����.
  String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>������û</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">


	var strParam = new Array();	//�˾��� �޾ƿ��� �Ķ���͵�

	strParam=window.dialogArguments;
	
	var car;
	
/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
function fnOnLoad(){
		
		
		
		gcem_staxdate.text		= strParam[0];  //��¥
	
		//������ư �����
		document.getElementById("Image0").style.display = "none";			
		
		if(strParam[2] == 'REMARK31'){
			car		    = 'A1';  
		}else if(strParam[2] == 'REMARK32'){
			car		    = 'A2';  
		}else if(strParam[2] == 'REMARK33'){
			car		    = 'T1';  
		}else if(strParam[2] == 'REMARK34'){
			car		    = 'T2'; 	
		}else if(strParam[2] == 'REMARK41'){
			car 		= 'C1';  
		}else if(strParam[2] == 'REMARK42'){    		
			car 		= 'C2'; 
		}else if(strParam[2] == 'REMARK43'){
			car 		= 'C5';  
		}else if(strParam[2] == 'REMARK44'){    		
			car 		= 'C6';  	
		}else if(strParam[2] == 'REMARK51'){
			car 		= 'C3';  
		}else if(strParam[2] == 'REMARK52'){    		
			car 		= 'C4';  	
		}else if(strParam[2] == 'REMARK53'){
			car 		= 'A3';  
		}else if(strParam[2] == 'REMARK54'){    		
			car 		= 'A4';  
		}		
		//alert(strParam);
		
		// ������ �� ������ ���
    	if(strParam[3] == 'N'){
		
	        txt_empno.value =gusrid;
	    	txt_empnmk.value = gusrnm;		

	    	//gcem_staxdate.text		= strParam[0];  //��¥
	    	
	    	fnSelect2();	    	

	    	gclx_starttime.BindColVal 	= strParam[1];  //�ð�
	    	gclx_endtime.BindColVal 	= strParam[1];  //�ð�

	    	//alert(strParam[3]);
	    	
	    	if(strParam[2] == 'REMARK11'){
	    		txt_car_nm.value 		= '�׷���';  	
	    	}else if(strParam[2] == 'REMARK12'){
	    		txt_car_nm.value 		= '�׷���';  
	    	}else if(strParam[2] == 'REMARK21'){
	    		txt_car_nm.value 		= '��Ÿ����_8196';  
	    	}else if(strParam[2] == 'REMARK22'){
	    		txt_car_nm.value 		= '��Ÿ����_8196';  
	    	}else if(strParam[2] == 'REMARK31'){
	    		txt_car_nm.value 		= '�ڳ�_0989';  
	    	}else if(strParam[2] == 'REMARK32'){
	    		txt_car_nm.value 		= '�ڳ�_0989';  	
	    	}else if(strParam[2] == 'REMARK33'){
	    		txt_car_nm.value 		= '��Ÿ��_0796';  
	    	}else if(strParam[2] == 'REMARK34'){
	    		txt_car_nm.value 		= '��Ÿ��_0796';  		    		
	    	}else if(strParam[2] == 'REMARK41'){
	    		txt_car_nm.value 		= 'ī�Ϲ�1_0623';  
	    	}else if(strParam[2] == 'REMARK42'){    		
	    		txt_car_nm.value 		= 'ī�Ϲ�1_0623';  
	    	}else if(strParam[2] == 'REMARK43'){
	    		txt_car_nm.value 		= 'ī�Ϲ�3_0702';  
	    	}else if(strParam[2] == 'REMARK44'){    		
	    		txt_car_nm.value 		= 'ī�Ϲ�3_0702';  	    		
	    	}else if(strParam[2] == 'REMARK51'){
	    		txt_car_nm.value 		= 'ī�Ϲ�2_0887';  
	    	}else if(strParam[2] == 'REMARK52'){    		
	    		txt_car_nm.value 		= 'ī�Ϲ�2_0887';  	 
	    	}else if(strParam[2] == 'REMARK53'){
	    		txt_car_nm.value 		= '�ڳ�CS_3260';  
	    	}else if(strParam[2] == 'REMARK54'){    		
	    		txt_car_nm.value 		= '�ڳ�CS_3260';  		    		
	    	}
	       	
	    	txt_phone_no.value = ds_default.namevalue(1,"EM_PHN_NO");	    	
	    	
			gclx_status.BindColVal 	= 'S';
			
			// �� �߰�
			//ds_default.AddRow();		
			
			
			ds_default.namevalue(1,"CAR_NO") = car;	 			
			ds_default.namevalue(1,"DRIVE_DT") = gcem_staxdate.text;
			
			ds_default.namevalue(1,"FROM_TM") = gclx_starttime.BindColVal;	 			
	
			
			ds_default.namevalue(1,"EM_PHN_NO") = txt_phone_no.value;	    	
			ds_default.namevalue(1,"STATUS") = gclx_status.BindColVal;	  			
		    //prompt(this, ds_default.text);

		// ������ �� ������ ���
    	}else if(strParam[3] == 'Y'){



	    	if(strParam[2] == 'REMARK11'){
	    		txt_car_nm.value 		= '�׷���';  	
	    	}else if(strParam[2] == 'REMARK12'){
	    		txt_car_nm.value 		= '�׷���';  
	    	}else if(strParam[2] == 'REMARK21'){
	    		txt_car_nm.value 		= '��Ÿ����_8196';  
	    	}else if(strParam[2] == 'REMARK22'){
	    		txt_car_nm.value 		= '��Ÿ����_8196';  
	    	}else if(strParam[2] == 'REMARK31'){
	    		txt_car_nm.value 		= '�ڳ�_0989';  
	    	}else if(strParam[2] == 'REMARK32'){
	    		txt_car_nm.value 		= '�ڳ�_0989';  
	    	}else if(strParam[2] == 'REMARK33'){
	    		txt_car_nm.value 		= '��Ÿ��_0796';  
	    	}else if(strParam[2] == 'REMARK34'){
	    		txt_car_nm.value 		= '��Ÿ��_0796';  	    		
	    	}else if(strParam[2] == 'REMARK41'){
	    		txt_car_nm.value 		= 'ī�Ϲ�1_0623';  	    		
	    	}else if(strParam[2] == 'REMARK42'){    		
	    		txt_car_nm.value 		= 'ī�Ϲ�1_0623';  
	    	}else if(strParam[2] == 'REMARK43'){
	    		txt_car_nm.value 		= 'ī�Ϲ�3_0702';  	    		
	    	}else if(strParam[2] == 'REMARK44'){    		
	    		txt_car_nm.value 		= 'ī�Ϲ�3_0702';  	    		
	    	}else if(strParam[2] == 'REMARK51'){
	    		txt_car_nm.value 		= 'ī�Ϲ�2_0887';  	    		
	    	}else if(strParam[2] == 'REMARK52'){    		
	    		txt_car_nm.value 		= 'ī�Ϲ�2_0887';  
	    	}else if(strParam[2] == 'REMARK53'){
	    		txt_car_nm.value 		= '�ڳ�CS_3260';  	    		
	    	}else if(strParam[2] == 'REMARK54'){    		
	    		txt_car_nm.value 		= '�ڳ�CS_3260';  	    		
	    	}
	       	
    		fnSelect();   	  
	    	
	    	if(gusrid == ds_default.namevalue(1,"ENO_NO")){
	    		//alert("��û�� ����� �����ι�");	
	    		//������ư �����
	    		document.getElementById("Image0").style.display = "";	
	    	}else{
	    		//alert("��û�� ����� �ȵ����ι�");	    
	    		document.getElementById("Image0").style.display = "none";	    		
	    		document.getElementById("Image1").style.display = "none";
	    	}
    		
	    	txt_empno.value = ds_default.namevalue(1,"ENO_NO");	    	
	    	txt_empnmk.value = ds_default.namevalue(1,"ENO_NM");	      		
	    	gclx_starttime.BindColVal 	= ds_default.namevalue(1,"FROM_TM"); 
	    	gclx_endtime.BindColVal 	= ds_default.namevalue(1,"TO_TM"); 
	    	
	    	
	    	txt_sayu.value = ds_default.namevalue(1,"SAYU");	
	    	txt_driver_no.value = ds_default.namevalue(1,"DRIVER");
	    	txt_driver_nm.value = ds_default.namevalue(1,"DRIVER_NM");	    	
	    	txt_destination.value = ds_default.namevalue(1,"DESTINATION");	   
	    	gclx_fellow.BindColVal 	= ds_default.namevalue(1,"FELLOW"); 
	    	gclx_cargo.BindColVal 	= ds_default.namevalue(1,"CARGO"); 	    	
	    	txt_phone_no.value = ds_default.namevalue(1,"EM_PHN_NO");
	    	txt_remark.value = ds_default.namevalue(1,"REMARK");	 
	    	txt_insert_ymd.value = ds_default.namevalue(1,"INSERT_YMD");		    	
			gclx_status.BindColVal 	= ds_default.namevalue(1,"STATUS");	   
			
	    	if(gclx_status.BindColVal == "Y"){
	    		//alert("��û�� ����� �����ι�");
	    		document.getElementById("Image0").style.display = "none";	    		
	    		document.getElementById("Image1").style.display = "none";
	    	}		

    	}

		

		
		
		
}

/******************************************************************************
	Description : �ʱ�ȭ 
****************************************************************************/
function fnInit(){
		

		

}

/******************************************************************************
	Description : ��ȸ - ������ �� ������ ���
******************************************************************************/
function fnSelect() {


		 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	 
																				     + ",v_staxdate="+gcem_staxdate.text
																				     + ",v_gusrid=" +gusrid
																				     + ",v_car=" +car																			     
																				     + ",v_from_tm=" + strParam[1]	 
	     																			 + ",v_to_tm=" + strParam[1];	 	 
		 
	    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc020",  "JSP(O:DS_DEFAULT=ds_default)",  param);
	
	    tr_post(tr1);

}

/******************************************************************************
Description : ��ȸ - ������ �� ������ ���
******************************************************************************/
function fnSelect2() {

		 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	 
																				     + ",v_gusrid=" +gusrid;	 	
	
		ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc021",  "JSP(O:DS_DEFAULT=ds_default)",  param);
		
		tr_post(tr1);


		
}


/******************************************************************************
Description : ����
******************************************************************************/
function fnSave() {

	
	    if (fnChk()) {
	        	
			ds_default.namevalue(1,"TO_TM") = gclx_endtime.BindColVal;			    	
			ds_default.namevalue(1,"SAYU") = txt_sayu.value; 	
			ds_default.namevalue(1,"DESTINATION") = txt_destination.value;			
			ds_default.namevalue(1,"DRIVER") = txt_driver_no.value;
			ds_default.namevalue(1,"FELLOW") = gclx_fellow.BindColVal;	 			
			ds_default.namevalue(1,"CARGO")  = gclx_cargo.BindColVal;			
			ds_default.namevalue(1,"REMARK") = txt_remark.value;	    	

	       ln_TRSetting(tr2, "<%=dirPath%><%=HDConstant.PATH_LI%>Lc020",  "JSP(I:DS_DEFAULT=ds_default)",  "proType=A, dsType=1");
	       
	       //prompt(this, ds_default.text);
	       
	       tr_post(tr2);
 
	    }else{
	        	
	       return;
	       
	    }

	    fnSelect();	 

}


/******************************************************************************
Description : ����� üũ
******************************************************************************/
function fnChk() {      	
	
		if(gclx_starttime.bindcolval >= gclx_endtime.bindcolval){
			alert("��û�ð��� Ȯ�����ּ���.");
			return false;
		}
	
		if(txt_sayu.value==""){
			alert("���������� �ʼ��׸��Դϴ�.");
			return false;
		}
		
		if(txt_driver_no.value=="" || txt_driver_no.value=="undefined"){
			alert("�����ڴ� �ʼ��׸��Դϴ�.");
			return false;
		}		
		
		if(txt_destination.value==""){
			alert("�������� �ʼ��׸��Դϴ�.");
			return false;
		}
		
		if(gclx_fellow.bindcolval==""){
			alert("�����ڸ� �Է��ϼ���.");
			return false;
		}
		
		if(gclx_cargo.bindcolval==""){
			alert("ȭ�����θ� �Է��ϼ���.");
			return false;
		}		

		//alert(gclx_endtime.BindColVal);

		 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	 
																				     + ",v_staxdate="+gcem_staxdate.text
																				     + ",v_car=" +car																			     
																				     + ",v_from_tm=" + strParam[1]	 
																					 + ",v_to_tm=" + gclx_endtime.BindColVal;	 	 

		ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc020",  "JSP(O:DS_CHECK=ds_check)",  param);
		
		tr_post(tr1);		
		
		var check = ds_check.namevalue(1,"chk");	
		
		
		if(check >= "1"){
			
			alert("�ߺ��� �ð��� �ֽ��ϴ�.\n");
			
			return false;
		}


		
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
																				     + ",v_staxdate="+gcem_staxdate.text;	 	 

		ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc020",  "JSP(O:DS_WEEK=ds_week)",  param);

		tr_post(tr1);		

		var term = ds_week.namevalue(1,"TERM");	

		

    	
    	// �������� ��� ��¥ ������ ���� �ʵ��� ���� 2019.07.04
		if(gusrid != '6060002' && gusrid != '2030007' && gusrid != '2070019' && gusrid != '3200018'){
    	
			if(gcem_staxdate.text > term){
			
				alert("�ش����� ������ �Ұ��մϴ�.(��¥�ʰ�)\n");
				
				return false;
				
			}		

		}

		//alert(gcem_staxdate.text);
    	
		var temp = gcurdate.replace("-","").replace("-","");
		//alert(temp);
		//return false;

		if(gcem_staxdate.text == temp){
			
			alert("���� ������ �濵�������� ���� �� ��û�Ͻñ� �ٶ��ϴ�.");
			
		}			
		
		
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
		     																			+ ",v_gusrid=" +gusrid;	 	 

		ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc020",  "JSP(O:DS_BLACKLIST=ds_blacklist)",  param);

		tr_post(tr1);		

		
		var BLACKLIST = ds_blacklist.namevalue(1,"BLACKLIST");	


		
		if(BLACKLIST >= "1"){
		
			alert("�̻�� ó���Ǿ����ϴ�. �����ڿ��� �����ϼ���.");
			
			return false;
			

		}				
		
		
		return true;
		
}




/******************************************************************************
Description : ����
******************************************************************************/
function ln_Delete() {

			if(confirm("�����Ͻðڽ��ϱ�?")){				
			
					if (ds_default2.CountColumn == 0) {
						ds_default2.setDataHeader("DRIVE_DT:STRING, CAR_NO:STRING, FROM_TM:STRING, TO_TM:STRING, STATUS:STRING");
					}
					
					// �� �߰�
					ds_default2.AddRow();	

					ds_default2.namevalue(1,"CAR_NO") = car;	 			
					ds_default2.namevalue(1,"DRIVE_DT") = gcem_staxdate.text;
					ds_default2.namevalue(1,"FROM_TM") = gclx_starttime.BindColVal;	 			
					ds_default2.namevalue(1,"TO_TM")  = gclx_endtime.BindColVal;	   	
					ds_default2.namevalue(1,"STATUS") = gclx_status.BindColVal;	 
					
					ds_default2.UserStatus(1) = 2;	
					
				    ln_TRSetting(tr3, "<%=dirPath%><%=HDConstant.PATH_LI%>Lc025",  "JSP(I:DS_DEFAULT2=ds_default2)",  "proType=A, dsType=1");
				     
				    //prompt(this, ds_default2.text);
				     
				    tr_post(tr3);	 
				     
			}

}






/******************************************************************************
Description : ������ ��ȸ
******************************************************************************/
function fnc_ClickEmpPopupSHR() {      


		var strURL;	
		var strPos;
		
		var sendParam	= new Array();		
		var arrResult	= new Array();
	
        var obj = new String();
        var eno_no;
        var eno_nm;
		
		strURL = "../../Security/lc/find_empno.jsp";
		strPos = "dialogWidth:450px;dialogHeight:500px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,sendParam,strPos);		

		if(arrResult != null){
				obj = arrResult.split(";");
				eno_no=obj[0];
				eno_nm=obj[1];
		}

		txt_driver_no.value = eno_no;
		txt_driver_nm.value = eno_nm;

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

<object  id=ds_check classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

<object  id=ds_week classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

<object  id=ds_blacklist classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>

<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>

</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">
	

</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">
  

</script>

<script language=JavaScript for=gcem_staxdate event=onKeyDown(kcode,scode)>


</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>


 </script>

<!-- �׸��� -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=tr2  event=OnSuccess()>

	alert("���������� ����Ǿ����ϴ�.");
	
	window.close();
	
</script>

<script language=JavaScript for=tr3  event=OnSuccess()>

	alert("���������� �����Ǿ����ϴ�.");
	
	window.close();
	
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<body onLoad="fnOnLoad();">


<br>

<table border="0" cellpadding="0" cellspacing="0" width=100%>
	<tr>
		<td class="r">
				<img src="../../Common/img/btn/com_b_delete.gif"	name="Image0"	style="cursor:hand" onclick="ln_Delete()"> &nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			
				
				<img src="../../Common/img/btn/com_b_save.gif"		name="Image1" 	style="cursor:hand" onclick="fnSave()"> &nbsp;
		</td>
	</tr>
</table>

<br>

<table>
	<tr> 
		<td>
			<table border="0" cellpadding="0" cellspacing="0" >
			  <tr>
				<td height="25px" width="120px" style="border:1 solid #708090;border-width:1 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;��û��</td>			  

				<td width="300px" style="border:1 solid #708090;border-left-width:0px">
					<input type="text" class="txt11" id="txt_empno"  style="width:60px;background-color:#d7d7d7" readOnly> &nbsp;
				    <input type="text" class="txt11" id="txt_empnmk" maxlength=8 style="width:90px;" style="width:60px;background-color:#d7d7d7" readOnly> 
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;��û����</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="m l">&nbsp;&nbsp;
					<object  id=gcem_staxdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;top:2px;">		
						<param name=Text						value="">
						<param name=Alignment     				value=0>
						<param name=Border          			value=true>
						<param name=Numeric       				value=false>
						<param name=Format          			value="####-##-##">
						<param name=PromptChar  				value="">
						<param name=BackColor     				value="#CCCCCC">  
						<param name=InheritColor   				value=false>
						<param name=readOnly       				value=true>
						<param name=ReadOnlyBackColor   		value="#d7d7d7">
				   </object>&nbsp;			
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;��û�ð�</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=gclx_starttime classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;top:2px;font-size:12px;width:80px;">
						<param name=CBData			         	value="08^08,09^09,10^10,11^11,12^12,13^13,14^14,15^15,16^16,17^17,18^18,19^19,20^20">
						<param name=CBDataColumns	    		value="CODE,NAME">
						<param name=SearchColumn	    	 	value=NAME>
						<param name=Sort			     		value=false>
						<param name=ListExprFormat       		value="NAME">								
						<param name=BindColumn		     		value="CODE">
						<param name=Enable              		value="false">
		
					</object>&nbsp;����&nbsp;&nbsp;&nbsp;&nbsp; 

					<object id=gclx_endtime classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;top:2px;font-size:12px;width:80px;">
						<param name=CBData			         	value="08^08,09^09,10^10,11^11,12^12,13^13,14^14,15^15,16^16,17^17,18^18,19^19,20^20,21^21">
						<param name=CBDataColumns	    		value="CODE,NAME">
						<param name=SearchColumn	    	 	value=NAME>
						<param name=Sort			     		value=false>
						<param name=ListExprFormat       		value="NAME">								
						<param name=BindColumn		     		value="CODE">
					</object>&nbsp;����		

		 		</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;��û����</td>               
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_car_nm" class="txtbox" type="text" style= "position:relative;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;��������</td>
		  		<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_sayu"    type="text"   class="txtbox"  style= "position:relative;width:280px;height:20px;">
				</td>
			  </tr>				  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;������</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_destination"    type="text"   class="txtbox"  style= "position:relative;width:280px;height:20px;">
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;������</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_driver_no"    type="text"   class="txtbox"  style= "position:relative;width:100px;height:20px;" readOnly="true">		
					<input id="txt_driver_nm"    type="text"   class="txtbox"  style= "position:relative;width:100px;height:20px;" readOnly="true">									
					<img src="../common/img/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopupSHR()" style="cursor:hand;">
				
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;������</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=gclx_fellow classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;top:2px;font-size:12px;width:100px;">
						<param name=CBData			         	value="0^0,1^1,2^2,3^3,4^4,5^5,6^6,7^7,8^8">
						<param name=CBDataColumns	    		value="CODE,NAME">
						<param name=SearchColumn	    	 	value=NAME>
						<param name=Sort			     		value=false>
						<param name="Index" 					value="0">						
						<param name=ListExprFormat       		value="NAME">								
						<param name=BindColumn		     		value="CODE">
					</object>
		 		</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;ȭ������</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=gclx_cargo classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;top:2px;font-size:12px;width:100px;">
						<param name=CBData			         	value="N^����,Y^����">
						<param name=CBDataColumns	    		value="CODE,NAME">
						<param name=SearchColumn	    	 	value=NAME>
						<param name=Sort			     		value=false>
						<param name="Index" 					value="0">							
						<param name=ListExprFormat       		value="NAME">								
						<param name=BindColumn		     		value="CODE">
					</object>
		 		</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;�ڵ���</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_phone_no"    type="text"   class="txtbox"  style= "position:relative;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
                    <textarea id="txt_remark"  name="txt_remark" cols="43" rows="5" maxlength="300" ></textarea>				
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�Է�����</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_insert_ymd"    type="text"   class="txtbox"  style= "position:relative;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=gclx_status classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;top:2px;font-size:12px;width:100px;">
						<param name=CBData			    	value="S^���,Y^����,N^�ݼ�">
						<param name=CBDataColumns			value="CODE,NAME">
						<param name=SearchColumn	    	value=NAME>
						<param name=Sort			    	value=false>
						<param name=ListExprFormat      	value="NAME">								
						<param name=BindColumn		    	value="CODE">
						<param name=Enable              	value="false">
					</object> 
				</td>
			  </tr>
			</table>
			</td>
		  </tr>
        </table>


          &nbsp;&nbsp;���ڵ�����ȣ�� �ٲ� ���� �̵��ư��忡�� �����ٶ��ϴ�.

		</td>
	</tr>
 </table>


</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_DEFAULT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   		Value="ds_default">
	<Param Name="BindInfo", 		Value='

		<C>Col=ENO_NO				Ctrl=txt_empno   					Param=text			</C>		
		<C>Col=ENO_NM				Ctrl=txt_empnmk   					Param=value			</C>	
		<C>Col=FROM_TM				Ctrl=gclx_starttime	   				Param=BindColVal	</C>
		<C>Col=TO_TM   		 		Ctrl=gclx_endtime	 				Param=BindColVal	</C>			
		<C>Col=SAYU				    Ctrl=txt_sayu	   					Param=value			</C>
		<C>Col=DRIVER				Ctrl=txt_driver_no	   				Param=value			</C>			
		<C>Col=DESTINATION			Ctrl=txt_destination	   			Param=value			</C>
		<C>Col=FELLOW				Ctrl=gclx_fellow	   				Param=BindColVal	</C>
		<C>Col=CARGO   		 		Ctrl=gclx_cargo	 					Param=BindColVal	</C>
		<C>Col=EM_PHN_NO			Ctrl=txt_phone_no	   				Param=value			</C>
		<C>Col=REMARK				Ctrl=txt_remark	   					Param=value			</C>
		<C>Col=INSERT_YMD			Ctrl=txt_insert_ymd	   				Param=value			</C>
    '>
</object>

