	<!--*************************************************************************
	* @source      : well010.jsp												*
	* @description : �ǰ���������û PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2009/12/21            ������                     �ǰ���������û �����ۼ�
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
	String eno_no = box.getString("SESSION_ENONO");         //���
	String eno_nm = box.getString("SESSION_ENONM");         //����
	String dep_cd = box.getString("SESSION_DPTCD");         //�μ�
	String dep_nm = box.getString("SESSION_DPTNM");         //�μ���
	String job_nm = box.getString("SESSION_JOBNM");         //����
	String nam_eng = box.getString("SESSION_NAM_ENG");         //������
	String eng_dpt_nm = box.getString("SESSION_ENG_DPT_NM");         //�����μ���
	String eng_job_nm = box.getString("SESSION_ENG_JOB_NM");         //����������
%>
<html>
<head>
	<title>�ǰ���������û(welj010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			var ENO_NO_SHR = document.getElementById("txtENO_NO").value;
			trT_WL_HEALTH_SHR.KeyValue = "tr05(O:dsT_WL_HEALTH=dsT_WL_HEALTH)";
			trT_WL_HEALTH_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.l.well010.cmd.WELL010CMD"
                                   + "&S_MODE=SHR"
                                   + "&ENO_NO="+ENO_NO_SHR;
			trT_WL_HEALTH_SHR.post();
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

			// save
			trT_WL_HEALTH.KeyValue = "tr01(I:dsT_WL_HEALTH=dsT_WL_HEALTH)";
			trT_WL_HEALTH.action = "/servlet/GauceChannelSVL?cmd=hr.wel.l.well010.cmd.WELL010CMD&S_MODE=SAV";
			trT_WL_HEALTH.post();
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
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
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			// �� �߰�
			dsT_WL_HEALTH.AddRow();
			dsT_WL_HEALTH.NameValue(dsT_WL_HEALTH.RowPosition, "ENO_NO") = "<%=eno_no%>";
			dsT_WL_HEALTH.NameValue(dsT_WL_HEALTH.RowPosition, "ENO_NM") = "<%=eno_nm%>";
			dsT_WL_HEALTH.NameValue(dsT_WL_HEALTH.RowPosition, "DPT_NM") = "<%=dep_nm%>";
			dsT_WL_HEALTH.NameValue(dsT_WL_HEALTH.RowPosition, "JOB_NM") = "<%=job_nm%>";

        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_WL_HEALTH.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�����Ͻðڽ��ϱ�?\n";

	            if( confirm(tmpMSG) ){
					dsT_WL_HEALTH.DeleteRow(dsT_WL_CARD.RowPosition);
					trT_WL_HEALTH.KeyValue = "tr01(I:dsT_WL_HEALTH=dsT_WL_HEALTH)";
					trT_WL_HEALTH.action = "/servlet/GauceChannelSVL?cmd=hr.wel.l.well010.cmd.WELL010CMD&S_MODE=DEL";
					trT_WL_HEALTH.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
        	dsT_WL_HEALTH.ClearData();
			dsT_WL_HEALTH.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
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
         	if ( !dsT_WL_HEALTH.isUpdated && !dsT_WL_HEALTH.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	 dsT_WL_HEALTH.SetDataHeader(
        	        			"ENO_NO:STRING(11):KEYVALUETYPE,"+			// ���
								"SEQ:DECIMAL(2):KEYVALUETYPE,"+			// ���
	                            "REQ_YMD:STRING(10)"
								);
			document.getElementById("txtENO_NO").value = "<%=eno_no%>";
			document.getElementById("txtENO_NM").value = "<%=eno_nm%>";
			document.getElementById("hidEMPL_DPT_CD").value = "<%=dep_cd%>";
			document.getElementById("txtDPT_NM").value = "<%=dep_nm%>";
			document.getElementById("txtJOB_NM").value = "<%=job_nm%>";
			

			cfStyleGrid2(form1.grdT_WL_HEALTH,0,"true","false");      // Grid Style ����

			for( var i = 1; i <= dsT_CM_COMMON_W2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_W2.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_W2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbGUBUN").add(oOption);
			}

			dsT_CM_COMMON_W2.InsertRow(1);
			dsT_CM_COMMON_W2.NameValue(1,"CODE") =  "";
        	dsT_CM_COMMON_W2.NameValue(1,"CODE_NAME") = "";

			fnc_SearchList();

        }


		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("hidEMPL_DPT_CD").value = obj.dpt_cd;

            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }
        }


        //������ ��¥���� üũ
        function fnc_ChkDate() {

            var PIS_YYMM = document.getElementById("txtPIS_YYMM").value.replace("-","");
            var today = getToday().replace("-","").replace("-","");

            if(PIS_YYMM != ""){
	            if(PIS_YYMM < today.substring(0,6)){
	                alert("�̹� ������ ���ڴ� ����Ҽ� �����ϴ�.");
	                document.getElementById("txtPIS_YYMM").value = "";
	                document.getElementById("txtPIS_YYMM").focus();
	                return false;
	            }
            }

        }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WL_HEALTH)			 	   |
    | 3. ���Ǵ� Table List(T_WL_HEALTH) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_HEALTH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_CARD)		       |
    | 3. ���Ǵ� Table List(T_WL_CARD)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_HEALTH_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_HEALTH=dsT_WL_HEALTH)">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_HEALTH)		       |
    | 3. ���Ǵ� Table List(T_WL_HEALTH)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_HEALTH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(I:dsT_WL_HEALTH=dsT_WL_HEALTH)">
	</Object>


	 <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_W2"/>
       <jsp:param name="CODE_GUBUN"    value="W2"/>
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
	<Script For="dsT_WL_HEALTH" Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_HEALTH.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For="dsT_WL_HEALTH" Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_HEALTH Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_HEALTH event="OnSuccess()">
        fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_HEALTH_SHR event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_HEALTH event="OnFail()">
        cfErrorMsg(this);

		 fnc_SearchList();
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"  onload="fnc_OnLoadProcess();">

	<!-- Ķ���� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ǰ���������û</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�ǰ�������/<font color="#000000">�ǰ���������û</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>

			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->


	<!-- ���� �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="70"></col>
					<col width="170"></col>
					<col width="70"></col>
					<col width="170"></col>
					<col width="70"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="8" class="input_ReadOnly"  readonly maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" class="input_ReadOnly"  readonly maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
						<!--
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
						-->
                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>

					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly></td>
				</tr>

				<tr>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="3">
					  <select id="cmbGUBUN" name = "cmbGUBUN" width="40">
					  </select>  
					</td>
					<td class="creamBold" align="center">��û��</td>
                    <td class="padding2423">
                        <input id="txtREQ_YMD" name="txtREQ_YMD" size="15" maxlength="20"  class="input_ReadOnly"  readonly>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold" >���񼭷�</td>
                    <td class="padding2423" colspan="5">
					 1. �������� ���� : �ֹε�� �, �Ǵ� ȣ���<br>
					 2. ��߱�        : ����<br>
					 3. ������ �߱�   : �ֹε�� �<br>
					 4. ����� ��û   : ������ܼ�, ���Ȯ�μ�, ��ü �˾ȼ�<br>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
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
	<!-- ���� ��ȸ �׸��� ���̺� ��-->


	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_WL_HEALTH" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_WL_HEALTH">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29   name="NO"		align=center	value={String(Currow)}</C>
                            <C> id="ENO_NO"     width=100  name="���"      align=center    edit=none     show=false        </C>
							<C> id="SEQ"	    width=100  name="����"      align=center      </C>
							<C> id="REQ_YMD"    width=100  name="��û��"    align=center      </C>
							<C> id="GUBUN"      width=100  name="����"      align=center    Edit=none  EditStyle=Lookup  Data="dsT_CM_COMMON_W2:CODE:CODE_NAME"  </C>
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

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																		 *
    *                                       												 *
    ***************************************************************************************-->
	<!-- T_WL_CARD ���� ���̺� -->
	<object id="bndT_WL_HEALTH" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_HEALTH">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=Value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=Value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=Value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=Value</C>
			<C>Col=GUBUN		Ctrl=cmbGUBUN		Param=Value</C>
		">
	</object>
