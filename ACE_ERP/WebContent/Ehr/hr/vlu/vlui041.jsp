<!--
*****************************************************
* @source       : vlui041.jsp
* @description  : �����Ű���ȸ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      �̵���        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
	String eno_no = box.getString("SESSION_ENONO");         //ǰ���ڻ��
	String eno_nm = box.getString("SESSION_ENONM");         //ǰ���ڻ��
	String dep_cd = box.getString("SESSION_DPTCD");         //ǰ���ڻ��

%>

<html>
<head>
<title>�����Ű��ۼ�(vlui041)</title>
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

        var btnList = 'TFTTTFFT';

        var GUBUN   = "";

		var strParam = new Array();

		strParam=window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�˻����� 2����
            var REG_YM_SHR = strParam[0];        //�ش�⵵
			var ENO_NO = strParam[1];			 //
			var ENO_NM = strParam[2];

			trT_EV_ABLRST.KeyValue = "tr01(O:dsT_EV_HWORKMST=dsT_EV_HWORKMST)";

			trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD"
                                   + "&S_MODE=SHR_WRK"
                                   + "&REG_YM_SHR="+REG_YM_SHR
                                   + "&ENO_NO="+ENO_NO;

			trT_EV_ABLRST.post();


			/*
			if(dsT_EV_HWORKMST.countrow<1){
				fnc_Add();
			}else{
		        ifrm.fnc_Row_Clear(); //�ʱ�ȭ
			}
			*/
			ifrm.fnc_Row_Clear(2); //�ʱ�ȭ
			ifrm.fnc_SearchList();

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


        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

             window.close();

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

		document.getElementById("txtREG_YM_SHR").value = strParam[0];
		document.getElementById("txtENO_NO_SHR").value = strParam[1];
		document.getElementById("txtENO_NM_SHR").value = strParam[2];
		fnc_SearchList();
        //cfStyleGrid(form1.grdT_EV_ABLRST,15,"false","false");      // Grid Style ����

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ABLRST)                       |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_HWORKMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_HWORKDTL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton            |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_ABLRST)        |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');

        } else {

            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
        if (trT_EV_ABLRST.ErrorCode != 50015) {
            cfErrorMsg(this);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����Ű���ȸ</td>
					<td align="right" class="navigator">HOME/�λ���/�����/<font color="#000000">�����Ű���ȸ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="80"></col>
                                <col width="160"></col>
                                <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">������&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" class="input_ReadOnly"  readOnly>
                               </td>
                                <td align="right" class="searchState">���</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" class="input_ReadOnly"  readOnly>
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
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
					<col width="120"></col>
					<col width="80"></col>
					<col width="60"></col>
					<col width="180"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="60"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold" rowspan = 2>�Ҽ�</td>
					<td align="center" class="creamBold" rowspan = 2>����</td>
					<td align="center" class="creamBold" rowspan = 2>����</td>

		            <td align="center" class="creamBold" colspan=3><nobr>�λ��̵�����</td>
					<td align="center" class="creamBold" rowspan = 2>���</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">�ٹ��Ⱓ</td>
					<td align="center" class="creamBold">�ҼӺμ�</td>
					<td align="center" class="creamBold">������</td>
				</tr>




        		<tr>
					<td class="tab15" style=""rowspan=3>
					  <input id="txt_evaym"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_headcd"  type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_divcd"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_deptcd"  type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_headnm"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
						<input id="txt_divnm"   type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
						<input id="txt_deptnm"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
					</td>
					<td class="tab18" style=""rowspan=3><nobr>
					  <input id="txt_paygrd"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width5px;height:20px;" ReadOnly>
						<input id="txt_paygrdnm" type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:70px;height:20px;" ReadOnly>
					</nobr></td>
					<td class="tab18" style=""rowspan=3><nobr>
						<input id="txt_empno"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_empnmk"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:55px;height:20px;" ReadOnly>
					</nobr></td>
					<td class="tab18" style=""><nobr>
						<comment id="__NSID__">
						<object id=gcem_startdt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>&nbsp; ~
  					 <comment id="__NSID__">
						 <object id=gcem_enddt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</nobr></td>
					<td class="tab18" style=""><nobr>
					   <input id="txt_place_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:90px;height:20px;" >
					</nobr></td>
					<td class="tab18" style=""><nobr>
					  <input id="txt_work_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:116px;height:20px;" >
					</nobr></td>

          			<td class="tab18" style=""><nobr>
						<input id="txt_remark_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:115px;height:20px;" >
					</nobr></td>
				</tr>

				<tr>

					<td class="tab18" style=""><nobr>
						<comment id="__NSID__">
						<object id=gcem_startdt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>&nbsp; ~
  					 <comment id="__NSID__">
						 <object id=gcem_enddt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</nobr></td>

					<td class="tab18" style=""><nobr>
							<input id="txt_place_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:90px;height:20px;" >
					</nobr></td>

					<td class="tab18" style=""><nobr>
            		<input id="txt_work_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:116px;height:20px;" >
          			</nobr></td>

					<td class="tab18" style=""><nobr>
					    <input id="txt_remark_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:115px;height:20px;" >
					</nobr></td>
				</tr>
				<tr>
					<td class="tab18" style=""><nobr>
						<comment id="__NSID__">
						<object id=gcem_startdt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>&nbsp; ~
  					 <comment id="__NSID__">
						 <object id=gcem_enddt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>

					</nobr></td>

					<td class="tab18" style=""><nobr>
						 <input id="txt_place_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:90px;height:20px;" >
					</nobr></td>

					<td class="tab18" style=""><nobr>
						<input id="txt_work_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:116px;height:20px;" >
					</nobr></td>

					<td class="tab18" style=""><nobr>
						 <input id="txt_remark_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:115px;height:20px;" >
					</nobr></td>
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
					<td valign="top" width="600" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->




<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:1px;">
			<table border="1" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="creamBold" width="40">NO</td>
					<td align="center" class="creamBold" width="80">�׸�</td>
					<td align="center" class="creamBold" width="550">�ֿ� ���� ����</td>
					<td align="center" class="creamBold" width="60">����ġ(%)</td>
					<td align="center" class="creamBold" width="60">���</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
	 <td >
		<iframe id="ifrm" name="ifrm" src="./vlui041_ifrm.jsp" frameborder=0 style="position:relative;top:1px;width:800;height:330px;border:1 solid #708090;"></iframe>
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
<!--  ���̺� -->
<object id="bndT_EV_HWORKMST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_HWORKMST">
	<Param Name="BindInfo", Value='
		<C>Col=EVAYM      	ctrl=txt_evaym		  	param=value	 </C>
		<C>Col=EMPNO      	ctrl=txt_empno		  	param=value	 </C>
		<C>Col=EMPNMK     	ctrl=txt_empnmk		  	param=value	 </C>
		<C>Col=HEADCD     	ctrl=txt_headcd		  	param=value	 </C>
		<C>Col=HEADNM     	ctrl=txt_headnm		  	param=value	 </C>
		<C>Col=DIVCD      	ctrl=txt_divcd		  	param=value	 </C>
		<C>Col=DIVNM      	ctrl=txt_divnm		  	param=value	 </C>
		<C>Col=DEPTCD     	ctrl=txt_deptcd     	param=value	 </C>
		<C>Col=DEPTNM    	ctrl=txt_deptnm		  	param=value	 </C>
		<C>Col=PAYGRD     	ctrl=txt_paygrd     	param=value	 </C>
		<C>Col=PAYGRDNM   	ctrl=txt_paygrdnm   	param=value	 </C>
		<C>Col=WORK_1     	ctrl=txt_work_1     	param=value	 </C>
		<C>Col=STARTDT_1  	ctrl=gcem_startdt_1 	param=text   </C>
		<C>Col=ENDDT_1    	ctrl=gcem_enddt_1	  	param=text	 </C>
		<C>Col=PLACE_1    	ctrl=txt_place_1    	param=value	 </C>
		<C>Col=REMARK_1		ctrl=txt_remark_1 		param=value	 </C>
		<C>Col=WORK_2     	ctrl=txt_work_2     	param=value	 </C>
		<C>Col=STARTDT_2  	ctrl=gcem_startdt_2 	param=text   </C>
		<C>Col=ENDDT_2    	ctrl=gcem_enddt_2	  	param=text	 </C>
		<C>Col=PLACE_2    	ctrl=txt_place_2    	param=value	 </C>
		<C>Col=REMARK_2		ctrl=txt_remark_2 		param=value	 </C>
		<C>Col=WORK_3     	ctrl=txt_work_3     	param=value	 </C>
		<C>Col=STARTDT_3  	ctrl=gcem_startdt_3 	param=text   </C>
		<C>Col=ENDDT_3    	ctrl=gcem_enddt_3	  	param=text	 </C>
		<C>Col=PLACE_3    	ctrl=txt_place_3    	param=value	 </C>
		<C>Col=REMARK_3		ctrl=txt_remark_3 		param=value	 </C>
    '>
</object>




