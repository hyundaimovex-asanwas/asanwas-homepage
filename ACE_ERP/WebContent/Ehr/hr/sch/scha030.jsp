	<!--*************************************************************************
	* @source      : scha030.jsp												*
	* @description : ���ڱ� ��û�� ó�� PAGE	 						*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION							*
	*----------------------------------------------------------------------------
	* 2016/07/22            �̵���            	ERP�̻�						*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.DateUtil" %>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>���ڱ� ��û�� ó��(scha030)</title>
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
    <jsp:include page="../../common/fileupload.jsp" flush="true" />
    <!-- ÷�� ������ ���� -->

	<script language="javascript">

		var year = gcurdate.substring(0,4);

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			
        	var PIS_YY_SHR = "";
        	var PIS_MM_SHR = "";

			//���ڱ� ��û�� ó�� ��ȸ
     		var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value;
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value;
            var cmbPAY_YN_SHR = document.getElementById("cmbPAY_YN_SHR").value;

            var STR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD = document.getElementById("txtEND_YMD_SHR").value;

            var STR_YMD2 = document.getElementById("txtSTR_YMD_SHR2").value;
            var END_YMD2 = document.getElementById("txtEND_YMD_SHR2").value;

            dsFILE.ClearData();
            
			dsT_SC_SCHLBOOK.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha030.cmd.SCHA030CMD"
                                   + "&S_MODE=SHR"
                                   + "&DPT_CD_SHR="+DPT_CD_SHR
                                   + "&ENO_NO_SHR="+ENO_NO_SHR
                                   + "&PAY_YN_SHR="+cmbPAY_YN_SHR
                                   + "&STR_YMD="+STR_YMD
                                   + "&END_YMD="+END_YMD
                                   + "&STR_YMD2="+STR_YMD2
                                   + "&END_YMD2="+END_YMD2;
			
			dsT_SC_SCHLBOOK.reset();
			
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
			trT_SC_SCHLBOOK.KeyValue = "tr01(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)";
			
			trT_SC_SCHLBOOK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha030.cmd.SCHA030CMD&S_MODE=SAV";
			
			trT_SC_SCHLBOOK.post();
			
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
         function fnc_Delete() {
			
            if (dsT_SC_SCHLBOOK.CountRow < 1) {
            	
                fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                
                alert("���� �� �ڷᰡ �����ϴ�!");
                
                return;
                
            }else{

                var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
                
                tmpMSG += "�����     = "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "ENO_NM")+"\n";
                tmpMSG += "�����     = "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "SEL_NM")+"\n";

                if( confirm(tmpMSG) ){

                    //�ش� ���� �����ϱ��� ���ϵ��� ���� �����Ѵ�.
                    for(var i=1; i<=dsFILE.CountRow; i++) {
                        dsFILE.DeleteRow(i);
                    }
                    fnc_DelFile()

                    var IOC_GBN = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "IOC_GBN");
                    var ENO_NO  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "ENO_NO");
                    var PIS_YM  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "PIS_YM");
                    var BIR_YMD = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "BIR_YMD");
                    var SEL_NM  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "SEL_NM");

                    dsT_SC_SCHLBOOK.DeleteRow(dsT_SC_SCHLBOOK.RowPosition);
                    // �Ķ���� �߰�
                    trT_SC_SCHLBOOK.Parameters = "IOC_GBN="+IOC_GBN+",ENO_NO="+ENO_NO+",PIS_YM="+PIS_YM+",BIR_YMD="+BIR_YMD+",SEL_NM="+SEL_NM;

                    trT_SC_SCHLBOOK.KeyValue = "tr02(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)";
                    trT_SC_SCHLBOOK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha010.cmd.SCHA010CMD&S_MODE=DEL";
                    trT_SC_SCHLBOOK.post();
                }
                
            }
            
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
			var ENO_NO = document.form1.txtENO_NO.value;
			var PAY_YM = document.form1.txtPIS_YM.value;


			if(dsT_SC_SCHLBOOK.CountRow == 0) {
                alert("��� ����Ÿ�� ������ �ּ���!");
                return;
            }

		    var hnwparm = "[:PIS_YM]="+PAY_YM.substr(0, 4)+"[:ENO_NO]="+ENO_NO+"[:PAY_YM]="+PAY_YM;

            document.form1.rptObject.SetValues(hnwparm);
            document.form1.rptObject.RunButton("Print");
            
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
			
            if (dsT_SC_SCHLBOOK.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_SC_SCHLBOOK.GridToExcel("���ڱݽ�û��ó����Ȳ", '', 225);
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
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
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
			
        	// �ʱ�ȭ
        	document.form1.txtENO_NO_SHR.value    = "";
        	document.form1.txtENO_NM_SHR.value    = "";
        	document.form1.txtDPT_CD_SHR.value    = "";
        	document.form1.txtDPT_NM_SHR.value    = "";
        	document.getElementById("resultMessage").innerText = ' ';


            dsT_SC_SCHLBOOK.ClearData();
            dsFILE.ClearData();
            
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			
			if (dsT_SC_SCHLBOOK.IsUpdated)  {
				
				if (!fnc_ExitQuestion())  return;
				
			}
			
        	window.close();
        	
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
			
         	if ( !dsT_SC_SCHLBOOK.isUpdated ) {
         		
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
				
                return false;
                
			}
         	
			return true;
			
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid_New(form1.grdT_SC_SCHLBOOK, 0, "true", "false");      // Grid Style ����

            form1.grdT_SC_SCHLBOOK.Editable = "true";

            //�Է� ���ϰ� ����
            fnc_DisableElementAll(oInputElementList);

            document.getElementById("cmbPAY_YN_SHR").value = "I";
            document.getElementById("txtSTR_YMD_SHR").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM-dd") %>";
            document.getElementById("txtEND_YMD_SHR").value = gcurdate;

            fnc_SearchList();
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			
			fnc_HotKey_Process(btnList, event.keyCode);
			
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
			
		}


        /********************************************
         * �հ豸�ؼ� �ֱ�                             *
         ********************************************/
        function fnc_sum(){
        	
            var ret_amt = form1.medRET_AMT.Text;
            var edu_amt = form1.medEDU_AMT.Text;
            var end_amt = form1.medEND_AMT.Text;

            if( ret_amt == "" ){ ret_amt = 0; }
            if( edu_amt == "" ){ edu_amt = 0; }
            if( end_amt == "" ){ end_amt = 0; }
            
            var sum = eval( ret_amt+"+"+edu_amt+"+"+end_amt )+"";

            form1.medTOT_AMT.Text = sum;
            
        }


        //�ִ� �Է°��� �����ϱ� ���� ���� ����
        var vMAX_RET_AMT=0;   //���б�
        var vMAX_EDU_AMT=0;   //������
        var vMAX_END_AMT=0;   //�⼺ȸ��(�б����)
