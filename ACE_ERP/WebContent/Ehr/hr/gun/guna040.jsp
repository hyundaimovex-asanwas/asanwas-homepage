	<!--*************************************************************************
	* @source      : guna040.jsp												*
	* @description : �����µ�� PAGE											    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/07            ä����          	        �����ۼ�									    *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>�����µ��(guna040)</title>
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

		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			//�����µ�� ���� ��ȸ
			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
			var GUN_CD_SHR  = document.getElementById("cmbGUN_CD_SHR").value;
			var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
            var EMPL_DPT_CD = document.getElementById("hidEMPL_DPT_CD").value;

			//�������ڰ� ������ ��ȸ����.
			if(STR_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(STR_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//�������ڰ� ������ ��ȸ����.
			if(END_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(END_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//�������ڰ� �������ں��� ũ�� �ʵȴ�.
			if(parseInt(END_YMD_SHR.replaceStr("-","")) < parseInt(STR_YMD_SHR.replaceStr("-",""))){
					alert("�������ڰ� �������ں��� �����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
			}

			dsT_DI_LONGTERM.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna040.cmd.GUNA040CMD"
                                   + "&S_MODE=SHR"
                                   + "&STR_YMD_SHR="+STR_YMD_SHR
                                   + "&END_YMD_SHR="+END_YMD_SHR
                                   + "&GUN_CD_SHR="+GUN_CD_SHR
                                   + "&GUN_STS_SHR="+GUN_STS_SHR
                                   + "&EMPL_DPT_CD="+EMPL_DPT_CD;
			dsT_DI_LONGTERM.reset();
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
			trT_DI_LONGTERM.KeyValue = "tr01(I:dsT_DI_LONGTERM=dsT_DI_LONGTERM)";
			trT_DI_LONGTERM.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna040.cmd.GUNA040CMD&S_MODE=SAV";
			trT_DI_LONGTERM.post();
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
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_DI_LONGTERM.CountColumn == 0) {
				dsT_DI_LONGTERM.setDataHeader("REG_NO:STRING, ENO_NO:STRING, ENO_NM:STRING, DPT_NM:STRING, JOB_NM:STRING, GUN_CD:STRING, REMARK:STRING, STR_YMD:STRING, END_YMD:STRING");
			}

			// �� �߰�
			dsT_DI_LONGTERM.AddRow();

			document.form1.cmbGUN_CD.selectedIndex = 0;
			document.getElementById("cmbREMARK").disabled = true;
            document.getElementById("cmbREMARK").value = "";
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
	        if (dsT_DI_LONGTERM.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "��Ϲ�ȣ = "+dsT_DI_LONGTERM.nameValue(dsT_DI_LONGTERM.RowPosition, "REG_NO")+"\n";
            	tmpMSG += "���       = "+dsT_DI_LONGTERM.nameValue(dsT_DI_LONGTERM.RowPosition, "ENO_NO")+"\n";
            	tmpMSG += "����       = "+dsT_DI_LONGTERM.nameValue(dsT_DI_LONGTERM.RowPosition, "ENO_NM")+"\n";

	            if( confirm(tmpMSG) ){
					var REG_NO = dsT_DI_LONGTERM.nameValue(dsT_DI_LONGTERM.RowPosition, "REG_NO");

					dsT_DI_LONGTERM.DeleteRow(dsT_DI_LONGTERM.RowPosition);

					// �Ķ���� �߰�
					trT_DI_LONGTERM.Parameters = "REG_NO="+REG_NO;

					trT_DI_LONGTERM.KeyValue = "tr01(I:dsT_DI_LONGTERM=dsT_DI_LONGTERM)";
					trT_DI_LONGTERM.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna040.cmd.GUNA040CMD&S_MODE=DEL";
					trT_DI_LONGTERM.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
			//document.form1.txtSTR_YMD_SHR.value = "";          // ��������(�˻�)
			//document.form1.txtEND_YMD_SHR.value = "";          // ��������(�˻�)
			document.form1.cmbGUN_CD.selectedIndex = 0;        // ����(�Է�)
			document.form1.cmbREMARK.selectedIndex = 0;        // ���(�Է�)
			document.form1.cmbGUN_CD_SHR.selectedIndex = 0;    // ����(�˻�)

        	dsT_DI_LONGTERM.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_DI_LONGTERM.IsUpdated)  {
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

            var end_ymd = document.getElementById("txtEND_YMD_SHR");

         	if ( !dsT_DI_LONGTERM.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
            if(end_ymd.value == ""){
                alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�!");
                return false;
            }
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_DI_LONGTERM,15,"true","false");      // Grid Style ����

        	// ����(�Է�)
        	var h4_cd = ""; 
        	
			for( var i = 1; i <= dsT_CM_COMMON_H4.CountRow; i++ ) {
			
                h4_cd = dsT_CM_COMMON_H4.NameValue(i,"CODE")
			    
			    if(h4_cd == "A" || h4_cd == "B" || h4_cd == "C" || h4_cd == "D" || h4_cd == "Y" ||
			       h4_cd == "W" || h4_cd == "M" || h4_cd == "N" || h4_cd == "O" || h4_cd == "X" || h4_cd == "9"){
                    continue;
			    }
			    
				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_H4.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_H4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbGUN_CD").add(oOption);
			}

        	// ����(��ȸ)
			for( var i = 1; i <= dsT_CM_COMMON_H4.CountRow; i++ ) {
			
                h4_cd = dsT_CM_COMMON_H4.NameValue(i,"CODE")
                
                if(h4_cd == "A" || h4_cd == "B" || h4_cd == "C" || h4_cd == "D" || h4_cd == "Y" ||
                   h4_cd == "W" || h4_cd == "M" || h4_cd == "N" || h4_cd == "O" || h4_cd == "X" || h4_cd == "9"){
                    continue;
                }
			
				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_H4.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_H4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbGUN_CD_SHR").add(oOption);
			}

			document.getElementById("txtSTR_YMD_SHR").value = getToday().substring(0,7)+"-01";
			document.getElementById("txtEND_YMD_SHR").value = getToday();

			

<%
    //�����Ͱ� �ƴϸ� �Ҽ� �μ��� ��ȸ �ϰ�
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
            document.getElementById('hidEMPL_DPT_CD').value = "<%=box.getString("SESSION_DPTCD") %>";
<%
    }
%>

            fnc_DisableElementAll(elementList);
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}
        
        
        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");
            
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
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");
            fnc_SearchEmpNo();
        } 
         
        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;
            
            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {            
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }
        }  

        var elementList = new Array( "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"cmbGUN_CD"
                                    ,"cmbREMARK"
                                    ,"txtSTR_YMD"
                                    ,"txtEND_YMD"
                                    ,"ImgStrYmd"
                                    ,"ImgEndYmd"
                                     );
        
        
        //������ ��¥���� üũ
        function fnc_ChkDate() {

            var STR_YMD = document.getElementById("txtSTR_YMD").value.replace("-","").replace("-","");
            var today = getToday().replace("-","").replace("-","");
            
            if(STR_YMD != ""){
	            if(STR_YMD <= today){
	                alert("�̹� ������ ���ڴ� ����Ҽ� �����ϴ�.");
	                document.getElementById("txtSTR_YMD").value = "";
	                document.getElementById("txtSTR_YMD").focus();
	                return false;
	            }
            }
            
        }
        
        
        function fnc_chgRemark(){

            //document.getElementById("cmbREMARK").remove(del_index);     //������ �͸� ����
            //document.getElementById("cmbREMARK").options.length = 3;    //3�� ����� ������
            document.getElementById("cmbREMARK").options.length = 0;    //��δ� ����
            
            //����ϱ���(SG)
            if(document.getElementById("cmbGUN_CD").value == "Q"){
                document.getElementById("cmbREMARK").disabled = false;
                
	            for( var i = 1; i <= dsT_CM_COMMON_SG.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_CM_COMMON_SG.NameValue(i,"CODE_NAME");
	                oOption.text  = dsT_CM_COMMON_SG.NameValue(i,"CODE_NAME");
	                document.getElementById("cmbREMARK").add(oOption);
	            }            
            
            //Ư���ް�����(SF)
            }else if(document.getElementById("cmbGUN_CD").value == "I"){
                document.getElementById("cmbREMARK").disabled = false;
                            
                for( var i = 1; i <= dsT_CM_COMMON_SF.CountRow; i++ ) {
                    oOption       = document.createElement("OPTION");
                    oOption.value = dsT_CM_COMMON_SF.NameValue(i,"CODE_NAME");
                    oOption.text  = dsT_CM_COMMON_SF.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbREMARK").add(oOption);
                }            
            
            //��Ÿ(����)
            }else if(document.getElementById("cmbGUN_CD").value == "L"){
                document.getElementById("cmbREMARK").disabled = false;
                            
                oOption       = document.createElement("OPTION");
                oOption.value = "����";
                oOption.text  = "����";
                document.getElementById("cmbREMARK").add(oOption);
                
            }else{
                document.getElementById("cmbREMARK").disabled = true;
                document.getElementById("cmbREMARK").value = "";
            }
        
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_LONGTERM)			 	   |
    | 3. ���Ǵ� Table List(T_DI_LONGTERM) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_LONGTERM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_LONGTERM)		       |
    | 3. ���Ǵ� Table List(T_DI_LONGTERM)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_LONGTERM" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_LONGTERM=dsT_DI_LONGTERM,I:dsT_DI_LONGTERM=dsT_DI_LONGTERM)">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H4"/>
       <jsp:param name="CODE_GUBUN"    value="H4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_SG"/>
       <jsp:param name="CODE_GUBUN"    value="SG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_SF"/>
       <jsp:param name="CODE_GUBUN"    value="SF"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_DI_LONGTERM Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_LONGTERM.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_LONGTERM Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_LONGTERM Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_LONGTERM event="OnSuccess()">
        fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_LONGTERM event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_DI_LONGTERM event=CanRowPosChange(row)>
		if ( dsT_DI_LONGTERM.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_DI_LONGTERM.GetHdrDispName('-3','ENO_NO') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_DI_LONGTERM.NameValue(row,"STR_YMD") == "" ) {
			alert("[ " + grdT_DI_LONGTERM.GetHdrDispName('-3','STR_YMD') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
	</script>

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_DI_LONGTERM event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
            var remark = dsT_DI_LONGTERM.NameValue(row, "REMARK");
            fnc_chgRemark();
            
            //���� ���� 1:������, 2:������, 3:�Ϸ�
            var status = dsT_DI_LONGTERM.NameValue(row, "GUN_STS");
        
            //�űԳ� �������ϰ��
            if(dsT_DI_LONGTERM.RowStatus(row) == "1"
                    || status == "1") {
                fnc_EnableElementAll(elementList);
            } 
            //������ �� ��� ���� ���ڸ� ���氡��
            else if(status == "2"){
                fnc_ChangeStateElement(false, "txtEND_YMD");
                fnc_ChangeStateElement(false, "ImgEndYmd");
            }
            
            //alert(remark);
            //���� ����� �� ���󺹱�            
            dsT_DI_LONGTERM.NameValue(row, "REMARK") = remark;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����µ��</td>
					<td align="right" class="navigator">HOME/���°���/���ϱ��°���/<font color="#000000">�����µ��</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
							<col width="70"></col>
							<col width="150"></col>
							<col width="70"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">�Ⱓ</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','108','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','224','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>
							<td class="searchState" align="right">����</td>
							<td class="padding2423" align="left">
								<select id="cmbGUN_CD_SHR" style="width='100';" onChange="fnc_SearchList()">
									<option value="0">���</option>
								</select>
							</td>
							<td class="searchState" align="right">���Ῡ��</td>
							<td class="padding2423" align="left">
								<select id="cmbGUN_STS_SHR"  style="width='70';" onChange="fnc_SearchList()">
									<option value="0">���</option>
									<option value="1">������</option>
									<option value="2">������</option>
									<option value="3">�Ϸ�</option>
								</select>
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
					<col width="70"></col>
					<col width="110"></col>
					<col width="70"></col>
					<col width="170"></col>
					<col width="70"></col>
					<col width="110"></col>
					<col width="70"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">��Ϲ�ȣ</td>
                    <td class="padding2423"><input id="txtREG_NO" size="12" class="input_ReadOnly"  readonly></td>				
					<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="8" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>

					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly></td>
				</tr>
				<tr>
					<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423" align="left">
                        <select id="cmbGUN_CD" style="width='100';" onchange="fnc_chgRemark()" ></select>
					</td>
					<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423" align="left">
                        <select id="cmbREMARK" style="width='120';"></select>
					</td>
					<td align="center" class="creamBold">���±Ⱓ</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);fnc_ChkDate();" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();" onfocusout="fnc_compareFromTo('txtSTR_YMD', 'txtEND_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','20','120');"></a> ~ 
                        <input id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();" onfocusout="fnc_compareFromTo('txtSTR_YMD', 'txtEND_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','20','120');"></a>
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
					<object id="grdT_DI_LONGTERM" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
						<param name="DataID" value="dsT_DI_LONGTERM">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="REG_NO"		width=75	name="��Ϲ�ȣ"		align=center	Edit=none    </C>
							<C> id="DPT_NM"		width=100   name="�Ҽ�"			align=center	Edit=none    </C>
							<C> id="JOB_NM"		width=50	name="����"			align=center	Edit=none    </C>
                            <C> id="ENO_NO"     width=70    name="���"         align=center    Edit=none    </C>
                            <C> id="ENO_NM"     width=70    name="����"         align=center    Edit=none    </C>
							<C> id="GUN_CD"		width=80	name="�����׸�"		align=center	Edit=none    EditStyle=Lookup  Data="dsT_CM_COMMON_H4:CODE:CODE_NAME" 	</C>
							<C> id="REMARK"		width=95	name="���"         align=center	Edit=none    </C>
							<C> id="STR_YMD"	width=70	name="��������"		align=center	Edit=none    </C>
							<C> id="END_YMD"	width=70	name="��������"		align=center	Edit=none    </C>
							<C> id="GUN_STS"	width=55	name="���࿩��"		align=center	Edit=none    value={decode(GUN_STS, 1, ������, 2, ������, 3, �Ϸ�)}</C>
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

	<input type="hidden" id="txtDPT_CD">
	<input type="hidden" id="txtJOB_CD">
	</form>
	<!-- form �� -->
</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_DI_LONGTERM ���� ���̺� -->
	<object id="bndT_DI_LONGTERM" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_DI_LONGTERM">
		<Param Name="BindInfo", Value="
			<C>Col=REG_NO		Ctrl=txtREG_NO		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=GUN_CD		Ctrl=cmbGUN_CD		Param=value</C>
			<C>Col=REMARK		Ctrl=cmbREMARK		Param=value</C>
			<C>Col=STR_YMD		Ctrl=txtSTR_YMD		Param=value</C>
			<C>Col=END_YMD		Ctrl=txtEND_YMD		Param=value</C>
		">
	</object>