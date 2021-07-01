<!--
    ************************************************************************************
    * @Source         : edue020.jsp                                                    
    * @Description    : ����������û�� PAGE                                            
    * @Developer Desc :                                                                
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                           
    *-------------+-----------+--------------------------------------------------------+
    * 2016/05/23 |  ������   | �ҽ�����                                              
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>



<html>

    <head>
    <title>����������û��</title>
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


        var year    = gcurdate.substr(0,4);
        
        var ord_no;
        
        var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
        	
        	var STR_YMD  = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD  = document.getElementById("txtEND_YMD_SHR").value;
            
            var EDU_NM   = document.getElementById("txtEDU_NM_SHR").value;
            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var ENO_NM   = document.getElementById("txtENO_NM_SHR").value;
            var DPT_CD   = document.getElementById("hidEMPL_DPT_CD").value;
            
            
            cfCheckDate(document.getElementById("txtSTR_YMD_SHR"));
            cfCheckDate(document.getElementById("txtEND_YMD_SHR"));

          
            if(STR_YMD != "" && END_YMD != "") {
                // ������������ FROM ~ TO���� ��
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("���������� FROM���ڴ� �ݵ�� ���������� TO���ں��� �۾ƾ��մϴ�.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return;
                }
            }

            if(ENO_NO != "" && ENO_NM == "") {
                alert("�߸��� ����Դϴ�.");
                document.getElementById("txtENO_NO_SHR").focus();
                return;
            }

            dsT_ED_OPENRQST.ClearData();

            dsT_ED_OPENRQST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue020.cmd.EDUE020CMD&S_MODE=SHR_01&STR_YMD="+STR_YMD+"&END_YMD="+END_YMD+"&EDU_NM="+EDU_NM+"&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD;

            dsT_ED_OPENRQST.Reset();

            form1.grdT_ED_OPENRQST.Focus();

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

            var dpt_cd   = document.getElementById("txtDPT_CD").value;
            var job_cd   = document.getElementById("txtJOB_CD").value;

            trT_ED_OPENRQST.KeyValue = "tr01(I:SAV=dsT_ED_OPENRQST)";
            
            trT_ED_OPENRQST.action  = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue020.cmd.EDUE020CMD"
					                                    + "&S_MODE=SAV"
					                                    + "&DPT_CD="+dpt_cd
					                                    + "&JOB_CD="+job_cd;

            trT_ED_OPENRQST.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var status = 0;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_ED_OPENRQST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if(document.getElementById("cmbSTS_GBN").value != "1") {
                alert("���°� ��û �����϶��� ������ �����մϴ�.");
                return;
            }

            status = dsT_ED_OPENRQST.RowStatus(dsT_ED_OPENRQST.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_ED_OPENRQST.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("������[" + dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition,"EDU_TXT") + "] ��� [" + dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition,"ENO_NO") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            	dsT_ED_OPENRQST.DeleteRow(dsT_ED_OPENRQST.RowPosition);

            if (status != 1) {

               trT_ED_OPENRQST1.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue020.cmd.EDUE020CMD&S_MODE=DEL";
               trT_ED_OPENRQST1.post();

             }

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_ED_OPENRQST.SetColumn(form1.grdT_ED_OPENRQST.GetColumnID(0));
            form1.grdT_ED_OPENRQST.Focus();

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

            if (dsT_ED_OPENRQST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_ED_OPENRQST.GridToExcel("����������û��", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_ED_OPENRQST.CountColumn == 0) {
                dsT_ED_OPENRQST.setDataHeader("ORD_NO:STRING, ENO_NO:STRING:NOTNULL, ENO_NM:STRING:NOTNULL, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, EDU_STR_YMD:STRING, EDU_END_YMD:STRING, EDU_TXT:STRING, EDU_NM:STRING, EDU_GBN_CD:STRING, EDU_GBN_NM:STRING, EDU_GBN_TXT:STRING, PLACE_TXT:STRING, FIX_NO:INT, GOAL_TXT:STRING, CONTENT_TXT:STRING, COST_AMT:INT, INS_YN:STRING, INS_NM:STRING, SUM_AMT:INT, RTN_AMT:INT, STS_GBN:STRING");
            }
            
            //�������� �ҷ����� �߰�  ( ����, �Ҽ�   ������ �����.)
            dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            dsVI_T_PERSON.reset();

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_ED_OPENRQST.AddRow();

            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "ENO_NO")  = gusrid;
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "ENO_NM")  = gusrnm;
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "DPT_CD")  = dsVI_T_PERSON.NameValue(0,"DPT_CD");
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "DPT_NM")  = dsVI_T_PERSON.NameValue(0,"DPT_NM");
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "JOB_CD")  = dsVI_T_PERSON.NameValue(0,"JOB_CD");
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "JOB_NM")  = dsVI_T_PERSON.NameValue(0,"JOB_NM");
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "STS_GBN") = "1";

            document.getElementById("cmbSTS_GBN").disabled     = true;

            form1.grdT_ED_OPENRQST.setColumn(form1.grdT_ED_OPENRQST.getColumnID(0));

            document.getElementById("txtEDU_TXT").focus();

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

            document.getElementById("txtSTR_YMD_SHR").value = '';
            document.getElementById("txtEND_YMD_SHR").value = '';
            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtEDU_NM_SHR").value = '';
            
            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_ED_OPENRQST.ClearData();

        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_ED_OPENRQST.IsUpdated ) {
            	
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                
                return false;
                
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
        
            //��� �Է�â ����
            fnc_DisableElementAll(elementList);
            fnc_ChangeStateElement(false, "cmbSTS_GBN");
            fnc_ChangeStateElement(false, "txtENO_NO");
            fnc_ChangeStateElement(false, "txtENO_NM");
            fnc_ChangeStateElement(false, "ImgEnoNo");

            //Grid Style ����
            cfStyleGrid_New(form1.grdT_ED_OPENRQST,0,"false","false");

            fnc_SetDateTerm();  
          
             //�������
            for( var i = 1; i <= dsCOMMON_Q9.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q9.NameValue(i,"CODE_NAME");
                document.getElementById("cmbEDU_GBN_CD").add(oOption);

            }
             

			fnc_SearchList();
			
			if(gusrid != "6060002" && gusrid != "6180001" && gusrid != "2070019" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2180001" ){ 

				   document.getElementById("txtENO_NO_SHR").value = gusrid;
		           document.getElementById("txtENO_NM_SHR").value = gusrnm;

		           fnc_ChangeStateElement(false, "txtENO_NO_SHR");
		           fnc_ChangeStateElement(false, "txtENO_NM_SHR");
		           fnc_ChangeStateElement(false, "ImgEnoNoShr");
		           
		           
		           document.getElementById("hidEMPL_DPT_CD").value =gdeptcd;

			}
			
			
			document.getElementById("txtSTR_YMD_SHR").focus();
			
        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

        	window.close();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/


        // �����Ⱓ SET
        function fnc_SetDateTerm() {
            //var dateinfo = getToday().split("-");
            
            var dateinfo = gs_date;
            
            //from - to ��¥�� �����ϱ�
            //var schDate  = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);
            var fromDate = null;
            var toDate   = null;
            
            //fromDate = new Date(schDate.getFullYear(), schDate.getMonth(), "01");
            //toDate   = new Date(schDate.getFullYear(), schDate.getMonth(), fnc_Lastday(schDate.getFullYear(), schDate.getMonth()+1));

            fromDate = gcurdate.substring(0,4) + gcurdate.substring(5,7)+"01";
            toDate = gs_date;
            
            // FROM ����
            document.getElementById("txtSTR_YMD_SHR").value = fromDate;
            
            // TO ����
            //document.getElementById("txtEND_YMD_SHR").value = fnc_MakeDateString(toDate);
            //document.getElementById("txtEND_YMD_SHR").value = toDate;

            //���� ������ ���� �������� 
            var _firstDayofMon = [gcurdate.substring(0,4),gcurdate.substring(5,7),'01'].join('-');  
            var arrDate = _firstDayofMon.split("-");
            var lastDate =new Date(arrDate[0],arrDate[1],0);
            var lastDay =lastDate.getDate();
            
            document.getElementById("txtEND_YMD_SHR").value = gcurdate.substring(0,4) + gcurdate.substring(5,7)+ lastDay;
                        
        }

        // DATE���� STRING(YYYY-MM-DD)���� ���ڷ� ��ȯ
        function fnc_MakeDateString(date) {
            var year  = date.getYear();
            var month = date.getMonth() + 1;
            var date  = date.getDate();

            if (month < 10) {
                month = "0" + month;
            }

            if (date < 10) {
                date = "0" + date;
            }

            return year + "-" + month + "-" + date
        }

        //����Է�â
        var elementList = new Array( "txtEDU_STR_YMD"
                                    ,"txtEDU_END_YMD"
                                    ,"ImgEduStrYmd"
                                    ,"ImgEduEndYmd"
                                    ,"txtEDU_TXT"
                                    ,"ImgEduCd"
                                    ,"cmbEDU_GBN_CD"
                                    ,"txtGOAL_TXT"
                                    ,"txtEDU_NM"
                                    ,"txtCONTENT_TXT"
                                    ,"txtOBJ_TAG"
                                    ,"txtEDU_GBN_TXT"
                                    ,"txtPLACE_TXT"
                                    ,"medCOST_AMT"
                                    ,"txtFIX_NO"
                                    ,"cmbINS_YN"
                                    ,"txtEFFECT_TAG"
                                    ,"txtCPT_TAG"
                                    ,"txtSITE_TAG"
                                    ,"medRTN_AMT");


        /**
         * �Է±ݾװ� �Ѿ��� �����
         */
        function fnc_BindTOT() {
            var cost_amt = 0;
            var rtn_amt  = 0;
            var fix_no   = 0;

            cost_amt = fnc_covNumber(document.getElementById("medCOST_AMT").Text);
            fix_no = fnc_covNumber(document.getElementById("txtFIX_NO").value);

            //ȯ�޿��� ����, ������
            if(document.getElementById("cmbINS_YN").value == "Y") {
                rtn_amt = fnc_covNumber(document.getElementById("medRTN_AMT").Text);
                document.getElementById("medRTN_AMT").readOnly =false;
                document.getElementById("medRTN_AMT").className="";
                document.getElementById("medRTN_AMT").Enable = true;
                document.getElementById("medRTN_AMT").disabled = true;
            }
            else {
            document.getElementById("medRTN_AMT").Text= 0;
            document.getElementById("medRTN_AMT").readOnly =true;
            document.getElementById("medRTN_AMT").className="input_ReadOnly";
            document.getElementById("medRTN_AMT").Enable = false;
            document.getElementById("medRTN_AMT").disabled = true;
            }


        }


       /***********************
       * �����ȸ�� �˾� *
       **********************/

        function fnc_EmplPop() {

			var obj = new String();

            obj.shr_kind = "SHR_02";
            obj.eno_nm = "";

            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtDPT_CD").value = obj.dpt_cd;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtJOB_CD").value = obj.job_cd;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
		}

        /**
         *��������� ��ȸ�Ѵ�.
         *��������� �˻�
         */
         function fnc_SearchEmpNm() {
              //����� ã�ƿ��� �� ���� ��������
              fnc_GetEnoNo('txtENO_NM', 'txtENO_NO', '1');
              fnc_SearchEmpNo();
         }


        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetEnoNm("txtENO_NO","","1");
            if(document.getElementById("txtENO_NO").value != "") {

                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_CD").value      = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("txtJOB_CD").value      = obj.job_cd;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_CD").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                document.getElementById("txtJOB_CD").value      = "";
            }

        }




       function fnc_CheckDate(){

            var EDU_STR_YMD = document.getElementById("txtEDU_STR_YMD").value.replace("-","").replace("-","");
            
            var today = gcurdate.replace("-","").replace("-","");

	      }

	   function fnc_CheckDate1(){
		   
	        var EDU_END_YMD = document.getElementById("txtEDU_END_YMD").value.replace("-","").replace("-","");
	        
            var today = gcurdate.replace("-","").replace("-","");
	        
		 }

		 function execCreationEdu(){

		 	var status = document.getElementById("cmbSTS_GBN").value;

            if(status==4){
            	
	            var sORD_NO     = dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "ORD_NO");

	            if (confirm("��û ������ �����Ͻðڽ��ϱ�? ") == false) return;

	            params = "&S_MODE=PROC"
			                   + "&ORD_NO="+sORD_NO;

	            dsRESULT.ClearData();

	            trT_ED_OPENRQST.KeyValue = "tr04(O:dsRESULT=dsRESULT)";
	            
	            trT_ED_OPENRQST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue020.cmd.EDUE020CMD"+params;
	            
	            trT_ED_OPENRQST.post();
	            
	        }
		 	
	        trT_ED_OPENRQST.KeyValue = "tr05(I:STS=dsT_ED_OPENRQST)";
	        
            trT_ED_OPENRQST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue020.cmd.EDUE020CMD&S_MODE=STS";
            
            trT_ED_OPENRQST.post();

		 }
		 
		// Link
		function fnc_SiteTag(){
			
			var siteTag = document.getElementById("txtSITE_TAG").value;
			
			if(siteTag == ""){
				return;
			}
			
			window.open('http://'+siteTag,'imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
			
		}
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_OPENRQST)  |
    | 3. ���Ǵ� Table List(T_ED_OPENRQST)         |
    +----------------------------------------------->
    <Object ID="dsT_ED_OPENRQST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EMPLIST)   |
    | 3. ���Ǵ� Table List(T_CM_EMPLIST)          |
    +----------------------------------------------->
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>
    
    
    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet(�ּ�)							       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ED_OPENRQST                     |
    | 3. Table List : T_ED_OPENRQST                 |
    +----------------------------------------------->
    <Object ID ="trT_ED_OPENRQST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_ED_OPENRQST1" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_ED_OPENRQST)">
    </Object>

    <!-- �������� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q1"/>
       <jsp:param name="CODE_GUBUN"    value="Q1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ������� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q9"/>
       <jsp:param name="CODE_GUBUN"    value="Q8"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_OPENRQST Event="OnDblClick(row, col)">
    
    /*
	 	var status = document.getElementById("cmbSTS_GBN").value;

        if(status==3 || status==4){
        	
           alert("���� �Ǵ� �ΰ� �Ϸ�� ��û���Դϴ�.\n\n���ε� ��û���� ������û�� �޴����� ��û�ٶ��ϴ�.");
           
           return;
           
        }
        
        ord_no      = dsT_ED_OPENRQST.NameValue(row, "ORD_NO");

        window.showModalDialog("../../hr/edu/edue021.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	*/

    </Script>

    <!-------------------------------------------------+
    | �ش� ���� ����� �� �հ� ���� ����               |
    +-------------------------------------------------->
    <script language=JavaScript for= medCOST_AMT event="OnKillFocus()">
        fnc_BindTOT();
    </script>

    <!-------------------------------------------------+
    | �ش� ���� ����� �� �հ� ���� ����               |
    +-------------------------------------------------->
    <script language=JavaScript for= medRTN_AMT event="OnKillFocus()">
        fnc_BindTOT();
    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_OPENRQST Event="OnLoadCompleted(iCount)">
    
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_OPENRQST.CountRow );
        }
        
    </Script>
    
    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
    
        if(iCount == 0) {
            //alert("�ش� �ڷᰡ �������� �ʽ��ϴ�.");
        } else {
            //��� �޼��� �����ֱ�
            alert(dsRESULT.NameString(1, "RTN_MSG"));

            if(dsRESULT.NameString(1, "RTN_CD") == "0") {
                //��ȸ�� ���������� �̷�� ������ �ٽ� worklog�� ��ȸ��Ŵ
                fnc_SearchList();
            }
        }
        
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_OPENRQST Event="OnLoadError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[������/��������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50020) {
            alert("������/�������ڿ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>
    <Script For=dsRESULT Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_OPENRQST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    <Script For=dsRESULT Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ED_OPENRQST event="OnSuccess()">
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ED_OPENRQST event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_ED_OPENRQST event=OnRowPosChanged(row)>

        fnc_BindTOT();
        
        fnc_DisableElementAll(elementList);
        
        fnc_ChangeStateElement(false, "txtENO_NO");
        fnc_ChangeStateElement(false, "txtENO_NM");
        fnc_ChangeStateElement(false, "ImgEnoNo");

        var typeList;
     
        if(row > 0) {
        	
        	 //�������� ��� ���¸� �����Ҽ� �ִ�.
        	if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "2070019" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2180001" ){ 
        		
        		 fnc_ChangeStateElement(true, "cmbSTS_GBN");
        		 
        	}

            //�ű��� ���
            if(dsT_ED_OPENRQST.RowStatus(row) == "1" || dsT_ED_OPENRQST.NameString(row, "STS_GBN") == "1") {
            	
                fnc_EnableElementAll(elementList);
                
                //�������� ��� �Է»����� ����� ���� ��ų�� �ִ�.
        		if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "2070019" || gusrid == "2030007" || gusrid == "2070020"  || gusrid == "2180001" ){ 
                	
                	fnc_ChangeStateElement(true, "txtENO_NO");
                    fnc_ChangeStateElement(true, "txtENO_NM");
                    fnc_ChangeStateElement(true, "ImgEnoNo");
                }

            }
        }
    </script>

    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_ED_OPENRQST event=CanRowPosChange(row)>

        //��ȿ�� ����
        if(row > 0) {
            if(dsT_ED_OPENRQST.RowStatus(row) == "1" || dsT_ED_OPENRQST.NameString(row, "STS_GBN") == "1") {


                // ������
                if( dsT_ED_OPENRQST.NameValue(row, "EDU_TXT") == '' ) {
                	
                    alert("���������� �ʼ� �Է»����Դϴ�.");
                    
                    document.getElementById("txtEDU_TXT").focus();
                    
                    return false;
                    
                }

                // ��������
                if( dsT_ED_OPENRQST.NameValue(row, "EDU_GBN_CD") == '' ) {
                	
                    alert("���������� �ʼ� �Է»����Դϴ�.");
                    
                    document.getElementById("cmbEDU_GBN_CD").focus();
                    
                    return false;
                    
                }

                // ������������
                if( dsT_ED_OPENRQST.NameValue(row, "EDU_STR_YMD") == '' ) {
                	
                    alert("�����������ڴ� �ʼ� �Է»����Դϴ�.");
                    
                    document.getElementById("txtEDU_STR_YMD").focus();
                    
                    return false;
                }

                // ������������ CHECK
                if (!fnc_CheckDate2(dsT_ED_OPENRQST.NameValue(row, "EDU_STR_YMD"), "������������") && dsT_ED_OPENRQST.NameValue(row, "EDU_STR_YMD") != "") {
                	
                    document.getElementById("txtEDU_STR_YMD").focus();
                    
                    return false;
                }

                // ������������
                if( dsT_ED_OPENRQST.NameValue(row, "EDU_END_YMD") == '' ) {
                	
                    alert("�����������ڴ� �ʼ� �Է»����Դϴ�.");
                    
                    document.getElementById("txtEDU_END_YMD").focus();
                    
                    return false;
                    
                }

                // ������������ CHECK
                if (!fnc_CheckDate2(dsT_ED_OPENRQST.NameValue(row, "EDU_END_YMD"), "������������") && dsT_ED_OPENRQST.NameValue(row, "EDU_END_YMD") != "") {
                	
                    document.getElementById("txtEDU_END_YMD").focus();
                    
                    return false;
                    
                }


                // �����������ڿ� ������������ ��
                if(dsT_ED_OPENRQST.NameValue(row, "EDU_STR_YMD") != '' && dsT_ED_OPENRQST.NameValue(row, "EDU_END_YMD") != '') {
                	
                    if(removeChar(dsT_ED_OPENRQST.NameValue(row, "EDU_STR_YMD"),'-') > removeChar(dsT_ED_OPENRQST.NameValue(row, "EDU_END_YMD"),'-')) {
                    	
                        alert("�����������ڴ� �ݵ�� �����������ں��� �۾ƾ��մϴ�.");
                        
                        document.getElementById("txtEDU_STR_YMD").focus();
                        
                        return false;
                    }
                }

                // ȯ�޿���
                if( dsT_ED_OPENRQST.NameValue(row, "INS_YN") == '' ) {
                	
                    alert("ȯ�޿��δ� �ʼ� �Է»����Դϴ�.");
                    
                    document.getElementById("cmbINS_YN").focus();
                    
                    return false;
                    
                }

            }
        }
    </script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->
