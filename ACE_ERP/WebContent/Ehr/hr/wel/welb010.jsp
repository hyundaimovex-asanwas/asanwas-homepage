<!--
***********************************************************************
* @source      : welb010.jsp
* @description : ���������������� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/07      ���뼺        �����ۼ�.
***********************************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%


    String ROLE_CD = box.getString("SESSION_ROLE_CD");


    //ROLE_CD�� IT���� ����
    boolean itMaster = false;

    if(ROLE_CD.equals("1001")) {
    	itMaster = true;
    }

%>

<html>
<head>
<title>����������������(welb010)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

		var btnList = 'TTTTFFTT';
		var emp_Sbutton = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var dpt_cd   = document.getElementById('txtDPT_CD_SHR').value;
			var eno_no   = document.getElementById('txtENO_NO_SHR').value;
            var chk_data = "";
            if(document.getElementById("chkCHK_DATA").checked)
                chk_data = "1";

			dsT_WL_HDPDLIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb010.cmd.WELB010CMD&S_MODE=SHR&DPT_CD="+dpt_cd+"&ENO_NO="+eno_no+"&CHK_DATA="+chk_data;
    		dsT_WL_HDPDLIST.reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

        //   var STR_YMD   = document.getElementById('txtSTR_YMD').value;
		//	var eno_no   = document.getElementById('txtENO_NO_SHR').value;

			if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

			trT_WL_HDPDLIST.KeyValue = "tr01(I:dsT_WL_HDPDLIST=dsT_WL_HDPDLIST)";
			trT_WL_HDPDLIST.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb010.cmd.WELB010CMD&S_MODE=SAV";
			trT_WL_HDPDLIST.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_HDPDLIST.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("[���:"+dsT_WL_HDPDLIST.NameValue(dsT_WL_HDPDLIST.RowPosition,'ENO_NO')+"/����:"+dsT_WL_HDPDLIST.NameValue(dsT_WL_HDPDLIST.RowPosition,'ENO_NM')+"/�޴�����ȣ:"+dsT_WL_HDPDLIST.NameValue(dsT_WL_HDPDLIST.RowPosition,'')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_WL_HDPDLIST.DeleteRow(dsT_WL_HDPDLIST.RowPosition);
				trT_WL_HDPDLIST.KeyValue = "tr01(I:dsT_WL_HDPDLIST=dsT_WL_HDPDLIST)";
				trT_WL_HDPDLIST.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb010.cmd.WELB010CMD&S_MODE=DEL";
				trT_WL_HDPDLIST.post();
			}

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
			//DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_WL_HDPDLIST.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_WL_HDPDLIST.setDataHeader("ENO_NO:STRING, ENO_NM:STRING, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, PHN_NO:STRING, SUB_AMT:STRING, STR_YMD:STRING, END_YMD:STRING, ABA_CD:STRING, ABA_NM:STRING, ACC_NO:STRING");
			}

			dsT_WL_HDPDLIST.AddRow();
			document.getElementById('txtENO_NO').focus();
        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

			document.getElementById('txtDPT_CD_SHR').value = '';
			document.getElementById('txtDPT_NM_SHR').value = '';
			document.getElementById('txtENO_NO_SHR').value = '';
			document.getElementById('txtENO_NM_SHR').value = '';
			document.getElementById('txtPHN_NO').value = '';
			document.getElementById('txtABA_CD').value = '';
			document.getElementById('txtABA_NM').value = '';
			document.getElementById('txtACC_NO').value = '';

			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_HDPDLIST.ClearData();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_HDPDLIST.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_WL_HDPDLIST.IsUpdated ) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            fnc_DisableElementAll(elementList);

			cfStyleGrid(form1.grdT_WL_HDPDLIST,15,"false","false");      // Grid Style ����

            document.getElementById('txtDPT_CD_SHR').focus();
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        var elementList = new Array( "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"txtPHN_NO"
                                    ,"cmbSUB_AMT"
                                    ,"txtSTR_YMD"
                                    ,"txtEND_YMD"
                                    ,"img_HelpOn1"
                                    ,"img_HelpOn2"
                                    ,"Image11"
                                    ,"imgABA_CD"
                                    ,"txtABA_CD"
                                    ,"txtACC_NO"
                                    );

        var exceptionList = new Array(
                                     "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"img_HelpOn1"
                                    ,"img_HelpOn2"
                                    );


        /***********************
         * 16. �����ȸ�� �˾� *
         **********************/
		function fnc_EmplPop() {

			var obj = new String();

            obj.shr_kind = "SHR_02";
            obj.eno_nm = "";

            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtDPT_CD").value = obj.dpt_cd;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtJOB_CD").value = obj.job_cd;
            document.getElementById("txtJOB_NM").value = obj.job_nm;


		}

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO','1');
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetEnoNm("txtENO_NO","","1");
            if(document.getElementById("txtENO_NO").value != "") {

                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_CD").value      = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("txtJOB_CD").value      = obj.job_cd;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_CD").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                document.getElementById("txtJOB_CD").value      = "";
            }

        }


        /**
         * ���������� ��ȸ �Ѵ�.
         * ������� �˻�
         */

         function fnc_FindBankInfo() {

             var eno_no   = document.getElementById('txtENO_NO').value;

	 		dsT_WL_HDPDLIST_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb010.cmd.WELB010CMD&S_MODE=SHR_01&ENO_NO="+eno_no;
    		dsT_WL_HDPDLIST_01.reset();

        }



    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_HDPDLIST)|
    | 3. ���Ǵ� Table List(T_WL_HDPDLIST)		 |
    +------------------------------------------------>
    <Object ID="dsT_WL_HDPDLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_HDPDLIST_01) |
    | 3. ���Ǵ� Table List(T_WL_HDPDLIST)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_HDPDLIST_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>



    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_WL_HDPDLIST)	|
    | 3. ���Ǵ� Table List(T_WL_HDPDLIST)	        |
    +--------------------------------------------------->
    <Object ID ="trT_WL_HDPDLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_WL_HDPDLIST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WL_HDPDLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | ��������  Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_HDPDLIST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[���,������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("����� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_WL_HDPDLIST event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_WL_HDPDLIST event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_HDPDLIST event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        if(row > 0) {
            if(dsT_WL_HDPDLIST.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
    </script>


    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ, ��ȿ�� �˻�
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_HDPDLIST event=CanRowPosChange(row)>

         if ( dsT_WL_HDPDLIST.NameValue(row,"ENO_NO") == "" ) {
            alert("[ ��� ]�� �ʼ� �Է»����Դϴ�");
            return false;
          } else if ( dsT_WL_HDPDLIST.NameValue(row,"PHN_NO") == "" ) {
            alert("[ �޴�����ȣ ]�� �ʼ� �Է»����Դϴ�");
            return false;
          } else if ( dsT_WL_HDPDLIST.NameValue(row,"SUB_AMT") == "" ) {
            alert("[ ������ ]�� �ʼ� �Է»����Դϴ�");
            return false;
          } else if ( dsT_WL_HDPDLIST.NameValue(row,"STR_YMD") == "" ) {
            alert("[ ������ ]�� �ʼ� �Է»����Դϴ�");
            return false;
          } else if ( dsT_WL_HDPDLIST.NameValue(row,"ABA_CD") == "" ) {
            alert("[ ���౸�� ]�� �ʼ� �Է»����Դϴ�.");
            return false;
          } else if ( dsT_WL_HDPDLIST.NameValue(row,"ACC_NO") == "" ) {
            alert(" [ ���¹�ȣ ]�� �ʼ� �Է»����Դϴ�. ");
            return false;
          }
     </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������������</td>
					<td align="right" class="navigator">HOME/�����Ļ�/��ź�����/<font color="#000000">����������������</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
<%
    if(itMaster){
%>
		    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
<%
    }
%>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                    <col width="60"></col>
                                    <col width="190"></col>
                                    <col width="60"></col>
                                    <col width="180"></col>
                                    <col width="160"></col>
                                    <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td align="right" class="searchState">�μ�&nbsp;</td>
                                <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                    <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState"> �� ��&nbsp; </td>
                                <td class="padding2423">
								    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13){fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled" >
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13){fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');"></a>
							    </td>
                                <td align="right" class="searchState">��ȿ������(���ϱ���)&nbsp;</td>
                                <td class="padding2423">
                                    <input type="checkbox" name="chkCHK_DATA" value="1">
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="50"></col>
					<col width="115"></col>
					<col width="75"></col>
					<col width="100"></col>
					<col width="50"></col>
					<col width="60"></col>
					<col width="60"></col>
					<col width="130"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">�� ��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" style="width:80" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo(); fnc_FindBankInfo();" onchange="fnc_SearchEmpNo()" >
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtENO_NO.disabled == true){return;} fnc_EmplPop(); fnc_FindBankInfo(); " ></a>
                    </td>
                    <td align="center" class="creamBold">�� ��</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" style="width:100%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm(); fnc_FindBankInfo();" onchange="fnc_SearchEmpNm()" >
                        <input type="hidden" id="hidOCC_CD" name="hidOCC_CD">
                    </td>
					<td align="center" class="creamBold">�� ��</td>
					<td class="padding2423"><input type=hidden id="txtDPT_CD"><input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">�� ��</td>
					<td class="padding2423"><input type=hidden id="txtJOB_CD"><input id="txtJOB_NM" size="15" class="input_ReadOnly" readonly></td>

					<td align="center" class="creamBold">�޴�����ȣ</td>
					<td class="padding2423"><input id="txtPHN_NO" size="15" maxlength="15" onkeypress="cfCheckNumber()"  style="ime-mode:disabled"></td>
    			</tr>
                <tr>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423">
						<select id="cmbSUB_AMT" style="width: 100px" >
						<option value="30000">30000</option>
						<option value="40000">40000</option>
						<option value="50000">50000</option>
						</select>
					</td>
                    <td align="center" class="creamBold">�������</td>
					<td class="padding2423" colspan="3">
                        <input id="txtSTR_YMD" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YMD','','500','130');"></a>
                         ~
                        <input id="txtEND_YMD" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtEND_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YMD','','600','130');"></a>
                    </td>
		            <td align="center" class="creamBold">���¸�</td>
					<td class="padding2423">
						<input id="txtABA_CD" name="txtABA_CD" size="2" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('BK','txtABA_CD','txtABA_NM');" onChange="fnc_GetCommNm('BK','txtABA_CD','txtABA_NM');">
						<input id="txtABA_NM" name="txtABA_NM" size="7" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgABA_CD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgABA_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtABA_CD','txtABA_NM','�޿������׸�','BK');return false;"></a>
                    </td>
  					<td align="center" class="creamBold">���¹�ȣ</td>
					<td class="padding2423"><input id="txtACC_NO" size="15" maxlength="15" onkeypress="cfCheckNumber()"  style="ime-mode:disabled"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

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
						<object	id="grdT_WL_HDPDLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
							<param name="DataID"					value="dsT_WL_HDPDLIST">
							<param name="Format"					value="
								<C> id={currow}		width=30    name='NO'			  align=center </C>
                                <C> id='ENO_NO'     width=70    name='���'           align=center </C>
                                <C> id='ENO_NM'     width=55    name='����'           align=center </C>
								<C> id='DPT_NM'		width=75	name='�Ҽ�'			  align=center </C>
								<C> id='JOB_NM'		width=50	name='����'			  align=center </C>
								<C> id='STR_YMD'	width=70	name='����������'	  align=center </C>
								<C> id='END_YMD'    width=70    name='����������'     align=center </C>
								<C> id='PHN_NO'		width=90	name='�޴�����ȣ'     align=center </C>
								<C> id='SUB_AMT'	width=70	name='������'		  align=right rightmargin='10'</C>
								<C> id='ABA_NM'	  	width=70	name='���¸�'         align=center	  </C>
								<C> id='ACC_NO'		width=115	name='���¹�ȣ'		  align=center </C>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- KPI Pool ���� ���̺� -->
<object id="bndT_WL_HDPDLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_HDPDLIST">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO		Ctrl=txtENO_NO	      	Param=value		</C>
		<C>Col=ENO_NM    	Ctrl=txtENO_NM	     	Param=value		</C>
		<C>Col=DPT_CD		Ctrl=txtDPT_CD      	Param=value		</C>
		<C>Col=DPT_NM		Ctrl=txtDPT_NM	      	Param=value		</C>
		<C>Col=JOB_CD		Ctrl=txtJOB_CD	     	Param=value		</C>
		<C>Col=JOB_NM		Ctrl=txtJOB_NM	     	Param=value		</C>
		<C>Col=PHN_NO		Ctrl=txtPHN_NO	     	Param=value		</C>
		<C>Col=SUB_AMT		Ctrl=cmbSUB_AMT     	Param=value		Disable=disabled    Mask="XXX,XXX,XXX,XXX"</C>
        <C>Col=STR_YMD      Ctrl=txtSTR_YMD         Param=value     </C>
        <C>Col=END_YMD      Ctrl=txtEND_YMD         Param=value     </C>
        <C>Col=ABA_CD       Ctrl=txtABA_CD          Param=value     </C>
        <C>Col=ABA_NM       Ctrl=txtABA_NM          Param=value     </C>
        <C>Col=ACC_NO       Ctrl=txtACC_NO          Param=value     </C>
    '>
</object>


<object id="bndT_WL_HDPDLIST_01" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_HDPDLIST_01">
	<Param Name="BindInfo", Value='

        <C>Col=ABA_CD       Ctrl=txtABA_CD          Param=value     </C>
        <C>Col=ABA_NM       Ctrl=txtABA_NM          Param=value     </C>
        <C>Col=ACC_NO       Ctrl=txtACC_NO          Param=value     </C>
    '>
</object>