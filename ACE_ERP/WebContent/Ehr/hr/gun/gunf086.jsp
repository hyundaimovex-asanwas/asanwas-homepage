<!--
*****************************************************
* @source       : gunf085.jsp
* @description : 1�� �ٹ� ��û PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/02/24     �̵���             �����ۼ�
*****************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%

	String req_no = request.getParameter("REQ_NO");         //��û��ȣ
	String eno_no = request.getParameter("ENO_NO");         //��û�ڻ��
	String app_yn = request.getParameter("APP_YN");			//�������
	String app_status = request.getParameter("APP_STATUS"); //���������Ȳ
	String app_cmt = request.getParameter("APP_CMT");       //�������ǰ�
%>


<html>


<head>

	<title>���� �ٹ� ��û</title>
	
	<jsp:include page="/Ehr/common/include/head.jsp"/>
	
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../../css/style.css" rel="stylesheet" type="text/css">
		<link href="../../css/general.css" rel="stylesheet" type="text/css">
		
		<script language=javascript src="../../common/common.js"></script>
		<script language=javascript src="../../common/input.js"></script>
		<script language=javascript src="../../common/result.js"></script>
		<script language=javascript src="../../common/mdi_common.js"></script>
		<script language="javascript" src="../../common/calendar/calendar.js"></script>
	
	
	
	<!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
	<script language="javascript" >
	

	var today = gcurdate;
	
	var GBN = "";
	
	var obj = new String();

	obj.app_cmt = "";
	// ��������
	

	
    /***********************************
     * 01. ��ȸ �Լ�_List ������ ��ȸ*
     ***********************************/
    function fnc_SearchList()
    {

    	trT_DI_OVERTIMESCHEDULE.KeyValue = "tr(O:dsT_DI_OVERTIMESCHEDULE=dsT_DI_OVERTIMESCHEDULE, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
    	trT_DI_OVERTIMESCHEDULE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf085.cmd.GUNF085CMD&S_MODE=SHR2&REQ_NO=<%=req_no%>&ENO_NO=<%=eno_no%>";
    	trT_DI_OVERTIMESCHEDULE.post();

    }

	
    /***********************************
     * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
     ***********************************/
    function fnc_SearchItem()
    {
    	
    	
    }

    
    /******************
     * 03. ���� �Լ�   *
     ******************/
    function fnc_Save()
    {
    	
    	
    }


    /******************
     * 04. ���� �Լ�  *
     ******************/
    function fnc_Delete()
    {
    	
    	
    }


    /******************
     * 05. �μ� �Լ�  *
     ******************/
    function fnc_Print()
    {

    	
    }

    
    /***********************
     * 06. ���� ���� �Լ�   *
     ***********************/
    function fnc_ToExcel()
    {
    	
    	
    }

    
    /******************
     * 07. �ű� �Լ�  *
     ******************/
    function fnc_AddNew()
    {
 
    	
    }

    
    /******************
     * 08. ��ȿ�� �˻� *
     ******************/
    function fnc_Valid()
    {
    	

    }


    
    /******************
     * 08. �߰� �Լ�  *
     ******************/
	function fnc_Append()
    {
    	

	}
    
    /******************
     * 09. ���� �Լ�  *
     ******************/
    function fnc_Remove()
    {
    	

    }


    
    /********************
     * 10. �ʱ�ȭ �Լ�  *
     ********************/
    function fnc_Clear()
    {
    	
    	location.reload();
    	
    }

    /************************
     * 11. ȭ�� ����(�ݱ�)  *
     ***********************/
    function fnc_Exit()
    {
    	
    }
    

    /******************************
     * 12. �˻� ���� ��ȿ�� �˻�  *
     ******************************/
    function fnc_SearchItemCheck(year)
    {
    	
    	
    }

    /*************************
     * 13. ���� ��ȿ�� üũ  *
     *************************/
    function fnc_SaveItemCheck()
    {
    	

    }

    /********************************************
     * 14. Form Load �� Default �۾� ó�� �κ�    *
     *******************************************/
    function fnc_OnLoadProcess()
    {

    	dsT_DI_APPROVAL.SetDataHeader(
				"GUN_YMD:STRING(10),"+			// ���³�¥
                "GUN_GBN:STRING(1),"+			// ���°��籸��
				"DPT_CD:STRING(6),"+			// ���ºμ�
				"DPT_NM:STRING(10),"+			// ���ºμ���
				"SEQ_NO:STRING(1),"+			// ���缱
				"ENO_NO:STRING(10),"+			// �����ڻ��
				"JOB_CD:STRING(10),"+			// ����������
				"APP_TIME:STRING(10),"+			// ����ð�
				"ENO_NO:STRING(10),"+			// ����ڻ��
				"APP_YN:STRING(10),"+			// ���翩��
				"ENO_NM:STRING(10),"+			// �����ڸ�
				"JOB_NM:STRING(10)"				// ������
		);
    	
    	
    	cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"true","false"); 			// ������Ȳ Grid Style ����(�׸���, ���º����÷� width, ���üũ�ڽ�, �������)
    	cfStyleGrid_New(form1.grdT_DI_OVERTIMESCHEDULE,0,"true","false"); 	// �Ѵޱٹ� Grid Style ����(�׸���, ���º����÷� width, ���üũ�ڽ�, �������)
    	
    	fnc_SearchList();
    	
    	// ������ &&  �̰��� �ΰ�쿡�� ��ư�� Ȱ��ȭ
		if(dsT_DI_APPROVAL.NameValue(1,"ENO_NO") == gusrid && dsT_DI_APPROVAL.NameValue(1,"APP_TIME") == ""){

        	document.getElementById("btn_approval").style.display = "";

        }else{

        	document.getElementById("btn_approval").style.display = "none";

        }
    	
    }

	/********************
     * 15. ����Ű ó��   *
     *******************/
	function fnc_HotKey()
	{
		
		fnc_HotKey_Process(btnList, event.keyCode);
		
		
	}
	


    /*************************
     *   16. ���� ó��       *
     *************************/
	function fnc_SubmitApproval(kind) {

        var app_yn = "";    //����ϷῩ��
        
        if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;

        if(kind == "����"){
        	
            app_yn = "Y";
            
        }else if(kind == "�ΰ�"){
        	
			if(obj.app_cmt == ""){
				
      			window.showModalDialog("../../../Ehr/hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
      	    
			}

            if(obj.app_cmt != ""){
            	
				app_yn = "N";
				
	            if(kind == "�ΰ�") {
	            	
	            	app_yn = "N";
	            	
	            }
	            
            }else{
            	
                alert("�ΰ������ �Է��� ó���ٶ��ϴ�.\n \n�۾��� ��ҵǾ����ϴ�.");
                
                return false;
                
        	}

        }
        

        dsT_DI_OVERTIMESCHEDULE_STATE.setDataHeader("REQ_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, APP_YN:STRING");
        
        dsT_DI_OVERTIMESCHEDULE_STATE.AddRow();
        
        dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"REQ_NO") = dsT_DI_OVERTIMESCHEDULE.NameValue(1,"REQ_NO");
        dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"ENO_NO") = dsT_DI_OVERTIMESCHEDULE.NameValue(1,"ENO_NO");
        dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_STATUS") = kind;
        dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_CMT") = obj.app_cmt;        
        dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_YN") = app_yn;
        
        //prompt(this, dsT_DI_OVERTIMESCHEDULE_STATE.text);
        
        trT_DI_OVERTIMESCHEDULE_STATE.KeyValue = "tr01(I:dsT_DI_OVERTIMESCHEDULE_STATE=dsT_DI_OVERTIMESCHEDULE_STATE)";
		trT_DI_OVERTIMESCHEDULE_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf085.cmd.GUNF085CMD&S_MODE=SAV2";
		trT_DI_OVERTIMESCHEDULE_STATE.post();
		
        document.getElementById("btn_approval").style.display = "none";//�����ư��

        window.close();

    }
    

    /*****************************************
     * 17.   �����Է��˾� (�ΰ�ó��)         *
     ****************************************/
	function fnc_SubmitCancle(kind) {

        var obj = new String();
      
        window.showModalDialog("../../../Ehr/hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        if(obj.app_cmt != undefined){

            dsT_DI_OVERTIMESCHEDULE_STATE.setDataHeader("REQ_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, KIND:STRING, APP_YN:STRING");
            
            dsT_DI_OVERTIMESCHEDULE_STATE.AddRow();
            
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"REQ_NO") = document.getElementById("txtREQ_NO").value;
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_STATUS") = kind;
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_CMT") = kind+"ó��-"+obj.app_cmt;
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"KIND") = kind;
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_YN") = "N";

            trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_OVERTIMESCHEDULE_STATE=dsT_DI_OVERTIMESCHEDULE_STATE)";
            trT_DI_BUSINESSTRIP_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf085.cmd.GUNF085CMD&S_MODE=SAV_03";
            trT_DI_BUSINESSTRIP_STATE.post();

            document.getElementById("btn_approval").style.display = "";

        }

    }
    
