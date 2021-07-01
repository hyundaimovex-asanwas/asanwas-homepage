	<!--*************************************************************************
	* @source      : taxa260.jsp												*
	* @description : �����߱�ó�� PAGE 										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/16            ä����          	        �����ۼ�
	* 2007/07/21            ����ȣ          	        ��������
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>�����߱�ó��(taxa260)</title>
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

        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "F"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
            var STR_YMD     = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD     = document.getElementById("txtEND_YMD_SHR").value;
            var CEF_STS     = document.getElementById("cmbCEF_STS_SHR").value;

            dsT_AC_CEFBOOK.DataId = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa260.cmd.TAXA260CMD"
                                  + "&S_MODE=SHR"
                                  + "&STR_YMD="+STR_YMD
                                  + "&END_YMD="+END_YMD
                                  + "&CEF_STS="+CEF_STS;
            dsT_AC_CEFBOOK.reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
        	//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {


            if(dsT_AC_CEFBOOK.CountRow == 0) {
                alert("��� ���� �����ϴ�.");
                return;
            }
             trT_AC_CEFBOOK.KeyValue = "service_tr06(I:dsT_AC_CEFBOOK=dsT_AC_CEFBOOK)";
             trT_AC_CEFBOOK.action   = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa260.cmd.TAXA260CMD"
                                     + "&S_MODE=SAV";
             trT_AC_CEFBOOK.post();

            var url = "taxa260_PV.jsp";
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;


        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
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

            document.getElementById("cmbCEF_STS_SHR").selectedIndex = 0;

			dsT_AC_CEFBOOK.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
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
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_AC_CEFBOOK, 0, "true", "false");      // Grid Style ����

            document.getElementById("txtSTR_YMD_SHR").value = getStrDate();
            document.getElementById("txtEND_YMD_SHR").value = getToday();

            document.getElementById("cmbCEF_STS_SHR").value = "B";
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EXAMINATION)			   |
    | 3. ���Ǵ� Table List(T_CM_EXAMINATION) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AC_CEFBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="false">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_CEFBOOK)		   |
    | 3. ���Ǵ� Table List(T_AC_CEFBOOK)		       |
    +------------------------------------------------------>
	<Object ID="trT_AC_CEFBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �뵵 ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R4"/>
       <jsp:param name="CODE_GUBUN"    value="R4"/>
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
	<Script For=dsT_AC_CEFBOOK Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_CEFBOOK.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_AC_CEFBOOK Event="OnLoadError()">
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_CEFBOOK Event="OnDataError()">
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_AC_CEFBOOK event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_AC_CEFBOOK event="OnFail()">
        alert(trT_AC_CEFBOOK.ErrorMsg);
    </script>


    <!-----------------------------------------------------+
    | �׸����� ROW�� ����Ŭ�� �� ó��                              |
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_AC_CEFBOOK event="OnDblClick(row,colid)">
        if(row < 1) {
            return;
        } else {
            var REQ_NO = dsT_AC_CEFBOOK.NameValue(row, "REQ_NO");

            var url = "/hr/tax/taxa261.jsp?&REQ_NO="+REQ_NO;
            window.showModalDialog(url, "", "dialogWidth:850px; dialogHeight:380px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            fnc_SearchList();
        }
    </script>

    <!-----------------------------------------------------+
    | header�� Ŭ�������� �̹ݿ� ����Ÿ ��� üũ
    +------------------------------------------------------>
    <script language="javascript" for=grdT_AC_CEFBOOK event=OnHeadCheckClick(Col,Colid,bCheck)>

        if(Colid == "IS_CHK" && dsT_AC_CEFBOOK.CountRow > 0) {
            for(var i=1; i<=dsT_AC_CEFBOOK.CountRow; i++) {

                if(bCheck == "1") {
                    dsT_AC_CEFBOOK.NameString(i, "IS_CHK") = "T";
                } else {
                    dsT_AC_CEFBOOK.NameString(i, "IS_CHK") = "F";
                }
            }
        }
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ҵ�������߱�ó��</td>
                    <td align="right" class="navigator">HOME/���꼼��/�ҵ���������/<font color="#000000">�ҵ�������߱�ó��</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="70"></col>
					<col width="220"></col>
					<col width="70"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">��ȸ�Ⱓ</td>
					<td class="padding2423" align="left">
						<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','55','110');"></a> ~
						<input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','170','110');"></a>
					</td>
                    <td class="searchState" align="right">��ȸ����</td>
                    <td class="padding2423" align="left">
                        <select id="cmbCEF_STS_SHR" style="WIDTH: 80px" onChange="fnc_SearchList()">
                            <option value="">���</option>
                            <option value="A">����</option>
                            <option value="B">��û</option>
                            <option value="C">�ݼ�</option>
                            <option value="E">�߱�</option>
                            <option value="F">�������</option>
                        </select>
                    </td>

				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search���̺� �� -->

	<!-- ��ȸ ���� ���̺� ���� -->
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
	<!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AC_CEFBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_AC_CEFBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id={currow}		width=25	name="NO"			align=center	Edit=none	 </C>
                            <C> id="IS_CHK"     width=50    name="���"             align=center    EditStyle=CheckBox,Pointer=Hand     HeadCheckShow=true      HeadCheck=true</C>
							<C> id="REQ_NO"		width=65	name="��û��ȣ"		align=center	Edit=none	 </C>
							<C> id="DPT_NM"		width=80 	name="�μ�"			align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="JOB_NM"		width=60	name="����"			align=center	Edit=none	 </C>
							<C> id="ENO_NM"		width=60	name="����"			align=center	Edit=none	 </C>
							<C> id="CEF_SEC_NM" width=130	name="��������"		align=center	Edit=none	 </C>
							<C> id="CEF_RSN_NM" width=130	name="�뵵"			align=center	Edit=none	 </C>
                            <C> id="CEF_STS_NM" width=40    name="����"           align=center    Edit=none   </C>
                            <C> id="CEF_NO"     width=70    name="�߱޹�ȣ"     align=center    Edit=none    </C>
							<C> id="SPL_YMD"	width=70	name="�߱���"			align=center	Edit=none	 </C>
                            <C> id="CEF_CNT"    width=35    name="�ż�"           align=center    Edit=none    </C>
                            <C> id="IPT_YMD"     width=70    name="��û��"     align=center    Edit=none    </C>
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