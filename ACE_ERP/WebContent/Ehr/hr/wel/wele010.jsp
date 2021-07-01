	<!--*************************************************************************
	* @source      : wele010.jsp												*
	* @description : �Ĵ��̿��ϰ��� PAGE												*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/22            ä����         	        �����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>
<html>
<head>
	<title>�Ĵ��̿��ϰ���(wele010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TTTTTFTT';

        var insert_type = "";

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
            document.getElementById("txtSTR_YMD_SHR").readOnly  = false;
            document.getElementById("txtEND_YMD_SHR").readOnly  = false;
            document.getElementById("txtSTR_YMD_SHR").className = "";
            document.getElementById("txtEND_YMD_SHR").className = "";
            document.getElementById("imgSTR_YMD_SHR").disabled  = false;
            document.getElementById("imgEND_YMD_SHR").disabled  = false;
            document.getElementById("txtRSTR_CD").readOnly      = true;
            document.getElementById("txtRSTR_CD").className     = "input_ReadOnly";

            //���� ���ε带 ����
            insert_type = "";

			//�Ĵ��̿��� ���� ��ȸ
			var ENO_NO_SHR  = document.getElementById("txtENO_NO_SHR").value;
			var DPT_CD_SHR  = document.getElementById("txtDPT_CD_SHR").value;
			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;

            dsT_WL_DININGUSE.ClearData();
            dsT_WL_DININGUSE.UseChangeInfo = true;

			dsT_WL_DININGUSE.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.e.wele010.cmd.WELE010CMD&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR;
			dsT_WL_DININGUSE.reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
			if (insert_type != "UPLOAD" && !fnc_SaveItemCheck() ) {
				return;
			} else if(insert_type == "UPLOAD" && !confirm("["+document.getElementById("txtSTR_YMD_SHR").value+"] �� �ش� �Ǵ� ��� ����Ÿ�� �ʱ�ȭ �˴ϴ�.\n����Ͻðڽ��ϱ�?")){
                return;
            }

			// save
			trT_WL_DININGUSE.KeyValue = "tr01(I:dsT_WL_DININGUSE=dsT_WL_DININGUSE, O:dsRESULT=dsRESULT)";
			trT_WL_DININGUSE.action = "/servlet/GauceChannelSVL?cmd=hr.wel.e.wele010.cmd.WELE010CMD&S_MODE=SAV&TYPE="+insert_type+"&STR_YMD="+document.getElementById("txtSTR_YMD_SHR").value;
			trT_WL_DININGUSE.post();
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_WL_DININGUSE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_WL_DININGUSE.GridToExcel("�Ĵ��̿��ϰ���", '', 225);

        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_WL_DININGUSE.CountColumn == 0) {
				dsT_WL_DININGUSE.setDataHeader("ENO_NO:STRING, ENO_NM:STRING, STR_YMD:STRING, END_YMD:STRING, DPT_CD:STRING, DPT_NM:STRING, RSTR_CD:STRING, MRN_CNT:DECIMAL(2.0), MRN_AMT:DECIMAL(6.0), AFN_CNT:DECIMAL(2.0), AFN_AMT:DECIMAL(6.0), EVN_CNT:DECIMAL(2.0), EVN_AMT:DECIMAL(6.0), TOT_CNT:DECIMAL(2.0), TOT_AMT:DECIMAL(6.0)");
			}

            dsT_WL_DININGUSE.AddRow();

            document.getElementById("txtSTR_YMD").value = document.getElementById("txtSTR_YMD_SHR").value;
            document.getElementById("txtEND_YMD").value = document.getElementById("txtEND_YMD_SHR").value;

            document.getElementById("txtENO_NO").value = "<%=box.getString("SESSION_ENONO") %>";

            fnc_SearchEmpNo();
        }

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_WL_DININGUSE.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "�����  = "+dsT_WL_DININGUSE.nameValue(dsT_WL_DININGUSE.RowPosition, "ENO_NO")+"\n";
            	tmpMSG += "������  = "+dsT_WL_DININGUSE.nameValue(dsT_WL_DININGUSE.RowPosition, "STR_YMD")+"\n";

	            if( confirm(tmpMSG) ){
					var ENO_NO     = dsT_WL_DININGUSE.nameValue(dsT_WL_DININGUSE.RowPosition, "ENO_NO");
                    var SEQ_NO     = dsT_WL_DININGUSE.nameValue(dsT_WL_DININGUSE.RowPosition, "SEQ_NO");
					var STR_YMD    = dsT_WL_DININGUSE.nameValue(dsT_WL_DININGUSE.RowPosition, "STR_YMD");


					dsT_WL_DININGUSE.DeleteRow(dsT_WL_DININGUSE.RowPosition);

					// �Ķ���� �߰�
					trT_WL_DININGUSE.Parameters = "ENO_NO="+ENO_NO+",STR_YMD="+STR_YMD+",SEQ_NO="+SEQ_NO;

					trT_WL_DININGUSE.KeyValue = "tr02(I:dsT_WL_DININGUSE=dsT_WL_DININGUSE)";
					trT_WL_DININGUSE.action = "/servlet/GauceChannelSVL?cmd=hr.wel.e.wele010.cmd.WELE010CMD&S_MODE=DEL";
					trT_WL_DININGUSE.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
  			for(var i=2; i<6; i++){
  				document.form1.elements[i].value = "";
  			}

  			document.getElementById("resultMessage").innerText = ' ';

        	fnc_DisableElementAll(elementList);
        	dsT_WL_DININGUSE.ClearData();

            document.getElementById("txtSTR_YMD_SHR").readOnly  = false;
            document.getElementById("txtEND_YMD_SHR").readOnly  = false;
            document.getElementById("txtSTR_YMD_SHR").className = "";
            document.getElementById("txtEND_YMD_SHR").className = "";
            document.getElementById("imgSTR_YMD_SHR").disabled  = false;
            document.getElementById("imgEND_YMD_SHR").disabled  = false;

            //���� ���ε带 ����
            insert_type = "";
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_WL_DININGUSE.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {
         	if (!dsT_WL_DININGUSE.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
			cfStyleGrid(form1.grdT_WL_DININGUSE,15,"true","false");      // Grid Style ����
			fnc_DisableElementAll(elementList);

            var vDATE = new Date(getTodayArray()[0], getTodayArray()[1]-1, getTodayArray()[2]);
            vDATE.setMonth(vDATE.getMonth() -1);

            var vSTR_YMD = vDATE.getYear()+"-"+lpad((vDATE.getMonth()+1), 2, "0")+"-16";
            var vEND_YMD = getTodayArray()[0]+"-"+getTodayArray()[1]+"-15";

            document.getElementById("txtSTR_YMD_SHR").value = vSTR_YMD;
            document.getElementById("txtEND_YMD_SHR").value = vEND_YMD;
            document.getElementById('txtSTR_YMD_SHR').focus();
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        var elementList = new Array( "txtENO_NM"
                                    ,"txtRSTR_CD"
                                    ,"txtENO_NO"
                                    ,"hidDPT_CD"
                                    ,"txtDPT_NM"
                                    ,"ImgEnoNo"
                                    ,"txtSTR_YMD"
                                    ,"txtEND_YMD"
                                    ,"imgSTR_YMD"
                                    ,"txtMRN_CNT"
                                    ,"medMRN_AMT"
                                    ,"txtAFN_CNT"
                                    ,"medAFN_AMT"
                                    ,"txtEVN_CNT"
                                    ,"medEVN_AMT"
                                    ,"txtTOT_CNT"
                                    ,"medTOT_AMT" );

        var enableList = new Array(  "txtMRN_CNT"
                                    ,"txtAFN_CNT"
                                    ,"txtEVN_CNT"
                                    );


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup("txtENO_NO");

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetEnoNm("txtENO_NO");

            if(obj.eno_no) {
                dsVI_T_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.e.wele010.cmd.WELE010CMD&S_MODE=SHR_01&ENO_NO="+obj.eno_no;
    			dsVI_T_PERSON.reset();
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value         = "";
                document.getElementById("txtRSTR_CD").value        = "";
            }
        }

  		/********************************************
         * �Ⱓ������ �ʵ忡�� ��Ŀ�� ������ ������ ����(�ű�,�˻�)*
         ********************************************/
        function setEndYmd(stObj, enObj){
        	var str_ymd = document.getElementById(stObj).value;
        	if( str_ymd.length > 8 ){
        		document.getElementById(stObj).value = str_ymd.substr(0,7)+"-16";
        		var enYY = str_ymd.substr(0,4);
        		var enMM = str_ymd.substr(5,2);
        		if( eval(enMM+"+"+1) > 12 ){  // ���� �� 1��
        			enYY = eval(enYY+"+"+1);  // �⵵ '+1'
        			enMM = "01";                 // 1��
        		} else {
                    enMM = lpad(enMM+1, 2, 0);
                }
        		document.getElementById(enObj).value = enYY+"-"+enMM+"-15";
        	}
        }

  		/********************************************
         * �Ⱓ������ �ʵ忡�� ��Ŀ�� ������ ������(�˻�)		*
         ********************************************/
        function setStdYmd(stObj){
        	var str_ymd = document.getElementById(stObj).value;
        	if( str_ymd.length > 8 ){
        		document.getElementById(stObj).value = str_ymd.substr(0,7)+"-16";
        	}
        }


  		/********************************************
         * �Ⱓ������ �ʵ忡�� ��Ŀ�� ������ ������ ����(�˻�)	*
         ********************************************/
        function setEndYmd2(enObj){
           	var end_ymd = document.getElementById(enObj).value;
           	if( end_ymd.length > 8 ){
           		document.getElementById(enObj).value = end_ymd.substr(0,7)+"-15";
           	}
        }

        /*****************************
         * �������� ���ε� ó��      *
         ****************************/
         function fnc_FileUpload() {
            var vSTR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
            var vEND_YMD = document.getElementById("txtEND_YMD_SHR").value;

            if(vSTR_YMD == "") {
                alert("�������� ����ֽ��ϴ�.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return;
            }
            if(vEND_YMD == "") {
                alert("�������� ����ֽ��ϴ�.");
                document.getElementById("txtEND_YMD_SHR").focus();
                return;
            }
            if(parseInt(vSTR_YMD) > parseInt(vEND_YMD)) {
                alert("�������� �����Ϻ��� Ŭ �� �����ϴ�.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return;
            }

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            //Ȯ���� Ŭ���ߴ��� ���� ����
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

			// �ش� Dataset�� Header�� ������ Header ����
            if (dsFILE_UPLOAD.CountColumn < 1) {
	            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }
            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** �����ִ� ���� �б� */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){

                trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD,O:dsT_WL_DININGUSE=dsT_WL_DININGUSE)";
                trFILE_UPLOAD.action   = "/servlet/GauceChannelSVL?cmd=hr.wel.e.wele010.cmd.WELE010CMD&S_MODE=SHR_02&STR_YMD="+vSTR_YMD+"&END_YMD="+vEND_YMD;
                trFILE_UPLOAD.post();
            }
        }

		/********************************************
         * CNT �հ豸�ؼ� �ֱ�	 					*
         ********************************************/
		function fnc_cntSum(){
            //�����Ǿ� ����
            var mrn_bas = 3000;     //��ħ �Ĵ�
            var afn_bas = 3500;     //���� �Ĵ�
            var evn_bas = 3500;     //���� �Ĵ�

			var mrn_cnt = fnc_covNumber(document.getElementById("txtMRN_CNT").value);
			var afn_cnt = fnc_covNumber(document.getElementById("txtAFN_CNT").value);
			var evn_cnt = fnc_covNumber(document.getElementById("txtEVN_CNT").value);

			document.getElementById("txtTOT_CNT").value = mrn_cnt + afn_cnt + evn_cnt;


            document.getElementById("medMRN_AMT").Text = mrn_bas * mrn_cnt;
            document.getElementById("medAFN_AMT").Text = afn_bas * afn_cnt;
            document.getElementById("medEVN_AMT").Text = evn_bas * evn_cnt;


            document.getElementById("medTOT_AMT").Text = (mrn_bas * mrn_cnt) + (afn_bas * afn_cnt) + (evn_bas * evn_cnt);
		}

		/********************************************
         * AMT �հ豸�ؼ� �ֱ�	 						*
         ********************************************/
		function fnc_amtSum(){
			var mrn_amt = document.form1.medMRN_AMT.Text;
			var AFN_AMT = document.form1.medAFN_AMT.Text;
			var evn_amt = document.form1.medEVN_AMT.Text;

			if( mrn_amt == "" ){ mrn_amt = 0; }
			if( AFN_AMT == "" ){ AFN_AMT = 0; }
			if( evn_amt == "" ){ evn_amt = 0; }
			var amtSum = eval( mrn_amt+"+"+AFN_AMT+"+"+evn_amt )+"";

			document.form1.medTOT_AMT.Text = amtSum;
		}
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WL_DININGUSE)			 	   |
    | 3. ���Ǵ� Table List(T_WL_DININGUSE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_DININGUSE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet								       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='÷������'>
        <param name="Enable"    value="true">
    </object>

    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!----------------------------------------------+
    | 1. �ڷ� ���ε�� Data Transacton              |
    | 2. �̸� : trFILE_UPLOAD_06                    |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_DININGUSE)			   |
    | 3. ���Ǵ� Table List(T_WL_DININGUSE)				   |
    +------------------------------------------------------>
	<Object ID="trT_WL_DININGUSE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_DININGUSE=dsT_WL_DININGUSE,I:dsT_WL_DININGUSE=dsT_WL_DININGUSE)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_DININGUSE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_DININGUSE.CountRow);
        }
    </Script>

   	<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			alert("�ش����� ������ �����ϴ�.");
		} else {
			// ��� ���� ����
            document.getElementById("txtENO_NM").value = dsVI_T_PERSON.NameValue(0,"ENO_NM");

			document.form1.hidDPT_CD.value       = dsVI_T_PERSON.NameValue(0,"DPT_CD");
			document.form1.txtDPT_NM.value       = dsVI_T_PERSON.NameValue(0,"DPT_NM");
			document.form1.txtRSTR_CD.value      = dsVI_T_PERSON.NameValue(0,"RSTR_CD");


            //ī�� ������ ���� ��� ī�� �Է°����ϰ�
            if(document.form1.txtRSTR_CD.value == "") {
                document.getElementById("txtRSTR_CD").readOnly = false;
                document.getElementById("txtRSTR_CD").className = "";
            }

        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_WL_DININGUSE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_DININGUSE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_DININGUSE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

        //ī���ȣ ����
        document.getElementById("txtRSTR_CD").readOnly      = true;
        document.getElementById("txtRSTR_CD").className     = "input_ReadOnly";

        fnc_SearchList();
    </script>

	<script for=trFILE_UPLOAD event="OnSuccess()">
		document.getElementById("resultMessage").innerText = "����÷�ΰ� �Ϸ�Ǿ����ϴ�.";

        dsT_WL_DININGUSE.UseChangeInfo = false;
        //���� ���ε带 ����
        insert_type = "UPLOAD";

        document.getElementById("txtSTR_YMD_SHR").readOnly  = true;
        document.getElementById("txtEND_YMD_SHR").readOnly  = true;
        document.getElementById("txtSTR_YMD_SHR").className = "input_ReadOnly";
        document.getElementById("txtEND_YMD_SHR").className = "input_ReadOnly";
        document.getElementById("imgSTR_YMD_SHR").disabled  = true;
        document.getElementById("imgEND_YMD_SHR").disabled  = true;
        document.getElementById("txtRSTR_CD").readOnly      = true;
        document.getElementById("txtRSTR_CD").className     = "input_ReadOnly";
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_DININGUSE event="OnFail()">
        cfErrorMsg(this);
    </script>

	<script for=trFILE_UPLOAD event="OnFail()">
        cfErrorMsg(this);
    </script>

 	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_WL_DININGUSE event=CanRowPosChange(row)>
		if ( dsT_WL_DININGUSE.NameValue(row,"RSTR_CD") == "" ) {
			alert("[ " + grdT_WL_DININGUSE.GetHdrDispName('-3','RSTR_CD') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
	</script>

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_DININGUSE event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0 ) {
            fnc_EnableElementAll(enableList);

            //���°� �Է��� ��� �����, �������� �Է��� �����ϰ�
            if(dsT_WL_DININGUSE.RowStatus(row) == "1"){
<%
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
                fnc_ChangeStateElement(true, "txtENO_NM"    );
                fnc_ChangeStateElement(true, "txtENO_NO"    );
                fnc_ChangeStateElement(true, "ImgEnoNo"     );
<%
    }
%>
                if(insert_type != "UPLOAD") {
                    fnc_ChangeStateElement(true, "txtSTR_YMD"   );
                    fnc_ChangeStateElement(true, "txtEND_YMD"   );
                    fnc_ChangeStateElement(true, "imgSTR_YMD"   );
                }
            }
        }
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- Ķ���� ������-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�Ĵ��̿��ϰ���</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�Ĵ��ڵ�/<font color="#000000">�Ĵ��̿��ϰ���</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
							<col width="70"></col>
							<col width="220"></col>
							<col width="50"></col>
							<col width="180"></col>
							<col width="50"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="right" class="searchState">��ȸ�Ⱓ</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);setStdYmd('txtSTR_YMD_SHR');" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR','','103','110');"></a>
								~
								<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);setEndYmd2('txtEND_YMD_SHR');" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','218','110');"></a>
							</td>
							<td align="right" class="searchState">���</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
								<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
							</td>
							<td class="searchState" align="right">�Ҽ�</td>
							<td class="padding2423" align="left">
								<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
								<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
									<img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')">
								</a>
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
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<tr>
					<td>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="60"></col>
							<col width="160"></col>
							<col width="60"></col>
							<col width="100"></col>
							<col width="60"></col>
							<col width="50"></col>
							<col width="80"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="center" class="creamBold">���</td>
                            <td class="padding2423">
                                <input id="txtENO_NO" name="txtENO_NO" size="8" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                                <input id="txtENO_NM" name="txtENO_NM" size="8" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                                <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                            </td>
							<td align="center" class="creamBold">�Ҽ�</td>
							<td class="padding2423" align="left">
								<input type="hidden" id="hidDPT_CD" name="hidDPT_CD">
								<input id="txtDPT_NM" name="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">ī���ȣ</td>
							<td class="padding2423" align="left">
								<input id="txtRSTR_CD" size="6">
							</td>
							<td align="center" class="creamBold">�Ⱓ������</td>
							<td class="padding2423">
								<input type="text" id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);setEndYmd('txtSTR_YMD','txtEND_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD','','622','98');"></a>
								~
								<input type="text" id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10">
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td class="paddingTop8" colspan="10"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> �Ĵ��̿� ���</td>
				</tr>
				<tr>
					<td colspan="10">
					<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="30"></col>
							<col width="130"></col>
							<col width="30"></col>
							<col width="130"></col>
							<col width="30"></col>
							<col width="130"></col>
							<col width="30"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="center" class="creamBold" colspan="2">����</td>
							<td align="center" class="creamBold" colspan="2">�߽�</td>
							<td align="center" class="creamBold" colspan="2">����</td>
							<td align="center" class="creamBold" colspan="2">�Ѱ�</td>
						</tr>
						<tr>
							<td align="center" class="creamBold">��</td>
							<td align="center" class="creamBold">�ݾ�</td>
							<td align="center" class="creamBold">��</td>
							<td align="center" class="creamBold">�ݾ�</td>
							<td align="center" class="creamBold">��</td>
							<td align="center" class="creamBold">�ݾ�</td>
							<td align="center" class="creamBold">��</td>
							<td align="center" class="creamBold">�ݾ�</td>
						</tr>
						<tr>
							<td class="padding2423" align="left">
								<input id="txtMRN_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" onKeypress="cfNumberCheck();" onFocusout="fnc_cntSum()">
							</td>
							<td class="padding2423" align="left">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medMRN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=6>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">��</td>
								</tr>
							</table>
							</td>
							<td class="padding2423" align="left">
								<input id="txtAFN_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" onKeypress="cfNumberCheck();" onFocusout="fnc_cntSum()">
							</td>
							<td class="padding2423" align="left">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medAFN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=6>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">��</td>
								</tr>
							</table>
							</td>
							<td class="padding2423" align="left">
								<input id="txtEVN_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" onKeypress="cfNumberCheck();" onFocusout="fnc_cntSum()">
							</td>
							<td class="padding2423" align="left">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medEVN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=6>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">��</td>
								</tr>
							</table>
							</td>
							<td class="padding2423" align="left">
								<input id="txtTOT_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" onKeypress="cfNumberCheck();">
							</td>
							<td class="padding2423" align="left">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medTOT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=6>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
											<param name=ReadOnly				value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">��</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
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
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                        <td width="80" style="padding-right:5px; padding-top:2px;">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('wele010.xls', '<%=FILEURL %>/wele010.xls');"></a>
                        </td>
	                    <td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                        </td>
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
					<object id="grdT_WL_DININGUSE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_WL_DININGUSE">
						<param name="Editable" value="false">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="N0"			align=center	value={String(Currow)}</C>
							<C> id="STR_YMD"	width=100	name="������"			align=center	Edit=none	Show=false</C>
							<C> id="END_YMD"	width=100	name="������"			align=center	Edit=none	Show=false</C>
							<C> id="DPT_CD"		width=60	name="�Ҽ��ڵ�"		align=center	Edit=none	Show=false</C>
							<C> id="DPT_NM"		width=105	name="�Ҽ�"			align=left		Edit=none	Leftmargin="10"</C>
							<C> id="ENO_NM"		width=60	name="����"			align=center	Edit=none</C>
							<C> id="RSTR_CD"	width=60	name="ī���ȣ"		align=center	Edit=none</C>
							<C> id="ENO_NO"		width=60	name="���"			align=center	Edit=none</C>
							<C> id="MRN_CNT"	width=40	name="���ļ�"			align=right		Edit=none	Rightmargin="10"</C>
							<C> id="MRN_AMT"	width=70	name="���ıݾ�"		align=right		Edit=none	Rightmargin="10"</C>
							<C> id="AFN_CNT"	width=40	name="�߽ļ�"			align=right		Edit=none	Rightmargin="10"</C>
							<C> id="AFN_AMT"	width=70	name="�߽ıݾ�"		align=right		Edit=none	Rightmargin="10"</C>
							<C> id="EVN_CNT"	width=40	name="���ļ�"			align=right		Edit=none	Rightmargin="10"</C>
							<C> id="EVN_AMT"	width=70	name="���ıݾ�"		align=right		Edit=none	Rightmargin="10"</C>
							<C> id="TOT_CNT"	width=40	name="�ѽļ�"			align=right		Edit=none	Rightmargin="10"</C>
							<C> id="TOT_AMT"	width=70	name="�ѱݾ�"			align=right		Edit=none	Rightmargin="10"</C>
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

	<!-- T_WL_DININGUSE ���� ���̺� -->
	<object id="bndT_WL_DININGUSE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_DININGUSE">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=RSTR_CD		Ctrl=txtRSTR_CD		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=STR_YMD		Ctrl=txtSTR_YMD		Param=value</C>
			<C>Col=END_YMD		Ctrl=txtEND_YMD		Param=value</C>
			<C>Col=MRN_CNT		Ctrl=txtMRN_CNT		Param=value</C>
			<C>Col=MRN_AMT		Ctrl=medMRN_AMT		Param=Text</C>
			<C>Col=AFN_CNT		Ctrl=txtAFN_CNT		Param=value</C>
			<C>Col=AFN_AMT		Ctrl=medAFN_AMT		Param=Text</C>
			<C>Col=EVN_CNT		Ctrl=txtEVN_CNT		Param=value</C>
			<C>Col=EVN_AMT		Ctrl=medEVN_AMT		Param=Text</C>
			<C>Col=TOT_CNT		Ctrl=txtTOT_CNT		Param=value</C>
			<C>Col=TOT_AMT		Ctrl=medTOT_AMT		Param=Text</C>
		">
	</object>