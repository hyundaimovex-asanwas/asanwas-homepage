<!--
*****************************************************
* @source       : misa020.jsp
* @description : ������ �ο���Ȳ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/04/12      �̽¿�        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
//************************************************************** ezgen
String a1 = "";
String b1 = "";
//************************************************************** ezgen
%>



<html>
<head>
<title>������ �ο���Ȳ(misa020)</title>
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
        var f = document.form1;
      	if( document.form1.rdoGBN_CASE[0].checked ){
       		var GBN_CASE = "ALL";
       	} else if( document.form1.rdoGBN_CASE[1].checked ){
       		var GBN_CASE = "HEAD_CD";
       	} else if( document.form1.rdoGBN_CASE[2].checked ){
       		var GBN_CASE = "DPT_CD";
       	}

        f.rptObject.SetValue("Group GBN_CASE", GBN_CASE);
        f.rptObject.RunButton("Command_Search");
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
        if ( f.flag.value == "Y" ) 
        {   
             form1.aaa.RunButton('print_go');
        }
        else alert("������ȸ �� �μ� �Ͻñ� �ٶ��ϴ�.");
    }

    /***********************
     * 06. ���� ���� �Լ�  *
     ***********************/
    function fnc_ToExcel() {

        var f = document.form1;
        f.rptObject.RunButton("Picture_Excel");

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
        var f = document.form1;
        f.rptObject.RunButton("Command_Cansle");

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
            return; 
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

<SCRIPT ID=clientHnwActivEvent LANGUAGE=javascript FOR="rptObject" EVENT="FireEvent(nParam1,nParam2,strParam)">
<!-- //EZgen�� FireEvent ��ư ����� �߻��� -->
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
</SCRIPT>
</head>
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll="auto" onkeydown = "fnc_HotKey();">
	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������ο���Ȳ</td>
					<td align="right" class="navigator">HOME/�濵����/�ο���Ȳ/<font color="#000000">������ �ο���Ȳ</font></td>
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
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"> <img src="/images/button/btn_SearchOn.gif" name="Image3"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
      <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"> <img src="/images/button/btn_AddnewOn.gif" name="Image2"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()">    </a-->
      <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"   name="Image4"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()">      </a-->
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="Image1"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()">     </a>
      <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()">   </a-->
      <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"> <img src="/images/button/btn_DeleteOn.gif" name="Image5"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()">    </a-->
      <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="Image6"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()">     </a-->
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">   <img src="/images/button/btn_ExitOn.gif"   name="Image6"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()">      </a>
    </td>
  </tr>
</table>
<!-- ��ư ���̺� �� -->
<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="searchState" align="center" class="creamBold" width="80">�������</td>
                                <td align="left" class="padding2423">
                                    &nbsp;&nbsp;
                                    <input type="radio" name="rdoGBN_CASE" id="rdoGBN_CASE" style="margin-bottom:-2px;border:0;">��ü&nbsp;&nbsp;
                                    <input type="radio" name="rdoGBN_CASE" id="rdoGBN_CASE" style="margin-bottom:-2px;border:0;" checked>������κ�&nbsp;&nbsp;
									<!--
                                    <input type="radio" name="rdoGBN_CASE" id="rdoGBN_CASE" style="margin-bottom:-2px;border:0;">���籸�к�&nbsp;&nbsp;
									-->
                                    <input type="radio" name="rdoGBN_CASE" id="rdoGBN_CASE" style="margin-bottom:-2px;border:0;">�μ���
                                </td>
                            </tr>
                        </table>
                    </td>
    </tr>
</table>
<BR>
<!-- power Search���̺� �� -->

        <comment id="__NSID__">
              <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="misa020.hnw">
              <param name="initvalue" VALUE="">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
        </comment>
		<script> __ShowEmbedObject(__NSID__); </script>
	</form>


</body>
</html>
