<!--*************************************************************************
/*--------------------------------------------------------------------------------
+ �ý��۸� : �Ͽ��� �λ���� - �⺻����
+ ������� : �λ� �⺻������ ȭ�� �ϴ��� 3���� ���� �̿��Ͽ� �Է�,����,����,��ȸ�Ѵ�.
+ ���α׷�ID : aday010.jsp
+ ������� : 
+ �� �� �� : �� �� ��
+ �ۼ����� : 2013.04.03
----------------------------------------------------------------------------------
+ �������� : 
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------*/-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�Ͽ��� �λ����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
    *																						 *
    ***************************************************************************************-->

	<!-- ÷�� ������ ���� -->
    <jsp:include page="/common/fileupload.jsp" flush="true" />
    <!-- ÷�� ������ ���� -->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFTT';
        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
            
			//���� ��ȸ
			var SITE_SHR = document.getElementById("txtSITE_CD_SHR").value;			// �Ҽ�
			var USE_STS = document.getElementById("cmbUSE_STS_S").value; 			// ä�뱸��
			var ENO_NM = document.getElementById("txtENO_NM_SHR").value;				// ����

			
			dsT_CA_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.ada.a.aday010.cmd.ADAY010CMD&S_MODE=SHR&SITE_SHR="+SITE_SHR+"&USE_STS="+USE_STS+"&ENO_NM="+ENO_NM;
			dsT_CA_PERSON.reset();
			

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
            
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_CA_PERSON.KeyValue = "tr01(I:dsT_CA_PERSON=dsT_CA_PERSON)";
			trT_CA_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.ada.a.aday010.cmd.ADAY010CMD&S_MODE=SAV";

			//prompt(this, dsT_CA_PERSON.text);
			
			trT_CA_PERSON.post();
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {

        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {

        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_Excel() {

            if (dsT_CA_PERSON.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CA_PERSON.GridToExcel("�ٷ��ڱ⺻����", '', 225);

			
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_CA_PERSON.CountColumn == 0) {
            	dsT_CA_PERSON.setDataHeader("SITE_CD:STRING, SITE_NM:STRING, USE_STS:STRING, ENO_NM:STRING, CET_NO:STRING, BNK_CD:STRING, BNK_NM:STRING, ADDRESS:STRING, PH_NO:STRING, ACC_NO:STRING, WRK_AMT:STRING, REMARK:STRING, FILE_KEY:STRING");
            }

            if (dsT_CA_PERSON.IsUpdated ) {
                alert("��������� �����մϴ�.\n�ش� �۾� ������ �Ŀ� �ű� �۾��� �Ͻñ� �ٶ��ϴ�.");
                document.getElementById("txtENO_NM").focus();
                return;
            }

            dsT_CA_PERSON.AddRow();

            form1.txtENO_NM.focus();

		}

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {

        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
            
	        document.getElementById("resultMessage").innerText = ' ';

			// �޺��ڽ� �⺻ ����
			document.form1.cmbAID_STS_SHR.selectedIndex = 0;

			dsT_CA_PERSON.ClearData();

            document.getElementById("txtREQ_YMD_STDT_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";

		}

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {

			if (dsT_CA_PERSON.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {

			document.form1.txtCET_NO.value = removeChar( document.form1.txtCET_NO.value, "-" ) ;

			var USE_STS = document.getElementById("cmbUSE_STS").value; 			// ä�뱸��
			
         	if ( USE_STS != "1" && USE_STS != "3" ) {
         		alert("ä�뱸���� �����ϼ���.");
                return false;
			}			
			
         	if ( document.form1.txtPH_NO.value == "") {
         		alert("����ó�� �ʼ��Է»����Դϴ�.");
                return false;
			}
			
         	if ( document.form1.txtREMARK.value == "") {
         		alert("������ �ʼ��Է»����Դϴ�.");
                return false;
			}
         	
         	if ( !dsT_CA_PERSON.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
			
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid_New(form1.grdT_CA_PERSON,0,"false","true");      // Grid Style ����

            //fnc_SearchList();
   
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}



        /********************************************
         * ÷������ ó��								*
         ********************************************/
		function fnc_FileUpload() {
			
            if(dsFILE.CountRow == 3) {
                alert("�� �̻� ÷�������� �߰��Ͻ� �� �����ϴ�.");
                return;
            }

            var key = dsT_CA_PERSON.NameValue(dsT_CA_PERSON.RowPosition, "FILE_KEY");

            if(key == "") {
                key = "aday010"+(new Date().getTime());
                dsT_CA_PERSON.NameValue(dsT_CA_PERSON.RowPosition, "FILE_KEY") = key;
            }

            if(!fnc_AddFileImg(key)) {
                return;
            }

		}

		/********************************************
         * ÷������ ����								*
         ********************************************/
		function fnc_FileDelete() {
            if(dsFILE.CountRow < 1) {
                alert("������ ������ �������� �ʽ��ϴ�.");
                return;
            }

            if( confirm("÷�ε� ������ �����Ͻðڽ��ϱ�?") ){
                dsFILE.DeleteRow(dsFILE.RowPosition);
                fnc_DelFile();
            }
		}

		
		/********************************************
         * ��¥ ���� ��ȿ�� üũ                           			*
         ********************************************/
        function fncCheckDate(obj) {
            
            if (obj.value == '') return;
            
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }


        /********************************************
         * �ֹε�Ϲ�ȣ �ʵ忡�� ��Ŀ�� ������ ��ȿ���� �˻�      *
         ********************************************/
        function checkSSN(){
            // ������ ����
            var ssn = removeChar( document.form1.txtCET_NO.value, "-" ) ;

	            if( document.form1.txtCET_NO.value.length != 10 && ssn != "" && ! covSsnValidator_validate(ssn) ){

	                alert("�߸��� �ֹι�ȣ�Դϴ�.");
	                //document.form1.txtCET_NO.value = "";
	                document.form1.txtCET_NO.focus();
	            }


        }


        /********************************************
         * �ֹε�Ϲ�ȣ �Է½� �ڵ� ������(-) �ֱ�          *
         ********************************************/
        function cfCheckNumber5(){
            if((event.keyCode < 48)||(event.keyCode > 57)){
                if(event.keyCode != 45){
                    event.returnValue=false;
                }
            }
            if( document.form1.txtCET_NO.value.length == 6 ){
                document.form1.txtCET_NO.value += "-";
            }
        }
        		
		/********************************************
         * �ֹι�ȣ ���� ��ȿ�� üũ                           			*
         ********************************************/		
        function fnc_SsnValid(obj) {
            if (obj.value != "") {
                if (!covSsnValidator_validate(removeChar(obj.value,'-'))) {
                    alert("�߸��� �ֹι�ȣ�Դϴ�. Ȯ�ιٶ��ϴ�.");
                    return false;
                }
            }

            return true;
        }		

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AD_AIDAPP)			 	   |
    | 3. ���Ǵ� Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_CA_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AD_AIDAPP)			       |
    | 3. ���Ǵ� Table List(T_AD_AIDAPP)				       |
    +------------------------------------------------------>
	<Object ID="trT_CA_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_CA_PERSON=dsT_CA_PERSON,I:dsT_CA_PERSON=dsT_CA_PERSON)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_CA_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CA_PERSON.CountRow);

			var FILE_KEY = dsT_CA_PERSON.NameValue(1, "FILE_KEY");

			dsFILE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.ada.a.aday010.cmd.ADAY010CMD&S_MODE=SHR_FILE&FILE_KEY="+FILE_KEY;
			dsFILE.reset();

        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_CA_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_CA_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_CA_PERSON event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_CA_PERSON event="OnFail()">
        alert(trT_CA_PERSON.ErrorMsg);
    </script>



    <!--------------------------+
    | grid���� row�� Ŭ��������      |
    +------ -------------------->
	<script for=grdT_CA_PERSON event=OnClick(Row,Colid)>

			var FILE_KEY = dsT_CA_PERSON.NameValue(dsT_CA_PERSON.RowPosition, "FILE_KEY");

			dsFILE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.ada.a.aday010.cmd.ADAY010CMD&S_MODE=SHR_FILE&FILE_KEY="+FILE_KEY;
			dsFILE.reset();


    </Script>

	<!-- ���� �׸��� Ŭ���� �ٿ�ε� �ǰ� -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
        if(row > 0) {
            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");

            // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
            if (vFILE_NAME != "" && vFILE_URL != "") {
				cfDownload(vFILE_NAME,vFILE_URL);
            }
        }
    </script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

	<!-- Ķ���� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>


	<!-- form ���� -->
	<form name="form1" id="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">�ٷ��� �⺻����</td>
					<td align="right" class="navigator">HOME/�������/�Ͽ�������/<font color="#000000">�ٷ��� �⺻����</font></td>
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
			
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"><img src="../../images/button/btn_ExcelOn.gif" name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Excel()"></a>

	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
        <tr>
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="100"></col>
                            <col width="200"></col>
                            <col width="100"></col>
                            <col width="120"></col>
                            <col width="100"></col>
                            <col width=""></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">�� �� &nbsp;</td>
                            <td class="padding2423">
                                    <input id="txtSITE_CD_SHR"  name="txtSITE_CD_SHR" style="width:15%" 	maxlength="4" onChange="fnc_GetCommNm('AY', 'txtSITE_CD_SHR','txtSITE_NM_SHR')"> 
									<input id="txtSITE_NM_SHR" name="txtSITE_NM_SHR" size="15" maxlength="15" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgSITE_NM_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgSITE_NM_SHR" name="imgSITE_NM_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSITE_CD_SHR','txtSITE_NM_SHR','�Ҽ�','AY');fnc_SearchList();"></a>
                            </td>
                            <td class="searchState" align="right">ä&nbsp;&nbsp;��&nbsp;</td>
                            <td class="padding2423" align="left">
                                <select id="cmbUSE_STS_S" style="width:120" onchange="fnc_SearchList();">
                                    <option value="">��ü</option>
                                    <option value="1">ä����</option>
                                    <option value="3">��ä��</option>
                                </select>
                            </td>
                            <td align="right" class="searchState">��&nbsp;&nbsp;��</td>
                            <td class="padding2423">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_SearchList();">
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

	<tr><td>&nbsp;</td></tr>

	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="65"></col>
			<col width="135"></col>
			<col width="65"></col>
			<col width="135"></col>
			<col width="65"></col>
			<col width="*"></col>
		</colgroup>
		<tr height = "40px">
			<td align="center" class="creamBold">����</td>
			<td class="padding2423"><input id="txtENO_NM" size="16" maxLength="25"></td>
			<td align="center" class="creamBold">�ֹι�ȣ</td>
			<td class="padding2423">
			<input id="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled" onChange="javascript : if (checkSSN(this) == true) {}"></td> 
			<td align="center" class="creamBold">�Ҽ�</td>
			<td class="padding2423">
			
                        <input id="txtSITE_CD" style="width:10%" 	maxlength="4" class="input_ReadOnly" readonly> 
                        <input id="txtSITE_NM" style="width:70%" 	class="input_ReadOnly" readonly>
                        			
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSITE_NM','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgSITE_NM" name="ImgSITE_NM"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSITE_CD','txtSITE_NM','�Ҽ�','AY')"></a>			
			
			</td>
		</tr>
		<tr height = "40px">
			<td align="center" class="creamBold">ä��</td>
			<td class="padding2423">
                        <select id="cmbUSE_STS" style="width:100%" >
                            <option value="1">ä����</option>
                            <option value="3" >��ä��</option>
                        </select>	
			</td>
			<td align="center" class="creamBold">�빫�ܰ�</td>
			<td class="padding2423"><input id="txtWRK_AMT" size="16" maxLength="16"></td>
			<td align="center" class="creamBold">�ּ�</td>
			<td class="padding2423"><input id="txtADDRESS" size="50" maxLength="50"></td>
		</tr>

		<tr height = "40px">
			<td align="center" class="creamBold">����ó</td>
			<td class="padding2423">
				<input id="txtPH_NO" size="16" maxLength="16">
			</td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423">
				<input id="txtREMARK" size="16" maxLength="16">
			</td>
			<td align="center" class="creamBold" rowspan="2">���⼭��<br>÷��</td>
			<td class="padding2423" colspan="5"  rowspan="2" align="right">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','../../images/button/FileAddOver.gif',1)"><img src="../../images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','../../images/button/FileDelOver.gif',1)"><img src="../../images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()"></a>
                <comment id="__NSID__">
                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:100%;height:65px;">
                    <param name="DataID" 					value="dsFILE">
                    <param name="Editable" 				value="false">
                    <param name="DragDropEnable" 		value="true">
                    <param name="SortView" 				value="Left">
                    <param name=ViewHeader  			value="false">
                    <param name="Format" 					value='
                        <C> id="{CUROW}"    width="30"      name="NO"         align="center"  value={String(Currow)}</C>
                        <C> id=FILE_NAME    width="250"     name="���ϸ�"      align="left"    leftmargin="10"</C>
                    '>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
			</td>			
        </tr>
		<tr height = "40px">
			<td align="center" class="creamBold">���¹�ȣ</td>
			<td class="padding2423">
				<input id="txtACC_NO" size="16" maxLength="16">
			</td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423">
				<input id="txtBNK_CD" size="3" maxLength="3" class="input_ReadOnly" readonly>
				<input id="txtBNK_NM" size="10" maxLength="10" class="input_ReadOnly" readonly>
			<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgBNK_NM','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgBNK_NM" name="imgBNK_NM" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtBNK_CD','txtBNK_NM','����', 'BK')"></a>
			</td>
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
						<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CA_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
						<param name="DataID" 				value="dsT_CA_PERSON">
                        <param name="ColSelect"  		value="true">
						<param name="Editable" 			value="false">
						<param name="DragDropEnable" 	value="true">
						<param name="SortView" 			value="Left">
						<param name="Format" 				value='
							<C> id="{CUROW}"	width="50"		name="NO"					align="center"	value={String(Currow)}</C>
                            <C> id="SITE_NM"    width="150"    name="�Ҽ�"              	align="left"    	Edit=none   LeftMargin="10" </C>
							<C> id="ENO_NM"		width="70"		name="����"				align="center"	Edit=none   </C>
							<C> id="CET_NO"		width="100"		name="�ֹι�ȣ"			align="center"	Edit=none   mask="XXXXXX-XXXXXXX"</C>
							<C> id="WRK_AMT"	width="80"		name="�빫�ܰ�"			align="right"		Edit=none	RightMargin="10"</C>
							<C> id="ADDRESS"	width="200"		name="�ּ�"		        align="left"		Edit=none	</C>
							<C> id="PH_NO"		width="100"		name="����ó"		        align="center"	Edit=none	</C>	
							<C> id="BNK_NM"		width="90"		name="����"		        align="center"	Edit=none	</C>		
							<C> id="ACC_NO"		width="120"		name="���¹�ȣ"		    align="center"	Edit=none	</C>																						
						'>
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

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->
	<!-- dsT_CA_PERSON ���� ���̺� -->
	<object id="bndT_CA_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_CA_PERSON">
		<Param Name="BindInfo", Value="
			<C>Col=CET_NO		Ctrl=txtCET_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=USE_STS		Ctrl=cmbUSE_STS	Param=value</C>			
			<C>Col=WRK_AMT	Ctrl=txtWRK_AMT		Param=value</C>
			<C>Col=SITE_CD		Ctrl=txtSITE_CD		Param=value</C>			
			<C>Col=SITE_NM		Ctrl=txtSITE_NM		Param=value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=value</C>
			<C>Col=PH_NO		Ctrl=txtPH_NO			Param=value</C>
			<C>Col=ADDRESS		Ctrl=txtADDRESS		Param=value</C>			
			<C>Col=ACC_NO		Ctrl=txtACC_NO		Param=value</C>
			<C>Col=BNK_CD		Ctrl=txtBNK_CD		Param=value</C>				
			<C>Col=BNK_NM		Ctrl=txtBNK_NM		Param=value</C>			
		">
	</object>
