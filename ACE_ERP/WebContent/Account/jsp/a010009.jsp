
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� �� :  �ŷ�ó upload
+ ���α׷� ID :  A010008.html
+ �� �� �� �� : 
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2008.07.23
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ �� �� �� �� :	
+ ��   ��  �� : 
+ �� �� �� �� :  
-----------------------------------------------------------------------------
+ �� �� �� �� :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title></title>

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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
    /*
		gcds_data.DataID = g_servlet+"/Account.a010007_s1?v_str1="+gcrd_tablegb.codevalue;
		prompt('',gcds_data.DataID);
		gcds_data.Reset();
		*/
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

	gcds_data.UseChangeInfo = "false";
  //prompt('',gcds_data.text);
  
	/*
  if(gcds_data.countrow <1){
		alert("������ ����Ÿ �������� �ʽ��ϴ�. Ȯ�ιٶ��ϴ�.");
		return false;
	}
  */

	if(confirm("�����Ͻðڽ��ϱ�?")){

       gctr_data0.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010009_t0?";
		gctr_data0.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;	
					
		gctr_data0.post();
  /*
		gctr_data0.KeyValue = "a010009_t1(I:USER=gcds_data)";
		gctr_data0.Action = g_servlet+"/Account.a010009_t1?";
		//gctr_data0.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;	
		prompt('',gcds_data.text);
		gctr_data0.post();
		*/
	}
	
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

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

}


/******************************************************************************
	Description : �˾�
******************************************************************************/
function ln_Popup(){

}


/******************************************************************************
	Description : ���� ������ �׸���� ��������
	parameter   :  - grid object�� , p2 - sheet��
******************************************************************************/
function ln_Excel_Apply(){
        gcds_excel.clearAll(); 
	    gcds_data.clearAll();

        //dataSet head �����
		ln_SetDataHeader();
    
		gcds_excel.addrow();
		gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_INFO") = file_path.value;
		gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_URL") = file_path.value;

		//gctr_data.KeyValue = "excel_upload_t1?(I:USER=gcds_excel,O:USER2=gcds_data)";
		/*
		gctr_data.KeyValue = "excel_upload_t1(I:USER=gcds_excel)";
		gctr_data.Action = g_servlet+"/Account.excel_upload_t1?";
		*/

		gctr_data.KeyValue = "excel_upload_t1(I:USER=gcds_excel,O:USER2=gcds_data)";
		gctr_data.Action ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>excel_upload_t1?";
		//prompt('',gcds_excel.text);
		gctr_data.post();
   
}

 /*-----------------------------------------------------------------------------
	Description : Dataset Head ���� - gcds_data00
-----------------------------------------------------------------------------*/
	function ln_SetDataHeader(){
		if(gcds_excel.countrow<1){
				var s_temp = "EXCEL_INFO:STRING(255),EXCEL_URL:URL";
				gcds_excel.SetDataHeader(s_temp);
		}
	}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_excel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
 <object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

 <object  id=gctr_data0 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010009_t0(I:USER=gcds_data)"> 
	<param name=TimeOut       value=3600000>
