<!--
*****************************************************
* @source       : vluk021.jsp
* @description  : �μ��� ���ǥ�Է� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/05/07     ���ϳ�       �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�μ��� ���ǥ�Է�(vluk021)</title>
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

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�˻����� 2����
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵

            //���� ��ȸ
            dsT_EV_RQSHEET.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk020.cmd.VLUK020CMD&S_MODE=SHR_DPT&REG_YM_SHR="+REG_YM_SHR;
            dsT_EV_RQSHEET.reset();

			// ����Ű��ȯ
			for (var i = 1; i <= dsT_EV_RQSHEET.CountRow; i++) {
		
				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\r\n","");
				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\n","");
				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\r","");				
			}
			
			dsT_EV_RQSHEET.ResetStatus();	            
            
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

            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_RQSHEET=dsT_EV_RQSHEET)";
            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk020.cmd.VLUK020CMD&S_MODE=SAV_DPT";

          //  prompt(this, dsT_EV_RQSHEET.text);

            trT_EV_ABLRST.post();
        	fnc_SearchList();


        }



        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
			if (dsT_EV_RQSHEET.countrow<1){
				alert ("������ ������ �����ϴ�.");
			}else {

				if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
					dsT_EV_RQSHEET.deleterow(dsT_EV_RQSHEET.rowposition);
			        trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_RQSHEET=dsT_EV_RQSHEET)";
			        trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk020.cmd.VLUK020CMD&S_MODE=DEL_DPT";
			        trT_EV_ABLRST.post();
					fnc_SearchList();
				}
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

            if (dsT_EV_RQSHEET.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("���ǥ�Է�", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

			if(dsT_EV_RQSHEET.CountColumn < 1 ){

                alert("�ݵ�� ��ȸ�� �Է��� �����մϴ�.");
                return false;

			}

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
			dsT_EV_RQSHEET.AddRow();

			dsT_EV_RQSHEET.nameValue(dsT_EV_RQSHEET.RowPosition, "EVAYM") = document.form1.txtREG_YM_SHR.value.replace("-","");        //�ش�⵵

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


            if (dsT_EV_RQSHEET.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

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

            if (!dsT_EV_RQSHEET.IsUpdated) {
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

			document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

		/*	document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);*/

			document.getElementById("txtREG_YM_SHR").value = '9999-99';

            fnc_ChangeStateElement(false, "txtREG_YM_SHR");
			
	        cfStyleGrid(form1.grdT_EV_ABLRST,15,"false","false");      // Grid Style ����

	        fnc_SearchList();

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
    <Object ID="dsT_EV_RQSHEET" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
            <Param Name=KeyValue    Value="sample_tr01(I:dsT_EV_RQSHEET=dsT_EV_RQSHEET)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->



    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_RQSHEET Event="OnLoadCompleted(iCount)">
     //  fnc_SearchList();
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
    <Script For=dsT_EV_RQSHEET Event="OnLoadError()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�μ��� ���ǥ�Է�</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�μ��� ���ǥ�Է�</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','/images/button/btn_DeleteOver.gif',1)"> <img src="/images/button/btn_DeleteOn.gif"  name="Image9" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
       <tr>
           <td align="center" class="greenTable">
               <table width="100%" border="0" cellspacing="0" cellpadding="0">
                       <colgroup>
                       <col width="60"></col>                
                       <col width="*"></col>
                       </colgroup>
                   <tr>
                       <td class="searchState" align="right">������&nbsp;</td>
                       <td class="padding2423" align="left" id="key1"  style="display:">
                           <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR"  size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13)fnc_SearchList(); cfDateHyphen(this);  cfNumberCheck()">
                      </td>
                   </tr>
               </table>
        </td>
    </tr>
</table>
<!-- power Search���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:420px;">
                            <param name="DataID"                	value="dsT_EV_RQSHEET">
                            <param name="EdiTABLE"                	value="true">
                            <param name="DragDropEnable"        	value="true">
                            <param name="SortView"                	value="Left">
                            <param name="VIEWSUMMARY"            	value=0>
                            <param name="Format"                	value="
                                <C> id='EVAYM'       		width=60    name='������'     	align=left   		Edit=None show=false</C>
                                <C> id='GB_MST'        	width=80    name='����'         	align=center   	Edit=None value={IF (GB_MST='11','�μ���', '')} suppress=1</C>
                                <C> id='GB_DTL'       	 width=80    name='�׸�'         	align=left   		Edit=None </C>
                                <C> id='ACT_ITEM'       width=300  name='�ൿ��ǥ'     	align=left 		Edit=none</C>
                                <C> id='T_SCR'        	width=50  	name='����'     		align=center 	Edit=none</C>                                
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>

		  		<td >
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=3
					style='width:243px;height:422px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" class="creamBold"><nobr>&nbsp;������</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gcem_yymm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt; " >
										<param name=Text          value="">
										<param name=Alignment	    value=0>
										<param name=Border	      value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=PromptChar	  value="_">
										<param name=IsComma	      value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</object>
							</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
							</td>
						</tr>
						<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold" align="left"><nobr>&nbsp;����</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
								<comment id="__NSID__">
								<object id=gclx_gbmst  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
											<param name="CBData" 				value="11^�μ���" />
											<param name="CBDataColumns" 		value="COM_CODE,COM_SNAME" />
											<param name="Index" 					value="0" />
											<param name="SearchColumn" 		value="COM_SNAME" />
											<param name="ListExprFormat" 		value="COM_SNAME^0^70" />
											<param name="BindColumn" 			value="COM_CODE" />
											<param name="Enable" 					value="true" />
								</object>
								</comment><script>__ShowEmbedObject(__NSID__);</script>	&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;�׸�</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<input id="txt_gbdtl" name="txt_gbdtl" type="text"  class="txt21" style="position:relative; left:0px;width:180px;"  >&nbsp;</nobr>
								</td>
							</tr>

							<tr>
								<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;����</td>
								<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px">&nbsp;
									<input id="txt_t_scr" name="txt_t_scr" type="text"  class="txt21" style="position:relative; left:0px;width:100px;" maxlength=34 >&nbsp;</nobr>
								</td>
							</tr>							
							
							<tr>
								<td style="height:300px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px"  class="creamBold">&nbsp;�ൿ��ǥ</td>
								<td Style="height:300px;border:0 solid #708090;border-bottom-width:0px">&nbsp;
                              		<textarea id=txt_actitem name=txt_actitem rows="22" cols="25" valid='maxlength=1000' field='����'></textarea>									
								</td>
							</tr>
						</table>
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
<object id="bndT_EV_ABLRST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_RQSHEET">
	<Param Name="BindInfo", Value='
    	<C>Col=EVAYM           	Ctrl=gcem_yymm2        		Param=text</C>
    	<C>Col=GB_MST          Ctrl=gclx_gbmst        			Param=BindColVal</C>
		<C>Col=GB_DTL       	Ctrl=txt_gbdtl           			Param=value</C>
		<C>Col=ACT_ITEM       	Ctrl=txt_actitem           		Param=value</C>
		<C>Col=T_SCR   		 	Ctrl=txt_t_scr    		 			Param=value</C>
    '>
</object>
