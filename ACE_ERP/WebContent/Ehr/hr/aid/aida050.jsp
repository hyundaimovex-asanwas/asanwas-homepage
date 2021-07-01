	<!--*************************************************************************
	* @source      : aida050.jsp														*
	* @description : ����������ޱ��ذ��� PAGE									*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2016/04/28            �̵���            	ERP �̻�									*
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>����������ޱ��ذ���</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = gcurdate.substring(0,4);

		var curRowPosition = 0;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			
			//����������ޱ���  ���� ��ȸ
			var CEF_SEC_SHR = document.getElementById("cmdCEF_SEC_SHR").value;

			dsT_AD_AIDTRF.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida050.cmd.AIDA050CMD&S_MODE=SHR&CEF_SEC_SHR="+CEF_SEC_SHR;
			
			dsT_AD_AIDTRF.reset();
			
			dsT_AD_AIDTRF.RowPosition = curRowPosition;
			
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {
			
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
			
			if ( !fnc_SaveItemCheck() ) {
				return;
			}
			
			curRowPosition = dsT_AD_AIDTRF.RowPosition;
			// save
			
			trT_AD_AIDTRF.KeyValue = "tr01(I:dsT_AD_AIDTRF=dsT_AD_AIDTRF)";
			
			trT_AD_AIDTRF.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida050.cmd.AIDA050CMD&S_MODE=SAV";
			
			trT_AD_AIDTRF.post();
			
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
			
	        if (dsT_AD_AIDTRF.CountRow < 1) {
	        	
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
				
                alert("���� �� �ڷᰡ �����ϴ�!");
                
                return;
                
            }
	        
			curRowPosition = dsT_AD_AIDTRF.RowPosition;
			
            var msg = "��      ��  : "+fnc_GetCommonName("dsT_CM_COMMON_R2", dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "CEF_SEC"))
                    + "\n���޳���  : "+fnc_GetCommonName("dsT_CM_COMMON_R1", dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "AID_CD"))
                    + "\n���� From : "+fnc_GetCommonName("dsT_CM_COMMON_A2", dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "JOB_CD_FROM"))
                    + "\n���� To   : "+fnc_GetCommonName("dsT_CM_COMMON_A2", dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "JOB_CD_TO"))
                    + "\n����(�̻�): "+dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "LSE_YY1")
                    + "\n����(�̸�): "+dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "LSE_YY2")
                    + "\n�� �ش��ϴ� ����Ÿ�� ���� �Ͻðڽ��ϱ�?";

            if(!confirm(msg)) {
            	
                return;
            }

            dsT_AD_AIDTRF.DeleteRow(dsT_AD_AIDTRF.RowPosition);

            // delete
			trT_AD_AIDTRF.KeyValue = "tr01(I:dsT_AD_AIDTRF=dsT_AD_AIDTRF)";
            
			trT_AD_AIDTRF.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida050.cmd.AIDA050CMD&S_MODE=SAV";
			
			trT_AD_AIDTRF.post();
			
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
			
            if (dsT_AD_AIDTRF.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_AD_AIDTRF.GridToExcel("����������ޱ��ذ���", '', 225);
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			
            //DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
            if(dsT_AD_AIDTRF.CountColumn < 1){
                // �����ͼ��� ��� ���� ����.
                dsT_AD_AIDTRF.setDataHeader("CEF_SEC:STRING, CEF_SEC_TXT:STRING, AID_CD:STRING, AID_CD_TXT:STRING, LSE_YY1:DECIMAL, LSE_YY2:DECIMAL, AID_AMT:DECIMAL, AID_RPT:STRING, REMARK:STRING");
            }

            dsT_AD_AIDTRF.AddRow();
            
            document.getElementById("txtLSE_YY2").value = "99";
            
		}

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
        	//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
			
	        document.getElementById("resultMessage").innerText = ' ';
	        
  			document.form1.cmdCEF_SEC_SHR.selectedIndex = 0;
  			
        	dsT_AD_AIDTRF.ClearData();
        	
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			
			if (dsT_AD_AIDTRF.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			
        	window.close();
        	
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {
			
         	if ( !dsT_AD_AIDTRF.isUpdated ) {
         		
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
				
                return false;
                
			}
         	
			return true;
			
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            fnc_ConstructCommonCode("dsT_CM_COMMON_R2", "cmdCEF_SEC_SHR", "", "�� ü");

            fnc_ConstructCommonCode("dsT_CM_COMMON_R2", "cmdCEF_SEC");
            fnc_ConstructCommonCode("dsT_CM_COMMON_R1", "cmdAID_CD");

            //����
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_FROM", "", "�� ü");
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_TO", "", "�� ü");
            document.getElementById("txtLSE_YY2").value = "99";


			cfStyleGrid_New(form1.grdT_AD_AIDTRF,15,"false","false");      // Grid Style ����

            //��� �Է�â ����
            fnc_DisableElementAll(elementList);
			
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        //�Է� element
        var elementList = new Array(     "cmdCEF_SEC"
                                        ,"cmdAID_CD"
                                        ,"cmbJOB_CD_FROM"
                                        ,"cmbJOB_CD_TO"
                                        ,"txtLSE_YY1"
                                        ,"txtLSE_YY2"
                                        ,"medAID_AMT"
                                        ,"txtAID_RPT"
                                        ,"txtREMARK"
                                    );

        //���� �׸�
        var exceptionList = new Array(   "cmdCEF_SEC"
                                        ,"cmdAID_CD"
                                  //      ,"cmbJOB_CD_FROM"   test
                                        ,"txtLSE_YY1"
                                      );

        //key list
        var keyList       = new Array(   "cmdCEF_SEC"
                                        ,"cmdAID_CD"
                                      );

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AD_AIDTRF)			 	   |
    | 3. ���Ǵ� Table List(T_AD_AIDTRF) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDTRF" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AD_AIDTRF)			       |
    | 3. ���Ǵ� Table List(T_AD_AIDTRF)				       |
    +------------------------------------------------------>
	<Object ID="trT_AD_AIDTRF" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AD_AIDTRF=dsT_AD_AIDTRF,I:dsT_AD_AIDTRF=dsT_AD_AIDTRF)">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- ������� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R2"/>
       <jsp:param name="CODE_GUBUN"    value="R2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���޳��� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R1"/>
       <jsp:param name="CODE_GUBUN"    value="R1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDTRF Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AD_AIDTRF.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDTRF Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDTRF Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDTRF event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDTRF event="OnFail()">
        alert(trT_AD_AIDTRF.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_AD_AIDTRF event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            //�ű��� ���
            if(dsT_AD_AIDTRF.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
    </script>


    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_AD_AIDTRF event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_AD_AIDTRF.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_AD_AIDTRF.GetHdrDispName('-3', colName) + " ]��(��) �ʼ� �Է»����Դϴ�");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }
        }
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

	<!-- form ���� -->
	<form name="form1">

	<!-- ��ư ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="60"></col>
                            <col width="600"></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">����</td>
                            <td class="padding2423" align="left">
                                <select id="cmdCEF_SEC_SHR" style="WIDTH: 15%" onChange="fnc_SearchList()"></select>
                            </td>
                        </tr>
                    </table>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- power Search���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">����</td>
					<td class="padding2423">
						<select id="cmdCEF_SEC" style="width:100px;"></select>
					</td>
					<td align="center" class="blueBold">���޳���</td>
					<td class="padding2423">
						<select id="cmdAID_CD" style="width:100px;"></select>
					</td>
                    <td align="center" class="blueBold">����</td>
                    <td class="padding2423">
                        <select id="cmbJOB_CD_FROM" style="width:100px;" onChange="">
                        </select>
                        &nbsp;~&nbsp;
                        <select id="cmbJOB_CD_TO" style="width:100px;" onChange="">
                        </select>
                    </td>
				</tr>
				<tr>
					<td align="center" class="blueBold">����(�̻�)</td>
					<td class="padding2423">
                        <input id="txtLSE_YY1" size="3" maxLength="3">
                    </td>
					<td align="center" class="blueBold">����(�̸�)</td>
					<td class="padding2423">
                        <input id="txtLSE_YY2" size="3" maxLength="3">
                    </td>
					<td align="center" class="blueBold">�ݾ�</td>
					<td class="padding2423">
					   <table width="50%" border="0" >
							<tr>
								<td width="80%">
									<comment id="__NSID__"><object id="medAID_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
										<param name=Alignment				value=2>
										<param name=Border					value=true>
										<param name=ClipMode				value=true>
										<param name=DisabledBackColor		value="#EEEEEE">
										<param name=Enable					value=true>
										<param name=IsComma					value=true>
										<param name=Language				value=0>
										<param name=MaxLength				value=8>
										<param name=Numeric					value=true>
										<param name=NumericRange			value=0~+:0>
										<param name=ShowLiteral				value=false>
										<param name=Visible					value=true>
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td align="left">��</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">��������</td>
					<td class="padding2423" colspan="3"><input id="txtAID_RPT" maxLength="30" style="width:100%;"></td>
					<td align="center" class="blueBold">���</td>
					<td class="padding2423"><input id="txtREMARK" maxLength="150" style="width:100%;"></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

	<!-- ��ȸ ���� ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AD_AIDTRF" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
						<param name="DataID" value="dsT_AD_AIDTRF">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"			width=40	name="NO"					align=center	value={String(Currow)}</C>
							<C> id="CEF_SEC"			width=80	name="����"				align=center	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_R2:CODE:CODE_NAME"</C>
							<C> id="AID_CD"				width=100	name="���޳���"			align=center	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_R1:CODE:CODE_NAME"</C>
                            <C> id="JOB_CD_FROM"   	width=100  name="���� From"      	align=center    EditStyle=Lookup  Data="dsT_CM_COMMON_A2:CODE:CODE_NAME"</C>
                            <C> id="JOB_CD_TO"     	width=100  name="���� To"        	align=center    EditStyle=Lookup  Data="dsT_CM_COMMON_A2:CODE:CODE_NAME"</C>
							<C> id="LSE_YY1"			width=90	name="����(�̻�)"		align=center	Edit=none</C>
							<C> id="LSE_YY2"			width=90	name="����(�̸�)"		align=center	Edit=none</C>
							<C> id="AID_AMT"			width=100	name="���ޱݾ�"			align=right		Edit=none	RightMargin="10"</C>
							<C> id="AID_RPT"				width=150	name="��������"			align=left		Edit=none</C>
							<C> id="REMARK"				width=110	name="���"				align=left		Edit=none</C>
						'>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AD_DONBOOK ���� ���̺� -->
	<object id="bndT_AD_AIDTRF" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AD_AIDTRF">
		<Param Name="BindInfo", Value="
			<C>Col=CEF_SEC				Ctrl=cmdCEF_SEC				Param=value</C>
			<C>Col=AID_CD				Ctrl=cmdAID_CD					Param=value</C>
			<C>Col=JOB_CD_FROM		Ctrl=cmbJOB_CD_FROM			Param=value</C>
			<C>Col=JOB_CD_TO			Ctrl=cmbJOB_CD_TO				Param=value</C>
			<C>Col=LSE_YY1				Ctrl=txtLSE_YY1					Param=value</C>
			<C>Col=LSE_YY2				Ctrl=txtLSE_YY2					Param=value</C>
			<C>Col=AID_AMT				Ctrl=medAID_AMT				Param=text</C>
			<C>Col=AID_RPT				Ctrl=txtAID_RPT					Param=value</C>
			<C>Col=REMARK				Ctrl=txtREMARK					Param=value</C>
		">
	</object>