</object>
</comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!="") {
		file_path.value = gcip_file.value;
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
  	alert("���� �ҷ����Ⱑ �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");

</script>
 
<script language=JavaScript for=gctr_data0 event=OnSuccess()>
    alert("���������� �����Ͽ����ϴ�.");
	gcds_data.UseChangeInfo = "true"
</script>

<script language=JavaScript for=gctr_data0 event=OnFail()>
	alert("Error Code : " + gctr_data0.ErrorCode + "\n" + "Error Message : " + gctr_data0.ErrorMsg + "\n");
	gcds_data.UseChangeInfo = "true";

</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr>
		<td>
			<table width="876" cellpadding="0" cellspacing="0" border="0" >
				<tr> 
					<td >
			       		<img src="../img/a010009_head.gif"> 
					</td>
					<td width="876" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	 style="cursor:hand" onclick="ln_Save()">
					</td>
				</tr>
       </table>
    </td>
  </tr>

  <tr>
	<td>
     <table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
			<tr width="876px"> 
				<td width="80px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;��������&nbsp;</nobr></td>
				<td class="tab18" style="width:750px;"><nobr>&nbsp;
						<input type="text" name="file_path" value="" style="position:relative;top:-2px;width:350px;" >&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="position:relative;top:4px;width:70;height:20"  >
							<param name="Text"		value="ã�ƺ���">
						</OBJECT>&nbsp;
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_btn_exl_app.gif" style="position:relative;top:3px;cursor:hand;"  onClick="ln_Excel_Apply()">
						</comment><script>__ws__(__NSID__);</script>  
						</nobr>
				</td> 
			</tr>
	 </table>
    </td>
	</tr>

  <!-- Grid �� �Է�â -->
	<tr>
		<td>
			<table>
				<tr>
				  <td>
					  <!--Grid-->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:876px;border:0 solid #708090;">
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
										style="position:relative;left:2px;width:876px; height:400px; border:1 solid #708090;display:block;" viewastext>
											<param name="dataid"			  value="gcds_data">
											<param name="indwidth"		  value ='0'>
											<param name="BorderStyle"		value=1>
											<param name="HeadLineColor" value=#b0bde2>
											<param name="LineColor"     value=#b0bde2>
											<param name=SortView  value="Left">
											<param name=ColSizing  value="true">
											<param name="format"		   	value="  
											 <C> id=''         , 		name=����          ,		width=60, 	Headbgcolor='#B9D4DC' Value={CurRow}</C>
                                             <C> id=VEND_CD    , 		name=�ŷ�ó�ڵ�    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VEND_NM    , 		name=�ŷ�ó��      ,		width=100, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VEND_ID    , 		name=����ڹ�ȣ    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VEND_NO    , 		name=���ι�ȣ      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VD_DIRECT  , 		name=��ǥ��        ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=BSNS_CND   , 		name=����          ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=BSNS_KND   , 		name=����          ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VD_TELNO   , 		name=��ȭ��ȣ      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VD_FAXNO   , 		name=�ѽ���ȣ      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=POST_NO1   , 		name=�����ȣ1     ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=POST_NO2   , 		name=�����ȣ2     ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=ADDRESS1   , 		name=�ּ�1         ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=ADDRESS2   , 		name=�ּ�2         ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=C_BANKCD   , 		name=���������ڵ�  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=C_ACCTNO   , 		name=���ݰ��¹�ȣ  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=C_ACCTNO_NM, 		name=���ݰ��¸�    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=C_ACCTNM   , 		name=���ݰ��¿�����,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=B_BANKCD   , 		name=���������ڵ�  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=B_ACCTNO   , 		name=�������¹�ȣ  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=B_ACCTNO_NM, 		name=�������¸�    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=B_ACCTNM   , 		name=�������¿�����,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=O_VENDGB   , 		name=���ŷ�����    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=O_VENDCD   , 		name=���ŷ�ó�ڵ�  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VEND_MAG   , 		name=������ȣ      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=USE_TAG    , 		name=�������      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=REMARK     , 		name=���          ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=CREAT_DT   , 		name=�������      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=CREAT_NM   , 		name=�����        ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=MSN        , 		name=���̵�        ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=MPWD       , 		name=��й�ȣ      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=COCOMYN    , 		name=���¾�ü����  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=H_VEND_CD  , 		name=��ǥ�ŷ�ó    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=H_VEND_NM  , 		name=��ǥ�ŷ�ó��  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=IUGB    , 		name=�Է¼���  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=WRDT    , 		name=�Է�����  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=WRID    , 		name=�Է���  ,		  width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=UPDT    , 		name=��������  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=UPID    , 		name=������  ,		  width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											">
									</object></comment><script>__ws__(__NSID__);</script>   
									<fieldset style="position:relative;left:3px;width:876px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
										&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
									</fieldset>
									
								</td>
							</tr>
							<tr>
								 <td>
								 	<B><FONT SIZE="2" COLOR="blue">���� ���� Ȯ���ڰ� .xlsx ������ ��� []�ٸ� �̸����� ����]�Ͽ� .xls ���Ϸ� ��ȯ  �� ���ε� �Ͻʽÿ�. </FONT></B>
								 </td>
					        </tr>
						</table>
					</td>
        </tr>
			<table>
		</td>
	</tr>
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		
		
	'>
</object></comment><script>__ws__(__NSID__);</script>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 