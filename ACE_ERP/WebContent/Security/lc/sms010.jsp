<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* �� �� �� ��	: �ڿ�>�ڿ�����>SMS����>SMS����
* ���α׷� ID	: sms010.jsp
* �� �� �� ��	: ���������Է�
* ��  ��   �� : �� �� ��
* �� �� �� �� : 2019.06.17
-----------------------------------------------------------------------------
* �� �� �� �� : 
* ��   ��  �� :
* �� �� �� �� : 
-----------------------------------------------------------------------------
* �� �� �� ��	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="security.common.*" %>
<%@ page import="Ehr.common.util.DateUtil" %>
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
<title>SMS����</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">


/*----------------------------------------------------------------------------
 * �������ε�
----------------------------------------------------------------------------*/

		function fnOnLoad(tree_idx){
			
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gcgd_disp1"), "comn");  //grid ���� 

		    fnInit();

			//fnSelect();
		    
		}



/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function fnSelect(){


		     
}


/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function fnInit(){

	  	//�����(������) �ϴ� ��ȸ
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        
    	ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Sms010",  "JSP(O:gcds_data00=gcds_data00)",  param);

	    tr_post(tr1);	  	        

}



/*----------------------------------------------------------------------------
	Description : ���� 
----------------------------------------------------------------------------*/

function fn_Save(){  
		
		if(!fnSave_Chk()) return;

		if(confirm("�޼����� �����Ͻðڽ��ϱ�?")){			
	
			var message = document.getElementById("txtComment").innerText;
			
			for(i=1;i<=gcds_data00.countrow;i++){

				if(gcds_data00.namevalue(i,"CHK") == "T"){

					gcds_data00.namevalue(i,"MEMO")=message;

				}
				
			}

		}			

}



/*---------------------------------------------------------------------------
	Description : ����� üũ  
---------------------------------------------------------------------------*/

function fnSave_Chk(){

		return true;	

}



/*----------------------------------------------------------------------------
Description : ����� �߰� 
----------------------------------------------------------------------------*/

function fn_Add(){  
	

	if(confirm("��������� �߰��Ͻðڽ��ϱ�?")){			

		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		
		strURL = "<%=dirPath%>/Security/lc/sms011.jsp"
		
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		
		if (arrResult != null) {
			
			gcds_data00.addrow();
			
			arrParam = arrResult.split(";");
			
			gcds_data00.namevalue(gcds_data00.rowposition, "DPT_NM" ) 		= arrParam[0];		
			gcds_data00.namevalue(gcds_data00.rowposition, "JOB_NM" ) 		= arrParam[1];
			gcds_data00.namevalue(gcds_data00.rowposition, "ENO_NM" ) 		= arrParam[2];
			gcds_data00.namevalue(gcds_data00.rowposition, "EM_PHN_NO" ) 	= arrParam[3];
			
   		}	

	}			

}

/******************************************************************************
Description :  SMS ����
******************************************************************************/

function fn_Tran(){

	
	if(!gcds_data00.IsUpdated) {

		alert("�Էµ� ������ �����ϴ�.");
		
		return false;
		
	}	
	
	for(i=1;i<=gcds_data00.countrow;i++){

		if(gcds_data00.namevalue(i,"CHK") == "T"){
			
			if(gcds_data00.namevalue(i,"MEMO") == ""){
				
				alert("�޼����� �����Ͻñ� �ٶ��ϴ�.");
				
				return false;
				
			}
		}
	}
	
	
	if(confirm("�޼����� �����Ͻðڽ��ϱ�?")){			
		
		//var date;
		//var phone;
		
		//if (ds_default01.CountColumn == 0) {
		//	ds_default01.setDataHeader("MESSAGE:STRING, EM_PHN_NO:STRING");
		//}
		
		// �� �߰�
		//ds_default01.AddRow();	

		//date = gcem_staxdate.text;
		//date = date.substring(0,4) + "��" + date.substring(4,6) + "��" + date.substring(6,8) + "��";

		//phone = txt_phone_no.value;
		//phone = phone.replace("-","").replace("-", ""); 

		 // �⺻����
         var param = "proType=A";   			 

	     ln_TRSetting(tr1, "<%=dirPath%><%=HDConstant.PATH_LI%>Sms010",  "JSP(I:gcds_data00=gcds_data00)",  param);

	     //prompt(this, gcds_data00.text);

	     tr_post(tr1);	 

	}	
	
}

</script>




<script language="javascript" for="gcgd_disp1" event="OnClick(row,colid)">

	if((row==0) && (colid=="CHK")){

	    if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;		
		
		for(i=1;i<=gcds_data00.countrow;i++){

			if(gs_gubun=="1"||gs_gubun==""){
				
				gcds_data00.namevalue(i,"CHK")="T";

			}else{
				
				gcds_data00.namevalue(i,"CHK")="F";

			}
			
		}
		
	}
</script>


<%
/*=============================================================================
				Developer Java Script ��
=============================================================================*/
%>
    
<%
/*=============================================================================
			Gauce Components Event Scripts ����
=============================================================================*/
%>

