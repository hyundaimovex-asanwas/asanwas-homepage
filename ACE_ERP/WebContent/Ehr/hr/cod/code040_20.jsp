<!--
***********************************************************************
* @source      : code040_20.jsp
* @description : ������༭ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2018/01/02      �̵���        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>������༭_20��</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
 <link href="../../common/css/style.css" rel="stylesheet" type="text/css">
 <link href="../../common/css/general.css" rel="stylesheet" type="text/css">

 <script language=javascript src="../../common/common.js"></script>
 <script language=javascript src="../../common/result.js"></script>
 <script language=javascript src="../../common/input.js"></script>
 <script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >
		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�


        var today = getToday();
        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD";
        var params = null;
        var strPis_yy="2020";

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {


           dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code040.cmd.CODE040CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO_SHR").value+"&PIS_YY="+strPis_yy;
           
           //prompt('',dsT_CM_PERSON.DataId);
           
           dsT_CM_PERSON.Reset();

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
        	
            if(!fnc_SaveItemCheck()) {
            	
            	return;
            
            }

            if(confirm("������ ������ Ȯ���Ͽ�����, �̿� ���� ����� �����ϰڽ��ϴ�.")){
            	
	            document.getElementById("txtSIGN_NM").value =document.getElementById("txtENO_NM").value;

	            //�н����庯��, count�ʱ�ȭ
	            trT_CM_PERSON.KeyValue = "tr01(I:dsT_CM_PERSON=dsT_CM_PERSON)";
	            
	            trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code040.cmd.CODE040CMD&S_MODE=SAV&ENO_NO="+document.getElementById("txtENO_NO_SHR").value+"&PIS_YY="+strPis_yy+"&SIGN_NM="+document.getElementById("txtENO_NM").value+"&CON_YMD="+document.getElementById("gcemCON_YMD").text;
	            //prompt('',dsT_CM_PERSON.text);

	            trT_CM_PERSON.post();
	         }
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
        	
        	gcrp_print9.Preview();

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {

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


        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {

        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }



        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {
        	
			if(document.getElementById("txtSIGN_NM").value!=""){
				
			    alert("�̹� ������ �Ͽ����ϴ�.");
			    
				return false;
				
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {

            //����� �α����� ������� ������ ���� �⺻������ �����´�.

           document.getElementById("txtENO_NO_SHR").value = gusrid;
           document.getElementById("txtENO_NM_SHR").value = gusrnm;


           if(gusrid != "6060002" && gusrid != "6180001" &&  gusrid != "2030007" && gusrid != "2070020"){ 

	         	fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	         	fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	         	fnc_ChangeStateElement(false, "ImgEnoNo");

			  }

			document.getElementById("txtSIGN_NM").disabled = true;
			document.getElementById("txtSIGN_NM").className = "input_ReadOnly";           
			document.getElementById("txtSIGN_YMD").disabled = true;
			document.getElementById("txtSIGN_YMD").className = "input_ReadOnly";             
					
			fnc_SearchList();

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
        //���� �׸��
        var oExceptionList = new Array(  );

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
        	
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

        }
         /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */

        function fnc_GetNm() {
        	 
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','1','0');

        }

        function fnc_Getcd() {
        	
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');
        }


    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                    |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)           |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton               |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_PERSON)           |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>

    <Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                  *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����      |
    +------------------------------------------------------>


    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        } else {

        }
    </Script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>

    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>


    <!-----------------------------------------------------+
    | Transaction Successful ó��                          |
    +------------------------------------------------------>


    <script for=trT_CM_PERSON event="OnSuccess()">
    
       // fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("���������� ���� ó�� �Ǿ����ϴ�.");
        
        fnc_SearchList();
        
    </script>


    <!-----------------------------------------------------+
    | Transaction Failure ó��                             |
    +------------------------------------------------------>

    <script for=trT_CM_PERSON event="OnFail()">
    
          cfErrorMsg(this);
          
    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- ���� ������ ���� -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- Ķ���� ������-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

    <!-- form ���� -->
    <form name="form1">


    <!-- ��ư ���̺� ���� -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr class="blueTable">
            <td align="right" class="blueTable">���&nbsp;</td>
            <td class="padding2423">
                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9"  maxlength= "8"   onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" onchange="fnc_GetNm();fnc_SearchList();" style="ime-mode:disabled"   >
                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength= "14"  onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}" onchange="fnc_Getcd();fnc_SearchList();"  >
                <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                <input type="hidden" id="hidEMPL_DPT_CD">
            </td>

            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)">  <img src="../../images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<table width="1000" border="1" cellspacing="0" cellpadding="0">
        <tr>
          <td>
          <br>&nbsp;&nbsp;����ƻ�(��)(��ǥ�̻� ���� �豹ȯ)(���ϡ�ȸ�硱�� ��)�� �ٷ��� <input id="txtENO_NM" name="txtENO_NM" size="6"  style="ime-mode:disabled">(���ϡ��ٷ��ڡ��� ��)�� ȸ���� ���������� �����ϸ� �����ǻ翡 ���� ������ ���� ��������� ü���Ѵ�. 
          <br>&nbsp;&nbsp;<strong>��1���� ���� ����Ⱓ ��</strong>
          <br>&nbsp;&nbsp;������ ���� ����Ⱓ��  <input id="txtFROM_YMD" name="txtFROM_YMD" size="9"  style="ime-mode:disabled" >~ <input id="txtTO_YMD" name="txtTO_YMD" size="9"  style="ime-mode:disabled" >
          (<input id="txtMONTH" name="txtMONTH" size="2"  style="ime-mode:disabled">����)�� �Ѵ�.<br>

          <br>&nbsp;&nbsp;<strong>��2���� �����ݾ� �� </strong>
          	<table width="1000" border="1" cellspacing="0" cellpadding="0">
          		<tr style="text-align:center;" height ="10px">
          		    <td>����</td>
          			<td width="150px">�⺻��</td>
          			<td width="150px">�ð��ܼ���</td>
          			<td width="150px">���ϱٷμ���</td>
          			<td width="150px">Ư��������</td>
          			<td width="150px">��������</td>
          			<td width="140px">��</td>
          		</tr>
          		<tr valign="middle">
          		    <td height ="5px" style="text-valign:center;text-align:center;">����</td>
          			<td valign=middle>
          			  <comment id="__NSID__">
          			  	<object id="gcemY01_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%" >
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemY02_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemY03_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td  style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemY04_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemY05_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td  style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemYSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          		</tr>
          		<tr valign="middle">
          		    <td  style="text-valign:center;text-align:center;">���޿�</td>
          			<td valign=middle height ="10px">
          			  <comment id="__NSID__">
          			  	<object id="gcemP01_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%" >
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td  style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemP02_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemP03_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemP04_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemP05_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          		</tr>
          	</table>

          <br>&nbsp;&nbsp;�� �ٷ����� ������ �⺻��, �ð��ܡ����ϱٷμ���, Ư�������� �� �������� �� ���� �� ������ �����Ͽ� �����ϴ� �����ӱݻ������� �ϸ�, �� �޿��� ������ �Ʒ��� ����.
          <br>&nbsp;&nbsp;&nbsp;&nbsp;1. �⺻���� �����ٷνð�(209�ð�/��)�� ���� �޿��̴�.
          <br>&nbsp;&nbsp;&nbsp;&nbsp;2. �ð��ܼ����� �� 52�ð��� ���塤�߰������ϱٷο� ���� �޿��̴�.
          <br>&nbsp;&nbsp;&nbsp;&nbsp;3. ���ϱٷμ����� �� 18�ð��� ���ϱٷο� ���� �޿��̴�.
          <br>&nbsp;&nbsp;&nbsp;&nbsp;4. Ư���������� ���������� �ٹ��� ��� �߻��� �� �ִ� �߰��� ����� �����ϱ� ���Ͽ� �����ϴ� ��ǰ���� ��ձ޿��� ���Կ��� �����Ѵ�.
          <br>&nbsp;&nbsp;&nbsp;&nbsp;5. ���������� �޿�ü�� �������� �߻��� �� �ִ� ������ �����ϱ� ���Ͽ� ���� �ϴ� �ѽ��� �����̴�.
          <br>&nbsp;&nbsp;�� ��⿡ ���Ե��� ���� ��Ÿ����(�ڰݼ���, ��å����, �������� ��)�� ȸ�簡 ���� �������ؿ� ���Ͽ� �����Ѵ�.
          <br>&nbsp;&nbsp;�� �� ���� �����ݾ��� ��1���� ���� ����Ⱓ ���̶� ����, ���� �� �źл��� �����̳� �λ���, ¡��, �ٹ������� � ���� ���� ���������� ���� ��쿡�� 
          <br>&nbsp;&nbsp;�����Ģ �� ȸ�� �λ������ ���� �����Ѵ�. <br>
          <br>&nbsp;&nbsp;<strong>��3���� ���޹�� ��</strong>
          <br>&nbsp;&nbsp;�� ��� 1�Ϻ��� ���ϱ����� �޿������Ⱓ���� �ϸ�, �� ������ 12���� 1�� �ش��ϴ� �ݾ��� �ſ� <input id="txtPAY_DAY" name="txtPAY_DAY" size="2"  style="ime-mode:disabled">��(���޴����� ������ ��� �� ����)�� 
          <br>&nbsp;&nbsp;�ٷ��� ���� ������ ���� ���¿� �Ա��ϴ� ������� �����Ѵ�.
          <br>&nbsp;&nbsp;�� å���� �ӱ��� �� ������ ������ �� ���̸�, ���¼����� ���� ���� ������ �� �ִ�.
          <br>&nbsp;&nbsp;�� �ߵ� �ԡ�������� ��� �ش� ���� �ٹ��ϼ��� ���� ���� ����Ͽ� �����Ѵ�.   <br>
          <br>&nbsp;&nbsp;<strong>��4���� ������� ��</strong>
          <br>&nbsp;&nbsp;�ٷ��ڴ� ������ ������ ���Ͽ� Ÿ�ο��� �˸��ų� Ÿ���� ������ �˷��� ���� ������, ������ ������ ���ݻ��׿� ���� ����� ����� �������� �ʴ´�. 
          <br>&nbsp;&nbsp;���� ������ ������ ������ �����ϴ� ��� ¡�� ������ �� �� ������, �̷� ���� �����Ϳ� ���Ǹ� �������� �ʴ´�.  <br>
          <br>&nbsp;&nbsp;<strong>��5���� ��   �� �� </strong>
          <br>&nbsp;&nbsp;�� �ٷ��ڴ� ���� ���� å���� �����׿� �����ϸ�, ��⿡ ��õ��� ���� ������ ȸ�簡 ���� ���� ���ؿ� ������.
          <br>&nbsp;&nbsp;�� �� ������ ��� ���� ����Ⱓ�� ���Ͽ� ����Ǹ�, ��Ÿ �źа� ���õ� ���ݻ����� �Ի� �� ü���� �ٷΰ�༭, �����Ģ �� ���ù��ɿ� ���Ѵ�.
          <br>&nbsp;&nbsp;�� �� ��༭�� �� ü���� �ٷΰ�༭���� �ӱݰ��� ������ ��ü�Ѵ�.   <br>
           </td>
          </tr>
          <tr>
          <td style="text-align:center;height:40px"><nobr>&nbsp;&nbsp;������� : <comment id="__NSID__">
          			  	<object id="gcemCON_YMD" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:10px;" >
							<param name=Alignment				value=0>
							<param name=Border					value=false>
							<param name=FORMAT					value="YYYY��MM��DD��">
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script><nobr>  <br></td>
          </tr>
          <tr>
          <td>
          <table width="1000" border="0" cellspacing="0" cellpadding="0">
          	<tr>
          		<td rowspan=3 style="text-align:center;" >(ȸ  ��) </td>
          		<td>�� &nbsp;&nbsp;&nbsp;��  :  <input id="txtCADDR" name="txtCADDR" size="30"  style="ime-mode:disabled">  </td>
          		<td rowspan=3 style="text-align:center;"> (�ٷ���)  </td>
          		<td >��   �� : <input id="txtDPT_NM" name="txtDPT_NM" size="20"  style="ime-mode:disabled"> </td>
          		<td rowspan=3 >��  ��  : <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_ConfirmOver.gif',1)">    <img src="../../images/button/btn_ConfirmOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> </td>

          	</tr>
          	<tr>
          		<td>ȸ �� �� : ����ƻ�(��)</td>
          		<td>��   �� : <input id="txtJOB_NM" name="txtJOB_NM" size="20"  style="ime-mode:disabled"></td>
          	</tr>
          	<tr>
          		<td>�� ǥ �� : <input id="txtCADDR_CT" name="txtCADDR_CT" size="9"  style="ime-mode:disabled">      (��) </td>
          		<td>��   �� : <input id="txtSIGN_NM" name="txtSIGN_NM" size="6"  style="ime-mode:disabled"  class="input_ReadOnly" readonly>  (��)
          		    <input id="txtSIGN_YMD" name="txtSIGN_YMD" size="16"  style="ime-mode:disabled"  class="input_ReadOnly" readonly>
          		 </td>
          	</tr>
          </table>

         </td>

        </tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

	</form>
    <!-- form �� -->





