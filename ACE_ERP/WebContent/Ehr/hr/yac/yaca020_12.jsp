<!--
*****************************************************************************
* @source      : yaca020.jsp                                                     *
* @description : ���������ڷ��� PAGE                                        *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/03/23            ����ȣ             �����ۼ�                                         *
*----------------------------------------------------------------------------
* 2013/12/17            �̵���             ������                                             *
*****************************************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<%

    String ROLE_CD = box.getString("SESSION_ROLE_CD");
    String YAC_AUTHO  = box.getString("SESSION_YAC_AUTHO");
    String ENO_NO    = box.getString("SESSION_ENONO");

    //ROLE_CD�� IT���� ����
    boolean itMaster = false;

    if(ROLE_CD.equals("1001")) {
    	itMaster = true;
    }

    //���������� �ƴ��� ����
    boolean isMaster = false;

     if(YAC_AUTHO.equals("M")) {
         isMaster = true;
      }
    // ���� ����
    //boolean open_yn = false;

    //if(ENO_NO.equals("19511030")) {
    //   open_yn = true;
    //  }


%>

<html>
<head>
<title>���������ڷ���(yaca020)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<link href="/css/general2.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

<script language="javascript">
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "T"   //����
                    + "T"   //���
                    + "F"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "../../servlet/GauceChannelSVL?cmd=hr.yac.a.yaca020.cmd.YACA020CMD";
        var params = null;

        var dataClassName_01 = "../../servlet/GauceChannelSVL?cmd=hr.yac.a.yaca021.cmd.YACA021CMD";
        var params_01 = null;

		var submit_chk = "N";
		
        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {

            //�������� ��ȸ
            params = "&S_MODE=SHR"
                   + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                   + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;

            trT_AC_RETACC.KeyValue = "tr"
                                   + "(O:dsT_AC_RETACC=dsT_AC_RETACC"
                                   + ",O:dsT_AC_DUTYPLACE=dsT_AC_DUTYPLACE)";
            trT_AC_RETACC.action = dataClassName+params;
            trT_AC_RETACC.post();

            if(dsT_AC_RETACC.CountRow >= 1)
            {

    			if(dsT_AC_RETACC.NameValue(1, "CLS_TAG") == "Y" ){
    				document.getElementById("chkCLS_TAG").checked = true;
    			}else{
    				document.getElementById("chkCLS_TAG").checked = false;
    			}

            fnc_SearchList_01();
       
            document.getElementById("txtSALT_AMT").value  = dsT_AC_RETACC.NameValue(1, "SALT_AMT");
            document.getElementById("txtFREE_INCOME").value = dsT_AC_RETACC.NameValue(1, "FREE_INCOME");
            document.getElementById("txtTAX_INCOME").value = dsT_AC_RETACC.NameValue(1, "TAX_INCOME");
            document.getElementById("txtHOSPT_AMT").value  = dsT_AC_RETACC.NameValue(1, "HOSPT_AMT");
            document.getElementById("txtMIN_CARD_AMT").value  = dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT");

			if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" && submit_chk == "N"){

				fnc_disableInput();
				
			}else{

				fnc_enableInput();
				
			}

            return;
            
            }
            
        }

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)    								*
         ********************************************/
  		function fnc_disableInput(param){

			alert("���������� �����Դϴ�.\n������ �Ұ����մϴ�.");

			submit_chk = "Y";

			document.getElementById("chkPLA1").disabled = true;
			document.getElementById("chkPLA1").className = "input_ReadOnly";
			document.getElementById("chkPLA2").disabled = true;
			document.getElementById("chkPLA2").className = "input_ReadOnly";
			document.getElementById("chkPLA3").disabled = true;
			document.getElementById("chkPLA3").className = "input_ReadOnly";
			document.getElementById("txtADDRESS").disabled = true;
			document.getElementById("txtADDRESS").className = "input_ReadOnly";			
			
	  		//document.getElementById("txtENO_NO_SHR").className = "input_ReadOnly";
	  		//document.getElementById("txtENO_NO_SHR").disabled = true;
	  		//document.getElementById("txtENO_NM_SHR").className = "input_ReadOnly";
	  		//document.getElementById("txtENO_NM_SHR").disabled = true;

        }

        /********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)       								*
         ********************************************/
  		function fnc_enableInput(){

			document.getElementById("chkPLA1").disabled = false;
			document.getElementById("chkPLA1").className = "";
			document.getElementById("chkPLA2").disabled = false;
			document.getElementById("chkPLA2").className = "";
			document.getElementById("chkPLA3").disabled = false;
			document.getElementById("chkPLA3").className = "";

  		}

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {
                dsT_CM_COMMON_BK.DataID = dataClassName+"&S_MODE=ITM_SHR";
                dsT_CM_COMMON_BK.Reset();
        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {

            if(submit_chk == "Y"){

                alert("���������ϼ̽��ϴ�.\n����ڿ��� ���ǹٶ��ϴ�.");
                return;
            } 
            
            if(!fnc_SaveItemCheck()) return;

            //�λ���ǥ ����
            trT_CM_PERSON.KeyValue = "tr01(I:dsT_CM_PERSON=dsT_CM_PERSON)";
            trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SAV_01&ENO_NO="+document.getElementById("txtENO_NO").value+"&HEAD_CD="+document.getElementById("txtHEAD_CD").value+"&DPT_CD="+document.getElementById("txtDPT_CD").value;
            trT_CM_PERSON.post();

            //�������� ����
            params = "&S_MODE=SAV"
                   + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                   + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;

            //DataSet�� �Է»��·� ����
            dsT_AC_RETACC.UseChangeInfo = false;
            dsT_AC_DUTYPLACE.UseChangeInfo = false;

            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC"
                                       + ",I:dsT_AC_DUTYPLACE=dsT_AC_DUTYPLACE)";
            trT_AC_RETACC_SAV.action = dataClassName+params;
            trT_AC_RETACC_SAV.post();
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
			var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
			var PIS_YYMM = document.getElementById("txtPIS_YY_SHR").value;

			var url = "yaca020_PV.jsp?ENO_NO="+ENO_NO+"&PIS_YYMM=" + PIS_YYMM;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;
        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETACC.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETACC.GridToExcel("���������ڷ���", '', 225);
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
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_RETACC.ClearData();
            dsT_CM_PERSON.ClearData();
            dsT_AC_DUTYPLACE.ClearData();

            dsT_AC_FAMILY.ClearData();    //�ξ簡������ clear
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETACC.IsUpdated || dsT_CM_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
        }

        var chkList = new Array( "chkPLA1"
                                ,"chkPLA2"
                                ,"chkPLA3");

        var itemList = new Array("txtJAS_NM"
                                ,"txtJAO_NO"
                                ,"txtHIR_YMD"
                                ,"txtRET_YMD"
                                ,"txtJAA_AMT"
                                ,"txtJAC_AMT"
                                ,"txtJAI_AMT"
                                ,"txtJAG_AMT"
                                ,"txtJAQ_AMT"
                                ,"txtJAR_AMT"
                                ,"txtJAH_AMT"
                                ,"txtJAP_AMT"
                                ,"txtJAL_AMT"
                                ,"txtJAN_AMT");

        var itemMsgList = new Array("���θ�(ȸ���)"
                                ,"����ڵ�Ϲ�ȣ"
                                ,"���رٹ�������"
                                ,"���رٹ�������"
                                ,"�����޿��Ѿ�"
                                ,"�������Ѿ�"
                                ,"�������Ѿ�"
                                ,"������ҵ�"
                                ,"���ο��ݾ�"
                                ,"���ο����̿��ǿ��ݺ����"
                                ,"�ǰ������"
                                ,"��뺸���"
                                ,"�����ҵ漼"
                                ,"�����ֹμ�"
                                ,"���μ����ֿ���");

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {

            var oChkElement = null;
            var oElement = null;
            var chkVal   = null;

			if(dsT_AC_RETACC.NameValue(1, "HOL_YN") != "Y" && dsT_AC_RETACC.NameValue(1, "HOL_YN") != "N"){
				    alert("�ξ簡�� ȭ�鿡�� ���� ������ ���θ� ��� �� �ֽʽÿ�..");
			     	return false;
			}

            if (dsT_AC_RETACC.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                alert("* ���� �� �ڷᰡ �����ϴ�!");
                return false;
            }




            for(var i=0; i<chkList.length; i++) {
                oChkElement = document.getElementById(chkList[i]);

                if(oChkElement.checked) {
                    for(var j=0; j<itemList.length; j++) {
                        chkVal = oChkElement.value;

                        oElement = document.getElementById(itemList[j]+chkVal);

                        if(oElement.text == "" || oElement.value == "") {
                            alert(itemMsgList[j]+"��(��) �Է��ϼ���");
                            oElement.Enable = true;
                            oElement.focus();
                            return false;
                        }

                        // ������ CHECK
			            if (!fnc_CheckDate(document.getElementById("txtHIR_YMD"+chkVal), '���رٹ��Ⱓ ������') &&
			            	 document.getElementById("txtHIR_YMD"+chkVal).value != "") {
			                document.getElementById("txtHIR_YMD"+chkVal).focus();
			                return false;
			            }

			            // ������ CHECK
			            if (!fnc_CheckDate(document.getElementById("txtRET_YMD"+chkVal), '���رٹ��Ⱓ ������') &&
			            	 document.getElementById("txtRET_YMD"+chkVal).value != "") {
			                document.getElementById("txtRET_YMD"+chkVal).focus();
			                return false;
			            }

			            // ������ CHECK
			            if (document.getElementById("txtHIR_YMD"+chkVal).value.length != 10){
			                document.getElementById("txtHIR_YMD"+chkVal).focus();
			                alert("���رٹ��Ⱓ �������� ���Է��� �ֽʽÿ�.");
			                return false;
			            }

			            // ������ CHECK
			            if (document.getElementById("txtRET_YMD"+chkVal).value.length != 10){
			                document.getElementById("txtRET_YMD"+chkVal).focus();
			                alert("���رٹ��Ⱓ �������� ���Է��� �ֽʽÿ�.");
			                return false;
			            }

                    }
                }
            }
            return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {

            //����� �α����� ������� ������ ���� �⺻������ �����´�.
            document.getElementById("txtENO_NO_SHR").value = "<%=ls_UserId %>";

            if(today.substring(5,7) == '01' || today.substring(5,7) =='02'||today.substring(5,7) =='03' )
            {
              document.getElementById("txtPIS_YY_SHR").value =  today.substring(0,4)-1;
            }
            else
            {
              document.getElementById("txtPIS_YY_SHR").value = today.substring(0,4)-1;
            }

<%
    //�����ڰ� �ƴ� ��� Ÿ���� ��ȸ�� ���� �ʰ�
    if(!isMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "none";

            fnc_ChangeStateElement(false, "txtADDRESS");
            fnc_ChangeStateElement(false, "ImgZipNo");
            document.getElementById("ImgZipNo").style.display = "none";
			//document.getElementById("imgPrint").style.display = "none";

<%
    }
%>

			if(dsT_AC_RETACC.NameValue(1, "CLS_TAG") == "Y" ){
				document.getElementById("chkCLS_TAG").checked = true;
			}else{
				document.getElementById("chkCLS_TAG").checked = false;
			}
			
			if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" ){
				alert("���������� �����Դϴ�.\n������ �Ұ����մϴ�.");
			}

			//��������� �������� ����� �߰����� ����Ʈ�� �����´�.
            fnc_SearchEmpNo();

            //���� ���� ȭ���� ���� ���� ���̰� ����
            fnc_ClickBtn(1);

        	//fnc_SearchList();

            fnc_OnLoadProcess_01();



	            
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

        //���� ���ǵǾ� �ִ� �׸��
        var oElementList = new Array(    "txtPIS_YY"
                                        ,"cmbBNK_CD");

        //�׸���� �޼���
        var oElementMsgList = new Array( "���ؿ���"
                                        ,"����ȸ�籸��");

        //���� �׸��
        var oExceptionList = new Array(  );

        //Layer ID
        var layerList = new Array(  "layer_1"
                                   ,"layer_2"
                                   ,"layer_3"
                                   ,"layer_4"
                                   ,"layer_5"
                                   ,"layer_6"
                                   ,"layer_7"
                                   ,"layer_9"
                                   ,"layer_10"
                                   ,"layer_11"
                                    );


        /**
         * ������ â���� �����ְ� �ݴ� ��Ȱ
         */
        function fnc_ClickBtn(selectKey) {
            var indexKey;

            //Layer �����ְ� �ݱ�
            fnc_ShowHiddenLayer(layerList, layerList[parseInt(selectKey)-1]);


            //Tab �̹��� �����ְ� �ݱ� (���� ���ѿ� ���� �����ִ°Ͱ� �ƴѰ��� �޶���)
            for(var i=1; i<=10; i++) {
                indexKey = lpad(i, 2, "0");
                if(document.getElementById("TabBtn"+indexKey) == undefined) {
                    continue;
                }

                document.getElementById("TabLeft"+indexKey).src         = "/images/common/tabTop.gif";
                document.getElementById("TabBtn"+indexKey).background   = "/images/common/tabMiddle.gif";
                document.getElementById("TabBtn"+indexKey).className    = "tabV";
                document.getElementById("TabRight"+indexKey).src        = "/images/common/tabBottom.gif";
            }

            selectKey = lpad(selectKey, 2, "0");

            document.getElementById("TabLeft"+selectKey).src            = "/images/common/tabTop_over.gif";
            document.getElementById("TabBtn"+selectKey).background      = "/images/common/tabMiddle_over.gif";
            document.getElementById("TabBtn"+selectKey).className       = "tabV_over";
            document.getElementById("TabRight"+selectKey).src           = "/images/common/tabBottom_over.gif";

            fnc_SearchList();
        }


        /**
         * �������� �׸� ���� ����
         */
         
        function checkFamily(param) {

            if(dsT_AC_FAMILY.CountRow > 1) {
                alert("��ϵ� �ξ簡���� �´��� Ȯ�ιٶ��ϴ�.");
            }			

            var CLS_TAG;
            
            if(document.getElementById("chkCLS_TAG").checked == true) {
            	CLS_TAG = 'Y';
            }else{
            	CLS_TAG = 'N';
            }

            // �������� �׸� ���� ����� ���� üũ
     
            //�������� ����
            params = "&S_MODE=SAV_CLS"
                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
            		+ "&CLS_TAG="+CLS_TAG;
            
            //DataSet�� �Է»��·� ����
            dsT_AC_RETACC.UseChangeInfo = false;

            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
            trT_AC_RETACC_SAV.action = dataClassName+params;
            trT_AC_RETACC_SAV.post();
            
        }


        //�����ٹ����� ���õ� Element List
        var plaList = new Array( "txtJAO_NO"
                                ,"txtJAS_NM"
                                ,"txtHIR_YMD"
                                ,"txtRET_YMD");

        /**
         * �����ٹ��� ���� ���� ó�� ���� ����
         */
        function checkPlace(oPLA) {
            var seq_no  = oPLA.value;
            var chk_place = oPLA.checked;

            dsT_AC_DUTYPLACE.NameValue(1, "TYPE"+seq_no) = "X";

            //�Է�â Ȱ��, ��Ȱ���� ó��
            if(!chk_place) {
                if(!confirm("üũ�� �����Ͻø� �����ٹ���"+seq_no+" �ڷᰡ �����˴ϴ�.")) {
                    oPLA.checked = true
                    return;
                }
                dsT_AC_DUTYPLACE.NameValue(1, "TYPE"+seq_no) = "";
            }

            changePlace(seq_no, chk_place);
        }

        /**
         * �����ٹ��� ���� ��ȸ ���� ����
         */
        function changePlace(seq_no, checked) {

            document.getElementById("chkPLA"+seq_no).checked = checked;

            for(var i=0; i<plaList.length; i++) {
                fnc_ChangeStateElement(checked, plaList[i]+seq_no);
            }
			eval("form1.txtHIR_YMD"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtRET_YMD"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAA_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAC_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAG_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAI_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAQ_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAR_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAH_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAP_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAL_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAN_AMT"+seq_no+".Enable = '"+checked+"'");


            //����� �������Ƿ� �ּ�ó��
            /*
            if(checked == false){
	            for(var i=0; i<plaList.length; i++) {
	                document.getElementById(plaList[i]+seq_no).value = "";
	            }

	            eval("form1.txtJAA_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAC_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAG_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAI_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAQ_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAR_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAH_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAP_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAL_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAN_AMT"+seq_no+".text = '0'");
            }*/

        }

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
                //document.getElementById("txtOCC_NM_SHR").value      = obj.occ_cd+" "+obj.occ_nm;
                //document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                //document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;

            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
                //document.getElementById("txtOCC_NM_SHR").value      = "";
                //document.getElementById("txtDPT_NM_SHR").value      = "";
                //document.getElementById("txtJOB_NM_SHR").value      = "";
            }
        }

        function fnc_UsrpostPopup(zip_no, addr, addr2) {
            var no = document.getElementById(zip_no).value;

            fnc_postPopup(zip_no, addr);

            if (document.getElementById(zip_no).value != "") {
                if (document.getElementById(zip_no).value.substr(3,1) != '-') {
                    document.getElementById(zip_no).value = document.getElementById(zip_no).value.substr(0,3) + '-' + document.getElementById(zip_no).value.substr(3,3);
                }

                if (no != document.getElementById(zip_no).value) {
                    document.getElementById(addr2).value = '';

                    document.getElementById("txtADDRESS").focus();
                }


            }

        }

       function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');

       }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
        }



        /********************************************
         * 									��������                         				*
         ********************************************/

        function fnc_Submit() {

        	if(submit_chk == "N"){

	            if(confirm("�������� �Ͻø� ���̻� �����Ͻ� �� �����ϴ�.\n�����Ͻðڽ��ϱ�?")) {
	
	                //�������� ��������
	                params = "&S_MODE=SAV_END"
	                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
                   	    + "&SUBMIT_TAG=Y";		                   	
	            
		            //DataSet�� �Է»��·� ����
		            dsT_AC_RETACC.UseChangeInfo = false;
		
		            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
		                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
		            trT_AC_RETACC_SAV.action = dataClassName+params;
		            trT_AC_RETACC_SAV.post();
		
		            }
        	}else{

				alert("�̹� ���������ϼ̽��ϴ�.");

<%
//������ ���
if(isMaster) {
%>
		            if(confirm("������̽ñ���.\n���������� ����Ͻðڽ��ϱ�?")) {

		                //�������� �������� ���
		                params = "&S_MODE=SAV_END"
		                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
	                   	    + "&SUBMIT_TAG=N";		
                   	                
			            //DataSet�� �Է»��·� ����
			            dsT_AC_RETACC.UseChangeInfo = false;
			
			            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
			                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
			            trT_AC_RETACC_SAV.action = dataClassName+params;
			            trT_AC_RETACC_SAV.post();
		            	
					}
		            submit_chk = "N";
		            fnc_SearchList();
			
<%
}
%>
				return;
            }     	
    }
        
        /********************************************
         * �ξ簡������ �Լ�                        *
         ********************************************/

        /* 01. ��ȸ �Լ�_List ������ ��ȸ  */
        function fnc_SearchList_01() {
          //  var oPIS_YY = document.getElementById("txtPIS_YY");
          //  var oBNK_CD = document.getElementById("cmbBNK_CD");
           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;

            params_01 = "&S_MODE=SHR"
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO;

            dsT_AC_FAMILY.dataid = dataClassName_01+params_01;
            dsT_AC_FAMILY.reset();
         }


        /* 02. ���� �Լ�   */
        function fnc_Delete_01() {


            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
             if (dsT_AC_FAMILY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                alert("* ���� �� �ڷᰡ �����ϴ�!");
                return;
              }

             if(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "REL_NM") == "����"){
                alert("���� �ڷ�� ������ �� �����ϴ�.");
                return false;
             }

             // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
             if (confirm(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "NAM_KOR")+" [" + dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "CET_NO") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

             //DataSet�� �Է»��·� ����
             dsT_AC_FAMILY.UseChangeInfo = false;

             var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
             var ENO_NO = document.getElementById("txtENO_NO_SHR").value;

             var tmpCnt = dsT_AC_FAMILY.RowPosition-1;

             params_01 = "&S_MODE=DEL"
                     + "&PIS_YY="+PIS_YY
                     + "&ENO_NO="+ENO_NO
                     + "&ROW_ID="+tmpCnt;

             trT_AC_FAMILY.KeyValue = "TR_SAV(I:dsT_AC_FAMILY=dsT_AC_FAMILY)";
             trT_AC_FAMILY.Action = dataClassName_01+params_01;
             trT_AC_FAMILY.post();
             fnc_SearchList_01();
         }

         /* 03. �ʱ�ȭ �Լ�   */
          function fnc_Clear_01() {
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_FAMILY.ClearData();
          }

          /* 04.  Form Load �� Default �۾� ó�� �κ�    */
          function fnc_OnLoadProcess_01() {

            cfStyleGrid(form1.grdT_AC_FAMILY,0,"false","false");      // Grid Style ����

          }

          /* 05.  �ξ簡�����׵��   */
          function fnc_RegFamily() {

              if(submit_chk == "Y"){
                  alert("���������ϼ̽��ϴ�.\n����ڿ��� ���ǹٶ��ϴ�.");
                  return;
              }  

            var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
            var ENO_NO = document.getElementById("txtENO_NO_SHR").value;

            var href_page = "/hr/yac/yaca022.jsp"
                          + "?TYPE=INS"
                          + "&PIS_YY="+PIS_YY
                          + "&ENO_NO="+ENO_NO;

            window.showModalDialog(href_page, "", "dialogWidth:660px; dialogHeight:690px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList_01();
           }

           /* 06.  ��������������   */
          function fnc_RegPension() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "/hr/yac/yaca060.jsp"
                      + "?TAX_INCOME="+dsT_AC_RETACC.NameValue(1, "TAX_INCOME")
                      + "&HOSPT_AMT="+dsT_AC_RETACC.NameValue(1, "HOSPT_AMT")
                      + "&MIN_CARD_AMT="+dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT")
                      + "&PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&HOL_YN="+dsT_AC_RETACC.NameValue(1, "HOL_YN")
                      + "&END_YN="+submit_chk                      
           ;

            window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
           }


          /* 07.  �Ƿ��������   */
          function fnc_RegHospital() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "/hr/yac/yaca030.jsp"
                      + "?TAX_INCOME="+dsT_AC_RETACC.NameValue(1, "TAX_INCOME")
                      + "&HOSPT_AMT="+dsT_AC_RETACC.NameValue(1, "HOSPT_AMT")
                      + "&MIN_CARD_AMT="+dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT")
                      + "&PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&HOL_YN="+dsT_AC_RETACC.NameValue(1, "HOL_YN")
                      + "&END_YN="+submit_chk                          
           ;

            window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
           }
          
          /* 08.  ��αݰ������   */
          function fnc_RegDonation() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "/hr/yac/yaca040.jsp"
                      + "?TAX_INCOME="+dsT_AC_RETACC.NameValue(1, "TAX_INCOME")
                      + "&HOSPT_AMT="+dsT_AC_RETACC.NameValue(1, "HOSPT_AMT")
                      + "&MIN_CARD_AMT="+dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT")
                      + "&PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&HOL_YN="+dsT_AC_RETACC.NameValue(1, "HOL_YN")
                      + "&END_YN="+submit_chk                          
           ;

            window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
           }

    </script>