<%
/*=============================================================================
			Gauce Components Event Scripts ��
=============================================================================*/
%>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts ����
=============================================================================*/
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����-TR1
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		ln_Query();
	</script>	

<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR1
%>

	<script language="javascript" for="gctr_data" event="onfail()">
		alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
	</script>


<%
/*=============================================================================
			Transaction Component's Event Message Scripts ��
=============================================================================*/
%>

<%
/*=============================================================================
			DataSet Components(DS) ���� ����
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<%=HDConstant.COMMENT_START%>
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
		<param name="KeyName"  	 value="toinb_dataid4">
		<param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
	
	<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
		<param name="KeyName"  	 value="toinb_dataid4">
		<param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>	
<%=HDConstant.COMMENT_END%>

<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<!-- ��ư ���̺� ���� -->
<table width="970" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:3px">
	<tr>
		<td height="30" class="paddingTop5" align="right">
			<img src="../../Common/img/btn/com_b_rowadd.gif"	name="Image2"	style="cursor:hand" onclick="fn_Add()">&nbsp;			
			<img src="../../Common/img/btn/com_b_trans.gif"		name="Image3"	style="cursor:hand" onclick="fn_Tran()">
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� --> 



<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<font color="blue" size = "2">* �޼��� �Է�</font>
	    <tr>
			<td class="padding2423" align="left" valign="top">
				<textarea id="txtComment"  cols=40  rows=10> [�ΰ�]
 
���:
����:
����ó:</textarea>
				<img src="../../Common/img/btn/com_b_save.gif"		name="Image1"	style="cursor:hand" onclick="fn_Save()">
				<br>
				<br>1. ���� ����ڸ� ����/����/����� �߰�
				<br>&nbsp;&nbsp;(������� ��� ��ȭ��ȣ �ٸ� �� ����)
				<br><br>2. �޼��� �Է� �� ����
				<br><br>3. ���� ��ư�� ������ SMS �߼۵�
				<br><br>4. 85byte �̹Ƿ� ��ü ���� �� �׽�Ʈ ����			
			</td>

			<td>
				<!-- body table -->
				<table cellpadding="0" cellspacing="0" width=730 height=600 bordercolor=black border="0">
						<tr>
							<td align="left" >
								<%=HDConstant.COMMENT_START%>
								<OBJECT classid=<%=HDConstant.CT_GRID_CLSID%> id=gcgd_disp1 style="width:700;height:600px;border:1 solid #708090;border-right-width:1px;border-left-width:1px;border-top-width:1px;">
										<PARAM NAME="DataID"				VALUE="gcds_data00">
										<PARAM NAME="BorderStyle" 			VALUE="0">
										<PARAM NAME="Indwidth"				VALUE="0">
										<PARAM NAME="Fillarea"				VALUE="true">
										<PARAM NAME="Colsizing"				VALUE="true">
										<PARAM NAME="editable"				VALUE="true">
										<PARAM NAME="TitleHeight"			VALUE=20>
										<param name="sortview"    			value=left>
										<param name="ViewSummary"  			value="1">
										<PARAM NAME="Format"				VALUE="  
											  <C> Name='No'						ID={CURROW}				Width=30	align=center edit=none</C>   
					                          <C> name='CHK'             		ID='CHK'         		Width=20    align=center edit=true editstyle=CheckBox HeadCheck=false HeadCheckShow=true</C>           
					                          <C> name='�μ�'             		ID='DPT_NM'         	Width=120   align=center edit=none sort=true</C>
					                          <C> name='��å'        			ID='JOB_NM'        		Width=80    align=center edit=none sort=true</C>   
					                          <C> name='���'        			ID='ENO_NO'         	Width=100   align=center show=false</C>  
					                          <C> name='����'        			ID='ENO_NM'         	Width=80    align=center edit=none sort=true</C>  
					                          <C> name='���Ź�ȣ'     			ID='EM_PHN_NO'         	Width=100   align=center edit=none </C>
					                          <C> name='�޼���'     			ID='MEMO'         		Width=250   align=left   edit=none</C>                            
								">
								</OBJECT>
								<%=HDConstant.COMMENT_END%>
							</td>
						</tr>
				</table>
			</td>
		</tr>
</table>

<!-- �⺻�� -->
	<%=HDConstant.COMMENT_START%>
	<OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 >
		<PARAM NAME="DataID"				VALUE="gcds_data00">
		<PARAM NAME="ActiveBind"			VALUE="true">
		<PARAM NAME="BindInfo"				VALUE="
			<C>Col=YOIL       		 				Ctrl=empno      			   					Param=Value</C>
			<C>Col=ENO_NM       					Ctrl=empnmk       								Param=Value</C>
			<C>Col=DEPT_CD   			 			Ctrl=txt_dept_cd     					  		Param=Value</C>
			<C>Col=T_PAY 							Ctrl=gcem_t_pay 								Param=Text</C>		
		">
	</OBJECT>
	<%=HDConstant.COMMENT_END%>


<!--------------------------------- �ڵ� �κ� �� --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>


