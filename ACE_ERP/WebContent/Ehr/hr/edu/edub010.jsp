	<!--*************************************************************************
	* @source      : edub010.jsp												*
	* @description : ���м������� PAGE 										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/26            ä����          	        �����ۼ�			    *
	* 2006/04/18            ���м�          	        �μ��߰�
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>
<html>
<head>
	<title>���м�������(edub010)</title>
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

		var btnList = 'TTTTTFTT';
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.edu.b.edub010.cmd.EDUB010CMD";

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
            disableInput();

			var PRO_YMD_STDT_SHR  = document.getElementById("txtPRO_YMD_STDT_SHR").value;
			var PRO_YMD_ENDT_SHR  = document.getElementById("txtPRO_YMD_ENDT_SHR").value;
			var ENO_NO_SHR  = document.getElementById("txtENO_NO_SHR").value;
			var SBJ_CD_SHR  = document.getElementById("cmbSBJ_CD_SHR").value;
			var JOB_CD_SHR  = document.getElementById("txtJOB_CD_SHR").value;
			var DPT_CD_SHR  = document.getElementById("txtDPT_CD_SHR").value;


			// ���ñⰣ FROM���ڿ� TO���� ��
            if(PRO_YMD_STDT_SHR != '' && PRO_YMD_ENDT_SHR != '') {
                if(removeChar(PRO_YMD_STDT_SHR,'-') > removeChar(PRO_YMD_ENDT_SHR,'-')) {
                    alert("���ñⰣ FROM���ڴ� �ݵ�� ���ñⰣ TO���ں��� �۾ƾ��մϴ�.");
                    document.getElementById("txtPRO_YMD_STDT_SHR").focus();
                    return false;
                }
            }

            dsT_CM_EXAMINATION.UseChangeInfo = true;
			dsT_CM_EXAMINATION.dataid = dataClassName+"&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR+"&PRO_YMD_STDT_SHR="+PRO_YMD_STDT_SHR+"&PRO_YMD_ENDT_SHR="+PRO_YMD_ENDT_SHR+"&SBJ_CD_SHR="+SBJ_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR;
			dsT_CM_EXAMINATION.reset();
        }

        /**
         * EXCEL ��� ������ ���ε� ��Ű�� DS�� �߰� ���Ѽ� ��������
         */
        function fnc_FileUpload() {

            //file�� binding ��Ų��.
            if(!bindingFile())
                return;

            //���ε� �ϱ� ���� ��ȸ�� ������ �ʱ�ȭ ��Ų��.
            fnc_Clear();

            //ds���� ���� ���ε�
            trFILE_UPLOAD.KeyValue = "TR_FILE"
                                   + "(I:dsFILE_UPLOAD=dsFILE_UPLOAD"                   //���ε��� ����
                                   + ",O:dsT_CM_EXAMINATION=dsT_CM_EXAMINATION"         //��� ����Ʈ
                                   + ",O:dsRESULT=dsRESULT"
                                   + ")";

            trFILE_UPLOAD.action = dataClassName+"&S_MODE=ULD";
            trFILE_UPLOAD.post();
        }

        /**
         * DataSet �� FILE �� ���ε� ��Ų��.
         */
        function bindingFile() {
            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** �����ִ� ���� �б� */

            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            return true;
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
			if ( !fnc_SaveItemCheck() ) {
				return;
			}
			// save
			trT_CM_EXAMINATION.KeyValue = "tr01(I:dsT_CM_EXAMINATION=dsT_CM_EXAMINATION, O:dsRESULT=dsRESULT)";
			trT_CM_EXAMINATION.action = "/servlet/GauceChannelSVL?cmd=hr.edu.b.edub010.cmd.EDUB010CMD&S_MODE=SAV";
			trT_CM_EXAMINATION.post();
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
			var PRO_YMD_STDT_SHR = document.getElementById("txtPRO_YMD_STDT_SHR").value;
			var PRO_YMD_ENDT_SHR = document.getElementById("txtPRO_YMD_ENDT_SHR").value;
			var ENO_NO_SHR       = document.getElementById("txtENO_NO_SHR").value;
			var SBJ_CD_SHR       = document.getElementById("cmbSBJ_CD_SHR").value;
			var JOB_CD_SHR       = document.getElementById("txtJOB_CD_SHR").value;
			var DPT_CD_SHR       = document.getElementById("txtDPT_CD_SHR").value;

            var url = "edub010_PV.jsp?ENO_NO_SHR="+ENO_NO_SHR+"&PRO_YMD_STDT_SHR="+PRO_YMD_STDT_SHR+"&PRO_YMD_ENDT_SHR="+PRO_YMD_ENDT_SHR+"&SBJ_CD_SHR="+SBJ_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&TTL_AVR_SHR=&CHECK4=";
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CM_EXAMINATION.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CM_EXAMINATION.GridToExcel("���м�������", '', 225)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_CM_EXAMINATION.CountColumn == 0) {
				dsT_CM_EXAMINATION.setDataHeader("ENO_NO:STRING, ENO_NM:STRING, DPT_CD:STRING, DPT_NM:STRING, JOB_NM:STRING, HIR_YMD:STRING, RET_YMD:STRING, CET_NO:STRING, SBJ_NM:STRING, PRO_YMD:STRING, OCC_CD:STRING, INT_NAM:STRING, SBJ_CD:STRING, SBJ_LSN:DECIMAL(5.2), SBJ_RED:DECIMAL(5.2), SBJ_SPC:DECIMAL(5.2), SBJ_VOC:DECIMAL(5.2), SBJ_IPT:DECIMAL(5.2), SBJ_TOT:DECIMAL(5.2), SBJ_ETC:DECIMAL(5.2), TTL_AVR:DECIMAL(5.2), GRADE:STRING, SBJ_AMT:STRING, REMARK:STRING");
			}

			enableInput();
            fnc_EnableElementAll(enoElementList);   //������� �Է°����ϰ�

			dsT_CM_EXAMINATION.AddRow();
			document.form1.cmbSBJ_CD.selectedIndex      = 0;

            document.getElementById("txtENO_NO").focus();
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
	        if (dsT_CM_EXAMINATION.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "�����     = "+dsT_CM_EXAMINATION.nameValue(dsT_CM_EXAMINATION.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "��������  = "+dsT_CM_EXAMINATION.nameValue(dsT_CM_EXAMINATION.RowPosition, "PRO_YMD")+"\n";
            	tmpMSG += "�����ڵ�  = "+dsT_CM_EXAMINATION.nameValue(dsT_CM_EXAMINATION.RowPosition, "SBJ_CD")+"\n";

	            if( confirm(tmpMSG) ){
					var ENO_NO = dsT_CM_EXAMINATION.nameValue(dsT_CM_EXAMINATION.RowPosition, "ENO_NO");
					var PRO_YMD  = dsT_CM_EXAMINATION.nameValue(dsT_CM_EXAMINATION.RowPosition, "PRO_YMD");

					dsT_CM_EXAMINATION.DeleteRow(dsT_CM_EXAMINATION.RowPosition);

					// �Ķ���� �߰�
					trT_CM_EXAMINATION.Parameters = "ENO_NO="+ENO_NO+",PRO_YMD="+PRO_YMD;

					trT_CM_EXAMINATION.KeyValue = "tr02(I:dsT_CM_EXAMINATION=dsT_CM_EXAMINATION)";
					trT_CM_EXAMINATION.action = "/servlet/GauceChannelSVL?cmd=hr.edu.b.edub010.cmd.EDUB010CMD&S_MODE=DEL";
					trT_CM_EXAMINATION.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {

  			disableInput();
	        document.getElementById("resultMessage").innerText = ' ';

			// �޺��ڽ� �⺻ ����
			document.form1.cmbSBJ_CD.selectedIndex      = 0;
			document.form1.cmbSBJ_CD_SHR.selectedIndex  = 0;

        	dsT_CM_EXAMINATION.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CM_EXAMINATION.IsUpdated)  {
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
         	if ( !dsT_CM_EXAMINATION.isUpdated && dsT_CM_EXAMINATION.UseChangeInfo) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			// �������� ���� �޺��ڽ� ����(�Է�)
			for( var i = 1; i <= dsT_CM_COMMON_M1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_M1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_M1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbSBJ_CD").add(oOption);
			}

			// �������� ���� �޺��ڽ� ����(�˻�)
			for( var i = 1; i <= dsT_CM_COMMON_M1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_M1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_M1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbSBJ_CD_SHR").add(oOption);
			}

			cfStyleGrid(form1.grdT_CM_EXAMINATION,15,"false","false");      // Grid Style ����
			disableInput();
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		function fnc_CheckDate(){

            var PRO_YMD = document.getElementById("txtPRO_YMD").value.replace("-","").replace("-","");
            var today = getToday().replace("-","").replace("-","");

            if(PRO_YMD != ""){
	            if(PRO_YMD >= today){
	                alert("���纸�� �̷��� �������� ����Ҽ� �����ϴ�.");
	                document.getElementById("txtPRO_YMD").value = "";
	                document.getElementById("txtPRO_YMD").focus();
	                return false;
	            }
	       }
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}


        //�Է��ʵ� ����Ʈ
        var elementList = new Array(     "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"
                                        ,"txtPRO_YMD"
                                        ,"imgPRO_YMD"
                                        ,"cmbSBJ_CD"
                                        ,"txtSBJ_LSN"
                                        ,"txtSBJ_RED"
                                        ,"txtSBJ_SPC"
                                        ,"txtSBJ_VOC"
                                        ,"txtSBJ_IPT"
                                        ,"txtSBJ_TOT"
                                        ,"txtSBJ_ETC"
                                        ,"txtINT_NAM"
                                        ,"txtGRADE"
                                        ,"medSBJ_AMT"
                                        ,"txtREMARK"
                                    );

        //����Է��ʵ� ����Ʈ
        var enoElementList = new Array(  "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"
                                      );

         /********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){
  		 	fnc_EnableElementAll(elementList, enoElementList);
  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){
  		 	fnc_DisableElementAll(elementList);
  		}

 		/********************************************
         * ���õ� ����� �ش��ϴ� ������� ��ȸ          		*
         ********************************************/
        function fnc_SearchInfo(){
			var ENO_NO = document.getElementById("txtENO_NO").value;
			if( ENO_NO == ""){	return;	}
			dsVI_T_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.edu.b.edub010.cmd.EDUB010CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO;
			dsVI_T_PERSON.reset();
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
            obj = fnc_GetEnoNm('txtENO_NO');
            fnc_ClearInputFieldAll(new Array("txtENO_NO"));
            if(document.getElementById("txtENO_NO").value != "") {

                document.getElementById("txtENO_NM" ).value = obj.eno_nm;
                document.getElementById("hidDPT_CD" ).value = obj.dpt_cd;
                document.getElementById("txtDPT_NM" ).value = obj.dpt_nm;
                document.getElementById("hidJOB_CD" ).value = obj.job_cd;
                document.getElementById("txtJOB_NM" ).value = obj.job_nm;
                document.getElementById("hidOCC_CD" ).value = obj.occ_cd;
                document.getElementById("txtOCC_NM" ).value = obj.occ_nm;
                document.getElementById("txtCET_NO" ).value = obj.cet_no;
                document.getElementById("txtHIR_YMD").value = obj.hirg_ymd;
                document.getElementById("txtRET_YMD").value = obj.ret_ymd;
            }
        }

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup("txtENO_NO");

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }

		/********************************************
         * TTL_AVR �հ豸�ؼ� �ֱ�	 					*
         ********************************************/
		function fnc_sbjSum(){
			var sbj_lsn = document.form1.txtSBJ_LSN.value;
			var sbj_red = document.form1.txtSBJ_RED.value;
			var sbj_spc = document.form1.txtSBJ_SPC.value;
			var sbj_voc = document.form1.txtSBJ_VOC.value;
			var sbj_ipt = document.form1.txtSBJ_IPT.value;
			var sbj_tot = document.form1.txtSBJ_TOT.value;
			var sbj_etc = document.form1.txtSBJ_ETC.value;

			if( sbj_lsn == "" ){ sbj_lsn = 0; }
			if( sbj_red == "" ){ sbj_red = 0; }
			if( sbj_spc == "" ){ sbj_spc = 0; }
			if( sbj_voc == "" ){ sbj_voc = 0; }
			if( sbj_ipt == "" ){ sbj_ipt = 0; }
			if( sbj_tot == "" ){ sbj_tot = 0; }
			if( sbj_etc == "" ){ sbj_etc = 0; }

			var sbjSum = eval( sbj_lsn+"+"+sbj_red+"+"+sbj_spc+"+"+sbj_voc+"+"+sbj_ipt+"+"+sbj_tot+"+"+sbj_etc )+"";

			document.form1.txtTTL_AVR.value = sbjSum;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EXAMINATION)			   |
    | 3. ���Ǵ� Table List(T_CM_EXAMINATION) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_EXAMINATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �������� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_M1"/>
       <jsp:param name="CODE_GUBUN"    value="M1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='÷������'>
        <param name="Enable"    value="true">
    </object>

    <!-----------------------------------------------------+
    | 1. FILE UPLOAD��  Data Transacton                       |
    +------------------------------------------------------>
    <Object ID="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton                          |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_EXAMINATION)               |
    | 3. ���Ǵ� Table List(T_CM_EXAMINATION)                 |
    +------------------------------------------------------>
    <Object ID="trT_CM_EXAMINATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <Param Name=KeyValue Value="sample_tr01(O:dsT_CM_EXAMINATION=dsT_CM_EXAMINATION,I:dsT_CM_EXAMINATION=dsT_CM_EXAMINATION)">
    </Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_CM_EXAMINATION Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_EXAMINATION.CountRow);

			enableInput();

            document.getElementById("txtPRO_YMD").readOnly = true;
            document.getElementById("txtPRO_YMD").className = "input_ReadOnly";

  			document.getElementById("ImgEnoNo").disabled   = true;   // ���ã��
  			document.getElementById("imgPRO_YMD").disabled = true;   // ��������
        }
    </Script>

   	<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			alert("�ش����� ������ �����ϴ�.");
		} else {
			// ��� ���� ����
			document.form1.hidOCC_CD.value  = dsVI_T_PERSON.NameValue(0,"OCC_CD");
			document.form1.txtOCC_NM.value  = dsVI_T_PERSON.NameValue(0,"OCC_NM");
			document.form1.txtCET_NO.value  = dsVI_T_PERSON.NameValue(0,"CET_NO");
			document.form1.txtHIR_YMD.value = dsVI_T_PERSON.NameValue(0,"HIR_YMD");
			document.form1.txtRET_YMD.value = dsVI_T_PERSON.NameValue(0,"RET_YMD");
        }
    </Script>

   	<Script For=dsRESULT Event="OnLoadCompleted(iCount)">
		if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowPopup("���м������� ���� ��� ���", dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>




	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_CM_EXAMINATION Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<Script For=dsT_TACCCOD_BK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<Script For=dsFILE_UPLOAD Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_EXAMINATION Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_CM_EXAMINATION event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<script for=trFILE_UPLOAD event="OnSuccess()">
		dsT_CM_EXAMINATION.UseChangeInfo = "false";
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_CM_EXAMINATION event="OnFail()">
        cfErrorMsg(this);
    </script>

	<script for=trFILE_UPLOAD event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_CM_EXAMINATION event=CanRowPosChange(row)>
		if ( dsT_CM_EXAMINATION.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_CM_EXAMINATION.GetHdrDispName('-3','ENO_NO') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_CM_EXAMINATION.NameValue(row,"PRO_YMD") == "" ) {
			alert("[ " + grdT_CM_EXAMINATION.GetHdrDispName('-3','PRO_YMD') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���м�������</td>
					<td align="right" class="navigator">HOME/���а���/<font color="#000000">���м�������</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"   onClick="fnc_SearchList()"  ><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle"    ></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"   onClick="fnc_AddNew()"      ><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle"    ></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"       onClick="fnc_Save()"        ><img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle"      ></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"   onClick="fnc_Clear()"       ><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle"    ></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"     onClick="fnc_ToExcel()"     ><img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle"     ></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"   onClick="fnc_Delete()"      ><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle"    ></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"     onClick="fnc_Print()"       ><img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle"     ></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"       onClick="fnc_Exit()"        ><img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle"      ></a>
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
                            <col width="250"></col>
                            <col width="70"></col>
                            <col width="180"></col>
                            <col width="70"></col>
                            <col width="*"></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">���ñⰣ</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtPRO_YMD_STDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtPRO_YMD_STDT_SHR', 'txtPRO_YMD_ENDT_SHR')">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtPRO_YMD_STDT_SHR','','100','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                 ~
                                <input type="text" id="txtPRO_YMD_ENDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtPRO_YMD_STDT_SHR', 'txtPRO_YMD_ENDT_SHR')">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtPRO_YMD_ENDT_SHR','','215','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                            </td>
                            <td class="searchState" align="right">��������</td>
                            <td class="padding2423" align="left" colspan="3">
                                <select id="cmbSBJ_CD_SHR" style="WIDTH: 50%" onChange="fnc_SearchList();">
                                    <option value="">���</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="searchState" align="right">���</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
                            </td>
                            <td class="searchState" align="right">�ҼӺ�</td>
                            <td class="padding2423" align="left">
                                <input id="txtDPT_CD_SHR" size="3" maxlength="2"> <input id="txtDPT_NM_SHR" style="width:28%" class="input_ReadOnly"  readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
                            </td>
                            <td class="searchState" align="right">������</td>
                            <td class="padding2423" align="left">
                                <input id="txtJOB_CD_SHR" size="3" maxlength="2"> <input id="txtJOB_NM_SHR" style="width:28%" class="input_ReadOnly"  readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','����','A2')"></a>
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
			<col width="80"></col>
			<col width="160"></col>
			<col width="80"></col>
			<col width="120"></col>
			<col width="80"></col>
			<col width="120"></col>
			<col width="80"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">���</td>
			<td class="padding2423" align="left">
                <input id="txtENO_NO" name="txtENO_NO"  size="8"  maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onfocusout="fnc_SearchEmpNo()" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input id="txtENO_NM" name="txtENO_NM"  size="8"  maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onfocusout="fnc_SearchEmpNm()">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
			</td>
			<td align="center" class="creamBold">�ֹι�ȣ</td>
			<td class="padding2423"><input id="txtCET_NO" size="15" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">�Ҽ�</td>
			<td class="padding2423" colspan="3">
				<input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly>
				<input type="hidden" id="hidDPT_CD" size="10">
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423">
				<input id="txtJOB_NM" size="15" class="input_ReadOnly" readonly>
				<input type="hidden" id="hidJOB_CD" size="10">
			</td>
			<td align="center" class="creamBold">�ٷα���</td>
			<td class="padding2423">
				<input id="txtOCC_NM" size="15" class="input_ReadOnly" readonly>
				<input type="hidden" id="hidOCC_CD" size="10">
			</td>
			<td align="center" class="creamBold">�Ի���</td>
			<td class="padding2423"><input id="txtHIR_YMD" class="input_ReadOnly" size="10" style="ime-mode:disabled" readonly></td>
			<td align="center" class="creamBold">�����</td>
			<td class="padding2423"><input id="txtRET_YMD" class="input_ReadOnly" size="10" style="ime-mode:disabled" readonly></td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop8"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"><strong> ���л���</strong></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="90"></col>
			<col width="60"></col>
			<col width="90"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">��������</td>
			<td class="padding2423">
				<input type="text" id="txtPRO_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPRO_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgPRO_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtPRO_YMD','','85','172');"></a>
			</td>
			<td align="center" class="creamBold">�����ڵ�</td>
			<td class="padding2423">
				<select id="cmbSBJ_CD" style="width:100%" onchange="document.getElementById('txtSBJ_NM').value = this.options[this.selectedIndex].text">
                    <option></option>
                </select>
                <input type="hidden" id="txtSBJ_NM" name="txtSBJ_NM" >
			</td>
			<td align="center" class="creamBold">û��</td>
			<td class="padding2423">
                <input id="txtSBJ_LSN" style="ime-mode:disabled" size="10" maxLength="4" onblur="fnc_sbjSum()" onkeypress="cfCheckNumber();">
            </td>
			<td align="center" class="creamBold">�ʱ�</td>
			<td class="padding2423">
                <input id="txtSBJ_RED" style="ime-mode:disabled" size="10" maxLength="4" onblur="fnc_sbjSum()" onkeypress="cfCheckNumber();">
            </td>
			<td align="center" class="creamBold">���ϱ�</td>
			<td class="padding2423">
                <input id="txtSBJ_SPC" style="ime-mode:disabled" size="10" maxLength="4" onblur="fnc_sbjSum()" onkeypress="cfCheckNumber();">
            </td>
		</tr>
        <tr>
		    <td align="center" class="creamBold">����</td>
			<td class="padding2423">
                <input id="txtSBJ_VOC" style="ime-mode:disabled" size="10" maxLength="4" onblur="fnc_sbjSum()" onkeypress="cfCheckNumber();">
            </td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423">
                <input id="txtSBJ_IPT" style="ime-mode:disabled" size="10" maxLength="4" onblur="fnc_sbjSum()" onkeypress="cfCheckNumber();">
            </td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423">
                <input id="txtSBJ_TOT" style="ime-mode:disabled" size="10" maxLength="4" onblur="fnc_sbjSum()" onkeypress="cfCheckNumber();">
            </td>
			<td align="center" class="creamBold">��Ÿ</td>
			<td class="padding2423">
                <input id="txtSBJ_ETC" style="ime-mode:disabled" size="10" maxLength="4" onblur="fnc_sbjSum()" onkeypress="cfCheckNumber();">
            </td>
			<td align="center" class="creamBold">�հ�</td>
			<td class="padding2423">
                <input id="txtTTL_AVR" size="10" maxLength="4" class="input_ReadOnly" readonly>
            </td>
		</tr>
		<tr>
			<td align="center" class="creamBold">����ó</td>
			<td class="padding2423">
                <input id="txtINT_NAM" size="15" maxLength="22">
            </td>
			<td align="center" class="creamBold">�޼�</td>
			<td class="padding2423">
                <input id="txtGRADE" size="10" maxLength="10">
            </td>
			<td align="center" class="creamBold">���÷�</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="100%">
				<comment id="__NSID__"><object id="medSBJ_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
					<param name=Alignment				value=2>
					<param name=Border					value=true>
					<param name=ClipMode				value=true>
					<param name=DisabledBackColor		value="#EEEEEE">
					<param name=Enable					value=true>
					<param name=IsComma					value=true>
					<param name=Language				value=0>
					<param name=MaxLength				value=8>
					<param name=Numeric					value=true>
					<param name=NumericRange			value=0~+:0>
					<param name=ShowLiteral				value=false>
					<param name=Visible					value=true>
				</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">��</td>
			</tr>
			</table>
			<td align="center" class="creamBold">���</td>
			<td class="padding2423" colspan="3">
                <input id="txtREMARK" size="38" maxLength="30">
            </td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

	<!-- ��ȸ ���� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                        <td width="80" style="padding-right:5px; padding-top:2px;">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('edub010.xls', '<%=FILEURL %>/edub010.xls');"></a>
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
					<object id="grdT_CM_EXAMINATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:200px;">
						<param name="DataID" value="dsT_CM_EXAMINATION">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width="40"		name="NO"			align="center"	value={String(Currow)} Gte_ColumnType="Number:0:False" </C>
							<C> id="ENO_NM"			width="55"		name="����"			align="center"	Edit=none</C>
							<C> id="ENO_NO"			width="60"		name="���"			align="center"	Edit=none Gte_ColumnType="Number:0:False"</C>
							<C> id="OCC_NM"			width="100"		name="�ٷα���"			align="left"	Edit=none	Show="false"</C>
							<C> id="DPT_NM"			width="100"		name="�μ�"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="JOB_NM"			width="70"		name="����"			align="center"	Edit=none</C>
							<C> id="CET_NO"			width="90"		name="�ֹι�ȣ"		align="center"	Edit=none</C>
							<C> id="HIR_YMD"		width="70"		name="�Ի���"			align="center"	Edit=none</C>
							<C> id="RET_YMD"		width="70"		name="�����"			align="center"	Edit=none</C>
							<C> id="SBJ_CD"			width="30"		name="�ڵ�"			align="center"	Edit=none</C>
							<C> id="SBJ_NM"			width="70"		name="��������"		align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="SBJ_LSN"		width="40"		name="L/C"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="SBJ_RED"		width="40"		name="R/C"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="SBJ_SPC"		width="40"		name="���ϱ�"		    align="right"	Edit=none	RightMargin="10"</C>
							<C> id="SBJ_VOC"		width="40"		name="����"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="SBJ_IPT"		width="40"		name="����"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="SBJ_TOT"		width="40"		name="����"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="SBJ_ETC"		width="40"		name="��Ÿ"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="TTL_AVR"		width="50"		name="����"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="GRADE"			width="30"		name="�޼�"			align="center"	Edit=none</C>
							<C> id="SBJ_AMT"		width="80"		name="���÷�"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="INT_NAM"		width="100"		name="����ó"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="PRO_YMD"		width="70"		name="������"			align="center"	Edit=none</C>
							<C> id="REMARK"			width="130"		name="���"			align="left"	Edit=none	LeftMargin="10"</C>
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

	<!-- T_CM_EXAMINATION ���� ���̺� -->
	<object id="bndT_CM_EXAMINATION" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_CM_EXAMINATION">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO			Ctrl=txtENO_NO			Param=value</C>
			<C>Col=ENO_NM			Ctrl=txtENO_NM			Param=value</C>
			<C>Col=CET_NO			Ctrl=txtCET_NO			Param=value</C>
			<C>Col=OCC_NM			Ctrl=txtOCC_NM			Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM			Param=value</C>
			<C>Col=JOB_NM			Ctrl=txtJOB_NM			Param=value</C>
			<C>Col=HIR_YMD			Ctrl=txtHIR_YMD			Param=value</C>
			<C>Col=RET_YMD			Ctrl=txtRET_YMD			Param=value</C>
			<C>Col=SBJ_CD			Ctrl=cmbSBJ_CD			Param=value</C>
			<C>Col=SBJ_LSN			Ctrl=txtSBJ_LSN			Param=value</C>
			<C>Col=SBJ_RED			Ctrl=txtSBJ_RED			Param=value</C>
			<C>Col=SBJ_SPC			Ctrl=txtSBJ_SPC			Param=value</C>
			<C>Col=SBJ_VOC			Ctrl=txtSBJ_VOC			Param=value</C>
			<C>Col=SBJ_IPT			Ctrl=txtSBJ_IPT			Param=value</C>
			<C>Col=SBJ_TOT			Ctrl=txtSBJ_TOT			Param=value</C>
			<C>Col=SBJ_ETC			Ctrl=txtSBJ_ETC			Param=value</C>
			<C>Col=TTL_AVR			Ctrl=txtTTL_AVR			Param=value</C>
			<C>Col=GRADE			Ctrl=txtGRADE			Param=value</C>
			<C>Col=SBJ_AMT			Ctrl=medSBJ_AMT			Param=Text</C>
			<C>Col=PRO_YMD			Ctrl=txtPRO_YMD			Param=value</C>
			<C>Col=INT_NAM			Ctrl=txtINT_NAM			Param=value</C>
			<C>Col=REMARK			Ctrl=txtREMARK			Param=value</C>
		">
	</object>