<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N
------------------------------------------------------------------------------>
<OBJECT id=gcrp_print9  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_CM_PERSON">
  	<PARAM NAME="DetailDataID"			VALUE="dsT_CM_PERSON">
	<PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      	VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            	VALUE="
	<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2739 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='������༭' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=706 ,top=2569 ,right=778 ,bottom=2617 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=696 ,top=2495 ,right=870 ,bottom=2670</I>
	<T>id='(ȸ  ��)' ,left=79 ,top=2416 ,right=235 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ȸ �� �� :' ,left=246 ,top=2492 ,right=445 ,bottom=2529 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ǥ �� :' ,left=251 ,top=2569 ,right=450 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=246 ,top=2416 ,right=445 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CADDR', left=466, top=2416, right=955, bottom=2453, align='left', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='(�ٷ���)' ,left=1021 ,top=2416 ,right=1177 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=1188 ,top=2416 ,right=1381 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��)' ,left=466 ,top=2492 ,right=810 ,bottom=2529 ,align='left' ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=1188 ,top=2492 ,right=1381 ,bottom=2529 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CADDR_CT', left=466, top=2569, right=656, bottom=2606, align='left', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='��    �� :' ,left=1188 ,top=2569 ,right=1381 ,bottom=2617 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DPT_NM', left=1389, top=2416, right=1757, bottom=2453, align='left', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='JOB_NM', left=1389, top=2495, right=1757, bottom=2532, align='left', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SIGN_NM', left=1392, top=2572, right=1759, bottom=2609, align='left', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='������� : ' ,left=74 ,top=2302 ,right=913 ,bottom=2339 ,align='right' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CON_YMD', left=915, top=2302, right=1328, bottom=2339, align='left' ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='ü���� �ٷΰ�༭, �����Ģ �� ���ù��ɿ� ���Ѵ�. ' ,left=122 ,top=2156 ,right=1889 ,bottom=2193 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ؿ� ������.' ,left=119 ,top=2066 ,right=1889 ,bottom=2103 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���޴����� ������ ��� �� ����)�� �ٷ��� ���� ������ ���� ���¿� �Ա��ϴ� ������� �����Ѵ�.' ,left=106 ,top=1561 ,right=1902 ,bottom=1598 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��� 1�Ϻ��� ���ϱ����� �޿������Ⱓ���� �ϸ�, �� ������ 12���� 1�� �ش��ϴ� �ݾ��� �ſ� 25��' ,left=69 ,top=1516 ,right=1897 ,bottom=1553 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �����Ѵ�.' ,left=116 ,top=1400 ,right=1881 ,bottom=1437 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡��, �ٹ������� � ���� ���� ���������� ���� ��쿡�� �����Ģ �� ȸ�� �λ������ ' ,left=116 ,top=1357 ,right=1881 ,bottom=1394 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����̴�.' ,left=138 ,top=1164 ,right=1876 ,bottom=1201 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǰ���� ��ձ޿��� ���Կ��� �����Ѵ�. ' ,left=135 ,top=1080 ,right=1876 ,bottom=1117 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����Ͽ� �����ϴ� �����ӱݻ������� �ϸ�, �� �޿��� ������ �Ʒ��� ����. ' ,left=119 ,top=852 ,right=1884 ,bottom=889 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷ��ڴ� ������ ������ ���Ͽ� Ÿ�ο��� �˸��ų� Ÿ���� ������ �˷��� ���� ������, ������ ' ,left=66 ,top=1786 ,right=1881 ,bottom=1823 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ���ݻ��׿� ���� ����� ����� �������� �ʴ´�. ���� ������ ������ ������ �����ϴ� ��� ' ,left=66 ,top=1831 ,right=1881 ,bottom=1868 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡�� ������ �� �� ������, �̷� ���� �����Ϳ� ���Ǹ� �������� �ʴ´�. ' ,left=66 ,top=1876 ,right=1881 ,bottom=1913 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������޹����' ,left=66 ,top=1466 ,right=1881 ,bottom=1503 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5������   �롽' ,left=71 ,top=1976 ,right=1886 ,bottom=2013 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ٷ��ڴ� ���� ���� å���� �����׿� �����ϸ�, ��⿡ ��õ��� ���� ������ ȸ�簡 ���� ���� ' ,left=71 ,top=2019 ,right=1886 ,bottom=2056 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ������ ��� ���� ����Ⱓ�� ���Ͽ� ����Ǹ�, ��Ÿ �źа� ���õ� ���ݻ����� �Ի� �� ' ,left=71 ,top=2111 ,right=1886 ,bottom=2148 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��༭�� �� ü���� �ٷΰ�༭���� �ӱݰ��� ������ ��ü�Ѵ�. ' ,left=71 ,top=2199 ,right=1886 ,bottom=2236 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. �⺻���� �����ٷνð�(209�ð�/��)�� ���� �޿��̴�.' ,left=95 ,top=910 ,right=1879 ,bottom=947 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. �ð��ܼ����� �� 52�ð��� ���塤�߰������ϱٷο� ���� �޿��̴�.' ,left=95 ,top=953 ,right=1879 ,bottom=990 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. ���ϱٷμ����� �� 18�ð��� ���ϱٷο� ���� �޿��̴�. ' ,left=95 ,top=995 ,right=1879 ,bottom=1032 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. Ư���������� ���������� �ٹ��� ��� �߻��� �� �ִ� �߰��� ����� �����ϱ� ���Ͽ� �����ϴ� ' ,left=95 ,top=1037 ,right=1879 ,bottom=1074 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5. ���������� �޿�ü�� �������� �߻��� �� �ִ� ������ �����ϱ� ���Ͽ� �����ϴ� �ѽ��� ' ,left=95 ,top=1122 ,right=1879 ,bottom=1159 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� å���� �ӱ��� �� ������ ������ �� ���̸�, ���¼����� ���� ���� ������ �� �ִ�.' ,left=69 ,top=1606 ,right=1884 ,bottom=1643 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ߵ� �ԡ�������� ��� �ش� ���� �ٹ��ϼ��� ���� ���� ����Ͽ� �����Ѵ�. ' ,left=69 ,top=1651 ,right=1884 ,bottom=1688 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��⿡ ���Ե��� ���� ��Ÿ����(�ڰݼ���, ��å����, �������� ��)�� ȸ�簡 ���� �������ؿ� ' ,left=69 ,top=1220 ,right=1884 ,bottom=1257 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ���� �����ݾ��� ��1���� ���� ����Ⱓ ���̶� ����, ���� �� �źл��� �����̳� �λ���,' ,left=69 ,top=1315 ,right=1884 ,bottom=1352 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4�������������' ,left=66 ,top=1741 ,right=1881 ,bottom=1778 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Ͽ� �����Ѵ�. ' ,left=119 ,top=1262 ,right=1879 ,bottom=1299 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �Ѵ�.' ,left=1392 ,top=452 ,right=1677 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MONTH', left=1222, top=452, right=1389, bottom=489, align='left' ,mask='(XX����)', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TO_YMD_1', left=886, top=452, right=1212, bottom=489, align='left' ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='~' ,left=852 ,top=452 ,right=878 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD_1', left=516, top=452, right=841, bottom=489, align='left' ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='������ ���� ����Ⱓ��' ,left=69 ,top=452 ,right=508 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������� �����ϸ� �����ǻ翡 ���� ������ ���� ��������� ü���Ѵ�.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��1�������� ����Ⱓ��' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��2���������ݾס�' ,left=69 ,top=534 ,right=1884 ,bottom=572 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���� ���ٷ��ڡ��� ��)�� ȸ����' ,left=1331 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) (��ǥ�̻� �豹ȯ) (���� ��ȸ�硱�� ��)�� �ٷ��� ' ,left=69 ,top=278 ,right=1138 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=1146, top=278, right=1323, bottom=315, align='left', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=69 ,top=585 ,right=177 ,bottom=646 ,border=true</X>
	<X>left=175 ,top=585 ,right=460 ,bottom=646 ,border=true</X>
	<X>left=458 ,top=585 ,right=743 ,bottom=646 ,border=true</X>
	<X>left=741 ,top=585 ,right=1027 ,bottom=646 ,border=true</X>
	<X>left=1024 ,top=585 ,right=1310 ,bottom=646 ,border=true</X>
	<X>left=1307 ,top=585 ,right=1593 ,bottom=646 ,border=true</X>
	<X>left=1590 ,top=585 ,right=1876 ,bottom=646 ,border=true</X>
	<T>id='����' ,left=74 ,top=590 ,right=172 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ٷ����� ������ �⺻��, �ð��ܡ����ϱٷμ���, Ư�������� �� �������� �� ���� �� ������ ' ,left=69 ,top=807 ,right=1884 ,bottom=844 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻��' ,left=183 ,top=590 ,right=452 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ð��ܼ���' ,left=466 ,top=590 ,right=736 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ϱٷμ���' ,left=749 ,top=590 ,right=1019 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư��������' ,left=1032 ,top=590 ,right=1302 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1315 ,top=590 ,right=1585 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1601 ,top=590 ,right=1871 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=643 ,right=177 ,bottom=704 ,border=true</X>
	<X>left=458 ,top=643 ,right=743 ,bottom=704 ,border=true</X>
	<X>left=741 ,top=643 ,right=1027 ,bottom=704 ,border=true</X>
	<X>left=1024 ,top=643 ,right=1310 ,bottom=704 ,border=true</X>
	<X>left=1307 ,top=643 ,right=1593 ,bottom=704 ,border=true</X>
	<X>left=1590 ,top=643 ,right=1876 ,bottom=704 ,border=true</X>
	<T>id='����' ,left=74 ,top=648 ,right=172 ,bottom=701 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=643 ,right=460 ,bottom=704 ,border=true</X>
	<C>id='Y01_AMT', left=183, top=651, right=455, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y02_AMT', left=463, top=651, right=736, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y03_AMT', left=746, top=651, right=1019, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y04_AMT', left=1029, top=651, right=1302, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y05_AMT', left=1312, top=651, right=1585, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YSUM_AMT', left=1598, top=651, right=1871, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=69 ,top=701 ,right=177 ,bottom=762 ,border=true</X>
	<X>left=458 ,top=701 ,right=743 ,bottom=762 ,border=true</X>
	<X>left=741 ,top=701 ,right=1027 ,bottom=762 ,border=true</X>
	<X>left=1024 ,top=701 ,right=1310 ,bottom=762 ,border=true</X>
	<X>left=1307 ,top=701 ,right=1593 ,bottom=762 ,border=true</X>
	<X>left=1590 ,top=701 ,right=1876 ,bottom=762 ,border=true</X>
	<T>id='���޿�' ,left=74 ,top=706 ,right=172 ,bottom=759 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=701 ,right=460 ,bottom=762 ,border=true</X>
	<C>id='P01_AMT', left=183, top=709, right=455, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P02_AMT', left=463, top=709, right=736, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P03_AMT', left=746, top=709, right=1019, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P04_AMT', left=1029, top=709, right=1302, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P05_AMT', left=1312, top=709, right=1585, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUM_AMT', left=1598, top=709, right=1871, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SIGN_YMD', left=1392, top=2635, right=1825, bottom=2672, align='left' , face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>



   ">
