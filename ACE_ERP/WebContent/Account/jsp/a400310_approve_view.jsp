<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ��� - �����û ���� �󼼳���
+ ���α׷� ID	: a400310_approve_view.jsp
+ �� �� �� ��	: �����û ���� �󼼳���
+ �� �� �� ��	: 2017.11.02 jys
+ ���콺 ����    : 5.2
-----------------------------------------------------------------------------
+ �� �� �� ��	:   
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ �� �� �� ��	: a400310_approve_s1, a400310_approve_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<%@ page import="sales.common.DateUtil"%> 
<% 
   //ContextPath ���� ����.
   String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����.
   
   String v_dwr_sid  = request.getParameter("v_dwr_sid");	    //
   String v_status	 = request.getParameter("v_status");	    //������ �۾� ������ : ���� 010�ۼ���, 011�������������, 012�������Ϸ�
   String v_ap_m_sid = request.getParameter("v_ap_m_sid");	    //���縶���� sid : �ݷ��ÿ��� �������� ��°� �ƴϹǷ� �Ϻ� �ε����� ��ģ��.
   
   String gusrip	= (String)session.getAttribute("vusrip");	//������ �̵��� IP���� üũ
%>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

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

var gs_date2   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_mgr_date= gcurdate.substring(2,4) + gcurdate.substring(5,7);

var gs_userid = gusrid;
var gs_yymm = gcurdate.substring(2,4) + gcurdate.substring(5,7); 


var g_WinParam = window.dialogArguments;
var g_ap_sid =0;
var g_ap_gu="";
var g_row=0;
var g_ap_sid2 =0;
var g_ap_gu2="";
var g_row2=0;
var g_ap_type2="";

//alert("g_WinParam[0]::"+g_WinParam[0]+"::g_WinParam[1]::"+g_WinParam[1]+"::g_WinParam[2]::"+g_WinParam[2]+"::g_WinParam[3]::"+g_WinParam[3]+"::g_WinParam[4]::"+g_WinParam[4]);

<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(){
	
	ln_Query(g_WinParam[3] );
	
	/*
	txt_app_teamcd.value = gdeptcd;
	txt_app_teamnm.value = gdeptnm;
	txt_app_empno.value = gusrid;
	txt_app_empnm.value = gusrnm;
	*/
	

	
	
	//�ΰ�������ȣ ���� + �ΰ����ع�ȣ + ��� + ����
	//gcem_signet_mgr_no.text = gs_yymm ;
	
	ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
	ds_gc_aptype.Reset();	// �������� AP005 - �������� �����ڵ� �о����
	
	ds_gc_apsts_d.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP003&s_item1=Y";
	ds_gc_apsts_d.Reset();	// �������_D AP003 - �������� �����ڵ� �о����
	
	gcem_ap_desc.style.background ="#99CC00";
	
	
}
<%
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
%>
function ln_Query(strAp_m_sid){
	
	//�����û  
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_approve_s0?v_str1="+strAp_m_sid;                                                  
	gcds_data.Reset();
	
	//���缱 MST ��ȸ
	gcds_ap_mst.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_s2?v_str1="+strAp_m_sid;                                                  
	gcds_ap_mst.Reset();
	
	
	//��û�� ���缱 ��ȸ 
	ds_apline.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_s1?v_str1="+strAp_m_sid+"&v_str2=1";                                                  
	ds_apline.Reset();
		
	//��û�� ���缱
	_line_chk1:
	for(var i=ds_apline.countrow;i>=1;i--){
		//alert(i+"::AP_TYPE::"+ ds_apline.namevalue(i,"AP_TYPE"));
		if(ds_apline.namevalue(i,"AP_EMPNO")==gs_userid&&ds_apline.namevalue(i,"AP_STATUS_D")=="1"){
			g_ap_sid = ds_apline.namevalue(i,"AP_SID");
			g_ap_gu  = ds_apline.namevalue(i,"AP_GU");
			g_row = i;
			break _line_chk1;
		}
	}
}




/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Chk_Save() {
   //AP_SID üũ      
   return true;
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){
	
}
<%
/******************************************************************************
	Description : ���
******************************************************************************/
%>
function ln_Print(){

}