/*
        //������ �ִ� ���� ����
        //���б� �� �ִ밪���� �̸� ����
               var maxRetList = new Array( "0"
                                   ,"14100"
                                   ,"169000"
                                   );

        //���б� ������, �⼺ȸ��
        var maxList1 = new Array(
                                    new Array(  "0"
                                               ,"62400"
                                              )
                                   ,new Array(  "0"
                                               ,"62400"
                                              )
                                   ,new Array(  "0"
                                               ,"62400"
                                              )
                                 );

        //����б� ������, �⼺ȸ��
        var maxList2 = new Array(
                                    new Array(  "362700"
                                               ,"84000"
                                              )
                                   ,new Array(  "362700"
                                               ,"84000"
                                              )
                                   ,new Array(  "362700"
                                               ,"84000"
                                              )
                                 );

        //���б� ������, �⼺ȸ��
        var maxList3 = new Array(
                                    new Array(  "370000"
                                               ,"2241000"
                                              )
                                   ,new Array(  "370000"
                                               ,"2241000"
                                              )
                                   ,new Array(  "370000"
                                               ,"2167000"
                                              )
                                   ,new Array(  "370000"
                                               ,"2009000"
                                              )
                                 );
*/
        /**
         * �г��� ���� �Ǿ����� �Է��� �� �ִ� �ִ� ���� ������Ŵ
         * @param - �г��ڵ�
         */
        function fnc_ChangeFsch(fsch_cd) {
            if(fsch_cd == "" || fsch_cd == null || fsch_cd == 'undefined') return;

            var vGrade = fsch_cd.substr(0,1);
            var vClass = fsch_cd.substr(1,1);

            //���б�, ����б�, ���б� ���� ����
            var vGradekey;
            if(vGrade == 2)     vGradekey = 0;      //���б�
            else if(vGrade == 3)vGradekey = 1;      //����б�
            else                vGradekey = 2;      //���б�(������, 4���)

            //�г� ������ ������
            var vClassKey;
            if(vClass == 1)     vClassKey = 0;      // 1�г�
            else if(vClass == 2)vClassKey = 1;      // 2�г�
            else if(vClass == 3)vClassKey = 2;      // 3�г�
            else                vClassKey = 3;      // 4�г�

            //1�г��� ��� ���б��� �ʿ�
            if(vClassKey == 0)  vMAX_RET_AMT = maxRetList[vGradekey];
            else                vMAX_RET_AMT = 0;

            //������, �⼺ȸ�� ����
            //���л�
            if(vGradekey == 0) {
                vMAX_EDU_AMT = maxList1[vClassKey][0];
                vMAX_END_AMT = maxList1[vClassKey][1];

            //����л�
            }else if(vGradekey == 1){
                vMAX_EDU_AMT = maxList2[vClassKey][0];
                vMAX_END_AMT = maxList2[vClassKey][1];

            //���л��� ���
            }else{
                vMAX_EDU_AMT = maxList3[vClassKey][0];
                vMAX_END_AMT = maxList3[vClassKey][1];
            }
        }

        /**
         * ������ �׸���� ���°����� ��� �����Ų��.
         */
        function fnc_ChangeAllPayYN() {
            var chk_yn = document.getElementById("cmbPAY_YN_CHK").value;
            var isChk = true;

            if(chk_yn == "") {
                alert("�ݿ��� ���¸� �����ϼ���");
                return;
            }

            if(dsT_SC_SCHLBOOK.CountRow < 1) {
                alert("��ȸ�� �������ּ���");
                return;
            }

            for(var i=1; i<=dsT_SC_SCHLBOOK.CountRow; i++) {
                if(dsT_SC_SCHLBOOK.NameValue(i, "IS_CHK") == "T") {
                    dsT_SC_SCHLBOOK.NameValue(i, "PAY_YN") = chk_yn;
                    isChk = false;
                }
            }

            if(isChk) {
                alert("�ݿ��� �ڷᰡ �����ϴ�.");
                return;
            }
        }

        //�Է��ʵ�
        var oInputElementList = new Array("medRET_AMT"
                                         ,"medEDU_AMT"
                                         ,"medEND_AMT"
                                         ,"medTOT_AMT"
                                         ,"medPAY_AMT"
                                         ,"cmbPAY_YN"
                                         );
        //�Է��ʵ� ���� �׸�
        var oInputExceptionList = new Array(
                                          "medTOT_AMT"
                                         );

        /**
         * ���ڱ������ݾ׿� ���� �������� ����
         */
        function fnc_ShowNotice() {
            var href_page = "../../../Ehr/hr/sch/scha011.jsp";

            window.showModalDialog(href_page, "", "dialogWidth:560px; dialogHeight:330px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        }
        
		//��������Ȳ
		function fnc_Approval(){
			
			cnt = 0;
			
			for(var i = 1; i <= dsT_SC_SCHLBOOK.CountRow; i++ ){
				if(dsT_SC_SCHLBOOK.NameString(i, "IS_CHK") == "T"){
					cnt++;
				}
				dsT_SC_SCHLBOOK.NameString(i, "DUMMY") = "T";
			}
			
			if(cnt == 0){
				alert("�������� �����Ͻʽÿ�");
				return;
			}
			
			trT_SC_SCHLBOOK_APPROVAL.KeyValue = "tr01(O:dsT_SC_SCHLBOOK_APPROVAL=dsT_SC_SCHLBOOK_APPROVAL,I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)";
			trT_SC_SCHLBOOK_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha030.cmd.SCHA030CMD&S_MODE=APPROVAL";
			trT_SC_SCHLBOOK_APPROVAL.post();
			
		}
		/******************
		 * 05. �μ� �Լ�  *
		 ******************/
		function fnc_ApprovalPrint() {
			//�ű� ���
			var param;

			var PRINT_NO = dsT_SC_SCHLBOOK_APPROVAL.NameValue(1, "PRINT_NO");
			if(PRINT_NO == "undefined" || PRINT_NO == undefined || PRINT_NO == ""){
				return;
			}
			param = "[@InitPage]=Page1[:PRINT_NO]=" + PRINT_NO;
			var url = "scha030_PV.jsp?PRINT_NO="+PRINT_NO;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
		}
        //��ǥó��
		function fnc_Slipconduct(){
        	cnt = 0;
			for(var i = 1; i <= dsT_SC_SCHLBOOK.CountRow; i++ ){
				if(dsT_SC_SCHLBOOK.NameString(i, "IS_CHK") == "T"){
					cnt++;
					if(dsT_SC_SCHLBOOK.NameString(i, "ACC_CD") == ""){
						alert("�޿�����/�μ� ������ �����ϵ��� �λ����� ��û�Ͻʽÿ� !!");
						return;
					}
				}
				dsT_SC_SCHLBOOK.NameString(i, "DUMMY") = "T";
			}
			if(cnt == 0){
				alert("��ǥó���Ҵ���� �����Ͻʽÿ�");
				return;
			}
			trT_SC_SCHLBOOK_PROC.KeyValue = "tr01(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK,O:dsRESULT=dsRESULT)";
			trT_SC_SCHLBOOK_PROC.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha030.cmd.SCHA030CMD&S_MODE=PROC";
			trT_SC_SCHLBOOK_PROC.post();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_SC_SCHLBOOK)			   |
    | 3. ���Ǵ� Table List(T_SC_SCHLBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_SC_SCHLBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet COPY ��						   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_SC_SCHLBOOK)			   |
    | 3. ���Ǵ� Table List(T_SC_SCHLBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_SC_SCHLBOOK_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_SC_SCHLBOOK_APPROVAL)			   |
    | 3. ���Ǵ� Table List(T_SC_SCHLBOOK_APPROVAL) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_SC_SCHLBOOK_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>
	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_SC_SCHLBOOK)			       |
    | 3. ���Ǵ� Table List(T_SC_SCHLBOOK)				       |
    +------------------------------------------------------>
	<Object ID="trT_SC_SCHLBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK,I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_SC_SCHLBOOK)		       |
    | 3. ���Ǵ� Table List(T_SC_SCHLBOOK)			       |
    +------------------------------------------------------>
	<Object ID="trT_SC_SCHLBOOK_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr02(O:dsT_SC_SCHLBOOK_APPROVAL=dsT_SC_SCHLBOOK_APPROVAL,I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)">
	</Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_SC_SCHLBOOK)			       |
    | 3. ���Ǵ� Table List(T_SC_SCHLBOOK)				       |
    +------------------------------------------------------>
	<Object ID="trT_SC_SCHLBOOK_PROC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK,I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �г� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_E9"/>
       <jsp:param name="CODE_GUBUN"    value="E9"/>
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
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_SC_SCHLBOOK.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK event="OnFail()">
        alert(trT_SC_SCHLBOOK.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK_PROC event="OnSuccess()">
       alert(dsRESULT.NameString(1, "RESULT_MSG"));
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK_PROC event="OnFail()">
        alert(trT_SC_SCHLBOOK_PROC.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_ApprovalPrint();
	</script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK_APPROVAL event="OnFail()">
        alert(trT_SC_SCHLBOOK_APPROVAL.ErrorMsg);
    </script>


	<!-----------------------------------------------------+
    | Grid Ŭ���� ������¿� ���� ��ư �� �ʵ� Ȱ��ȭ ó��			   |
    +------------------------------------------------------>
	<script language="javascript"  for=dsT_SC_SCHLBOOK event=OnRowPosChanged(row)>
        //�Է� ���ϰ� ����
        fnc_DisableElementAll(oInputElementList);

        if(row > 0) {
            //�ִ밪 �Է� ���ϰ� ���Ѱ� ����
            //fnc_ChangeFsch(dsT_SC_SCHLBOOK.NameString(row, "FSCH_CD"));

            //��ϵ� ���ϵ� ��ȸ
            fnc_GetFileList(dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, "FILE_KEY"));

            //����ó���� �Ϸ���� �ʾ����� ��������
            if(dsT_SC_SCHLBOOK.NameValue(row, "PAY_YN") != "4"
                    || (dsT_SC_SCHLBOOK.NameValue(row, "PAY_YN") == "4"
                            && dsT_SC_SCHLBOOK.RowStatus(row) == "4")) {
                //���������ϰ� â Ǯ�� ����
                fnc_EnableElementAll(oInputElementList, oInputExceptionList);
            }
        }
	</script>

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��                |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_SC_SCHLBOOK event=CanRowPosChange(row)>
        if(row > 0) {
            //����ó���� �Ϸ���� �ʾ����� ��������
            if(dsT_SC_SCHLBOOK.NameValue(row, "PAY_YN") != "4"
                    || (dsT_SC_SCHLBOOK.NameValue(row, "PAY_YN") == "4"
                            && dsT_SC_SCHLBOOK.RowStatus(row) == "4")) {
            }
        }
    </script>


    <!-----------------------------------------------------+
    | header�� Ŭ�������� �̹ݿ� ����Ÿ ��� üũ
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_SC_SCHLBOOK event=OnHeadCheckClick(Col,Colid,bCheck)>

        if(Colid == "IS_CHK" && dsT_SC_SCHLBOOK.CountRow > 0) {
            for(var i=1; i<=dsT_SC_SCHLBOOK.CountRow; i++) {
                if(dsT_SC_SCHLBOOK.NameString(i, "IS_CHK") == "F") {
                    dsT_SC_SCHLBOOK.NameString(i, "IS_CHK") = "T";
                } else if(dsT_SC_SCHLBOOK.NameString(i, "IS_CHK") == "T") {
                    dsT_SC_SCHLBOOK.NameString(i, "IS_CHK") = "F";
                }
            }
        }

    </script>


    <!-- ���� �׸��� Ŭ���� �ٿ�ε� �ǰ� -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
        if(row > 0) {
            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");
            // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
            if (vFILE_NAME != "" && vFILE_URL != "") {
                cfDownload(vFILE_NAME, vFILE_URL);
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
	<form name="form1">


	<!-- ��ư ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
   	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','../../images/button/btn_CancelOver.gif',1)"><img src="../../images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a> -->
                <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPrint','','../../images/button/btn_PrintOver.gif',1)"> <img src="../../images/button/btn_PrintOn.gif"  name="ImgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
	            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a> -->
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0" id="searchTable">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="60"></col>
							<col width="220"></col>
							<col width="60"></col>
                            <col width="220"></col>
							<col width="60"></col>
                            <col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">��û����</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR','','100','130');"></a>
                                ~
                                <input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','220','130');"></a>
							</td>
							<td class="searchState" align="right">��������</td>
							<td class="padding2423" align="left">
                                <input type="text" id="txtSTR_YMD_SHR2" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR2','','250','130');"></a>
                                ~
                                <input type="text" id="txtEND_YMD_SHR2" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR2','','370','130');"></a>
							</td>
                            <td align="right" class="searchState">ó����Ȳ</td>
                            <td class="padding2423">
                                <select id="cmbPAY_YN_SHR" name="cmbPAY_YN_SHR" onchange="fnc_SearchList()">
                                    <option value="" >��ü</option>
                                    <option value="I">������</option>
                                    <option value="0">��û</option>
                                    <option value="1">����</option>
                                    <option value="2">�ݼ�</option>
                                    <option value="3">��ǥ</option>
                                    <option value="4">����</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
							<td align="right" class="searchState">��&nbsp;&nbsp;��</td>
							<td class="padding2423"><input name=txtDPT_CD_SHR size="6"  maxlength="6" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
								<input id=txtDPT_NM_SHR size="10" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image30" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
							</td>
							<td align="right" class="searchState"> ��&nbsp;&nbsp;��</td>
                            <td class="padding2423" colspan="3">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
			<col width="100"></col>
			<col width="110"></col>
			<col width="100"></col>
			<col width="110"></col>

			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
            <col width="*"></col>
        </colgroup>
        <tr>
            <td align="center" class="blueBold">�Ҽ�</td>
            <td class="padding2423">
                <input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly>
                <input type="hidden" id="hidDPT_CD" size="10">
                <input type="hidden" id="hidIOC_GBN" size="10">
            </td>
            <td align="center" class="blueBold">����</td>
            <td class="padding2423" colspan="3">
                <input id="txtJOB_NM" size="7" class="input_ReadOnly" readonly>
                <input type="hidden" id="hidOCC_CD" size="10">
                <input type="hidden" id="hidPAST_MON">
            </td>
            <td align="center" class="blueBold">���</td>
            <td class="padding2423"><input id="txtENO_NO" name="txtENO_NO" size="10" class="input_ReadOnly" readonly maxlength="8" style="ime-mode:disabled" onKeypress="cfNumberCheck()"></td>
            <td align="center" class="blueBold">����</td>
            <td class="padding2423"><input id="txtENO_NM" size="12" class="input_ReadOnly" readonly></td>
            <td align="center" class="blueBold">�Ի���</td>
            <td class="padding2423"><input id="txtHIR_YMD" size="15" maxLength="3" class="input_ReadOnly" readonly></td>
        </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="1000" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="left" class="paddingTop8"><img src="../../images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> �����ڳ࿡ ���� �����Է�</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
        <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
        <colgroup>
			<col width="100"></col>
			<col width="110"></col>
			<col width="100"></col>
			<col width="110"></col>

			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="*"></col>
        </colgroup>
        <tr>
            <td align="center" class="blueBold">�б���</td>
            <td class="padding2423"><input id="txtSCH_NM" size="12" class="input_ReadOnly" readonly></td>
            <td align="center" class="blueBold">�а�</td>
            <td class="padding2423"><input id="txtMAJ_NM" size="14" class="input_ReadOnly" readonly></td>
            <td align="center" class="blueBold">�г�</td>
            <td class="padding2423"><input id="txtFSCH_NM" size="14" class="input_ReadOnly" readonly></td>
            <td align="center" class="blueBold">���޳��</td>
            <td class="padding2423">
                <input type="text" id="txtPIS_YM" style="ime-mode:disabled" size="7" maxlength="7" class="input_ReadOnly" readonly>
            </td>
            <td align="center" class="blueBold">��������</td>
            <td class="padding2423">
                <input type="text" id="txtPAY_YMD" style="ime-mode:disabled" size="10" class="input_ReadOnly" readonly>
            </td>
        </tr>
        <tr>
            <td align="center" class="blueBold">����</td>
            <td class="padding2423"><input id="txtSEL_NM" size="12" class="input_ReadOnly" readonly></td>
            <td align="center" class="blueBold">�ֹι�ȣ</td>
            <td class="padding2423"><input id="txtBIR_YMD" size="8"class="input_ReadOnly" readonly></td>
            <td align="center" class="blueBold" rowspan="4">���⼭��<br>÷��</td>
            <td class="padding2423" colspan="5"  rowspan="4" align="right">
                <comment id="__NSID__">
                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:100%;height:103px;">
                    <param name="DataID" value="dsFILE">
                    <param name="Editable" value="false">
                    <param name="DragDropEnable" value="true">
                    <param name="SortView" value="Left">
                    <param name=ViewHeader  value="false">
                    <param name="Format" value='
                        <C> id="{CUROW}"    width="30"      name="NO"         align="center"  value={String(Currow)}</C>
                        <C> id=FILE_NAME    width="260"     name="���ϸ�"      align="left"    leftmargin="10"</C>
                    '>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
            </td>
        </tr>
        <tr>
            <td align="center" class="blueBold">���б�</td>
            <td class="padding2423">
                <table width="100%" border="0" >
                <tr>
                    <td width="90%">
                        <comment id="__NSID__"><object id="medRET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="left">��</td>
                </tr>
                </table>
            </td>
            <td align="center" class="blueBold">������</td>
            <td class="padding2423">
                <table width="100%" border="0" >
                    <tr>
                    <td width="90%">
                        <comment id="__NSID__"><object id="medEDU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="left">��</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" class="blueBold">�б��������</td>
            <td class="padding2423">
                <table width="100%" border="0" >
                    <tr>
                    <td width="90%">
                        <comment id="__NSID__"><object id="medEND_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="left">��</td>
                    </tr>
                </table>
            </td>
            <td align="center" class="blueBold">��</td>
            <td class="padding2423">
                <table width="100%" border="0" >
                <tr>
                    <td width="90%">
                        <comment id="__NSID__"><object id="medTOT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=9>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                            <param name=ReadOnly                value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="left">��</td>
                </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" class="blueBold">���ޱݾ�</td>
            <td class="padding2423">
                <table width="100%" border="0" >
                <tr>
                    <td width="85px">
                        <comment id="__NSID__"><object id="medPAY_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:85px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=9>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="left">��</td>
                </tr>
                </table>
            </td>
            <td align="center" class="blueBold">���޿���</td>
            <td class="padding2423">
                <select id="cmbPAY_YN">
                    <option value="0">��û</option>
                    <option value="1">����</option>
                    <option value="2">�ݼ�</option>
                    <option value="4">����</option>
                </select>
            </td>
        </tr>
        </table>
        </td>
    </tr>
    </table>
    <!-- ���� �Է� ���̺� �� -->

	<!-- ��ȸ ���� ���̺� ���� 
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					</tr>
				</table>
			</td>
            <td class="paddingTop8" width="180" height="38">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" align="center">
                            <img src="../../images/button/btn_ApprovalOn.gif"        id="btnO"       onClick="fnc_Approval()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnO','','../../images/button/btn_ApprovalOver.gif',1)" style="cursor:hand;">
                        </td>
						<td>&nbsp;</td>
                        <td valign="top" align="center" style="DISPLAY:none">
                            <img src="../../images/button/btn_SlipOn.gif"            id="btnD"       onClick="fnc_Slipconduct()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('fnc_Slipconduct','','../../images/button/btn_SlipOver.gif',1)" style="cursor:hand;">
                        </td>
						<td>
						&nbsp;
						</td>
                        <td valign="top" align="center">
                            <select id="cmbPAY_YN_CHK" name="cmbPAY_YN_CHK" style="width:80px">
                                <option value="" >��ü</option>
                                <option value="0">��û</option>
                                <option value="1">����</option>
                                <option value="2">�ݼ�</option>
                                <option value="4">����</option>
                            </select>
                        </td>
                        <td valign="top" align="center">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBatchAdjust','','../../images/button/BatchAdjustOver.gif',1)"><img src="../../images/button/BatchAdjustOn.gif"  id="imgBatchAdjust"  name="imgBatchAdjust" width="80" height="20" border="0" align="absmiddle" onClick="fnc_ChangeAllPayYN()"></a>
                        </td>
                    </tr>
                </table>
            </td>
		</tr>
	</table>
	-->
	<!-- ��ȸ ���� ���̺� �� -->

	<br>
	
	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_SC_SCHLBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:350px;">
						<param name="DataID" value="dsT_SC_SCHLBOOK">
                        <param name="ColSelect"  value="true">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<FC> id="{CUROW}"	    width="30"		name="NO"					align="center"	value={String(Currow)}  </FC>
                            <FC> id="PIS_QQ"     		width="40"     	name="�б�"           		align="center"  Edit=none </FC>
                            <FC> id="IPT_YMD"       	width="80"    	name="��û����"         	align="center"  Edit=none</FC>
                            <FC> id="PAY_YMD"       	width="80"    	name="��������"         	align="center"  Edit=none</FC>
							<FC> id="DPT_NM"			width="100"		name="�Ҽ�"					align="left"		Edit=none		LeftMargin="10"</FC>
							<FC> id="JOB_NM"			width="60"		name="����"					align="center"	Edit=none</FC>
							<FC> id="ENO_NO"			width="60"		name="���"					align="center"	Edit=none</FC>
							<FC> id="ENO_NM"			width="70"		name="����"					align="center"	Edit=none</FC>
							<FC> id="HIR_YMD"			width="80"		name="�Ի���"				align="center"	Edit=none</FC>
							<C> id="BIR_YMD"			width="100"		name="�ֹι�ȣ"			align="center"	Edit=none</C>
							<C> id="SEL_NM"				width="60"		name="����"					align="center"	Edit=none</C>
							<C> id="MF_TAG"			width="50"		name="����"					align="center"	Edit=none		EditStyle=Combo		Data="F:����,M:����"</C>
							<C> id="OLD_AGE"			width="50"		name="����"					align="center"	Edit=none</C>
							<C> id="SCH_NM"			width="150"		name="�б�"					align="left"		Edit=none		LeftMargin="10"</C>
							<C> id="MAJ_NM"			width="100"		name="�а�"					align="left"		Edit=none		LeftMargin="10"</C>
							<C> id="FSCH_NM"			width="100"		name="�г�"					align="left"		Edit=none		LeftMargin="10"</C>
							<C> id="RET_AMT"			width="100"		name="���б�"				align="right"	Edit=none   	RightMargin="10"</C>
							<C> id="EDU_AMT"			width="100"		name="������"				align="right"	Edit=none   	RightMargin="10"</C>
							<C> id="END_AMT"			width="100"		name="�б��;������" align="right"	Edit=none   	RightMargin="10"</C>
							<C> id="TOT_AMT"			width="100"		name="�հ�"					align="right"	Edit=none		RightMargin="10"	value={(RET_AMT+EDU_AMT+END_AMT)}</C>
							<C> id="PAY_AMT"			width="100"		name="���ޱݾ�"			align="right"	Edit=none	  RightMargin="10"   </C>
                            <C> id="PAY_YN"     		width="60"      name="���޿���"         	align="center"  Edit=none   EditStyle="Combo" Data="0:��û,1:����,2:�ݼ�,3:��ǥ,4:����"</C>
                            <C> id="PIS_YM"     			width="80"      name="���޳��"         	align="center"  Edit=none</C>
                            <C> id="ACC_NM"     		width="80"      name="����"             		align="center"  Edit=none</C>
                            <C> id="ACC_NO"     		width="120"     name="���¹�ȣ"         	align="center"  Edit=none</C>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

    <!--**************************************************************************************
    *                                                                                        *
    *   ���ε� ������Ʈ                                                                             *
    *                                                                                        *
    ***************************************************************************************-->

    <!-- T_SC_SCHLBOOK ���� ���̺� -->
    <object id="bndT_SC_SCHLBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_SC_SCHLBOOK">
        <Param Name="BindInfo", Value="
            <C>Col=IOC_GBN      Ctrl=hidIOC_GBN     Param=value</C>
            <C>Col=PIS_YM       Ctrl=txtPIS_YM      Param=value</C>
            <C>Col=PAY_YMD      Ctrl=txtPAY_YMD     Param=value</C>
            <C>Col=ENO_NO       Ctrl=txtENO_NO      Param=value</C>
            <C>Col=ENO_NM       Ctrl=txtENO_NM      Param=value</C>
            <C>Col=DPT_CD       Ctrl=hidDPT_CD      Param=value</C>
            <C>Col=DPT_NM       Ctrl=txtDPT_NM      Param=value</C>
            <C>Col=OCC_CD       Ctrl=hidOCC_CD      Param=value</C>
            <C>Col=JOB_NM       Ctrl=txtJOB_NM      Param=value</C>
            <C>Col=HIR_YMD      Ctrl=txtHIR_YMD     Param=value</C>
            <C>Col=BIR_YMD      Ctrl=txtBIR_YMD     Param=value</C>
            <C>Col=SEL_NM       Ctrl=txtSEL_NM      Param=value</C>
            <C>Col=OLD_AGE      Ctrl=txtOLD_AGE     Param=value</C>
            <C>Col=FSCH_NM      Ctrl=txtFSCH_NM     Param=value</C>
            <C>Col=SCH_NM       Ctrl=txtSCH_NM      Param=value</C>
            <C>Col=MAJ_NM       Ctrl=txtMAJ_NM      Param=value</C>
            <C>Col=PAY_YN       Ctrl=cmbPAY_YN      Param=value</C>
            <C>Col=RET_AMT      Ctrl=medRET_AMT     Param=Text</C>
            <C>Col=EDU_AMT      Ctrl=medEDU_AMT     Param=text</C>
            <C>Col=END_AMT      Ctrl=medEND_AMT     Param=text</C>
            <C>Col=SCO_AMT      Ctrl=medSCO_AMT     Param=text</C>
            <C>Col=OTH_AMT      Ctrl=medOTH_AMT     Param=text</C>
            <C>Col=TOT_AMT      Ctrl=medTOT_AMT     Param=text</C>
            <C>Col=PAY_AMT      Ctrl=medPAY_AMT     Param=text</C>
        ">
    </object>