</script>



</head>


<!--**************************************************************************************
*                                                                                        *
*  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
*                                                                                        *
***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_OVERTIMESCHEDULE                 |
    | 3. Table List : T_DI_OVERTIMESCHEDULE             |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMESCHEDULE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_BUSINESSTRIP_STATE           |
    | 3. Table List : T_DI_BUSINESSTRIP_STATE       |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMESCHEDULE_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                 |
    | 2. �̸� : dsT_DI_APPROVAL                 |
    | 3. Table List : T_DI_APPROVAL             |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    

    <!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_DILIGENCE)		       |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_OVERTIMESCHEDULE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	
	
    <!--------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			      |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUSINESSTRIP_STATE)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_STATE)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_OVERTIMESCHEDULE_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    
<!--*************************************
*                                       *
*  Component���� �߻��ϴ� Event ó����  *
*                                       *
**************************************-->
	<!----------------------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ���� dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    
        if (iCount > 0) {
			
			document.getElementById("txtREQNO").innerText = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
			document.getElementById("txtREQNO").innerText = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
			
		}
        
    </Script>
    

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						|
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMESCHEDULE event="OnSuccess()">
	
        if(GBN == "SAV01") {
        	
        	alert("�۾��� �Ϸ� �Ͽ����ϴ�!");
        	
        	fnc_Clear();
        	
        }
        
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						|
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMESCHEDULE event="OnFail()">
	
		cfErrorMsg(this);
		
    </script>
    

    <!-----------------------------------------------------+
    | grdT_DI_OVERTIMESCHEDULE OnClick ó�� - �ΰ���� ��ȸ|
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_DI_OVERTIMESCHEDULE event=OnClick(Row,Colid)>
	
		if(Colid == "END_TAG" && dsT_DI_OVERTIMESCHEDULE.NameValue(Row, "APP_REMARK") != "" ){
			
			var obj =  dsT_DI_OVERTIMESCHEDULE.NameValue(Row, "APP_REMARK");
			
			window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			
		}
		
	</script>
    
    <!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick ó�� - �ΰ���� ��ȸ        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

  
	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		
		window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	
	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "�ǰ��Է�" ){

		window.showModalDialog("../../hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	}
	
	
  </script>
  
  
<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="left">
		</td>
		<td height="35" class="paddingTop5" align="right">
			 <span id="btn_approval" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','../../images/button/btn_ApprovalOver.gif',1)">
				<img src="../../images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle"  onClick="fnc_SubmitApproval('����');">
				</a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','../../images/button/btn_RejectionOver.gif',1)">
				<img src="../../images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('�ΰ�');">
				</a>
 			</span>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->


<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- ���� �Է� ���̺� ���� -->
			<table width="220" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
							<colgroup>
								<col width="150"></col>
								<col width="*"></col>
							</colgroup>
							<tr height="28">
								<td align="center" class="blueBold">��û��ȣ</td>
								<td class="padding2423">
									<input id="txtREQNO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ���� �Է� ���̺� �� -->

	        </td>
	        <td width="25">&nbsp;</td>
	        <td>

        	<!-- ���缱 ���� ���̺� ���� -->
			<table width="900" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:780px;height:70px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Editable"              value="true">
							<param name="Format"				value="
								<C> id='SEQ_NM'			width=70	name='����'				align=center	Value={IF(SEQ_NO > '90','����', '����')}</C>
								<C> id='ENO_NM'			width=90	name='������'			align=center	</C>
								<C> id='JOB_NM'			width=80	name='����'				align=center	</C>
                                <C> id='DPT_NM'			width=150	name='��'				align=center	</C>
								<C> id='APP_STATUS'		width=250	name='�������'			align=center    </C>
								<C> id='REMARK1'		width=120	name='�ǰ�'				align=center 	Color='Blue'	</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
       		  </table>
        	<!-- ���缱 ���� ���̺� �� -->

        </td>
    </tr>
</table>


<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage"></span></td>
				</tr>
			</table>
		</td>

	</tr>
</table>


<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_OVERTIMESCHEDULE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:250px;">
							<param name="DataID"				value="dsT_DI_OVERTIMESCHEDULE">
							<param name="Editable"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="Format"				value="
								<C> id='{CUROW}'			width=40		name='NO'			align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  value={String(Currow)}		</C>							
								<C> id='ENO_NO'				width=100		name='���'			align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  </C>
								<C> id='ENO_NM'				width=100		name='����'			align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  </C>
								<C> id='REG_YMD'			width=180		name='�ٹ�����'		align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  MASK='XXXX-XX-XX' </C>
								<C> id='REMARK'				width=100		name='�ٹ�����'		align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  </C>
								<C> id='REQ_NO'				width=50		name='��û��ȣ'		align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  show=false</C>
								<C> id='STR_TIME'			width=180		name='���۽ð�'		align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  MASK='XX:XX'</C>
								<C> id='END_TIME'			width=180		name='����ð�'		align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  MASK='XX:XX'</C>
								<C> id='DAY_TOTAL_TIME'		width=100		name='�ѱٹ��ð�'	align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->



</form>
<!-- form �� -->



</body>
</html>