<% //����MST %>
function ln_SetDataHeader3(){
	if (gcds_ap_mst.countrow<1){
		var s_temp = "AP_M_SID:DECIMAL(10),DOC_SID:DECIMAL(10),DOC_GU:STRING(10),DOC_GU2:STRING(10),AP_STATUS_M:STRING(10),L_EMPNO:STRING(10),"
				   + "I_EMPNO:STRING(10),I_DATE:STRING(20),I_IP:STRING(30),U_EMPNO:STRING(10),U_DATE:STRING(20),U_IP:STRING(30),"
				   + "NUM_PARAM1:DECIMAL(10),NUM_PARAM2:DECIMAL(10),NUM_PARAM3:DECIMAL(10),NUM_PARAM4:DECIMAL(10),NUM_PARAM5:DECIMAL(10),"
				   + "CH_PARAM1:STRING(20),CH_PARAM2:STRING(20),CH_PARAM3:STRING(20)";
		gcds_ap_mst.SetDataHeader(s_temp);
	}
}


<% //����DTL %>
function ln_SetDataHeader4(){
	if (gcds_ap_dtl.countrow<1){
		var s_temp = "AP_SID:DECIMAL(10),AP_M_SID:DECIMAL(10),AP_GU:STRING(10),AP_SEQ:DECIMAL(10),AP_TYPE:STRING(10),AP_STATUS_D:STRING(10),"
				   + "AP_EMPNO:STRING(10),AP_REAL_EMPNO:STRING(10),AP_DESC:STRING(100),"
				   + "I_EMPNO:STRING(10),I_DATE:STRING(20),I_IP:STRING(30),U_EMPNO:STRING(10),U_DATE:STRING(20),U_IP:STRING(30),"
				   + "AP_JOBNM:STRING(20),AP_DPTNM:STRING(50)";
		gcds_ap_dtl.SetDataHeader(s_temp);
	}
}




</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_data2 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_apline classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_apline2 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_ap_mst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_ap_dtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object id=ds_gc_aptype classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_gc_apsts_d classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<object id=gcds_signet_id classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_jobcd classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_data_his classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//�� ��ȸ �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		//alert("�˻��� ����Ÿ�� �����ϴ�.");
	}else{
		//alert("rowposition::"+rowposition);
		//alert(gcds_data.namevalue(rowposition,"ATT_FILE_NAME"));
		if(gcds_data.namevalue(rowposition,"ATT_FILE_NAME")!=""){
			fnAddFileList(gcds_data.namevalue(rowposition,"ATT_FILE_NAME"));
		}
	}

	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_signet_gb_0" event="onloadCompleted(row,colid)">
    gcds_signet_gb_0.InsertRow(1);
    gcds_signet_gb_0.NameValue(1,"CDCODE")="";
    gcds_signet_gb_0.NameValue(1,"CDNAM")="��ü";
    gclx_signet_gb_0.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td height="30px" colspan=2>
			<b><font size="2" color="blue">&nbsp;�� ���� ��û ����</font></b>
		<td>
	</tr>

	<tr>
		<td colspan=2 >
			<table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:0 solid #708090'>
				<tr>
					<td><nobr>
						<comment id="__NSID__">
				  		<object id=gcgd_data classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='1000px' height='360px' border='1'>
							<param name="dataid"		 value="gcds_data">
							<param name="borderstyle"    value="0">
							<param name="indwidth"       value="0">
							<param name="fillarea"		 value="true">
							<param name="colsizing"      value="true">
							<param name="editable"       value="true">
							<PARAM NAME="viewSummary"	 VALUE="1">
							<param name="format"		 value="   
								<C> Name='��û��ȣ'	  ID=APPNO      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=center	SumBgColor='#C3D0DB' edit=none </C>
								<G> Name='��ü����'     HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='�ڵ�'	      ID=VENDCD   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    SumBgColor='#C3D0DB' edit=none </C>
								<C> Name='��ü��'	      ID=VENDNM   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=180    align=left      SumBgColor='#C3D0DB' edit=none </C>
								<C> Name='����ڹ�ȣ'   ID=VENDID       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center	SumBgColor='#C3D0DB' edit=none mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XXXXXXX')}</C>
								</G>
								<G> Name='��������'     HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='����'        ID=PAYKND           HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:��������,2:��������,3:�ڵ����,4:���γ���'</C>
								<C> Name='��û��'      ID=REQDATE  	      HeadAlign=Center HeadBgColor=#B9D4DC Width=70     align=center  	SumBgColor='#C3D0DB' edit=none MASK='XXXX/XX/XX'</C>
								<C> Name='���ޱ���'     ID=PAYGB 		      HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB' edit=none  EditStyle=Combo, Data='1:���뿹��,2:����,3:��ȭ���뿹��,4:����(��ȭ)'</FC>
								<C> Name='�ݾ�'		  ID=OUTAMT           HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=right	    SumBgColor='#C3D0DB' edit=none </C>
								</G>
								<G> Name='��������'     HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='����'        ID=BANK_NM   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70     align=left  	SumBgColor='#C3D0DB' edit=none </C>
								<C> Name='����'        ID=PAYACCTNO   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	SumBgColor='#C3D0DB' edit=none </C>
								<C> Name='������'      ID=ACCT_AUTH   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	SumBgColor='#C3D0DB' edit=none </C>
								</G>
						  	 ">
						</object>
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>	
			</table>		
		</td>
	</tr>
    <tr>
		<td width="998px" align="right"  style="padding-top:4px;" colspan=2> 
			&nbsp;
		</td>
	</tr>
	
	<tr>
		<td height="30px" style='width:500px;height:30px;border:1 solid #708090' colspan=2><b><font size="2" color="blue">&nbsp;�� ��û�� ���缱</font></b></td>
	</tr>
	<tr>
		<td colspan=2>
		<table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:0 solid #708090'>
			<tr>
				<td><nobr>
					<comment id="__NSID__">
			  		<object id=gcgd_appteam classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='1000px' height='100px' border='1'>
						<param name="dataid"		 value="ds_apline">
						<param name="borderstyle"    value="0">
						<param name="indwidth"       value="0">
						<param name="fillarea"		 value="true">
						<param name="colsizing"      value="true">
						<param name="editable"       value="true">
						<param name="format"		 value="  
							<C> Name='����'	      ID=AP_SEQ        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	edit=none </C> 
							<C> Name='����'	      ID=AP_TYPE      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none   EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm'</C>
							<C> Name='���'	      ID=AP_EMPNO   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    edit=none </C>
							<C> Name='�̸�'	      ID=ENO_NM       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center	edit=none </C>
							<C> Name='����'		  ID=AP_JOBNM         HeadAlign=Center HeadBgColor=#B9D4DC Width=50     align=center	edit=none </C>
							<C> Name='�Ҽ�'        ID=AP_DPTNM   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	edit=none </C>
							<C> Name='�������'     ID=AP_STATUS_D   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  	edit=none   EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm'</C>
							<C> Name='�ǰ�'        ID=AP_DESC   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=560    align=left  	edit=none </C>
					  	 ">
					</object>
					</comment><script>__ws__(__NSID__);</script></nobr>
				</td>
			</tr>	
		</table>		
		</td>
	</tr>