</head>

<!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETACC)                |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
<Object ID="dsT_CM_PERSON"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_RETACC"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_DUTYPLACE"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton               |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETACC)           |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
<Object ID="trT_AC_RETACC"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID="trT_CM_PERSON"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID="trT_AC_RETACC_SAV"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID ="trT_AC_RETACC_END" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
     <Param Name=KeyName     Value="toinb_dataid4">
     <Param Name=KeyValue    Value="SVL(I:SAV=dsT_AC_RETACC)">
</Object>
<!-----------------------------------------------------+
    | �ξ簡�� ����                                         |
    1 1. ��ȸ�� DataSet                                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_FAMILY)            |
    | 3. ���Ǵ� Table List(T_AC_FAMILY)                   |
    +------------------------------------------------------->
<Object ID="dsT_AC_FAMILY_OLD"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_FAMILY"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!-----------------------------------------------------+
    | �ξ簡�� ����                                        |
    1 1. �ڷ� ���� �� ��ȸ�� Data Transacton               |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_FAMILY)           |
    | 3. ���Ǵ� Table List(T_AC_FAMILY)                  |
    +------------------------------------------------------>
<Object ID="trT_AC_FAMILY"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
<Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            document.getElementById("resultMessage").innerText = "�ش� �ڷᰡ �������� �ʽ��ϴ�.";
            dsT_AC_RETACC.ClearData();
            dsT_CM_PERSON.ClearData();
            dsT_AC_DUTYPLACE.ClearData();

            dsT_AC_FAMILY.ClearData();    //�ξ簡������ clear

        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            document.getElementById("resultMessage").innerText = "�ش� �ڷḦ ��ȸ�߽��ϴ�.";

            //�λ���ǥ ��ȸ
            dsT_CM_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR_01&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            dsT_CM_PERSON.reset();

        }
    </Script>

<Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {

        } else {

        }
    </Script>

<Script For=dsT_AC_DUTYPLACE Event="OnLoadCompleted(iCount)">

//        alert(dsT_AC_DUTYPLACE.ColumnID(6)+", "+dsT_AC_DUTYPLACE.ColumnSize(6)+"\n"+
//              dsT_AC_DUTYPLACE.ColumnID(7)+", "+dsT_AC_DUTYPLACE.ColumnSize(7));

        //�����ٹ����ڷḦ ���� �ʱ�ȭ ��Ŵ
        for(var i=1; i<=3; i++) {
            changePlace(i, false);
        }

        for(var i=1; i<=3; i++) {
            if(dsT_AC_DUTYPLACE.NameString(1, "TYPE"+i) == "X") {
                changePlace(i, true);
            }
        }
    </Script>

<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
<Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

<Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
<Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

<Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

<!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
<script for=trT_AC_RETACC event="OnSuccess()">
        //radio ��ư�� �����ϱ�
        fnc_CheckedElement("radHOL_YN", dsT_AC_RETACC.NameValue(1, "HOL_YN"));
        fnc_CheckedElement("radSOU_YN", dsT_AC_RETACC.NameValue(1, "SOU_YN"));
        fnc_CheckedElement("radWCT_YN", dsT_AC_RETACC.NameValue(1, "WCT_YN"));
    </script>

<script for=trT_CM_PERSON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

<script for=trT_AC_RETACC_SAV event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("�۾��� �Ϸ� �Ͽ����ϴ�!");
        fnc_SearchList();
    </script>

<script for=trT_AC_RETACC_END event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("�۾��� �Ϸ� �Ͽ����ϴ�!");
        //fnc_SearchList();
    </script>
<!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
<script for=trT_AC_RETACC event="OnFail()">
        cfErrorMsg(this);
    </script>

<script for=trT_CM_PERSON event="OnFail()">
        cfErrorMsg(this);
    </script>

<script for=trT_AC_RETACC_SAV event="OnFail()">
        cfErrorMsg(this);
    </script>


<!-----------------------------------------------------+
    | Grid Head Check event ó��                                   |
    +------------------------------------------------------>
<script language="javascript" for=grdT_AC_RETACC
	event=OnHeadCheckClick(Col,Colid,bCheck)>
        for(var i=1; i<=dsT_AC_RETACC.CountRow; i++) {
            dsT_AC_RETACC.NameValue(i, "STATUS") = bCheck;
        }

    </script>

<script language=JavaScript for=txtGOV_AMT event=onKillFocus()>

        if(Number(form1.txtGOV_AMT.Text) >= 100000){
            form1.txtGOV_DED.Text = 100000;
        }else{
            form1.txtGOV_DED.Text = Number(form1.txtGOV_AMT.Text);
        }

    </script>

<script language=JavaScript for=txtGOV_NTS event=onKillFocus()>

        if(Number(form1.txtGOV_AMT.Text) >= 100000){
            form1.txtGOV_DED.Text = 100000;
        }else{
            form1.txtGOV_DED.Text = Number(form1.txtGOV_AMT.Text);
        }

    </script>


<!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>


<Script For=dsT_AC_FAMILY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_01");
        }
    </Script>

<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
<Script For=dsT_AC_FAMILY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
<Script For=dsT_AC_FAMILY Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

<!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
<script for=trT_AC_FAMILY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("�۾��� �Ϸ� �Ͽ����ϴ�!");

        fnc_SearchList();
    </script>

<!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
<script for=trT_AC_FAMILY event="OnFail()">
        cfErrorMsg(this);
    </script>


<!-----------------------------------------------------+
    | Grid OnDblClick event ó��                                   |
    +------------------------------------------------------>
<script language="javascript" for=grdT_AC_FAMILY
	event=OnDblClick(row,colid)>

        var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
        var ENO_NO = document.getElementById("txtENO_NO_SHR").value;


        var href_page = "/hr/yac/yaca022.jsp"
                      + "?TYPE=UPT"
                      + "&PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO")
                      + "&TAX_INCOME="+dsT_AC_RETACC.NameValue(1, "TAX_INCOME")
                      + "&HOSPT_AMT="+dsT_AC_RETACC.NameValue(1, "HOSPT_AMT")
                      + "&MIN_CARD_AMT="+dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT")
                      ;

        window.showModalDialog(href_page, "", "dialogWidth:660px; dialogHeight:690px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        fnc_SearchList();
    </script>

<!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15"
	marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"
	onload="fnc_OnLoadProcess();">
<!-- ���� ������ ���� -->
<iframe name="file_down" marginwidth="0" marginheight="0"
	frameborder="0" width="0" height="0" scrolling="no"></iframe>

<!-- Ķ���� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none"><iframe
	name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0"
	src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%"
	scrolling="no"></iframe></div>

<!-- form ���� -->
<form name="form1"><!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="23"><img src="/images/common/barHead.gif" width="23"
					height="25"></td>
				<td valign="top" background="/images/common/barGreenBg.gif"
					class="barTitle">���������ڷ���</td>
				<td align="right" class="navigator">HOME/���꼼��/��������/<font
					color="#000000">���������ڷ���</font></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� --> <!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
		
	 	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_submit.gif',1)">
		<img src="/images/button/btn_submit.gif" name="imgSave" width="100" height="20" border="0" align="absmiddle" onClick="fnc_Submit()"></a>			

		&nbsp;&nbsp;&nbsp;	
			
		<a href="http://www.yesone.go.kr/index.jsp" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgNts','','/images/button/btn_NtsOver.gif',1)">
		<img src="/images/button/btn_NtsOn.gif" name="imgNts" width="65" height="20" border="0" align="absmiddle"></a> &nbsp;&nbsp; 
			
		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)">
		<img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	 	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">
		<img src="/images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> 
        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">
		<img src="/images/button/btn_PrintOn.gif" name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> 
        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">
		<img src="/images/button/btn_ExitOn.gif" name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� --> <!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center" class="greenTable">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="200"></col>
						<col width="80"></col>
						<col width="140"></col>
						<col width=""></col>
					</colgroup>
					<tr>
						<td align="right" class="searchState">�ͼӳ⵵&nbsp;</td>
						<td class="padding2423">
						<%
						if (!isMaster) {
						%> <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="5"
							class="input_ReadOnly" readonly> <%
 } else {
 %> <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="5"> <%
 }
 %>
						</td>

						<td align="right" class="searchState">���&nbsp;</td>
						<td class="padding2423">
						
						<!--              <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()" style="ime-mode:disabled">
                                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                             --> 
                             <!--  
                             <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="8" onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}"
							onchange="fnc_GetNm();fnc_SearchList();"onblur="fnc_SearchList();" style="ime-mode:disabled"> 
							
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="14"onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}"
							onchange="fnc_Getcd();fnc_SearchList();"onblur="fnc_SearchList();"> 
							-->
							
                             <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="8" onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" style="ime-mode:disabled"> 
							
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="14"onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}"> 
														
							<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle"
							onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()"
							onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"style="cursor:hand;"> 
							
							<input type="hidden" id="hidEMPL_DPT_CD">
							</td>
					</tr>
					<!--
                                <tr>
                                    <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                    <td class="padding2423">
                                        <input id="txtOCC_NM_SHR" name="txtOCC_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                    <td class="padding2423">
                                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                    <td class="padding2423">
                                        <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                </tr>
                                 -->
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- power Search���̺� �� --> <!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="bottom" class="searchState"><span
					id="resultMessage">&nbsp;</span></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� --> <!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse" bordercolor="#999999"
			class="table_cream">
			<colgroup>
				<col width="40"></col>
				<col width="80"></col>
				<col width="40"></col>
				<col width="60"></col>
				<col width="55"></col>
				<col width="80"></col>
				<col width="40"></col>
				<col width=""></col>
			</colgroup>
			<tr>
				<!--  
				<td align="center" class="creamBold">����</td>
				<td class="padding2423"><input id="txtOCC_NM"
					style="width:100%;" class="input_ReadOnly" readonly></td>
				-->		
				<td align="center" class="creamBold">�Ҽ�</td>
				<td class="padding2423">
				<input id="txtDPT_NM" style="width:100%;" class="input_ReadOnly" readonly></td>
				<td align="center" class="creamBold">����</td>
				<td class="padding2423">
				<input id="txtJOB_NM" style="width:100%;" class="input_ReadOnly" readonly></td>
				<!--  
				<td align="center" class="creamBold">�ֹι�ȣ</td>
				<td class="padding2423">
				<input id="txtCET_NO" style="width:100%;" class="input_ReadOnly" readonly></td>
				-->
				<td align="center" class="creamBold">�����ȣ</td>
				<td class="padding2423">
				<input id="txtZIP_NO" size="7" maxlength="7" class="input_ReadOnly" readonly> 
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgZipNo','','/images/button/btn_HelpOver.gif',1)">
				<img src="/images/button/btn_HelpOn.gif" id="ImgZipNo" name="ImgZipNo" width="21" height="20" border="0" align="absmiddle"
					onClick="fnc_UsrpostPopup('txtZIP_NO','txtADR_CT','txtADDRESS')"></a>
				</td>
				<td align="center" class="creamBold">�ּ�</td>
				<td class="padding2423">
				<input id="txtADR_CT" style="width:45%" class="input_ReadOnly" readonly> 
					<input id="txtADDRESS" maxlength="60" style="width:45%"> 
					<input type=hidden id="txtENO_NO"> 
					<input type=hidden id="txtHEAD_CD"> 
					<input type=hidden id="txtDPT_CD">
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
		<td class="paddingTop5">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->



