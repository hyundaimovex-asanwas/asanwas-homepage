<!--
***********************************************************************
* @source      : idtb013.jsp
* @description : �ٷΰ�༭ - ����� �׿� PAGE
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
<title>�ٷΰ�༭</title>
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
        var strPis_yy="2019";

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


           if(gusrid != "6060002" &&  gusrid != "2030007" && gusrid != "2070020" && gusrid != "6180001"){ 

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
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
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
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
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
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)">  <img src="../../images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<table width="1000" border="1" cellspacing="0" cellpadding="0">
        <tr>
          <td>
          <br>&nbsp;&nbsp;����ƻ�(��)(���ϡ������̶� ��)�� �ٷ��� <input id="txtENO_NM" name="txtENO_NM" size="6"  style="ime-mode:disabled">(���ϡ������̶� ��)(��)�� �����ǻ翡 ���� ������ ���� �ٷΰ���� ü���Ѵ�. 
          <br>&nbsp;&nbsp;<strong>��1���� �ٷΰ��Ⱓ��</strong>
          <br>&nbsp;&nbsp;�� �ٷΰ��Ⱓ��  <input >�� <input >�� <input >�Ϻ��� <input >�� <input >�� <input >�ϱ��� (<input id="txtMONTH" name="txtMONTH" size="6"  style="ime-mode:disabled">����)�� �ϸ�, ���Ⱓ�� ����Ǿ� ������� �ƴ��� ���
          <br>&nbsp;&nbsp;�ٷΰ���� �ڵ����� ����ȴ�. ����, ���Ⱓ ���� '��'�� ����ϰ� �ִ� ������ ����� ���, ���Ⱓ ���� ���̶� �� ����� �翬�� ����ȴ�.
          <br>&nbsp;&nbsp;�� '��'�� '��'�� ���� �Ի��Ϸκ��� 3������ �ÿ�(����) �Ⱓ�� �д�. �ÿ�Ⱓ �� �Ǵ� �ÿ�Ⱓ�� ����� �ڷμ�, ��ӱٷΰ� �������ϴٰ� �����Ǵ� ��� 
          <br>&nbsp;&nbsp;'��'�� �� ����� ������ �� �ִ�.<br>
          
          <br>&nbsp;&nbsp;<strong>��2���� �ٷ���ҡ� </strong>
          <br>&nbsp;&nbsp;'��'�� ������ (<input id="txtWPLACE_NM" name="txtWPLACE_NM" size="15" >)(��)�� �ϸ�, '��'�� �濵�� ���� �Ǵ� �λ�� ��å�� ���Ͽ� ������ �� �ִ�.<br>
          
          <br>&nbsp;&nbsp;<strong>��3���� ���� �� ȣĪ�� </strong>
          <br>&nbsp;&nbsp;'��'�� ����:<input id="txtJOB_NM" name="txtJOB_NM" size="10" >, ȣĪ:<input id="txtPOS_NM" name="txtPOS_NM" size="15" >���� �ϸ�, ������ ������ �濵���� �ʿ� �� '��'�� �����ɷ� �� ���� ���� �����Ͽ� �����Ģ�� ���� ������ �� �ִ�.<br>
          
          <br>&nbsp;&nbsp;<strong>��4���� �������� </strong>
          <br>&nbsp;&nbsp;'��'�� �������� '��'�� ���� ����(<input id="txtWORK_NM" name="txtWORK_NM" size="15" >) �� �׿� �μ��� ������ �ϸ�, '��'�� ������ �ʿ信 ���� �̸� ������ �� �ִ�. '��'�� �̿� ���Ͽ� ���ǰ� ������, 
          <br>&nbsp;&nbsp;��೻���� ������ ��Ż���� �ʴ� �� �̸� �ؼ��Ͽ��� �Ѵ�.
          
          <br>&nbsp;&nbsp;<strong>��5���� �ٹ��� �� ���ϡ�</strong>
          <br>&nbsp;&nbsp;�ٹ����� �� 6�� �ٹ��� ��Ģ���� �ϸ�, ������ �� �����Ģ���� ���� ���� ���Ϸ� �Ѵ�.<br>
          
          <br>&nbsp;&nbsp;<strong>��6���� �ٷνð� �� �ްԽð���</strong>
          <br>&nbsp;&nbsp;�ٷνð��� �ްԽð��� �����ϰ� 1�� 8�ð����� �Ѵ�.
          <br>&nbsp;&nbsp;�� �����ٷνð��� ���� �������� �����Ͽ� �� 209�ð����� ��.
          <br>&nbsp;&nbsp;�� �þ� �� �����ð��� ����� ������ ���Ͽ� ���� ��. 
          <br>&nbsp;&nbsp;�� �ްԽð��� ���ɽð� 1�ð����� ��.
          <br>&nbsp;&nbsp;�� '��'�� Ư���� ������ ���� ��� �ٹ��ð��� ������ �� ������, ���� ����, �߰�, ���ϱٷθ� ���� �� ����.<br>
          
          <br>&nbsp;&nbsp;<strong>��7���� �Աݡ�</strong>
          <br>&nbsp;&nbsp;'��'�� '��'�� �ٷο� ���� �밡�� ȸ�系�Կ� ���� �ٿ� ���� �ӱ��� �ſ� 25�Ͽ� �����ϸ�, �ӱ��� ���γ����� �޿����� �� ���� ������༭���� ���� �ٿ� ������.<br>
          
          <br>&nbsp;&nbsp;<strong>��8���� ���������ް���</strong>
          <br>&nbsp;&nbsp;'��'�� �ٷα��ع����� ���ϴ� �ٿ� ���� '��'���� ���������ް��� �ο��Ѵ�.<br>
          
          <br>&nbsp;&nbsp;<strong>��9���� ���������</strong>
          <br>&nbsp;&nbsp;'��'�� '��'�� �� ��� �Ǵ� �ٷα��ع� �� �����Ģ�� �����ϰų� �ǹ��� �������� �ƴ��� ��, ����ڴ� ����� ������ �� �ִ�.<br>
          
          <br>&nbsp;&nbsp;<strong>��10���� �Ұ��׷¡�</strong>
          <br>&nbsp;&nbsp;'��'�� �����ϰ� �ִ� ����� Ư������ ����Ͽ�, '��'�� ��å���� ���� ����� �ߴܵǰų�, ������ �ߴܵǾ� ����� �������� ���� ��쿡 �ٷΰ���� �ڵ� �����ȴ�.<br>
          
          <br>&nbsp;&nbsp;<strong>��11���� �ٷΰ�༭�� ���Ρ�</strong>
          <br>&nbsp;&nbsp;'��'�� �ٷΰ���� ü���԰� ���ÿ� �� ��༭�� �纻�Ͽ� '��'�� ���ο䱸�� ������� '��'���� �����Ѵ�.<br>
          
          <br>&nbsp;&nbsp;<strong>��12���� ��Ÿ��</strong>
          <br>&nbsp;&nbsp;�� ��༭�� ������ ���� ������ '��'�� ���� �� ���� �� ���� ��ħ�� ������� �ϸ�, �� �ܿ� ������ ���� ������ �ٷα��ع��ɿ� ���Ѵ�.<br>
          
           
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
	<T>id='�ٷΰ�༭' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ������ ���� �ٷΰ���� ü���Ѵ�.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��1�����ٷΰ��Ⱓ��' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=868, top=278, right=1045, bottom=315, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ƻ�(��) (���� �������̶� ��)�� �ٷ��� ' ,left=69 ,top=278 ,right=868 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���� �������̶� ��)(��)�� �����ǻ翡 ' ,left=1114 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ٷΰ��Ⱓ��' ,left=69 ,top=452 ,right=397 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD_1', left=405, top=452, right=730, bottom=489, align='left' ,mask='XXXX��XX��XX��', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='�� \'��\'�� \'��\'�� ���� �Ի��Ϸκ��� 3������ �ÿ�(����) �Ⱓ�� �д�. �ÿ�Ⱓ �� �Ǵ� ' ,left=69 ,top=492 ,right=1884 ,bottom=529 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �ִ�.' ,left=108 ,top=572 ,right=1884 ,bottom=609 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ÿ�Ⱓ�� ����� �ڷμ�, ��ӱٷΰ� �������ϴٰ� �����Ǵ� ��� \'��\'�� �� ����� ����' ,left=108 ,top=532 ,right=1884 ,bottom=569 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ (' ,left=69 ,top=677 ,right=370 ,bottom=714 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �ִ�.' ,left=69 ,top=717 ,right=370 ,bottom=754 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')(��)�� �ϸ�, \'��\'�� �濵�� ���� �Ǵ� �λ�� ��å�� ���Ͽ� ����' ,left=619 ,top=677 ,right=1881 ,bottom=714 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��2�����ٷ���ҡ�' ,left=69 ,top=632 ,right=1884 ,bottom=669 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �ϸ�, ������ ȣĪ�� �濵���� �ʿ� ��' ,left=968 ,top=826 ,right=1881 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=', ȣĪ:' ,left=561 ,top=826 ,right=704 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ����:' ,left=69 ,top=826 ,right=304 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������� �� ȣĪ��' ,left=69 ,top=781 ,right=1884 ,bottom=818 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �����ɷ� �� ���� ���� �����Ͽ� �����Ģ�� ���� ������ �� �ִ�.' ,left=69 ,top=865 ,right=1884 ,bottom=902 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ʿ信 ���� �̸� ������ �� �ִ�. \'��\'�� �̿� ���Ͽ� ���ǰ� ������, ��೻����' ,left=66 ,top=1013 ,right=1881 ,bottom=1050 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4������������' ,left=66 ,top=929 ,right=1881 ,bottom=966 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �������� \'��\'�� ���� ����(' ,left=66 ,top=974 ,right=786 ,bottom=1011 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=') �� �׿� �μ��� ������ �ϸ�, \'��\'��' ,left=1167 ,top=974 ,right=1884 ,bottom=1011 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��12������Ÿ��' ,left=66 ,top=2252 ,right=1881 ,bottom=2289 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��༭�� ������ ���� ������ \'��\'�� ���� �� ���� �� ���� ��ħ�� ������� �ϸ�, ' ,left=66 ,top=2297 ,right=1881 ,bottom=2334 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ܿ� ������ ���� ������ �ٷα��ع��ɿ� ���Ѵ�.' ,left=66 ,top=2336 ,right=1881 ,bottom=2373 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��11�����ٷΰ�༭�� ���Ρ�' ,left=66 ,top=2101 ,right=1881 ,bottom=2138 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �ٷΰ���� ü���԰� ���ÿ� �� ��༭�� �纻�Ͽ� \'��\'�� ���ο䱸�� �������' ,left=66 ,top=2146 ,right=1881 ,bottom=2183 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �����Ѵ�.' ,left=66 ,top=2185 ,right=1881 ,bottom=2223 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��10�����Ұ��׷¡�' ,left=66 ,top=1947 ,right=1881 ,bottom=1984 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �����ϰ� �ִ� ����� Ư������ ����Ͽ�, \'��\'�� ��å���� ���� ����� �ߴܵǰų�, ' ,left=66 ,top=1992 ,right=1881 ,bottom=2029 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ߴܵǾ� ����� �������� ���� ��쿡 �ٷΰ���� �ڵ� �����ȴ�.' ,left=66 ,top=2032 ,right=1881 ,bottom=2069 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��9�������������' ,left=66 ,top=1797 ,right=1881 ,bottom=1834 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �� ��� �Ǵ� �ٷα��ع� �� �����Ģ�� �����ϰų� �ǹ��� �������� �ƴ��� ��,' ,left=66 ,top=1842 ,right=1881 ,bottom=1879 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڴ� ����� ������ �� �ִ�.' ,left=66 ,top=1881 ,right=1881 ,bottom=1918 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �ٷα��ع����� ���ϴ� �ٿ� ���� \'��\'���� ���������ް��� �ο��Ѵ�.' ,left=66 ,top=1728 ,right=1881 ,bottom=1765 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��8�������������ް���' ,left=66 ,top=1683 ,right=1881 ,bottom=1720 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��7�����ӱݡ�' ,left=66 ,top=1535 ,right=1881 ,bottom=1572 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �ٷο� ���� �밡�� ȸ�系�Կ� ���� �ٿ� ���� �ӱ��� �ſ� 25�Ͽ� �����ϸ�,' ,left=66 ,top=1580 ,right=1881 ,bottom=1617 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ӱ��� ���γ����� �޿����� �� ���� ������༭���� ���� �ٿ� ������.' ,left=66 ,top=1619 ,right=1881 ,bottom=1656 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=839 ,top=2477 ,right=1013 ,bottom=2651</I>
	<T>id='(��)' ,left=870 ,top=2662 ,right=942 ,bottom=2709 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=868 ,top=2535 ,right=939 ,bottom=2582 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ�̻�   ��  ��  ȯ' ,left=447 ,top=2543 ,right=831 ,bottom=2580 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ư���� ���α� ����� 194 ����ƻ�(��)' ,left=447 ,top=2482 ,right=1299 ,bottom=2519 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=79 ,top=2617 ,right=167 ,bottom=2654 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2614 ,right=429 ,bottom=2651 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2670 ,right=429 ,bottom=2717 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2543 ,right=434 ,bottom=2580 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=77 ,top=2484 ,right=161 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=238 ,top=2484 ,right=437 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� :          ��     ��     ��' ,left=74 ,top=2410 ,right=1881 ,bottom=2447 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=733 ,top=452 ,right=831 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����)' ,left=1781 ,top=450 ,right=1879 ,bottom=487 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1318 ,top=452 ,right=1416 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ��Ż���� �ʴ� �� �̸� �ؼ��Ͽ��� �Ѵ�.' ,left=66 ,top=1053 ,right=1881 ,bottom=1090 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷνð��� �ްԽð��� �����ϰ� 1�� 8�ð����� �Ѵ�.' ,left=66 ,top=1281 ,right=1881 ,bottom=1318 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��6�����ٷνð� �� �ްԽð���' ,left=66 ,top=1236 ,right=1881 ,bottom=1273 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �����ٷνð��� ���� �������� �����Ͽ� �� 209�ð����� ��.' ,left=66 ,top=1320 ,right=1881 ,bottom=1357 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �þ� �� �����ð��� ����� ������ ���Ͽ� ������.' ,left=66 ,top=1360 ,right=1881 ,bottom=1397 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ްԽð��� ���ɽð� 1�ð����� ��.' ,left=66 ,top=1400 ,right=1881 ,bottom=1437 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� Ư���� ������ ���� ��� �ٹ��ð��� ������ �� ������, ���� ����, �߰�, ����' ,left=66 ,top=1439 ,right=1881 ,bottom=1476 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷθ� ���� �� ����.' ,left=111 ,top=1479 ,right=1881 ,bottom=1516 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٹ����� �� 6�� �ٹ��� ��Ģ���� �ϸ�, ������ �� �����Ģ���� ���� ���� ���Ϸ� �Ѵ�.' ,left=66 ,top=1180 ,right=1881 ,bottom=1217 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5�����ٹ��� �� ���ϡ�' ,left=66 ,top=1135 ,right=1881 ,bottom=1172 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='JOB_NM', left=302, top=826, right=558, bottom=863, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='POS_NM', left=699, top=826, right=955, bottom=863, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WORK_NM', left=778, top=974, right=1164, bottom=1011, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>





   ">
</OBJECT>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->

<object id="bndT_CM_CONTRACT_EM" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_CONTRACT_EM">
    <Param Name="BindInfo", Value='

		 <C>Col=SID            Ctrl=txtSID           Param=value   </C>
		 <C>Col=CD_GBN         Ctrl=txtCD_GBN        Param=text   </C>
		 <C>Col=ENO_NM         Ctrl=txtENO_NM        Param=text   </C>
		 <C>Col=FROM_YMD       Ctrl=txtFROM_YMD      Param=text   </C>
		 <C>Col=TO_YMD         Ctrl=txtTO_YMD        Param=text   </C>
		 <C>Col=MONTH          Ctrl=txtMONTH         Param=text   </C>
		 <C>Col=PROJECT_NM     Ctrl=txtPROJECT_NM    Param=text    </C>
		 <C>Col=PRO_FROM       Ctrl=txtPRO_FROM      Param=text    </C>
		 <C>Col=PRO_TO         Ctrl=txtPRO_TO        Param=text    </C>
		 <C>Col=WPLACE_NM      Ctrl=txtWPLACE_NM     Param=text    </C>
		 <C>Col=JOB_NM         Ctrl=txtJOB_NM        Param=text    </C>
		 <C>Col=POS_NM         Ctrl=txtPOS_NM        Param=text    </C>
		 <C>Col=WORK_NM        Ctrl=txtWORK_NM       Param=text    </C>
		 

    '>
</object>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