</table>
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
 ------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcbn_disp classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='  
	<C>Col=APP_NO                  Ctrl=gcem_app_no           Param=text</C>
	<C>Col=SIGNET_ID               Ctrl=gcem_signet_id        Param=text</C>
	<C>Col=SIGNET_USE              Ctrl=gcem_signet_use       Param=text</C>
	<C>Col=SIGNET_SUBMIT           Ctrl=gcem_signet_submit    Param=text</C>
	<C>Col=PAPER_CNT               Ctrl=gcem_paper_cnt        Param=text</C>
	<C>Col=SEAL_CNT                Ctrl=gcem_seal_cnt         Param=text</C>
	<C>Col=SIGNET_CERTI_CNT        Ctrl=gcem_signet_certi_cnt Param=text</C>
	<C>Col=REGI_CNT                Ctrl=gcem_regi_cnt         Param=text</C>
	<C>Col=CUR_CAN_GB              Ctrl=gcra_cur_can_gb       Param=codevalue</C>
	<C>Col=SEAL_DATE               Ctrl=gcem_seal_date        Param=text</C>
	<C>Col=SIGNET_MGR_NO           Ctrl=gcem_signet_mgr_no    Param=text</C>
	<C>Col=APP_TEAMCD              Ctrl=txt_app_teamcd        Param=value</C>
	<C>Col=APP_TEAMNM              Ctrl=txt_app_teamnm        Param=value</C>
	<C>Col=APP_JOBCD               Ctrl=txt_app_jobcd         Param=value</C>
	<C>Col=APP_EMPNO               Ctrl=txt_app_empno         Param=value</C>
	<C>Col=APP_EMPNM               Ctrl=txt_app_empnm         Param=value</C>
	<C>Col=APP_DATE                Ctrl=gcem_app_date         Param=text</C>
	<C>Col=REMARK                  Ctrl=gcem_remark           Param=text</C>
	<C>Col=WRID                    Ctrl=txt_wrid              Param=value</C>
	<C>Col=WRDT                    Ctrl=txt_wrdt              Param=value</C>
	<C>Col=UPID                    Ctrl=txt_upid              Param=value</C>
	<C>Col=UPDT                    Ctrl=txt_updt              Param=value</C>
	<C>Col=ATT_FILE_NAME           Ctrl=txt_real_file    	  Param=value</C>
	'>
  </object>
  
  
  </comment><script>__ws__(__NSID__);</script> 
</body>
</html>