<table width="800" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td width="130" valign="top" style="padding:7 0 0 0"><!--tab���̺���� -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft01"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn01" onclick="fnc_ClickBtn(1)"
							style="cursor:hand;">�ξ簡������<font color = "blue">(�Է�)</font></td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight01"></td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft10"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn10" onclick="fnc_ClickBtn(10)"
							style="cursor:hand;">�����ٹ���<font color = "blue">(�Է�)</font></td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight10"></td>
					</tr>
				</table>
				</td>
			</tr>

			
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft11"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn11" onclick="fnc_RegHospital()"
							style="cursor:hand;">�Ƿ�����<font color = "blue">(�Է�)</font></td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight11"></td>
					</tr>
				</table>
				</td>
			</tr>			
						
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft11"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn11" onclick="fnc_RegDonation()"
							style="cursor:hand;">��αݰ���<font color = "blue">(�Է�)</font></td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight11"></td>
					</tr>
				</table>
				</td>
			</tr>			
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft11"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn11" onclick="fnc_RegPension()"
							style="cursor:hand;">����/���ø���/����ֽ�������<font color = "blue">(�Է�)</font></td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight11"></td>
					</tr>
				</table>
				</td>
			</tr>			
			
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30" style="cursor:hand;"></td>
					</tr>
				</table>
				</td>
			</tr>
						
			
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft02"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn02" onclick="fnc_ClickBtn(2)"
							style="cursor:hand;">��������</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight02"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft03"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn03" onclick="fnc_ClickBtn(3)"
							style="cursor:hand;">Ư������-�����</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight03"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft04"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn04" onclick="fnc_ClickBtn(4)"
							style="cursor:hand;">Ư������-�Ƿ��</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight04"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft05"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn05" onclick="fnc_ClickBtn(5)"
							style="cursor:hand;">Ư������-������</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight05"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft06"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn06" onclick="fnc_ClickBtn(6)"
							style="cursor:hand;">Ư������-�����ڱ�</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight06"></td>
					</tr>
				</table>
				</td>
			</tr>
			
			<!-- 
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="5" style="cursor:hand;"></td>
					</tr>
				</table>
				</td>
			</tr>
			
			 -->
			 
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft07"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn07" onclick="fnc_ClickBtn(7)"
							style="cursor:hand;">Ư������-��α�</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight07"></td>
					</tr>
				</table>
				</td>
			</tr>
	<!-- 		<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft08"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn08" onclick="fnc_ClickBtn(8)"
							style="cursor:hand;">Ư������-��Ÿ</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight08"></td>
					</tr>
				</table>
				</td>
			</tr>
	-->
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft08"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn08" onclick="fnc_ClickBtn(8)"
							style="cursor:hand;">��Ÿ�ҵ����</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight08"></td>
					</tr>
				</table>
				</td>
			</tr>
			
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30" style="cursor:hand;"></td>
					</tr>
				</table>
				</td>
			</tr>
						
			<tr>
				<td style="padding:0 0 3 0">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130"
							height="5" id="TabLeft09"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif"
							class="tabV" id="TabBtn09" onclick="fnc_ClickBtn(9)"
							style="cursor:hand;">���װ���</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"
							height="5" id="TabRight09"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<!--tab���̺� �� --></td>
		
		
		
		<td valign="top">
		<!-- Layer �� --> 
		<!--���� ������ ���� -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5" height="5"><img
					src="/images/common/arcGray01.gif" width="5" height="5"></td>
				<td background="/images/common/arcGray02.gif"></td>
				<td width="5" background="/images/common/arcGray03.gif"></td>
			</tr>
			<tr>
				<td width="5" background="/images/common/arcGray04.gif"></td>
				<!-- �ּ� ���̰� 350�� �Ǿ���մϴ�.���� �������ʿ� �����ϴ�. ������ ���� �ֱ� ������ -->
				<td height="520" valign="top" bgcolor="#FFFFFF" style="padding:15">


				<!-- �ξ簡������ -->
				<div id="layer_1"
					style="position:absolute; visibility:hidden; display:none; display:none; width:865px; z-index:1;">

				<!-- ��ư ���̺� ���� -->
				<table width="860" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="35" class="paddingTop1" align="left">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFamilyRegistration','','/images/common/btnFamilyRegistration.gif',1)">
						<img src="/images/common/btnFamilyRegistration.gif" name="imgFamilyRegistration" width="130" height="25" border="0" align="absmiddle" 
							onClick="fnc_RegFamily()">
						</a></td>
						<td height="35" class="paddingTop5" align="right">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)">
						<img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle"
							onClick="fnc_SearchList_01()">
						</a> 
					<!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)">
						<img src="/images/button/btn_CancelOn.gif" name="ImgClear" width="60" height="20" border="0" align="absmiddle"
							onClick="fnc_Clear_01()">
						</a> 
					-->		
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)">
						<img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle"
							onClick="fnc_Delete_01()">
						</a>
					<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit_01()"></a> -->
						</td>
					</tr>
				</table>
				<!-- ��ư ���̺� �� --> <!-- ��ȸ ���� ���̺� ���� -->
				<table width="860" border="0" cellspacing="0" cellpadding="0">

							<tr>
								<td align="right" valign="bottom" class="searchState">
									<input type="checkbox" name="chkCLS_TAG" id="chkCLS_TAG" onclick="checkFamily(this)" style="border:0">����
								</td>
					
								<td align="left" valign="bottom" class="searchState">
								<font color = "blue">
								���������� �׸��� ����� ������ ��쿡�� üũ
								</font>
								</td>
								<td align="right" valign="bottom" class="searchState">
								�ػ󼼳����� ���Ͻø� �ش系���� ����Ŭ��</td>
							</tr>
				</table>
				<!-- ��ȸ ���� ���̺� �� --> <!-- ���� ��ȸ �׸��� ���̺� ����-->
				<table width="860" border="0" cellspacing="0" cellpadding="0">

							<tr align="center">
								<td>
								<comment id="__NSID__"> 
								<object id="grdT_AC_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B"
									style="width:860px;height:435px;">
									<param name="DataID" 				value="dsT_AC_FAMILY">
									<param name="Editable" 			value="false">
									<param name="DragDropEnable" 	value="true">
									<param name="SortView" 			value="Left">
									<param name="Format"
										value='
                                          <FC> id=NO     			width=24        align=center       name=NO                suppress=2  </FC>
                                          <FC> id=REL_NM      	width=107      align=left	       name=����              	suppress=2  </FC>
                                          <FC> id=NAM_KOR     width=55        align=center       name=����              	suppress=2  </FC>
                                          <C> id=CET_NO       	width=95        align=center       name=�ֹι�ȣ          	suppress=2  </C>
                                          <C> id=BAS_MAN      	width=40        align=center       name="�⺻;����"      suppress=2  </C>
                                          <C> id=GOL_70       	width=40        align=center       name=���              	suppress=2  </C>
                                          <C> id=TRB_MAN      	width=40        align=center       name=�����            	suppress=2  </C>
                                          <C> id=WCT_MAN      width=40        align=center       name=�γ���            	suppress=2  </C>
                                          <C> id=RCH_MAN      	width=40        align=center       name="�ڳ�;����"      suppress=2  </C>
                                          <C> id=CHI_MAN      	width=40        align=center       name=���ڳ�            	suppress=2  </C>
                                          <C> id=INP_MAN      	width=40        align=center       name="���;�Ծ�"      suppress=2  </C>

                                          <C> id=GBN_NM       		width=70        align=center     name=����                </C>
                                          <C> id=LIN_AMT      		width=70        align=right        name=�����              </C>
                                          <C> id=MED_AMT      		width=70        align=right        name=�Ƿ��              show=false</C>
                                          <C> id=EDU_AMT      		width=70        align=right        name=������              </C>
                                          
                                          <G> name=�ſ�ī���    HeadBgColor=#F7DCBB                                          
                                          <C> id=CARD_AMT     		width=100       align=right        name="�ſ�ī��;(�����������)"   </C>
                                          <C> id=DIR_CARD_AMT 	width=100       align=right        name="����/����ī��;(�����������)"  </C>
                                          <C> id=SCH_AMT      		width=100       align=right        name="�п���;���γ���" </C>
                                          <C> id=CASH_AMT     	width=100       align=right        name="���ݿ�����;(�����������)"  </C>
                                          <C> id=MARKET_AMT     	width=100       align=right        name=���������   </C>
                                          </G>
                                                                                    
                                          <G> name=��α�     HeadBgColor=#F7DCBB
                                           <C> id=LC3_AMT      		width=70        align=right       name=������α�      show=false</C>
                                           <C> id=LC1_AMT      		width=70        align=right       name=Ư�ʱ�α�      show=false</C>
                                           <C> id=LC2_AMT      		width=70        align=right       name=������α�      show=false</C>
                                           <C> id=LC4_AMT      		width=70        align=right       name=������α�      show=false</C>
                                          </G>
                                          <G> name=�����ڱ�   HeadBgColor=#F7DCBB 
                                           <C> id=LH1_AMT      		width=120        align=right      name=�������������ݻ�ȯ  show=false</C>
                                           <C> id=LH2_AMT04    	width=120        align=right      name="��������������ھ�;(10��~15��)"  show=false</C>
                                           <C> id=LH2_AMT      		width=120        align=right      name="��������������ھ�;(15��~30��)"  show=false</C>
                                           <C> id=LH4_AMT      		width=120        align=right      name="��������������ھ�;(30���̻�)"  show=false</C>
                                          </G>
					                   	'>
								</object> </comment><script> __ShowEmbedObject(__NSID__); </script></td>
							</tr>

				</table>
				<!-- ���� ��ȸ �׸��� ���̺� ��-->
				</div>
				
				
				
				
				<!-- �����ٹ����ڷ� -->
				<div id="layer_11"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:10;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> �����ٹ����ڷ�</td>
						<td>
						-2012�� ��� �ٹ��Ͻ� ���� �ش���� �ʽ��ϴ�. �ߵ��Ի��ڸ� �ش�˴ϴ�.<br>
						-2012�� �����Ⱓ �߿� �ٹ������ �ִ� �����ٹ����� ���� �ڷ� �Է�</td>
					</tr>
					<tr>
						<td colspan="2" height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="120"></col>
						<col width="158"></col>
						<col width="158"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center"></td>
						<td class="padding2423">
						<input type="checkbox" name="chkPLA1" id="chkPLA1" value="1" style="border:0" onclick="checkPlace(this)">
						&nbsp;�����ٹ���1
						</td>
						<td class="padding2423">
						<input type="checkbox" name="chkPLA2" id="chkPLA2" value="2" style="border:0" onclick="checkPlace(this)">
						&nbsp;�����ٹ���2
						</td>
						<td class="padding2423">
						<input type="checkbox" name="chkPLA3" id="chkPLA3" value="3" style="border:0" onclick="checkPlace(this)">
						&nbsp;�����ٹ���3
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">���θ�(ȸ���)</td>
						<td class="padding2423"><input type="text" name="txtJAS_NM1"
							id="txtJAS_NM1" size="20" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAS_NM2"
							id="txtJAS_NM2" size="20" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAS_NM3"
							id="txtJAS_NM3" size="20" class="input_ReadOnly" readonly>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">����ڵ�Ϲ�ȣ</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO1"
							id="txtJAO_NO1" size="13" maxlength="12"
							style="text-align:right;" style="ime-mode:disabled"  onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO2"
							id="txtJAO_NO2" size="13" maxlength="12"
							style="text-align:right;" style="ime-mode:disabled" onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO3"
							id="txtJAO_NO3" size="13" maxlength="12"
							style="text-align:right;" style="ime-mode:disabled" onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" class="input_ReadOnly" readonly>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">���رٹ��Ⱓ</td>
						<td class="padding2423"><input type="text" name="txtHIR_YMD1"
							id="txtHIR_YMD1" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>&nbsp;~
							<input type="text" name="txtRET_YMD1"
							id="txtRET_YMD1" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtHIR_YMD2"
							id="txtHIR_YMD2" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>&nbsp;~
							<input type="text" name="txtRET_YMD2"
							id="txtRET_YMD2" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtHIR_YMD3"
							id="txtHIR_YMD3" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>&nbsp;~
							<input type="text" name="txtRET_YMD3"
							id="txtRET_YMD3" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">�����޿��Ѿ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAA_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAA_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAA_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">�������Ѿ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAC_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAC_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAC_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">�������Ѿ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAI_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAI_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAI_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">������ҵ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAG_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAG_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAG_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					 </tr>
					<tr>
						<td class="creamBold" align="center">���ο��ݺ����</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAQ_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAQ_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAQ_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">���ο����̿���<br>
						���ݺ����</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAR_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAR_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAR_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">�ǰ������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAH_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAH_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAH_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">��뺸���</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAP_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAP_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAP_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">�����ҵ漼</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAL_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAL_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAL_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">�����ֹμ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAN_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAN_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAN_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</div>
				<!-- �����ٹ����ڷ� -->				
				
				
				
				<!-- �ξ簡������ --> 
				<!-- �������� -->
				<div id="layer_2"
					style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
				<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<td class="tabTitle" valign="bottom"><img
							src="/images/common/arrowGreen.gif" width="8" height="15"
							align="absmiddle"> �⺻����</td>
						<!-- <td width="110"><img src="/images/common/btnFamily.gif" width="110" height="25" border="0" onclick="fnc_RegFamily()" style="cursor:hand;"></td> -->
					</tr>
					<tr>
						<td colspan="2" height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">���μ�����</td>
						<td class="padding2423">
						<input type="radio" name="radHOL_YN"
							id="radHOL_YN" style="border:0" value='Y' disabled>��
						&nbsp;&nbsp;<input type="radio" name="radHOL_YN" id="radHOL_YN"
							style="border:0" value='N' disabled>�ƴϿ�</td>
						</td>

						<td class="padding2423">-���� ������ ����</td>


					</tr>
					<tr>
						<td class="creamBold" align="center">����ڰ���</td>
						<td class="padding2423"><input type="radio" name="radSOU_YN"
							id="radSOU_YN" style="border:0" value="Y" disabled>��
						&nbsp;&nbsp;<input type="radio" name="radSOU_YN" id="radSOU_YN"
							style="border:0" value="N" disabled>�ƴϿ�</td>
						<td class="padding2423">-�����ҵ�ݾ��� 100���� ��������</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">�ξ簡������</td>
						<td class="padding2423" valign="top"><input type="text"
							name="txtDFM_CNT" id="txtDFM_CNT" size="3"
							style="text-align:right;" readonly class="input_ReadOnly">
						��</td>
						<td class="padding2423">-�ٷ��ڿ� ���踦 �����ϴ� �ξ簡������ ���ҵ� 100���� ����<br>
						-������� �������� ������ �����ҵ� 100���� �̳�<br>
						-�� 60���̻� (1952.12.31 ���� ���) ���� �Ǵ� <br>&nbsp;����� ��������<br>
						-�ڳ�/�Ծ��� �� 20������ (1992.1.1 ���� ���)<br>
						-��Ź�Ƶ��� ��� �� 18�� �̸� (1995.1.1 ���� ���)<br>
						-�� 20������ �Ǵ� �� 60���̻��� �����ڸ�<br>
						</td>
					</tr>
				</table>
				<br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> �߰�����</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center" rowspan="1" valign="top"
							style="padding-top:4px">��ο�����</td>
						<td class="padding2423"><input type="text"
							name="txtGOL_CNT70" id="txtGOL_CNT70" size="3"
							style="text-align:right;" readonly class="input_ReadOnly">
						��</td>
						<td class="padding2423">-�⺻��������ڷ� �� 70���̻� (1942.12.31 ���� ���)</td>
					</tr>
	<!--   				<tr>
	  					<td class="padding2423"><input type="text"
							name="txtGOL_CNT65" id="txtGOL_CNT65" size="3"
							style="text-align:right;" readonly class="input_ReadOnly">
						��</td>
						<td class="padding2423">-65���̻�(1943.12.31 ���� ���) 69�������� �������
						</td>
					</tr>
    -->
     				<tr>
						<td class="creamBold" align="center">����ΰ���</td>
						<td class="padding2423"><input type="text" name="txtTRB_CNT"
							id="txtTRB_CNT" size="3" style="text-align:right;" readonly
							class="input_ReadOnly"> ��</td>
						<td class="padding2423">-�⺻��������ڰ� ������� ���</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">�γ��ڰ���</td>
						<td class="padding2423"><input type="radio" name="radWCT_YN"
							id="radWCT_YN" style="border:0" value="Y" disabled>��
						&nbsp; <input type="radio" name="radWCT_YN" id="radWCT_YN"
							style="border:0" value="N" disabled>�ƴϿ�</td>
						<td class="padding2423">-�ξ簡���� �ִ� �γ��ڼ������̰ų� ����ڰ� �ִ� ����</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">�ڳ���������</td>
						<td class="padding2423"><input type="text" name="txtRCH_CNT"
							id="txtRCH_CNT" size="3" style="text-align:right;" readonly
							class="input_ReadOnly"> ��</td>
						<td class="padding2423">-�� 6������ (2006.01.01 ���� ���)�� �ڳฦ �� �ٷμҵ���
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">���ڳ��߰�����<br>
						(�ڳ��)</td>
						<td class="padding2423"><input type="text" name="txtCHI_CNT"
							id="txtCHI_CNT" size="3" style="text-align:right;" readonly
							class="input_ReadOnly"> ��</td>
						<td class="padding2423">-�� 20������ (1992.01.01 ���� ���) �ڳడ 2����
						��� <br>&nbsp;�� 100����, 2���� �ʰ��ϴ� ��� 1�δ� �� 200���� �߰�����</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">������Ծ����</td>
						<td class="padding2423"><input type="text" name="txtINP_CNT"
							id="txtINP_CNT" size="3" style="text-align:right;" readonly
							class="input_ReadOnly"> ��</td>
						<td class="padding2423">-2012�� ������ ��� �Ǵ� �Ծ�Ű� �Ծ��� (��Ź�Ƶ�����)</td>
					</tr>
				</table>
				</div>
				
				
				<!-- �������� --> 
				<!-- Ư������-����� -->
				<div id="layer_3"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:2;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> ���ݺ�������</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">���ο��ݺ����</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtNPEN_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<!-- <td class="padding2423" rowspan="2"> -->
						<td class="padding2423">-���ο���, ����������, ���ο��� �� �ٷ��� ���κδ��</td>
					</tr>
					<!--
                                <tr>
                                    <td class="creamBold" align="center">���ο����̿���<br>���ݺ����</td>
                                    <td class="padding2423">
                                        <table><tr>
                                        <td>
                                            <comment id="__NSID__">
                                            <object id="txtEPEN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                                                <param name=Alignment               value=2>
                                                <param name=Border                  value=true>
                                                <param name=ClipMode                value=true>
                                                <param name=DisabledBackColor       value="#EEEEEE">
                                                <param name=Enable                  value=true>
                                                <param name=IsComma                 value=true>
                                                <param name=Language                value=0>
                                                <param name=MaxLength               value=8>
                                                <param name=Numeric                 value=true>
                                                <param name=NumericRange            value=-~+:0>
                                                <param name=ShowLiteral             value=false>
                                                <param name=Visible                 value=true>
                                                <param name=SelectAll               value="true">
                                            </object>
                                            </comment>
                                            <script> __ShowEmbedObject(__NSID__); </script>
                                        </td>
                                        <td>��</td>
                                        </tr></table>
                                    </td>
                                </tr>
                                -->
				</table>
				<br>

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> Ư������-�����</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">���ΰǰ������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtHINU_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�޿����� ��õ¡���� ���ΰǰ������</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">��������纸���</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtOLD_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-��������纸����� ���� �ٷ��ڰ� �δ��ϴ� �����</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">��뺸���</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtHINS_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�޿����� ��õ¡���� ��뺸���</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">���强�����</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLIN_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-���强 �����̸鼭 �Ǻ����ڰ� �⺻���������<br>
						-�ٷ��� ���� �Ǵ� �ҵ��� ���� ������ ����� ������ �����</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">��������뺸���</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLIH_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�⺻��������� �� ������� �Ǻ����ڷ� ����� ���� <br>&nbsp;���强 ������ �����</td>
					</tr>
				</table>
				</div>
				
				
				<!-- Ư������-����� --> 
				<!-- Ư������-�Ƿ�� -->
				<div id="layer_4"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:3;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> Ư������-�Ƿ��</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="67"></col>
						<col width="98"></col>
						<col width="91"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
					    <td class="creamBold" align="center" rowspan="2">���װ���</td>
						<td class="creamBold" align="center"  colspan="1">�����Ƿ��</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtMHEA_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-��������Ƿ�� ���Ե� ������ ���� ������ �Ƿ��</td>
					</tr>
					<!--  
					<tr>
						<td class="creamBold" align="center" colspan="1">����<br>�÷º����Ƿ��</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLEN_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�÷º����� �Ȱ� �Ǵ� ����Ʈ���� ������ ����
						������<br>&nbsp;������� 1�δ� �� 50���� �̳� �ݾ׿��� ����<br>
     				</tr>
     				-->
     				<tr>
						<td class="creamBold" align="center" colspan="1">65���̻�/<BR>����Ƿ��</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLF2_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-������� ��Ȱ�̳� 65�� �̻��ڸ� ���� ������ �Ƿ��</td>
					</tr>


					<tr>
				   		<td class="creamBold" align="center" rowspan="1">�ѵ�����</td>
						<td class="creamBold" align="center" colspan="1">�Ϲ��Ƿ��<br>(������)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtOHEA_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-��������Ƿ�� ���ԵǸ� �ٷ��ڰ� ���� �̿��� <br>&nbsp;�⺻��������ڸ�
						���� ������ �Ƿ��<br>
						</td>
					</tr>
	<!-- 				<tr>
						<td class="creamBold" align="center" colspan="2">����������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtOLD_MED_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-��������纸����� ���� �����޿� ����� ���� ������
						'�����Ϻ� �δ��' </td>
					</tr>
          -->
					<!--	-�⺻����������� �÷º����� �Ƿ�� ������ �ݾ��� ������ �Է�â�� �ѰǾ� �Է�</td>  -->
			<!--  <tr>
						<td class="creamBold" align="center">�÷º������Ƿ��</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLEN_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>

						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLEN_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>

						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLEN_AMT4"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>

						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLEN_AMT5"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>-->
				</table>
				</div>
				<!-- Ư������-�Ƿ�� --> 
				
				
				<!-- Ư������-������ -->
				<div id="layer_5"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:4;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> Ư������-������</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="180"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">���α�����</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtGRA_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-������ ���� ������ ������(����/���п� ���װ���)</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">����������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><select id="cmbEDU_TAG1" name="cmbEDU_TAG1"
									class="input_ReadOnly" disabled>
									<option value=""></option>
									<option value="1">������</option>
									<option value="2">���߰�</option>
									<option value="3">���б�</option>
								</select></td>
								<td><comment id="__NSID__"> <object
									id="txtEDU_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>

						<table>
							<tr>
								<td><select id="cmbEDU_TAG2" name="cmbEDU_TAG1"
									class="input_ReadOnly" disabled>
									<option value=""></option>
									<option value="1">������</option>
									<option value="2">���߰�</option>
									<option value="3">���б�</option>
								</select></td>
								<td><comment id="__NSID__"> <object
									id="txtEDU_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>

						<table>
							<tr>
								<td><select id="cmbEDU_TAG3" name="cmbEDU_TAG1"
									class="input_ReadOnly" disabled>
									<option value=""></option>
									<option value="1">������</option>
									<option value="2">���߰�</option>
									<option value="3">���б�</option>
								</select></td>
								<td><comment id="__NSID__"> <object
									id="txtEDU_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>

						<table>
							<tr>
								<td><select id="cmbEDU_TAG4" name="cmbEDU_TAG1"
									class="input_ReadOnly" disabled>
									<option value=""></option>
									<option value="1">������</option>
									<option value="2">���߰�</option>
									<option value="3">���б�</option>
								</select></td>
								<td><comment id="__NSID__"> <object
									id="txtEDU_AMT4"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>

						<table>
							<tr>
								<td><select id="cmbEDU_TAG5" name="cmbEDU_TAG1"
									class="input_ReadOnly" disabled>
									<option value=""></option>
									<option value="1">������</option>
									<option value="2">���߰�</option>
									<option value="3">���б�</option>
								</select></td>
								<td><comment id="__NSID__"> <object
									id="txtEDU_AMT5"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>

						</td>
						<td class="padding2423">-�⺻���������(�ҵ�ݾ� ��100���� �̳�, ����<br>&nbsp;���� ����)
						 �� ���� ������ ���κ� ������<br>
						-������ �ڳฦ ���� ������ �����ƽü� ������<br>
						-��ġ�� ���߰� ���б� �� ����������� ����<br>&nbsp;���ݴ��� ������<br>
						-�޽ĺ�/�б���������/���������(���籸�Ժ� ����)<br>
						-�� ����б� �������Ժ�(1�δ� 50�����ѵ�,<br>&nbsp;���Կ�����÷��) </td>
					</tr>
					<tr>
						<td class="creamBold" align="center">�����Ư��������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtHED_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�⺻����������� ������� ���Ͽ� ��ȸ�����ü�<br>&nbsp;�Ǵ� �񿵸����ο�
						������ Ư��������</td>
					</tr>
				</table>
				</div>
				<!-- Ư������-������ --> 
				
				
				<!-- Ư������-�����ڱ� -->
				<div id="layer_6"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:5;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> Ư������-�����ڱ�</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="75"></col>
						<col width="75"></col>		
						<col width="75"></col>												
						<col width="85"></col>
						<col width="*"></col>
					</colgroup>

					<tr>
						<td class="creamBold" align="center" rowspan="2" colspan="2">��������<br>�����ݻ�ȯ</td>				
						<td class="creamBold" align="center">������</td>						
						<td class="padding2423" align="left">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH1_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						-12.31. ���� ������ �������� ��<br>
						&nbsp;�������ñԸ��� ������ �����ϱ� ���� ���� ��<br>
						</td>
					</tr>
					
					<tr>
						<td class="creamBold" align="center" >���ΰ�</td>						
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH5_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						-12.31. ���� ������ �������� ��<br>
						&nbsp;�������ñԸ��� ������ �����ϱ� ���� ���� ��<br>
						&nbsp;2012�� ���� �ѱ޿����� 5,000���� ������ ���<br>
						&nbsp;��4.0%���� ���� ���ڷ� ������ �ڱ��� �ƴ� ��</td>
					</tr>					
					
					<tr>
						<td class="creamBold" align="center" colspan="3">������</td>			
							
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH6_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-12.31. ���� ������ �������� ��<br>
						&nbsp;2012�� ���� �ѱ޿����� 5,000���� ������ ���<br> 
						&nbsp;�������ñԸ��� ������ �����ϱ� ���� ���� ��
					</tr>					
					
					<tr>
						<td class="creamBold" align="center" rowspan="5">�������<br>�������Ա�</td>
						<td class="creamBold" align="center" rowspan="3">2011��<br>�������Ժ�</td>						
						<td class="creamBold" align="center">15�� �̸�</td>						
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH2_AMT04"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-��ȯ�Ⱓ 15�� �̸��� ���Ա� ���ڻ�ȯ��</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">15��~29��</td>		
						<td class="padding2423">
						
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH2_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423" rowspan="1">-��ȯ�Ⱓ 15��~29���� ���Ա� ���ڻ�ȯ��</td>
					</tr>

					<tr>
						<td class="creamBold" align="center">30�� �̻�</td>		
						<td class="padding2423">
						
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH4_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423" rowspan="1">-��ȯ�Ⱓ 30�� �̻��� ���Ա� ���ڻ�ȯ��</td>
					</tr>


					<tr>
						<td class="creamBold" align="center" rowspan="2">2012��<br>�������Ժ�</td>									
						<td class="creamBold" align="center">�����ݸ�<br>���ġ��</td>		
						<td class="padding2423">
						
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH7_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423" rowspan="1">-��������������Ա��� 70%�̻��� �����ݸ���<br>  
						&nbsp;�����ϰų�  ���ġ��  ���һ�ȯ������� <br> 
						&nbsp;�����ϴ� ���</td>
					</tr>
					
					<tr>
						<td class="creamBold" align="center">��Ÿ ����</td>		
						<td class="padding2423">
						
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLH8_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423" rowspan="1">-�����ݸ�/���ġ���� �ƴ� �Ϲ����� ���</td>
					</tr>					




				</table>
				</div>
				<!-- Ư������-�����ڱ� --> 
				
				
				<!-- Ư������-��α� -->
				<div id="layer_7"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:6;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> Ư������-��α�</td>
    					</tr>
					<tr>
						<td colspan="2" height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">������α�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC3_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�������, �����ǿ���, ���� �Ǵ� �縳�б��� �ü��� <br>&nbsp;�����
						�ݾ�, Ư���糭������ ������ �뿪</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">��ġ�ڱݱ�α�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtGOV_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-��ġ�ڱݱ�αݾ�(����, �Ŀ�ȸ, ���Ű�������ȸ)</td>
					</tr>
					
					<!--  
					<tr>
						<td class="creamBold" align="center">Ư�ʱ�α�(50%)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC1_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-��ȭ����������, �����ϼ��� � ����� �ݾ�</td>
					</tr>
					-->
					
					<tr>
						<td class="creamBold" align="center">������α�(15%)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC2_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�񿵸����ο� ����� �ݾ�(��ȸ��������, ��ȭ.������ü ��)</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">������α�(10%)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC4_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423" rowspan="2">-�񿵸����ο� ����� �ݾ�(��ȸ, ����,
						����)</td>
					</tr>
				</table>

				<br>
