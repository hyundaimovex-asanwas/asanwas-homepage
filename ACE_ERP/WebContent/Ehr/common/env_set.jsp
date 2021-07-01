<!--
    ************************************************************************************
    * @Source         : sela022.jsp                                                    *
    * @Description    : �������� ���� PAGE                                             *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/19  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>


<html>

    <head>
    <title>�������� ����</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFTFFFFT';



        var gbn     = '';
        var title   = '';
        var bbs_gbn = '';
        var seq_no  = '';
        var ref_no  = '';
        var step_no = '';
        var dept_no = '';
        var eno_no  = '';
        var eno_no  = '';


        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {


            document.getElementById("txtSUBJECT_TAG").innerText = "Windows 7 ����� ����";
            document.getElementById("txtSRCFILE1_NM").innerText =  "AMX_20121101.zip";
            document.getElementById("txtTGTFILE1_NM").innerText =  "C:/project3/asn/file_repository/upload/201211210237033730.zip";
            document.getElementById("txtSRCFILE2_NM").innerText =  "win7_user.jpg";
            document.getElementById("txtTGTFILE2_NM").innerText =  "C:/project3/asn/file_repository/upload/2011081707564756471.jpg";


        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {


            window.close();
        }

        function fnc_link(val1, val2) {

            // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
            cfDownload(val1, val2);

        }

    </script>

    </head>






<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������� ����</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="100"></col>
                    <col width="300"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">÷������</td>
                    <td class="padding2423" colspan="3">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE1_NM').innerText, document.getElementById('txtTGTFILE1_NM').value);"><span id="txtSRCFILE1_NM"  name="txtSRCFILE1_NM"></span></a>
                            <input type=hidden id="txtTGTFILE1_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE2_NM').innerText, document.getElementById('txtTGTFILE2_NM').value);"><span id="txtSRCFILE2_NM"  name="txtSRCFILE2_NM"></span></a>
                            <input type=hidden id="txtTGTFILE2_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE3_NM').innerText, document.getElementById('txtTGTFILE3_NM').value);"><span id="txtSRCFILE3_NM"  name="txtSRCFILE3_NM"></span></a>
                            <input type=hidden id="txtTGTFILE3_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE4_NM').innerText, document.getElementById('txtTGTFILE4_NM').value);"><span id="txtSRCFILE4_NM"  name="txtSRCFILE4_NM"></span></a>
                            <input type=hidden id="txtTGTFILE4_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE5_NM').innerText, document.getElementById('txtTGTFILE5_NM').value);"><span id="txtSRCFILE5_NM"  name="txtSRCFILE5_NM"></span></a>
                            <input type=hidden id="txtTGTFILE5_NM">
                    </td>
                </tr>

                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtSUBJECT_TAG"  name="txtSUBJECT_TAG"></span>
                    </td>
                </tr>
                <tr>
                    <td class="padding2423" colspan="4" >
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="130" rows="26" readonly>Windows 7 ����� ����

	Components ���� ������  �߻��� ��  �Ʒ��� ���� ��ġ �� ���ٶ��ϴ�.

	������ > ����� ���� > ����ڰ��� ��Ʈ�� ����  : �˸�����������   ����(÷��2����) > ������  ��

	÷��1 (AMX_20121101.zip)��  DownLoad�� ������ Ǯ��

	Installer.exe ��   ������� �ֽʽÿ�.

	����) Windows 7 ��  �������α׷��� �����ϱ� ���Ͽ� ����ڰ��� ��Ʈ���� ����Ͽ� �����մϴ�.

	�����մϴ�.
                        </textarea>
                    </td>
                </tr>
                <input type=hidden id="txtBBS_GBN">
                <input type=hidden id="txtSEQ_NO">
                <input type=hidden id="txtREF_NO">
                <input type=hidden id="txtSTEP_NO">
                <input type=hidden id="txtDEPT_NO">
            </table>
        </td>
    </tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

</form>
<!-- form �� -->

</body>
</html>