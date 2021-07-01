<!--
    ************************************************************************************
    * @Source         : pira031.jsp                                                    *
    * @Description    : �޿����� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>�޿�����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //���
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_CAREER.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira031.cmd.PIRA031CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_CAREER.Reset();

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

            if(fnc_SaveItemCheck()) {

                trT_CM_CAREER.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira031.cmd.PIRA031CMD&S_MODE=SAV";
                trT_CM_CAREER.post();

            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var status = 0;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_CM_CAREER.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_CAREER.RowStatus(dsT_CM_CAREER.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_CAREER.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�������[" + dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"STR_YMD") + "] ���������[" + dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"PJT_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CM_CAREER.DeleteRow(dsT_CM_CAREER.RowPosition);

            if (status != 1) {
                trT_CM_CAREER.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira031.cmd.PIRA031CMD&S_MODE=DEL";
                trT_CM_CAREER.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_CM_CAREER.SetColumn(form1.grdT_CM_CAREER.GetColumnID(0));
            form1.grdT_CM_CAREER.Focus();

            bnd.ActiveBind = true;

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

        	var eno_nm = document.getElementById("txtENO_NM").value;
        	var job_cd = document.getElementById("txtJOB_CD").value;
        	var job_nm = document.getElementById("txtJOB_NM").value;
        	var hob_cd = document.getElementById("txtHOB_CD").value;
        	var hinu_amt = document.getElementById("txtHINU_AMT").value;
        	var old_amt = document.getElementById("txtOLD_AMT").value;
        	var npen_amt = document.getElementById("txtNPEN_AMT").value;

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_CM_CAREER.CountColumn == 0) {
                dsT_CM_CAREER.setDataHeader("ENO_NO:STRING,  ENO_NM:STRING, STR_YMD:STRING, END_YMD:STRING,  JOB_NM:STRING, REMARK:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_CM_CAREER.AddRow();

			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"ENO_NM") = eno_nm;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"JOB_CD") = job_cd;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"JOB_NM") = job_nm;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"HOB_CD") = hob_cd;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"NPEN_AMT") = npen_amt;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"HINU_AMT") = hinu_amt;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"OLD_AMT") = old_amt;



            fnc_ColEnabled('E');

            form1.grdT_CM_CAREER.setColumn(form1.grdT_CM_CAREER.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY �ʵ�� �űԽ� �Է� ����
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

        	//����ӽ�����
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_CM_CAREER.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            //Grid Style ����
            cfStyleGrid_New(form1.grdT_CM_CAREER, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        	window.close();
            
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/
         /**
         * T_CM_COMMON(�����ڵ�) ��ȸ�� �˾� (�μ� �� ���δ� ����)
         * @param - ctrl_01 : ���Ϲ��� �ڵ��
         * @param - ctrl_02 : ���Ϲ��� �ڵ���Ӹ�
         * @param - ctrl_03 : Ÿ��Ʋ��
         * @param - ctrl_04 : cd_gbn �ڵ��
         * @param - ctrl_05 : �����ڵ� gbn2_tag ��� ����(Y/N)(20070313�߰�)
         * @param - ctrl_06 : �ٷα��п� ���� �ڵ屸��(20070704�߰�)
         */
        function fnc_careerCodePopup(ctrl_01,ctrl_02,ctrl_03,ctrl_04,ctrl_05,ctrl_06) {

            var obj = new String();

            obj.comm_cd = document.getElementById(ctrl_01).value;
            obj.comm_nm = document.getElementById(ctrl_02).value;
            obj.title   = ctrl_03;
            obj.cd_gbn  = ctrl_04;

            //���� ������ N���� ����
            if(ctrl_05 == undefined || ctrl_05.trim() == ""){
                obj.gbn2_tag = "N";
            }else{
                obj.gbn2_tag = document.getElementById(ctrl_05).value;
            }

            //���� ���ų� �����̸� ��ü
            if(ctrl_06 == undefined){
                obj.occ_cd = "";
            }else{
                obj.occ_cd = ctrl_06;
            }

            window.showModalDialog("/common/popup/career.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.comm_cd != '' && obj.comm_nm != ''){
                document.getElementById(ctrl_01).value = obj.comm_cd;
                document.getElementById(ctrl_02).value = obj.comm_nm;
            }

        }



        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

        }

    </script>
</head>


    <!--********************************************************************
    * ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_CAREER                       |
    | 3. Table List : T_CM_CAREER                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_CAREER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_CAREER                       |
    | 3. Table List : T_CM_CAREER                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_CAREER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_CAREER)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_CAREER Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_CAREER.CountRow);
            document.getElementById("txtJOB_CD").disabled   = true;
            document.getElementById("txtJOB_NM").disabled   = true;
            document.getElementById("txtTOTAL_AMT").disabled   = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_CAREER Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_CAREER Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[ ] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50020) {
            alert("�������/��������� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_CAREER event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_CAREER event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_CAREER Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_CAREER.SysStatus(row);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�޿�����</strong>
        </td>
        <td height="25" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <!--   <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">  <img src="../../images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>-->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> 
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                 <colgroup>
                    <col width="100 "></col>
                    <col width="150"></col>
                    <col width="100 "></col>
                    <col width="150 "></col>
                    <col width="100 "></col>
                    <col width="150 "></col>
                    <col width="100 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">���</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO" maxlength="10" style="width:45%">
                        <input id="txtENO_NM" maxlength="10" style="width:45%">
                    </td>
                    <td align="center" class="blueBold">����</td>
                    <td class="padding2423" >
                        <input id="txtJOB_CD" style="width:15%;ime-mode:inactive" maxlength="3" onChange="fnc_ChkJobCd();">
                        <input id="txtJOB_NM" style="width:50%" class="input_ReadOnly"  readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJOB_CD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgJOB_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD','txtJOB_NM','����','A2');return false;"></a>
                    </td>
                    <input type=hidden id="ENO_NO" size="10">
                    <input type=hidden id="ENO_NM" size="10">
                    <td align="center" class="blueBold"></td>
                    <td class="padding2423" >
                    </td>
                    <td align="center" class="blueBold"></td>
                    <td class="padding2423" >

                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                 <colgroup>
                    <col width="100 "></col>
                    <col width="150"></col>
                    <col width="100 "></col>
                    <col width="150 "></col>
                    <col width="100 "></col>
                    <col width="150 "></col>
                    <col width="100 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">���ο���</td>
                    <td class="padding2423" >
                        <input id="txtNPEN_AMT" maxlength="10" style="width:100%;text-align:right">
                    </td>
                    <td align="center" class="blueBold">�ǷẸ��</td>
                    <td class="padding2423" >
                        <input id="txtHINU_AMT" maxlength="20" style="width:100%;text-align:right">
                    </td>
                    <td align="center" class="blueBold">��纸��</td>
                    <td class="padding2423" >
                    	<input id="txtOLD_AMT" maxlength="20" style="width:100%;text-align:right">
                    </td>
                    <td align="center" class="blueBold">��뺸��</td>
                    <td class="padding2423" >
                    	<input id="txtHINS_AMT" maxlength="20" style="width:100%;text-align:right">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_CAREER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:990px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_CAREER">
                            <param name="Format"                  value="
                                <C> id=ENO_NO        width=120        name=���          		align=center    Edit=none  </C>
								<C> id=ENO_NM        width=150       name=����          	align=center    Edit=none  </C>
								<C> id=JOB_NM        width=150       name=������         	align=center    Edit=none  </C>
								<C> id=NPEN_AMT      width=140       name=���ο���       align=right                </C>
								<C> id=HINU_AMT      width=140       name=�ǷẸ��        align=right                </C>
								<C> id=OLD_AMT       width=140       name=��纸��        align=right                </C>
								<C> id=HINS_AMT      width=140       name=��뺸��        align=right                </C>
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
"ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, ODR_NM:STRING, ATT_SBJ:STRING:KEYVALUETYPE,  CMP_NM:STRING"
**************************************************************
-->
<!-- �����°��� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_CAREER">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=ENO_NM       Ctrl=txtENO_NM       Param=value Disable=disabled </C>
		<C> Col=SEQ_NO        Ctrl=txtSEQ_NO       Param=value </C>
		<C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
		<C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value Disable=disabled</C>
		<C> Col=JOB_NM        Ctrl=txtJOB_NM       Param=value Disable=disabled</C>
		<C> Col=HINU_AMT       Ctrl=txtHINU_AMT      Param=value  </C>
		<C> Col=OLD_AMT       Ctrl=txtOLD_AMT      Param=value  </C>
		<C> Col=HINS_AMT       Ctrl=txtHINS_AMT      Param=value  </C>
		<C> Col=NPEN_AMT       Ctrl=txtNPEN_AMT      Param=value  </C>
    '>
</object>