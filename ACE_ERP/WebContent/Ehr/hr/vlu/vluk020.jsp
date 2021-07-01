<!--
*****************************************************
* @source       : vluk020.jsp
* @description  : ���ǥ�Է� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/10/10     �̵���        ERP �̻�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���ǥ�Է�</title>
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


        var frameid = window.external.GetFrame(window).FrameId;
        
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�˻����� 2����
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
            var GBMST_STR = document.form1.cmbGBMST_STR.value;    		//�򰡱���

            //���� ��ȸ
            dsT_EV_RQSHEET.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk020.cmd.VLUK020CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&GB_MST="+GBMST_STR;
            
            //prompt(this, dsT_EV_RQSHEET.dataid);
            
            dsT_EV_RQSHEET.reset();

			// ����Ű��ȯ
			for (var i = 1; i <= dsT_EV_RQSHEET.CountRow; i++) {
		
				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\r\n","");
				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\n","");
				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\r","");				
			}
			
			dsT_EV_RQSHEET.ResetStatus();			
           
            dsT_EV_TEMP.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk020.cmd.VLUK020CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&GB_MST="+GBMST_STR;
            dsT_EV_TEMP.reset();
            
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

			var GB_DTL   = dsT_EV_TEMP.nameValue(dsT_EV_RQSHEET.RowPosition, "GB_DTL");      	//����

			//alert(GB_DTL);
        	
            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_RQSHEET=dsT_EV_RQSHEET)";
            trT_EV_ABLRST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk020.cmd.VLUK020CMD"
										     + "&S_MODE=SAV"
										     + "&GB_DTL="+GB_DTL;

            
            //prompt(this,dsT_EV_RQSHEET.TEXT);

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
			        trT_EV_ABLRST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk020.cmd.VLUK020CMD&S_MODE=DEL";
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

		//	dsT_EV_RQSHEET.setDataHeader("EVAYM:STRING:KEYVALUE,GB_MST:STRING,GB_DTL:STRING,ACT_ITEM:STRING");

			}

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
			dsT_EV_RQSHEET.AddRow();


			dsT_EV_RQSHEET.nameValue(dsT_EV_RQSHEET.RowPosition, "EVAYM") = document.form1.txtREG_YM_SHR.value.replace("-","");        //�ش�⵵
		//	dsT_EV_RQSHEET.nameValue(dsT_EV_RQSHEET.RowPosition, "GBMST") = document.form1.cmbGBMST_STR.value;        				//�򰡱���

	//	prompt(this,dsT_EV_RQSHEET.text);

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

			document.getElementById("txtREG_YM_SHR").value = '9999-99';

	        cfStyleGrid_New(form1.grdT_EV_ABLRST,15,"false","false");      // Grid Style ����

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

    <Object ID="dsT_EV_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">



<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','../../images/button/btn_DeleteOver.gif',1)"> <img src="../../images/button/btn_DeleteOn.gif"  name="Image9" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
       <tr>
           <td align="center" class="blueTable">
               <table width="100%" border="0" cellspacing="0" cellpadding="0">
                       <colgroup>
                       <col width="60"></col>
                       <col width="60"></col>
                       <col width="60"></col>                   
                       <col width="*"></col>
                       </colgroup>
                   <tr>
                       <td class="searchState" align="right">������&nbsp;</td>
                       <td class="padding2423" align="left" id="key1"  style="display:">
                           <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR"  size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13)fnc_SearchList(); cfDateHyphen(this);  cfNumberCheck()">
                      </td>
 
                       <td align="right" class="searchState">����</td>
                       <td class="padding2423">
                           <select id="cmbGBMST_STR" style="WIDTH:100px"  onchange="fnc_SearchList()">
							  <option value="00">��ü</option>
							  <option value="01">����</option>
							  <option value="02">������</option>
							  <option value="03">����</option>
                            </select>
                       </td>
                   </tr>
               </table>
        </td>
    </tr>
</table>
<!-- power Search���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:600px;height:500px;">
                            <param name="DataID"                	value="dsT_EV_RQSHEET">
                            <param name="EdiTABLE"                	value="true">
                            <param name="DragDropEnable"        	value="true">
                            <param name="SortView"                	value="Left">
                            <param name="VIEWSUMMARY"            	value=0>
                            <param name="Format"                	value="
                                <C> id='EVAYM'       		width=60    name='������'     	align=left   		Edit=None show=false</C>
                                <C> id='GB_MST'        		width=80    name='����'         	align=center   		Edit=None value={IF (GB_MST='01','����',IF (GB_MST='02','������' , IF (GB_MST='03','����' '')))} suppress=1</C>
                                <C> id='GB_DTL'       	 	width=120    name='�׸�'         align=left   		Edit=None </C>
                                <C> id='ACT_ITEM'        	width=350  	name='�ൿ��ǥ'     	align=left 			Edit=none</C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    
		  		<td>

				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=3 style='width:400px;height:502px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" class="blueBold"><nobr>&nbsp;������</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gcem_yymm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt; " >
										<param name=Text          value="">
										<param name=Alignment	  value=0>
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
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="blueBold" align="left"><nobr>&nbsp;����</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
								<comment id="__NSID__">
								<object id=gclx_gbmst  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
											<param name="CBData" 					value="01^����,02^������,03^����" />
											<param name="CBDataColumns" 			value="COM_CODE,COM_SNAME" />
											<param name="Index" 					value="0" />
											<param name="SearchColumn" 				value="COM_SNAME" />
											<param name="ListExprFormat" 			value="COM_SNAME^0^70" />
											<param name="BindColumn" 				value="COM_CODE" />
											<param name="Enable" 					value="true" />
								</object>
								</comment><script>__ShowEmbedObject(__NSID__);</script>	&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="blueBold">&nbsp;�׸�</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<input id="txt_gbdtl" name="txt_gbdtl" type="text"  class="txt21" style="position:relative; left:-5px;width:180px;"  >&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:300px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px"  class="blueBold">&nbsp;�ൿ��ǥ</td>
								<td Style="height:300px;border:0 solid #708090;border-bottom-width:0px">&nbsp;
                              		<textarea id=txt_actitem name=txt_actitem rows="28" cols="45" valid='maxlength=1000' field='����'></textarea>									
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
    	<C>Col=EVAYM           	Ctrl=gcem_yymm2        			Param=text</C>
    	<C>Col=GB_MST          	Ctrl=gclx_gbmst        			Param=BindColVal</C>
		<C>Col=GB_DTL       	Ctrl=txt_gbdtl           		Param=value</C>
		<C>Col=ACT_ITEM       	Ctrl=txt_actitem           		Param=value</C>

    '>
</object>