<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/> 
<!--  <body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">-->

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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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

                            <tr>
                                <td align="right" class="searchState">���� </td>
                                <td class="padding2423">
                                    <input id="txtEDU_CD_SHR" size="10" maxlength= "10" onkeypress="if(event.keyCode==13) fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');" >
                                    <input id="txtEDU_NM_SHR" size="20" maxlength= "200" class="input_ReadOnly" onkeypress="if(event.keyCode==13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');"></a>
                                </td>
                                <td align="right" class="searchState">�������� </td>
                                <td class="padding2423">
                                    <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();" onfocusout="fnc_compareFromTo('txtSTR_YMD_SHR', 'txtEND_YMD_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','280','120');"></a> ~
                                    <input id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();" onfocusout="fnc_compareFromTo('txtSTR_YMD_SHR', 'txtEND_YMD_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd1','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduEndYmd1" name="ImgEduEndYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','650','120');"></a>
                                </td>
                                <td class="searchState" align="right">���</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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

<!-- ��ȸ ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100 "></col>
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">�� û ��</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "9"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_EmplPop();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        <b>
                        &nbsp;&nbsp;�μ�
                        <input id="txtDPT_NM" size="12" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtDPT_CD">
                        &nbsp;&nbsp;����
                        <input id="txtJOB_NM" size="15" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtJOB_CD">
                        </b>
                    </td>
                    <td align="center" class="blueBold">ó����Ȳ</td>
                    <td class="padding2423" colspan="2">
                        <select id="cmbSTS_GBN" style="width:50%" onChange="execCreationEdu();">
                            <option value="1">��û</option>
                            <option value="3">�ΰ�</option>
                            <option value="4">����</option>
                        </select>
                       �ο�
                        <input id="txtFIX_NO" name="txtFIX_NO" maxlength="5" style="width:20%;text-align:right;" >

                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" >��������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEDU_TXT" name="txtEDU_TXT"  maxlength="200" style="width:100%" >
                    </td>
                    <td align="center" class="blueBold" >�������</td>
                    <td class="padding2423" colspan="2">
                        <input id="txtOBJ_TAG" name="txtOBJ_TAG"  maxlength="200" style="width:100%" >
                    </td>

                </tr>
                <tr>
                    <td align="center" class="blueBold" >��������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtGOAL_TXT" name="txtGOAL_TXT" maxlength="60" style="width:100%">
                    </td>
                    <td align="center" class="blueBold" >��������</td>
                    <td class="padding2423" align="left" colspan="2">
                        <select id="cmbEDU_GBN_CD" style="width:100px" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�����Ͻ�</td>
                    <td class="padding2423">
                        <input id="txtEDU_STR_YMD" name="txtEDU_STR_YMD" style="ime-mode:disabled" size="10" maxlength="10"  onblur="fnc_CheckDate(this);" onChange="fnc_CheckDate(this, '������������');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtEDU_STR_YMD', 'txtEDU_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduStrYmd" name="ImgEduStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_STR_YMD','','0','252');"></a> ~
                        <input id="txtEDU_END_YMD" name="txtEDU_END_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate1(this);" onChange="fnc_CheckDate(this, '������������');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtEDU_STR_YMD', 'txtEDU_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduEndYmd" name="ImgEduEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_END_YMD','','112','252');"></a>
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" >
                        <input id="txtEDU_GBN_TXT" name="txtEDU_GBN_TXT" maxlength="28" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" colspan="2">
                        <input id="txtPLACE_TXT" name="txtPLACE_TXT" maxlength="20" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" colspan="6">
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="117" rows="4" onKeyUp="fc_chk_byte(this,300)"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�ҿ���</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            		value=2>
                            <param name=Border               		value=true>
                            <param name=ClipMode             		value=true>
                            <param name=DisabledBackColor    	value="#EEEEEE">
                            <param name=Enable               		value=true>
                            <param name=IsComma              	value=true>
                            <param name=Language             		value=0>
                            <param name=MaxLength            	value=9>
                            <param name=Numeric              		value=true>
                            <param name=ShowLiteral          		value="false">
                            <param name=Visible              			value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>

					<td align="center" class="blueBold">ȯ�޿���</td>
                    <td class="padding2423">
                        <select id="cmbINS_YN" style="width:100%" onchange="fnc_BindTOT()">
                            <option value="N">������</option>
                            <option value="Y">����</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">ȯ�޿����</td>
                    <td class="padding2423" colspan="2">
                        <comment id="__NSID__"><object id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:99%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>

                    </td>
                </tr>
                    <td align="center" class="blueBold">���� URL</td>
                    <td class="padding2423" >
                        http://<input id="txtSITE_TAG"  name="txtSITE_TAG" size="17" maxlength="300" >&nbsp;<input type="button" value="����" size="6" align="right" onClick="fnc_SiteTag()">
                    </td>
                    <td align="center" class="blueBold" >����ȿ��</td>
                    <td class="padding2423" >
                        <input id="txtEFFECT_TAG" name="txtEFFECT_TAG"  maxlength="50" style="width:100%" >
                    </td>
                    <td align="center" class="blueBold" >�������</td>
                    <td class="padding2423" colspan="2">
                        <input id="txtCPT_TAG" name="txtCPT_TAG"  maxlength="150" style="width:100%" >
                    </td>
                <tr>


                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->

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
                        <object    id="grdT_ED_OPENRQST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:300px;">
                            <param name="DataID"                  value="dsT_ED_OPENRQST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     		width=40    name='����'         align=center </C>
                                <C> id='EDU_TXT'      		width=150   name='��������'     align=left   </C>
                                <C> id='EDU_STR_YMD'  	width=80    name='��������'     align=left   </C>
                                <C> id='EDU_END_YMD'  	width=80    name='��������'     align=center </C>
                                <C> id='EDU_GBN_CD'   	width=60    name='��������'     align=center EditStyle=Lookup Data='dsCOMMON_Q9:CODE:CODE_NAME' </C>
                                <C> id='GOAL_TXT'     		width=150   name='��������'     align=left   </C>
                                <C> id='EDU_GBN_TXT'  	width=100   name='�������'     align=left   </C>
                                <C> id='PLACE_TXT'    		width=100   name='�������'     align=left   </C>
                                <C> id='CONTENT_TXT'  	width=120   name='��������'     align=left  multiline=true </C>
                                <C> id='COST_AMT'     	width=80    name='�ҿ���'     align=right  </C>
                                <C> id='FIX_NO'       		width=50    name='�ο�'         align=right  </C>

                                <C> id='ENO_NM'       		width=70    name='����'         align=center </C>
                                <C> id='DPT_NM'       		width=80    name='�μ�'         align=left   </C>
                                <C> id='JOB_NM'       		width=70    name='����'         align=center </C>
                                <C> id='INS_YN'       		width=70    name='ȯ�޿���'     align=center   Value={Decode(INS_YN,'Y','����','N','������')}</C>
                                <C> id='RTN_AMT'      		width=70    name='ȯ�޿����'   align=right </C>

                                <C> id='STS_GBN_NM'   	width=70    name='ó����Ȳ'     align=center value={DECODE(STS_GBN,'1','��û','2','����','3','�ΰ�','4','����')}</C>
                                <C> id='OBJ_TAG'      		width=120   name='�������'     align=left   </C>
                                <C> id='EFFECT_TAG'   	width=120   name='����ȿ��'     align=left   </C>
                                <C> id='CPT_TAG'  	  		width=120   name='�������'     align=left   </C>
                                <C> id='SITE_TAG'     		width=120   name='�������Ʈ'   align=left   </C>
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

