<!--*************************************************************************
* @source      : reta050.jsp                                                *
* @description : �����ݿ���ݾ���ȸ PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/03/23      ����ȣ        �����ۼ�                                    *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>�����ݿ���ݾ���ȸ(reta050)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language="javascript" src="/common/dateformat.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "T"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.a.reta050.cmd.RETA050CMD";
        var params = null;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            //�˻���ȿ�� �˻�
            if(!fnc_SearchItemCheck()) return;

            //�˻�����
            var oENO_NO = document.getElementById("txtENO_NO_SHR");
            var oYMD = document.getElementById("txtYMD_SHR");
            var oHIRG_YMD = document.getElementById("txtHIRG_YMD");
            var oRET_YMD = document.getElementById("txtRET_YMD");

            //������ ���Ⱓ�� �������� ����
            oRET_YMD.value = oYMD.value;

            params = "&S_MODE=SHR"
                   + "&ENO_NO="     +oENO_NO.value
                   + "&HIRG_YMD="   +oHIRG_YMD.value
                   + "&RET_YMD="    +oRET_YMD.value
                   + "&YMD="        +oRET_YMD.value;

            //���Ϲ��� DataSet ����
            trT_AC_RETINFO.KeyValue = "tr02"
                                    + "(O:dsT_AC_RETINFO=dsT_AC_RETINFO"
                                    + ",O:dsT_AC_RETMASTER=dsT_AC_RETMASTER"
                                    + ")";

			trT_AC_RETINFO.action = dataClassName+params;
			trT_AC_RETINFO.post();
        }



        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {

        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETINFO.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETINFO.GridToExcel("�����ݿ���ݾ���ȸ", '', 225);
        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. �߰� �Լ�                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. ���� �Լ�                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. �ʱ�ȭ �Լ�                           *
         ********************************************/
        function fnc_Clear() {
            document.getElementById("resultMessage").innerText = ' ';
            dsT_AC_RETINFO.ClearData();
            dsT_AC_RETMASTER.ClearData();
            fnc_ClearInputFieldAll(new Array("txtENO_NO_SHR")); //��� �Է�â�� �ʱ�ȭ
//            document.getElementById("txtENO_NO_SHR").value = "";
			fnc_OnLoadProcess();//�ʱ�ȭ�۾� ����
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETINFO.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {
	        //cfCheckDateTerm('txtYMD_SHR','txtHIRG_YMD','txtYMD_SHR');
            return fnc_CheckElement(oElementList, oElementMsgList);
        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {

			var oToday = getToday()
            document.getElementById('txtENO_NO_SHR').value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById('txtENO_NM_SHR').value = '<%=box.get("SESSION_ENONM")%>';

            fnc_SearchEmpNo();
<%
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
    	    document.getElementById("txtENO_NO_SHR").disabled = false;
    	    document.getElementById("txtENO_NM_SHR").disabled = false;
    	    document.getElementById("ImgEnoNo").disabled = false;
<%
    } else  {
%>
    	    document.getElementById('txtENO_NO_SHR').readOnly = true;
            document.getElementById('txtENO_NO_SHR').className = "input_ReadOnly";
    	    document.getElementById("txtENO_NM_SHR").readOnly = true;
            document.getElementById('txtENO_NM_SHR').className = "input_ReadOnly";
    	    document.getElementById("ImgEnoNo").disabled = true;
<%
    }
%>

            //ù��° �μ� : �׸����
            //�ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)
            //�׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
            cfStyleGrid(form1.grdT_AC_RETMASTER,0,"false","false");      // Grid Style ����
        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form�� Active �� �� ó�� �� ��          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * ��Ÿ �Լ�              *
         ********************************************/

        //���� ���ǵǾ� �ִ� �׸��
        var oElementList = new Array(    "txtENO_NO_SHR"
                                        ,"txtENO_NM_SHR"
                                        ,"txtYMD_SHR");

        //�׸���� �޼���
        var oElementMsgList = new Array( "���"
                                        ,"����"
                                        ,"��������");
        //���� �׸��
        var oExceptionList = new Array(  );


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            fnc_ClearInputFieldAll(new Array("txtENO_NO_SHR"));
            if(document.getElementById("txtENO_NO_SHR").value != "") {

                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
                document.getElementById("txtHIRG_YMD_SHR").value    = obj.hirg_ymd;
                document.getElementById("txtOCC_NM_SHR").value      = obj.occ_cd+" "+obj.occ_nm;
                document.getElementById("txtOCC_CD_SHR").value      = obj.occ_cd;
                document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;
                document.getElementById("txtRET_YMD_SHR").value     = obj.ret_ymd;
                document.getElementById("txtRAM_YMD_SHR").value     = obj.ram_ymd;
                document.getElementById("txtRAM_YMD2_SHR").value    = obj.ram_ymd2;
                document.getElementById("txtRAM_YMD3_SHR").value    = obj.ram_ymd3;
                document.getElementById("txtHIRR_YMD_SHR").value    = obj.hirr_ymd;

                var prev = prev_month(getTodayArray()[0]+"-"+getTodayArray()[1]).split("-");
                document.getElementById("txtDSP_YMD").value = prev[0]+"-"+prev[1];
                document.getElementById("txtYMD_SHR").value = prev[0]+"-"+prev[1]+"-"+fnc_Lastday(prev[0], prev[1]);
            } else {
                document.getElementById("txtENO_NM_SHR").value      = "";
                document.getElementById("txtHIRG_YMD_SHR").value    = "";
                document.getElementById("txtOCC_NM_SHR").value      = "";
                document.getElementById("txtOCC_CD_SHR").value      = "";
                document.getElementById("txtDPT_NM_SHR").value      = "";
                document.getElementById("txtJOB_NM_SHR").value      = "";
                document.getElementById("txtRET_YMD_SHR").value     = "";
                document.getElementById("txtRAM_YMD_SHR").value     = "";
                document.getElementById("txtRAM_YMD2_SHR").value    = "";
                document.getElementById("txtRAM_YMD3_SHR").value    = "";
                document.getElementById("txtDSP_YMD").value         = "";
                document.getElementById("txtYMD_SHR").value         = "";
                document.getElementById("txtHIRR_YMD_SHR").value    = "";
            }


            //���Ⱓ�� �������� ���ε�
            bindingTenure();
        }



        /**
         * ���� �Ⱓ�� �����Ѵ�.
         * (���Ⱓ�� ������ ������ �������� �������� �Ѵ�.)
         */
        function bindingTenure() {
            var oHIRG_YMD = document.getElementById("txtHIRG_YMD");
            var elementName = new Array(    "txtHIRR_YMD_SHR"   //�Ի���
                                           ,"txtRAM_YMD_SHR"   //�߰�������1
                                           ,"txtRAM_YMD2_SHR"   //�߰�������2
                                           ,"txtRAM_YMD3_SHR"   //�߰�������3
                                           ,"txtRET_YMD_SHR");  //�����
            var element;
            var oDate;
            var vYMD;

            //�Ի��� ���
            for(i=0; i<4; i++) {
                element = document.getElementById(elementName[i]);
                if(element.value != "" && element.value != "undefined") {

                    if(i != 0) {
                        vYMD = element.value.split("-");
                        oDate = new Date(vYMD[0], vYMD[1]-1, vYMD[2]);
                        oDate.setDate(oDate.getDate()+1);
                        oHIRG_YMD.value = oDate.format("yyyy-mm-dd");
                    } else
                        oHIRG_YMD.value = element.value;

                } else {
                    break;
                }
            }

        }
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->
    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETINFO)                |
    | 3. ���Ǵ� Table List(T_AC_RETINFO)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_RETMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETINFO)                |
    | 3. ���Ǵ� Table List(T_AC_RETINFO)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETINFO" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETINFO.CountRow);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINFO Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    <Script For=dsT_AC_RETMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINFO Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
    <Script For=dsT_AC_RETMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETINFO event="OnSuccess()">
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETINFO event="OnFail()">
        alert(trT_AC_RETINFO.ErrorMsg);
    </script>

    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |
    +--------------------------->
    <script for=grdT_AC_RETINFO event=OnClick(Row,Colid)>

    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- ���� ������ ���� -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����ݿ���ݾ���ȸ</td>
                    <td align="right" class="navigator">HOME/���꼼��/�����ݰ���/<font color="#000000">�����ݿ���ݾ���ȸ</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="110"></col>
                                    <col width="140"></col>
                                    <col width="100"></col>
                                    <col width="140"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                                <tr>

                                    <td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                        <input type="hidden" id="hidEMPL_DPT_CD">
                                    </td>
                                    <td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                                    </td>


                                    <td align="center" class="searchState">��&nbsp;��&nbsp;��</td>
                                    <td class="padding2423">
                                        <input id="txtHIRG_YMD_SHR" name="txtHIRG_YMD_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                    <td class="padding2423">
                                        <input id="txtOCC_NM_SHR" name="txtOCC_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                        <input id="txtOCC_CD_SHR" name="txtOCC_CD_SHR" type="hidden">
                                    </td>
                                    <td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                    <td class="padding2423">
                                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                    <td class="padding2423">
                                        <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" class="searchState">��������</td>
                                    <td class="padding2423" colspan="5">
                                        <input type="text"   id="txtDSP_YMD" size="7" class="input_ReadOnly" readonly>
                                        <input type="hidden" id="txtYMD_SHR" name="txtYMD_SHR">
                                        <input id="txtRET_YMD_SHR" name="txtRET_YMD_SHR" type="hidden">
                                        <input id="txtRAM_YMD_SHR" name="txtRAM_YMD_SHR" type="hidden">
                                        <input id="txtRAM_YMD2_SHR" name="txtRAM_YMD2_SHR" type="hidden">
                                        <input id="txtRAM_YMD3_SHR" name="txtRAM_YMD3_SHR" type="hidden">
                                        <input id="txtHIRR_YMD_SHR" name="txtHIRR_YMD_SHR" type="hidden">
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

    <!-- �˻� ���� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
        <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
            <colgroup>
                <col width="90"></col>
                <col width="170"></col>
                <col width="90"></col>
                <col width="170"></col>
                <col width="90"></col>
                <col width="*"></col>
            </colgroup>
            <tr>
                <td align="center" class="creamBold">�����Ⱓ</td>
                <td class="padding2423">
                    <input type="text" id="txtHIRG_YMD" name="txtHIRG_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                    ~
                    <input type="text" id="txtRET_YMD" name="txtRET_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                </td>
                <td align="center" class="creamBold">�ټӳ��</td>
                <td class="padding2423">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="10"></td>
                            <td><input id="txtRET_LSE_YY" name="txtRET_LSE_YY" type="text" size="3" class="input_ReadOnly" readonly> ��</td>
                            <td><input id="txtRET_LSE_MM" name="txtRET_LSE_MM" type="text" size="3" class="input_ReadOnly" readonly> ��</td>
                            <td><input id="txtRET_LSE_DD" name="txtRET_LSE_DD" type="text" size="3" class="input_ReadOnly" readonly> ��</td>
                            <td width="10"></td>
                        </tr>
                    </table>
                </td>
                <td align="center" class="creamBold">�ټӺ���</td>
                <td class="padding2423">
                    <input id="txtRET_LSE_PER" name="txtRET_LSE_PER" type="text" size="8" class="input_ReadOnly" readonly>
                </td>
            </tr>
            <tr>
                <td align="center" class="creamBold">����ӱ�</td>
                <td class="padding2423">
                    <input id="txtAVG_PAY" name="txtAVG_PAY" type="text" size="14" class="input_ReadOnly" readonly style="text-align:right;">
                </td>
                <td align="center" class="creamBold">���ο���������ȯ��</td>
                <td class="padding2423">
                    <input id="txtRTPL_AMT" name="txtRTPL_AMT" type="text" size="14" class="input_ReadOnly" readonly style="text-align:right;">
                </td>
                <td align="center" class="creamBold">���꿹��ݾ�</td>
                <td class="padding2423" colspan="5">
                    <input id="txtRET_PAY" name="txtRET_PAY" type="text" size="14" class="input_ReadOnly" readonly style="text-align:right;">
                </td>
            </tr>
        </table>
        </td>
    </tr>
    </table>
    <!-- �˻� ���� ���̺� �� -->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="520" border="0" cellspacing="0" cellpadding="0">
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
                    <object id="grdT_AC_RETMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:170px;">
                        <param name="DataID" value="dsT_AC_RETMASTER">
                        <param name="Editable" value="false">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{CUROW}"    width=40        align=center        name="NO"         value={String(Currow)}</C>
                            <C> id=SEQ_NM       width=150       align=center        name="��  ��"               </C>
                            <C> id=RET_YMD      width=110       align=center        name="������"               </C>
                            <C> id=RAM_YMD      width=110       align=center        name="������"               </C>
                            <C> id=AVG_AMT      width=110       align=center        name="����ӱ�"             </C>
                            <C> id=LSE_PER      width=110       align=center        name="�ټӺ���"             </C>
                            <C> id=RTR_AMT      width=150       align=center        name="������(�ߵ������)"   </C>
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


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_AC_RETINFO" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_RETINFO">
    <Param Name="BindInfo", Value='
        <C>Col=AVG_PAY          Ctrl=txtAVG_PAY             Param=value     </C>
        <C>Col=SUB_BON          Ctrl=txtSUB_BON             Param=value     </C>
        <C>Col=LSE_YY           Ctrl=txtRET_LSE_YY          Param=value     </C>
        <C>Col=LSE_MM           Ctrl=txtRET_LSE_MM          Param=value     </C>
        <C>Col=LSE_DD           Ctrl=txtRET_LSE_DD          Param=value     </C>
        <C>Col=LSE_PER          Ctrl=txtRET_LSE_PER         Param=value     </C>
        <C>Col=RET_PAY          Ctrl=txtRET_PAY             Param=value     </C>
        <C>Col=RTPL_AMT         Ctrl=txtRTPL_AMT            Param=value     </C>
    '>
</object>