</OBJECT>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->

<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='

		 <C>Col=ENO_NM            Ctrl=txtENO_NM        Param=value   </C>
		 <C>Col=FROM_YMD          Ctrl=txtFROM_YMD      Param=value   </C>
		 <C>Col=TO_YMD            Ctrl=txtTO_YMD        Param=value   </C>
		 <C>Col=MONTH             Ctrl=txtMONTH         Param=value   </C>
		 <C>Col=P01_AMT           Ctrl=gcemP01_AMT      Param=text    </C>
		 <C>Col=P02_AMT           Ctrl=gcemP02_AMT      Param=text    </C>
		 <C>Col=P03_AMT           Ctrl=gcemP03_AMT      Param=text    </C>
		 <C>Col=P04_AMT           Ctrl=gcemP04_AMT      Param=text    </C>
		 <C>Col=P05_AMT           Ctrl=gcemP05_AMT      Param=text    </C>
		 <C>Col=SUM_AMT           Ctrl=gcemSUM_AMT      Param=text    </C>
		 <C>Col=Y01_AMT           Ctrl=gcemY01_AMT      Param=text    </C>
		 <C>Col=Y02_AMT           Ctrl=gcemY02_AMT      Param=text    </C>
		 <C>Col=Y03_AMT           Ctrl=gcemY03_AMT      Param=text    </C>
		 <C>Col=Y04_AMT           Ctrl=gcemY04_AMT      Param=text    </C>
		 <C>Col=Y05_AMT           Ctrl=gcemY05_AMT      Param=text    </C>
		 <C>Col=YSUM_AMT          Ctrl=gcemYSUM_AMT     Param=text    </C>
		 <C>Col=PAY_DAY           Ctrl=txtPAY_DAY       Param=value   </C>
		 <C>Col=CON_YMD           Ctrl=gcemCON_YMD      Param=text    </C>
		 <C>Col=CADDR             Ctrl=txtCADDR         Param=value   </C>
		 <C>Col=CADDR_CT          Ctrl=txtCADDR_CT      Param=value   </C>
		 <C>Col=SIGN_NM           Ctrl=txtSIGN_NM       Param=value   </C>
		 <C>Col=SIGN_YMD          Ctrl=txtSIGN_YMD      Param=value   </C>
		 <C>Col=DPT_NM            Ctrl=txtDPT_NM        Param=value   </C>
		 <C>Col=JOB_NM            Ctrl=txtJOB_NM        Param=value   </C>

    '>
</object>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