<!--
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> ����û �ڷ�</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">���װ�����α�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC3_NTS"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�������, �����ǿ���, ���� �Ǵ� �縳�б��� �ü��� �����
						�ݾ�, Ư������������ ������ �뿪</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">��ġ�ڱݱ�α�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtGOV_NTS"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-��ġ�ڱݱ�αݾ�(����, �Ŀ�ȸ, ���Ű�������ȸ)</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">Ư�ʱ�α�(50%)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC1_NTS"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-��ȭ����������, �����ϼ��� � ����� �ݾ�</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">������α�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLC2_NTS"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423" rowspan="2">-�񿵸����ο� ����� �ݾ�(��ȸ, ����,
						����)</td>
					</tr>
				</table> -->
				</div>


				<!-- Ư������-��α� --> <!-- Ư������-��Ÿ -->
	<!--  	       <div id="layer_8"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:7;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> Ư������-��Ÿ</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">���ĺ� ����</td>
						<td class="padding2423"><input type="text" name="txtWED_CNT"
							id="txtWED_CNT" size="9" maxlength="1" style="text-align:right;"
							style="ime-mode:disabled" onkeypress="cfCheckNumber();">
						��</td>
						<td class="padding2423">-�����ҵ��� 2500���� ������ �ٷμҵ��ڰ� ������ ���� ��
						�ξ簡���� ���ĺ�<br>
						(�ڳ� 20�� ����, ���� 60�� 55�� �̻��� �θ�)</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">�̻�� ����</td>
						<td class="padding2423"><input type="text" name="txtMOV_CNT"
							id="txtMOV_CNT" size="9" maxlength="1" style="text-align:right;"
							style="ime-mode:disabled" onkeypress="cfCheckNumber();">
						��</td>
						<td class="padding2423">-�����ҵ��� 2500���� ������ �ٷμҵ��ڰ� ���� ������ �ּ�
						�̵��� ���� ������ �̻�� -���踦 �����ϴ� ������ �ִ� ��쿡�� �� ������ �Բ� �ּҸ� �̵��� �Ϳ� ����(�ܵ��а�
						�����Ұ�)</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">��ʺ� ����</td>
						<td class="padding2423"><input type="text" name="txtFUN_CNT"
							id="txtFUN_CNT" size="9" maxlength="1" style="text-align:right;"
							style="ime-mode:disabled" onkeypress="cfCheckNumber();">
						��</td>
						<td class="padding2423">-�����ҵ��� 2500���� ������ �ٷμҵ��ڰ� ���� �⺻�����������
						��ʸ� ���� ������ ���</td>
					</tr>
				</table>
				</div>
         -->

				<!-- Ư������-��Ÿ --> 
				<!-- ��Ÿ�ҵ���� -->
				<div id="layer_9"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:8;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> ��Ÿ�ҵ����</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="70"></col>
						<col width="80"></col>
						<col width="109"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center" colspan="2">���ο��������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLF1_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-2000.12.31 ���� �������� ���ο��������</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="2">���������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtANN_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-2001.01.01 ���� �������� ���������</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="2">û������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLHO_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-2009.12.31 ���� ������ ��� �� ���Ծ��� 10���� ������ ��<br>
									            -2010.1.1 ���� ������ ��� �� ���Ծ� ���� ����, <br>&nbsp;�� 10������ �ʰ��� ���
										          �� �ʰ��ݾ��� ������󿡼� ����
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="2">����û����������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLHP_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�������� �� ������ �������� �ƴ��� ������ �����ְ� <br>&nbsp;������ ����û�����������<br>
						-�� ���Ծ��� 10������ �ʰ��ϴ� ��� �� �ʰ��ݾ��� <br>&nbsp;������󿡼� ����<br>
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="2">������ø�������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLHQ_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-������ �Ǵ� �ܵ������ַμ� ���� ���ø������� ����<br>
						-������ø��������� 09.12.31���� �������� �ѱ޿��� <br>&nbsp;8800���� ������ ��<br>
						-2010.1.1 ���� �����ڴ� �ҵ���� �Ұ���
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="2">�ٷ������ø�������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLHR_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-������ �Ǵ� �ܵ������ַμ� ���� ���ø������� ����<br></td>
					</tr>
					
					<!--  
					<tr>
						<td class="creamBold" align="center" colspan="2">�����������ھ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtVEN2_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=true>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-2009�� ���� ���� �Ǵ� ������ �ݾ�</td>
					</tr>
					-->
					
					
					<tr>
						<td class="creamBold" align="center" rowspan="5">�ſ�ī��</td>
						<td class="creamBold" align="center" colspan="1">�ſ�ī��</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtCARD_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�ſ�ī����� �ݾ�</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="1">��(��)��ī��</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtDIR_CARD_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-����(üũ)ī��/����ī��</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="1">���γ��ξ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtGIRO_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�п��� ���γ��αݾ�</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="1">���ݿ�����</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtCASH_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-���ݿ����� �ݾ�</td>
					</tr>
					<tr>
						<td class="creamBold" align="center" colspan="1">�������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> 
								<object id="txtMARKET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�������</td>
					</tr>

					<tr>
						<td class="creamBold" align="center" rowspan="3">����ֽ�������</td>
						
						<!--  
						<td class="creamBold" align="center">1�������Ծ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtSTOCK_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�ݵ��ڻ��� 60%�̻��� �����ֽĿ� �����ϴ� �ֽ����ݵ�<br>
						 -2008.10.20���� 2009.12.31���� �����ڿ� �� ��<br>
						 -1���� ���Ծ׿� ���� 20% �ҵ����<br>
						 -��� ��������� ������ ����ֽ��������� �հԾ��� �б⸶�� 300���� �ʰ� �Ұ���
						</td>
					</tr>
					<tr>
						<td class="creamBold" align="center">2�������Ծ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtSTOCK_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-2���� ���Ծ׿� ���� 10% �ҵ����</td>
					</tr>
					<tr>
					-->					
						<td class="creamBold" align="center">3�������Ծ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtSTOCK_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-3���� ���Ծ׿� ���� 5% �ҵ����</td>
					</tr>

				</table>
				</div>
				
		
				
				<!-- ��Ÿ�ҵ���� --> 
				<!-- ���װ��� -->
				<div id="layer_10"
					style="position:absolute; visibility:hidden; display:none; width:620px; z-index:9;">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="/images/common/arrowGreen.gif"
							width="8" height="15" align="absmiddle"> ���װ���</td>
					</tr>
					<tr>
						<td height="3"></td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="130"></col>
						<col width="120"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="creamBold" align="center">�������Ա����ڼ���</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLST_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-������ �Ǵ� 1���ø��� �����ϴ� �������� �ٷ��ڰ� 1995.11.01-1997.12.31�Ⱓ
						�� <font color="red"><B>�̺о�����</B></font>�� ���� �����Ͽ� 1995.11.01 ���� ������ ������� ���ڻ�ȯ��</td>
					</tr>
					
					<!--   ���� �ٷ��ڸ� ���� �� �ִ� ���װ���, �츮�� ���� �ٷ��ڸ� �����Ƿ� �ش���� ����
					<tr>
						<td class="creamBold" align="center">�������ռ���</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtTMP1_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�������տ� ���Ͽ� ��õ¡���� �ٷμҵ��� ���װ���</td>
					</tr>
					-->					
					<tr>
						<td class="creamBold" align="center">�����ġ�ڱݼ���</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtGOV_DED"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-�ݳ� ������ ��ġ�ڱݱ�α� �� 10���� ����</td>
					</tr>
					<!--  
					<tr>
						<td class="creamBold" align="center" rowspan="2">�ܱ����μ���</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtPAYO_SUM"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-���ܿ��� �ٷθ� �����ϰ� ���� ���ܱٷμҵ�</td>
					</tr>
					<tr>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtLSQ_AMT"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">-���ܿ��� �����Ͽ��ų� ������ �ҵ漼��</td>
					</tr>
					-->
				</table>
				</div>
				<!-- ���װ��� --> 

				</td>
				<td width="5" background="/images/common/arcGray05.gif"></td>
			</tr>
			<tr>
				<td height="5" background="/images/common/arcGray06.gif"></td>
				<td background="/images/common/arcGray07.gif"></td>
				<td background="/images/common/arcGray08.gif"></td>
			</tr>
		</table>
		<!--���� ������ �� --> 
		<!-- Layer �� -->
		</td>
	</tr>
