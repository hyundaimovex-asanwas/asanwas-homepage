<!--
*****************************************************
* @source       : misb260.jsp
* @description  : ����αٷ��ڸ�� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/05/01      �̽¿�        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>����αٷ��ڸ��(misb260)</title>
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

        var str_ymd = f.txtSTR_YMD_SHR.value;
        var end_ymd = f.txtEND_YMD_SHR.value;
        var dpt_cd  = f.txtDPT_CD.value;
        var dpt_nm  = f.txtDPT_NM.value;
        var cd_gbn  = f.txtCD_GBN.value;
        var url = "misb260_PV.jsp?str_ymd="+str_ymd+"&end_ymd="+end_ymd+"&dpt_cd="+dpt_cd+"&dpt_nm="+dpt_nm+"&cd_gbn="+cd_gbn;
        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
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

    document.getElementById('txtSTR_YMD_SHR').value = getToday();
    document.getElementById('txtEND_YMD_SHR').value = getToday();

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

    /************************************************
     * ���� �� �Ҽ��ڵ� �˾�â ó��                 *
     ************************************************/
    function fnc_DptNmPopup(gbn) {
        
        var obj = new String();

        if (gbn == 'DEPT') {
            obj.title = '�μ�';
            obj.gbn   = 'DEPT2';
            
            window.showModalDialog("/common/popup/codenm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            if(obj.comm_cd != '' && obj.comm_nm != '') {
                document.getElementById('txtDPT_CD').value  = obj.comm_cd;
                document.getElementById('txtDPT_NM').value  = obj.comm_nm;
                document.getElementById('txtCD_GBN').value  = obj.cd_gbn;
            }
        }
    }

        /*************************************************
         * �Ҽ� �� ���ڵ� �Է½� �ش� �� DISPLAY         *
         ************************************************/
        function fnc_CommNm(gbn) {

            // �Ҽ��ڵ�
            document.getElementById('txtCD_GBN').value  = "";
            document.getElementById('txtDPT_NM').value  = "";                        
            // �Ҽ��ڵ�
            fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM');

            if (document.getElementById('txtDPT_NM').value != "") {
                document.getElementById('txtCD_GBN').value  = "A4";
            } else {
                fnc_GetCommNm('B2', 'txtDPT_CD','txtDPT_NM');
				if (document.getElementById('txtDPT_NM').value != "") {
				    document.getElementById('txtCD_GBN').value  = "B2";
                }
            }
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
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����αٷ��ڸ��</td>
          <td align="right" class="navigator">HOME/�濵����/�����Ȳ/<font color="#000000">����αٷ��ڸ��</font></td>
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
      <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>-->
      <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
      <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a -->
      <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"</a> -->
      <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>-->
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
    </td>
  </tr>
</table>
<!-- ��ư ���̺� �� -->


<!-- power Search���̺� ���� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="right" class="searchState" width="64">��ȸ�Ⱓ&nbsp;</td>
                                <td class="padding2423" width = "220">

                                    <input type="text" id="txtSTR_YMD_SHR"  name="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" value="" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','98','106');">
                                    <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                    ~
                                    <input type="text" id="txtEND_YMD_SHR"  name="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" value="" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','213','106');">
                                    <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
								<td>&nbsp;</td>
                                <td class="searchState" align="right" width="64">�μ�</td>
                                <td class="padding2423" align="left">
                                    <input id="txtDPT_CD" style="width:36" maxlength="2" onChange="fnc_CommNm('DEPT');">
                                    <input id="txtDPT_NM" style="width:96" class="input_ReadOnly"  readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
                                        <img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DptNmPopup('DEPT');">
                                    </a>
                                    <input type=hidden id="txtCD_GBN" style="width:36" >
                                </td>
							</tr>
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

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" id="biz"  style="display:none">
            <input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            &nbsp;
            <input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� ���� -->
<!-- table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="paddingTop8">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
        </tr>
      </table>
    </td>
  </tr>
</table -->
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->

<!-- ���� ��ȸ �׸��� ���̺� ��-->
<input type="hidden" name="txtDOC_AUTHO" value="1">
<input type="hidden" name="flag">
<input type="hidden" name="hidGBN_OCC_CD" value="A">
<input type="hidden" name="hidGBN_GBN_CASE" value="H">
</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