<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState">* �űԷ� ������û �Ͻð� ���������� �����Ͻ� ���� ������ ��û �ϼž� ����� ��ܿ� ��ϵ˴ϴ�.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>


</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �λ���ǥ ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_OPENRQST">
    <Param Name="BindInfo", Value='

        <C> Col=EDU_STR_YMD   Ctrl=txtEDU_STR_YMD   Param=value </C>
        <C> Col=EDU_END_YMD   Ctrl=txtEDU_END_YMD   Param=value </C>
        <C> Col=ENO_NO        Ctrl=txtENO_NO        Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM        Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM        Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM        Param=value </C>
        <C> Col=EDU_TXT       Ctrl=txtEDU_TXT       Param=value </C>
        <C> Col=EDU_NM        Ctrl=txtEDU_NM        Param=value </C>
        <C> Col=EDU_GBN_CD    Ctrl=cmbEDU_GBN_CD    Param=value </C>
        <C> Col=GOAL_TXT      Ctrl=txtGOAL_TXT      Param=value </C>
        <C> Col=EDU_GBN_TXT   Ctrl=txtEDU_GBN_TXT   Param=value </C>
        <C> Col=PLACE_TXT     Ctrl=txtPLACE_TXT     Param=value </C>
        <C> Col=CONTENT_TXT   Ctrl=txtCONTENT_TXT   Param=value </C>
        <C> Col=COST_AMT      Ctrl=medCOST_AMT      Param=text  </C>
        <C> Col=FIX_NO        Ctrl=txtFIX_NO        Param=value </C>
        <C> Col=INS_YN        Ctrl=cmbINS_YN        Param=value </C>
        <C> Col=RTN_AMT       Ctrl=medRTN_AMT       Param=text  </C>
        <C> Col=STS_GBN       Ctrl=cmbSTS_GBN       Param=value </C>
        <C> Col=OBJ_TAG       Ctrl=txtOBJ_TAG       Param=value </C>
        <C> Col=EFFECT_TAG    Ctrl=txtEFFECT_TAG    Param=value </C>
        <C> Col=CPT_TAG       Ctrl=txtCPT_TAG       Param=value </C>
        <C> Col=SITE_TAG      Ctrl=txtSITE_TAG      Param=value </C>
    '>
</object>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 