</table>
<br>    <!--�ѱ޿� ǥ�� -->
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">

                    <tr>
                    <td class="padding2423">- �ѱٷμҵ����&nbsp;
                        <input name=txtSALT_AMT id=txtSALT_AMT size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       ���̸� ���� �����(�ҵ��)�ҵ��� 
                        <input name=txtFREE_INCOME id=txtFREE_INCOME size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       ���̰� �������޿���     
                        <input name=txtTAX_INCOME id=txtTAX_INCOME size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       ���Դϴ�.                                     
                    </td>
                    </tr>

                    <tr>
                    <td class="padding2423">- �Ƿ�� ������ ���� �� �ִ� �ּұݾ���&nbsp;
                        <input name=txtHOSPT_AMT id=txtHOSPT_AMT size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       ���Դϴ�.
                    <!--     
                    <br>&nbsp;&nbsp;<strong>(�Ƿ�� �����ݾ��� 200���� �̻��� �е��� �ݵ�� �Ƿ����������� �Է����ֽñ� �ٶ��ϴ�.)</strong><br>
					-->
                    </td>
                    </tr>
                    <tr>
                    <td class="padding2423">- �ſ�ī�� ������ ���� �� �ִ� �ּ� ���ݾ���&nbsp;
                        <input name=txtMIN_CARD_AMT id=txtMIN_CARD_AMT size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       ���Դϴ�.
                    </td>
                    </tr>
                </table>
       <!--�ѱ޿� ǥ�� �� -->
