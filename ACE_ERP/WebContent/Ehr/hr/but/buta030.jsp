<!--
*****************************************************
* @source       : buta030.jsp
* @description : ����ǰ�ǽ�û��Ȳ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/06      ���м�        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>����ǰ�ǽ�û��Ȳ(buta030)</title>
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
    var nscp = (navigator.appName == "Netscape")

    var btnList = 'TFTTFFTT';
    /***********************************
     * 01. ��ȸ �Լ�_List ������ ��ȸ  *
     ***********************************/
    function fnc_SearchList() {


    }

    /***********************************
     * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
     ***********************************/
    function fnc_SearchItem() {

        //�̰��� �ش� �ڵ��� �Է� �ϼ���

    }

    /******************"C:/project000/MASA(back_up)/�ҽ�/data2/htdocs2/PMSL/js/comFunction.js"
     * 03. ���� �Լ�  *
     ******************/
    function fnc_Save() {

    }

    /******************
     * 04. ���� �Լ�  *
     ******************/
    function fnc_Delete() {

    }

    /******************
     * 05. �μ� �Լ�  *
     ******************/
    function fnc_Print() {
        var f = document.form1;

        if ( f.txtSTR_YMD_SHR.value == "" ||  f.txtSTR_YMD_SHR.value == null )
        {
            alert("����Ⱓ�� �����Ͻʽÿ�.");
            f.txtSTR_YMD_SHR.focus();
            return false;
        }
        if ( f.txtEND_YMD_SHR.value == "" ||  f.txtEND_YMD_SHR.value == null )
        {
            alert("����Ⱓ�� �����Ͻʽÿ�.");
            f.txtEND_YMD_SHR.focus();
            return false;
        }
        if ( f.txtEND_YMD_SHR.value < f.txtSTR_YMD_SHR.value )
        {
            alert("�Ⱓ�� �߸� �Է��ϼ̽��ϴ�.");
            f.txtSTR_YMD_SHR.focus();
            return false;
        }

        var str_ymd_shr = f.txtSTR_YMD_SHR.value;
        var end_ymd_shr = f.txtEND_YMD_SHR.value;
        var dpt_cd  = f.txtDPT_CD_SHR.value;
        var job_cd  = f.txtJOB_CD_SHR.value;

        var str_ymd = str_ymd_shr.substr(0,4) + str_ymd_shr.substr(5,2) + str_ymd_shr.substr(8,2);
        var end_ymd = end_ymd_shr.substr(0,4) + end_ymd_shr.substr(5,2) + end_ymd_shr.substr(8,2);
        var ymd_val = "���Ⱓ : " + str_ymd_shr.substr(0,4) + "." + str_ymd_shr.substr(5,2) + "." + str_ymd_shr.substr(8,2) + " - ";
        var ymd_val = ymd_val + end_ymd_shr.substr(0,4) + "." + end_ymd_shr.substr(5,2) + "." + end_ymd_shr.substr(8,2);

        var url = "buta030_PV.jsp?str_ymd="+str_ymd+"&end_ymd="+end_ymd+"&dpt_cd="+dpt_cd+"&job_cd="+job_cd+"&ymd_val="+ymd_val;
  		window.open(url,"","width=1024,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        return;

    }

    /***********************
     * 06. ���� ���� �Լ�  *
     ***********************/
    function fnc_ToExcel() {

  // ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
  // �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

    }

    /******************
     * 07. �ű� �Լ�  *
     ******************/
    function fnc_AddNew() {

  //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

		document.form1.txtSTR_YMD_SHR.focus();
        document.getElementById("txtDPT_CD_SHR").value = "<%=box.get("SESSION_DPTCD") %>";
        document.getElementById("txtDPT_NM_SHR").value = "<%=box.get("SESSION_DPTNM") %>";


    }

    /************************
     * 11. ȭ�� ����(�ݱ�)  *
     ***********************/
    function fnc_Exit() {


      frame = window.external.GetFrame(window);
      frame.CloseFrame();

   }

    /******************************
     * 12. �˻� ���� ��ȿ�� �˻�  *
     ******************************/
    function fnc_SearchItemCheck(year) {

  //�̰��� �ش� �ڵ��� �Է� �ϼ���

    }

    /*************************
     * 13. ���� ��ȿ�� üũ  *
     *************************/
    function fnc_SaveItemCheck() {

    }

    /********************************************
     * 14. Form Load �� Default �۾� ó�� �κ�  *
     *******************************************/
    function fnc_OnLoadProcess() {

        document.getElementById("txtSTR_YMD_SHR").value = getToday().substr(0,7)+"-01";
        document.getElementById("txtEND_YMD_SHR").value = getToday();
        document.getElementById("txtDPT_CD_SHR").value = "<%=box.get("SESSION_DPTCD") %>";
        document.getElementById("txtDPT_NM_SHR").value = "<%=box.get("SESSION_DPTNM") %>";
		document.form1.txtSTR_YMD_SHR.focus();

     }

    /********************
    * 15. ����Ű ó��  *
    *******************/
    function fnc_HotKey() {

      fnc_HotKey_Process(btnList, event.keyCode);

    }

    /********************************************
    * ��¥ ���� ��ȿ�� üũ                     *
    ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

        function fnc_Comchange(val) {
            var f = document.form1;
            if ( val == "0" )
            {
                key1.style.display = "";
                key2.style.display = "none";
            } else {
                key1.style.display = "none" ;
                key2.style.display = "";
            }
        }
    /********************************************
    * ez-gen ��ư Ŭ�� �̺�Ʈ                   *
    ********************************************/
    function winclose()
    {
        window.close();
    }
    function goclick(x)
    {
        if( !document.form1.aaa.RunButton(x)) alert("��ü�� �����ϴ�.");
    }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>



    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->

    <!--------------------------+
    | Grid �̺�Ʈ ó��  |
    +--------------------------->

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
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����ǰ�ǽ�û��Ȳ</td>
          <td align="right" class="navigator">HOME/���°���/�������/<font color="#000000">����ǰ�ǽ�û��Ȳ</font></td>
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
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
    </td>
  </tr>
</table>
<!-- ��ư ���̺� �� -->


<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="searchState" align="right">����Ⱓ&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                     ~
                                    <input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','340','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>

                                <td class="searchState" align="right">�Ҽ�&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtDPT_CD_SHR" size="3" maxlength="2" valid="key=true;type=eng" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
                                    <input id="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                </td>
                                <td class="searchState" align="right">������&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtJOB_CD_SHR" size="14" maxlength="20" >

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

<table border="0"><tr><td height="5"></td></tr></table>


<!-- ���� ��ȸ �׸��� ���̺� ��-->
<input type="hidden" name="txtDOC_AUTHO" value="1">
<input type="hidden" name="flag">
</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
