<!--
***********************************************************************
* @source      : scha090.jsp
* @description : ���ڱ� ��û�Ⱓ ���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/07/22            �̵���            	ERP�̻�						
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���ڱ� ��û�Ⱓ ����</title>
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


        var today = gcurdate;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var pis_yy = document.getElementById('txtPIS_YY_SHR').value;

            if(!fnc_SearchItemCheck()) return;  //��ȸ ��ȿ�� �˻�

			dsT_SC_RQSTYMD.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha090.cmd.SCHA090CMD&S_MODE=SHR&PIS_YY="+pis_yy;
    		dsT_SC_RQSTYMD.reset();

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

			if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

            trT_SC_RQSTYMD.KeyValue = "tr01(I:dsT_SC_RQSTYMD=dsT_SC_RQSTYMD)";
			trT_SC_RQSTYMD.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha090.cmd.SCHA090CMD&S_MODE=SAV";
			trT_SC_RQSTYMD.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_SC_RQSTYMD.CountRow < 1) {
				
				alert("������ �ڷᰡ �����ϴ�.");
				
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				
				return;
			}

			if(confirm("[�⵵:"+dsT_SC_RQSTYMD.NameValue(dsT_SC_RQSTYMD.RowPosition,'PIS_YY')+"/�б�:"+dsT_SC_RQSTYMD.NameValue(dsT_SC_RQSTYMD.RowPosition,'PIS_QQ')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				
				dsT_SC_RQSTYMD.DeleteRow(dsT_SC_RQSTYMD.RowPosition);
				
				trT_SC_RQSTYMD.KeyValue = "tr01(I:dsT_SC_RQSTYMD=dsT_SC_RQSTYMD)";
				
				trT_SC_RQSTYMD.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha090.cmd.SCHA090CMD&S_MODE=DEL";
				trT_SC_RQSTYMD.post();
				
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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            //DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_SC_RQSTYMD.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_SC_RQSTYMD.setDataHeader("PIS_YY:STRING:KEYVALUE, PIS_QQ:STRING, STR_YMD:STRING, END_YMD:STRING, PAY_YM:STRING, PAY_YMD:STRING");
			}

            dsT_SC_RQSTYMD.AddRow();
            
            dsT_SC_RQSTYMD.NameValue(dsT_SC_RQSTYMD.RowPosition, "PIS_YY")  = document.getElementById('txtPIS_YY_SHR').value;

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

            if (dsT_SC_RQSTYMD.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

        	window.close();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            var pis_yy = document.getElementById('txtPIS_YY_SHR');

            if(pis_yy.value == "" || pis_yy.value.length < 4){
                alert("4�ڸ��� �⵵�� �Է��ϼ���!");
                pis_yy.focus();
                return false;
            }

            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_SC_RQSTYMD.IsUpdated ) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}


            //��û��, �������� ������ ���� ����
            var str_ymd;
            var end_ymd;
            var str_ymd2;
            var end_ymd2;
            var pay_ym;
            var pay_ym2;
            for(var i=1; i<=dsT_SC_RQSTYMD.CountRow; i++) {
                str_ymd = parseInt(dsT_SC_RQSTYMD.NameString(i, "STR_YMD").replace(/-/g, ""));
                end_ymd = parseInt(dsT_SC_RQSTYMD.NameString(i, "END_YMD").replace(/-/g, ""));
                pay_ym  = parseInt(dsT_SC_RQSTYMD.NameString(i, "PAY_YM").replace(/-/g, ""));

                for(var j=1; j<=dsT_SC_RQSTYMD.CountRow; j++) {
                    if(i == j) continue;

                    str_ymd2 = parseInt(dsT_SC_RQSTYMD.NameString(j, "STR_YMD").replace(/-/g, ""));
                    end_ymd2 = parseInt(dsT_SC_RQSTYMD.NameString(j, "END_YMD").replace(/-/g, ""));
                    pay_ym2  = parseInt(dsT_SC_RQSTYMD.NameString(j, "PAY_YM").replace(/-/g, ""));


                    if((str_ymd  <= str_ymd2 && str_ymd2 <= end_ymd)
                            || (str_ymd  <= end_ymd2 && end_ymd2 <= end_ymd)
                            || (str_ymd2 <= str_ymd  && str_ymd  <= end_ymd2)
                            || (str_ymd2 <= end_ymd  && end_ymd  <= end_ymd2)) {
                        alert(i+"��° �ٰ� "+j+"��° ���� �Ⱓ���� �ߺ��˴ϴ�.\n ��û�����Ͽ�, ��û�������� Ȯ���� �ּ���.");
                        return false;
                    }
                }
            }

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById('txtPIS_YY_SHR').value = today.substring(0,4);

			cfStyleGrid_New(form1.grdT_SC_RQSTYMD,15,"false","false");      // Grid Style ����

            document.getElementById('txtPIS_YY_SHR').focus();

            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		var elementList = new Array( "txtSTR_YMD"
                                    ,"txtEND_YMD"
                                    ,"txtPAY_YM"
                                    ,"txtPAY_YMD"
                                    ,"imgSTR_YMD"
                                    ,"imgEND_YMD"
                                    ,"imgPAY_YM"
                                    ,"imgPAY_YMD" );

		var keyList = new Array(     "txtSTR_YMD"
                                    ,"txtEND_YMD"
                                    ,"txtPAY_YM"
                                    ,"txtPAY_YMD" );


        /**
         * ��û �������ڸ� ������ ��û �⵵�� �ڵ����� ���ε�
         */
        function bindPIS_YY() {
        	
            //alert("����");
        	
            var str_ymd = document.getElementById("txtSTR_YMD").value;
            
            var pis_yy = "";

            if(str_ymd.length > 3) {
            	
                pis_yy = str_ymd.substr(0,4);
            }
            

            
            dsT_SC_RQSTYMD.NameString(dsT_SC_RQSTYMD.RowPosition, "PIS_YY") = pis_yy;
            
        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_SC_RQSTYMD)   |
    | 3. ���Ǵ� Table List(T_SC_RQSTYMD)		     |
    +------------------------------------------------>
    <Object ID="dsT_SC_RQSTYMD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_SC_RQSTYMD)	    |
    | 3. ���Ǵ� Table List(T_SC_RQSTYMD)	            |
    +--------------------------------------------------->
    <Object ID ="trT_SC_RQSTYMD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_SC_RQSTYMD Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_SC_RQSTYMD Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_SC_RQSTYMD Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
	    cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_SC_RQSTYMD event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_SC_RQSTYMD event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_SC_RQSTYMD event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            fnc_EnableElementAll(elementList);
        }
    </script>


    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_SC_RQSTYMD event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_SC_RQSTYMD.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_SC_RQSTYMD.GetHdrDispName('-3', colName) + " ]��(��) �ʼ� �Է»����Դϴ�");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }
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
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
									<col width="60"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">�� ��&nbsp;</td>
								<td class="padding2423">
                                     <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">��û������</td>
					<td class="padding2423">
                        <input id="txtSTR_YMD" size="10" maxlength="10" onblur="if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this); bindPIS_YY();" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imdSTR_YMD','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imdSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','60','180');"></a>
                    </td>
                    <td align="center" class="blueBold">��û������</td>
					<td class="padding2423">
                        <input id="txtEND_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','300','180');"></a>
                    </td>
                    <td align="center" class="blueBold">���޳��</td>
					<td class="padding2423">
                        <input id="txtPAY_YM" size="7" maxlength="7" onkeypress="cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAY_YM','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" name="imgPAY_YM" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPAY_YM','','540','180');"></a>
                    </td>
                    <td align="center" class="blueBold">��������</td>
					<td class="padding2423">
                        <input id="txtPAY_YMD" size="10" maxlength="10" onkeypress="cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAY_YMD','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" name="imgPAY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPAY_YMD','','540','180');"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_SC_RQSTYMD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_SC_RQSTYMD">
                            <param name="Format"					value="
								<C> id={currow}			width=65    	name='NO'		    		align=center </C>
								<C> id='PIS_YY'	    	width=140	name='�⵵'	        		align=center </C>
                                <C> id='STR_YMD' 		width=200	name='��û������'	   		align=center </C>
								<C> id='END_YMD'		width=200	name='��û������'	    	align=center </C>
								<C> id='PAY_YM'	    	width=160	name='���޳��'	  		align=center </C>
								<C> id='PAY_YMD'		width=160	name='��������'	 		align=center </C>
							">
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

<!-- ���ڱ� ��û�Ⱓ ���̺� -->
<object id="bndT_SC_RQSTYMD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_SC_RQSTYMD">
    <Param Name="BindInfo", Value='
        <C> Col=PIS_YY       	Ctrl=txtPIS_YY       		Param=value</C>
        <C> Col=PIS_QQ       	Ctrl=cmbPIS_QQ       	Param=value</C>
        <C> Col=STR_YMD      	Ctrl=txtSTR_YMD      	Param=value</C>
        <C> Col=END_YMD      Ctrl=txtEND_YMD      	Param=value</C>
        <C> Col=PAY_YM       	Ctrl=txtPAY_YM      	 	Param=value</C>
        <C> Col=PAY_YMD      	Ctrl=txtPAY_YMD      	Param=value</C>
    '>
</object>