</form>
<!-- form �� -->

</body>
</html>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_AC_RETACC"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_AC_RETACC">
	<Param Name="BindInfo"
		, Value='
        <C>Col=DFM_CNT          Ctrl=txtDFM_CNT             Param=value     </C>
        <C>Col=GOL_CNT70        Ctrl=txtGOL_CNT70           Param=value     </C>
        <C>Col=GOL_CNT65        Ctrl=txtGOL_CNT65           Param=value     </C>
        <C>Col=TRB_CNT          Ctrl=txtTRB_CNT             Param=value     </C>
        <C>Col=RCH_CNT          Ctrl=txtRCH_CNT             Param=value     </C>
        <C>Col=CHI_CNT          Ctrl=txtCHI_CNT             Param=value     </C>
        <C>Col=INP_CNT          Ctrl=txtINP_CNT             Param=value     </C>

        <C>Col=NPEN_AMT         Ctrl=txtNPEN_AMT            Param=text      </C>
        <C>Col=EPEN_AMT         Ctrl=txtEPEN_AMT            Param=text      </C>
        <C>Col=HINU_AMT         Ctrl=txtHINU_AMT            Param=text      </C>
        <C>Col=HINS_AMT         Ctrl=txtHINS_AMT            Param=text      </C>
        <C>Col=LIN_AMT          Ctrl=txtLIN_AMT             Param=text      </C>
        <C>Col=LIH_AMT          Ctrl=txtLIH_AMT             Param=text      </C>

        <C>Col=MHEA_AMT         Ctrl=txtMHEA_AMT            Param=text      </C>
        <C>Col=OHEA_AMT         Ctrl=txtOHEA_AMT            Param=text      </C>
        <C>Col=LF2_AMT          Ctrl=txtLF2_AMT             Param=text      </C>
        <C>Col=LEN_AMT          Ctrl=txtLEN_AMT             Param=text      </C>
        <C>Col=LEN_AMT2         Ctrl=txtLEN_AMT2            Param=text      </C>
        <C>Col=LEN_AMT3         Ctrl=txtLEN_AMT3            Param=text      </C>
        <C>Col=LEN_AMT4         Ctrl=txtLEN_AMT4            Param=text      </C>
        <C>Col=LEN_AMT5         Ctrl=txtLEN_AMT5            Param=text      </C>

        <C>Col=GRA_AMT          Ctrl=txtGRA_AMT             Param=text      </C>
        <C>Col=EDU_TAG1         Ctrl=cmbEDU_TAG1            Param=value     </C>
        <C>Col=EDU_TAG2         Ctrl=cmbEDU_TAG2            Param=value      </C>
        <C>Col=EDU_TAG3         Ctrl=cmbEDU_TAG3            Param=value      </C>
        <C>Col=EDU_TAG4         Ctrl=cmbEDU_TAG4            Param=value      </C>
        <C>Col=EDU_TAG5         Ctrl=cmbEDU_TAG5            Param=value      </C>
        <C>Col=EDU_AMT1         Ctrl=txtEDU_AMT1            Param=text      </C>
        <C>Col=EDU_AMT2         Ctrl=txtEDU_AMT2            Param=text      </C>
        <C>Col=EDU_AMT3         Ctrl=txtEDU_AMT3            Param=text      </C>
        <C>Col=EDU_AMT4         Ctrl=txtEDU_AMT4            Param=text      </C>
        <C>Col=EDU_AMT5         Ctrl=txtEDU_AMT5            Param=text      </C>
        <C>Col=HED_AMT          Ctrl=txtHED_AMT             Param=text      </C>

        <C>Col=LHO_AMT          Ctrl=txtLHO_AMT             Param=text      </C>
        <C>Col=LHP_AMT          Ctrl=txtLHP_AMT             Param=text      </C>
        <C>Col=LHQ_AMT          Ctrl=txtLHQ_AMT             Param=text      </C>
        <C>Col=LHR_AMT          Ctrl=txtLHR_AMT             Param=text      </C>
        <C>Col=LH1_AMT          Ctrl=txtLH1_AMT             Param=text      </C>
        <C>Col=LH2_AMT          Ctrl=txtLH2_AMT             Param=text      </C>
        <C>Col=LH4_AMT          Ctrl=txtLH4_AMT             Param=text      </C>
        <C>Col=LH5_AMT          Ctrl=txtLH5_AMT             Param=text      </C>
        <C>Col=LH6_AMT          Ctrl=txtLH6_AMT             Param=text      </C>
        <C>Col=LH7_AMT          Ctrl=txtLH7_AMT             Param=text      </C>
        <C>Col=LH8_AMT          Ctrl=txtLH8_AMT             Param=text      </C>        
        <C>Col=LH2_AMT04        Ctrl=txtLH2_AMT04           Param=text      </C>

        <C>Col=LC3_AMT          Ctrl=txtLC3_AMT             Param=text      </C>
        <C>Col=GOV_AMT          Ctrl=txtGOV_AMT             Param=text      </C>
        <C>Col=LC1_AMT          Ctrl=txtLC1_AMT             Param=text      </C>
        <C>Col=LC2_AMT          Ctrl=txtLC2_AMT             Param=text      </C>
        <C>Col=LC3_NTS          Ctrl=txtLC3_NTS             Param=text      </C>
        <C>Col=GOV_NTS          Ctrl=txtGOV_NTS             Param=text      </C>
        <C>Col=LC1_NTS          Ctrl=txtLC1_NTS             Param=text      </C>
        <C>Col=LC2_NTS          Ctrl=txtLC2_NTS             Param=text      </C>
        <C>Col=LC4_AMT          Ctrl=txtLC4_AMT             Param=text      </C>

        <C>Col=WED_CNT          Ctrl=txtWED_CNT             	Param=value     </C>
        <C>Col=MOV_CNT          Ctrl=txtMOV_CNT             	Param=value     </C>
        <C>Col=FUN_CNT          Ctrl=txtFUN_CNT             	Param=value     </C>

        <C>Col=LF1_AMT          	Ctrl=txtLF1_AMT             		Param=text      </C>
        <C>Col=ANN_AMT          	Ctrl=txtANN_AMT             	Param=text      </C>
        <C>Col=VEN2_AMT         	Ctrl=txtVEN2_AMT            	Param=text      </C>
        <C>Col=CARD_AMT         	Ctrl=txtCARD_AMT            	Param=text      </C>
        <C>Col=DIR_CARD_AMT    Ctrl=txtDIR_CARD_AMT        	Param=text      </C>
        <C>Col=GIRO_AMT         	Ctrl=txtGIRO_AMT            	Param=text      </C>
        <C>Col=CASH_AMT         	Ctrl=txtCASH_AMT            	Param=text      </C>
        <C>Col=MARKET_AMT      	Ctrl=txtMARKET_AMT        	Param=text      </C>
        
        <C>Col=LST_AMT          	Ctrl=txtLST_AMT             		Param=text      </C>
        <C>Col=TMP1_AMT         	Ctrl=txtTMP1_AMT            	Param=text      </C>
        <C>Col=GOV_DED          	Ctrl=txtGOV_DED             		Param=text      </C>
        <C>Col=PAYO_SUM         	Ctrl=txtPAYO_SUM            	Param=text      </C>
        <C>Col=LSQ_AMT          	Ctrl=txtLSQ_AMT             		Param=text      </C>
        <C>Col=INP_AMT          	Ctrl=txtINP_AMT             		Param=text      </C>
        <C>Col=WEL_CARD         	Ctrl=txtWEL_CARD            	Param=text      </C>

        <C>Col=CLS_TAG         	Ctrl=chkCLS_TAG            		Param=value     </C>

        <C>Col=STOCK_AMT1       Ctrl=txtSTOCK_AMT1          	Param=text      </C>
        <C>Col=STOCK_AMT2       Ctrl=txtSTOCK_AMT2          	Param=text      </C>
        <C>Col=STOCK_AMT3       Ctrl=txtSTOCK_AMT3          	Param=text      </C>



        <C>Col=txtSALT_AMT        	Ctrl=txttxtSALT_AMT           	Param=text      </C>
        <C>Col=FREE_INCOME       	Ctrl=txtFREE_INCOME          	Param=text      </C>        
        <C>Col=TAX_INCOME       		Ctrl=txtTAX_INCOME          	Param=text      </C>
        <C>Col=HOSPT_AMT        		Ctrl=txtHOSPT_AMT           	Param=text      </C>
        <C>Col=MIN_CARD_AMT     	Ctrl=txtMIN_CARD_AMT        	Param=text      </C>
        <C>Col=OLD_MED_AMT      	Ctrl=txtOLD_MED_AMT         	Param=text      </C>
        <C>Col=OLD_AMT          		Ctrl=txtOLD_AMT             		Param=text      </C>
        '>
</object>

<object id="bndT_AC_DUTYPLACE"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_AC_DUTYPLACE">
	<Param Name="BindInfo"
		, Value='
        <C>Col=JAO_NO1          Ctrl=txtJAO_NO1             Param=value     </C>
        <C>Col=JAS_NM1          Ctrl=txtJAS_NM1             Param=value     </C>
        <C>Col=HIR_YMD1         Ctrl=txtHIR_YMD1            Param=value     </C>
        <C>Col=RET_YMD1         Ctrl=txtRET_YMD1            Param=value     </C>
        <C>Col=JAA_AMT1         Ctrl=txtJAA_AMT1            Param=text      </C>
        <C>Col=JAC_AMT1         Ctrl=txtJAC_AMT1            Param=text      </C>
        <C>Col=JAG_AMT1         Ctrl=txtJAG_AMT1            Param=text      </C>
        <C>Col=JAI_AMT1         Ctrl=txtJAI_AMT1            Param=text      </C>
        <C>Col=JAQ_AMT1         Ctrl=txtJAQ_AMT1            Param=text      </C>
        <C>Col=JAR_AMT1         Ctrl=txtJAR_AMT1            Param=text      </C>
        <C>Col=JAH_AMT1         Ctrl=txtJAH_AMT1            Param=text      </C>
        <C>Col=JAP_AMT1         Ctrl=txtJAP_AMT1            Param=text      </C>
        <C>Col=JAL_AMT1         Ctrl=txtJAL_AMT1            Param=text      </C>
        <C>Col=JAN_AMT1         Ctrl=txtJAN_AMT1            Param=text      </C>

        <C>Col=JAO_NO2          Ctrl=txtJAO_NO2             Param=value     </C>
        <C>Col=JAS_NM2          Ctrl=txtJAS_NM2             Param=value     </C>
        <C>Col=HIR_YMD2         Ctrl=txtHIR_YMD2            Param=value     </C>
        <C>Col=RET_YMD2         Ctrl=txtRET_YMD2            Param=value     </C>
        <C>Col=JAA_AMT2         Ctrl=txtJAA_AMT2            Param=text      </C>
        <C>Col=JAC_AMT2         Ctrl=txtJAC_AMT2            Param=text      </C>
        <C>Col=JAG_AMT2         Ctrl=txtJAG_AMT2            Param=text      </C>
        <C>Col=JAI_AMT2         Ctrl=txtJAI_AMT2            Param=text      </C>
        <C>Col=JAQ_AMT2         Ctrl=txtJAQ_AMT2            Param=text      </C>
        <C>Col=JAR_AMT2         Ctrl=txtJAR_AMT2            Param=text      </C>
        <C>Col=JAH_AMT2         Ctrl=txtJAH_AMT2            Param=text      </C>
        <C>Col=JAP_AMT2         Ctrl=txtJAP_AMT2            Param=text      </C>
        <C>Col=JAL_AMT2         Ctrl=txtJAL_AMT2            Param=text      </C>
        <C>Col=JAN_AMT2         Ctrl=txtJAN_AMT2            Param=text      </C>

        <C>Col=JAO_NO3          Ctrl=txtJAO_NO3             Param=value     </C>
        <C>Col=JAS_NM3          Ctrl=txtJAS_NM3             Param=value     </C>
        <C>Col=HIR_YMD3         Ctrl=txtHIR_YMD3            Param=value     </C>
        <C>Col=RET_YMD3         Ctrl=txtRET_YMD3            Param=value     </C>
        <C>Col=JAA_AMT3         Ctrl=txtJAA_AMT3            Param=text      </C>
        <C>Col=JAC_AMT3         Ctrl=txtJAC_AMT3            Param=text      </C>
        <C>Col=JAG_AMT3         Ctrl=txtJAG_AMT3            Param=text      </C>
        <C>Col=JAI_AMT3         Ctrl=txtJAI_AMT3            Param=text      </C>
        <C>Col=JAQ_AMT3         Ctrl=txtJAQ_AMT3            Param=text      </C>
        <C>Col=JAR_AMT3         Ctrl=txtJAR_AMT3            Param=text      </C>
        <C>Col=JAH_AMT3         Ctrl=txtJAH_AMT3            Param=text      </C>
        <C>Col=JAP_AMT3         Ctrl=txtJAP_AMT3            Param=text      </C>
        <C>Col=JAL_AMT3         Ctrl=txtJAL_AMT3            Param=text      </C>
        <C>Col=JAN_AMT3         Ctrl=txtJAN_AMT3            Param=text      </C>
    '>
</object>

<object id="bndT_CM_PERSON"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_CM_PERSON">
	<Param Name="BindInfo"
		, Value='
        <C>Col=OCC_NM          Ctrl=txtOCC_NM             Param=value     </C>
        <C>Col=DPT_NM          Ctrl=txtDPT_NM             Param=value     </C>
        <C>Col=JOB_NM          Ctrl=txtJOB_NM             Param=value     </C>
        <C>Col=CET_NO          Ctrl=txtCET_NO             Param=value     </C>
        <C>Col=ZIP_NO          Ctrl=txtZIP_NO             Param=value     </C>
        <C>Col=ADDRESS         Ctrl=txtADDRESS            Param=value     </C>
        <C>Col=ADR_CT          Ctrl=txtADR_CT             Param=value     </C>
        <C>Col=ENO_NO          Ctrl=txtENO_NO             Param=value     </C>
        <C>Col=HEAD_CD         Ctrl=txtHEAD_CD            Param=value     </C>
        <C>Col=DPT_CD          Ctrl=txtDPT_CD             Param=value     </C>
    '>
</object>