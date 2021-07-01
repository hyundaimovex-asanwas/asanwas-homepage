 <!--
*****************************************************
* @source      : insc010.jsp
* @description : �����Ļ�/���纸��/����ӱݻ���
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/09      ����ȣ                   �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>����ӱݻ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">

    <!--*****************************
    *  CSS ����  *
    *****************************-->
    <style type="text/css">
    .header {
        padding: 1px;
        background-color: #f7dcbb;
        text-align: center;
    }
    .content {
        padding: 1px;
        padding-right : 7px;
        background-color: #ffffff;
        text-align: right;
    }
    .textbox {
        padding: 1px;
        padding-right : 3px;
        background-color: #ffffff;
        text-align: right;
    }
    .content2 {
        padding: 1px;
        background-color: #ffffff;
        text-align: center;
    }
    </style>


<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<script language="javascript" src="/common/dateformat.js"></script>
<script language="javascript" src="/common/input.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "F"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�
        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ins.c.insc010.cmd.INSC010CMD";
        var params = null;
        var OCC_CD = null;

        //�ʵ��� �� �հ踦 ���ϱ� ����
        var fieldSum = new Array(0, 0, 0, 0);   //���������� �ʵ���� ��
        var subTotal = 0;   //��[A]S
        var total = 0;      //�հ�[A+B+C]
        
        //�ʵ��̸�
        var FIELD_NM = null;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        /**
         * ��������� ��ȸ �Ѵ�.
         */
         function fnc_SearchEmp() {
            //�˻�����
            var oENO_NO = document.getElementById("txtENO_NO_SHR").value;

            params = "&S_MODE=SHR_EMP"
                   + "&ENO_NO="+oENO_NO;

            dsT_CM_PERSON.dataid = dataClassName+params;
            dsT_CM_PERSON.reset();

            fncChangeFromToYmd();  //�����Ⱓ��ȸ
        }
        /**
         * ����ӱ� ���������� ��ȸ�Ѵ�.
         */
        function fnc_SearchList() {
            //�˻�����
            var oENO_NO         = document.getElementById("txtENO_NO_SHR");
            var oYMD            = document.getElementById("txtYMD_SHR");

            if(oENO_NO.value == "") {
                alert("����� ������ �ּ���");
                oENO_NO.focus();
                return;
            }

            if(oYMD.value == "" ){
                alert("������� �Է��Ͻʽÿ�.");
                oYMD.focus();
                return;
            }

            params = "&S_MODE=SHR"
                   + "&ENO_NO="+oENO_NO.value
                   + "&YMD="+oYMD.value;

            //�ʱ�ȭ ��Ű��
            dsT_CP_PAYMASTER.ClearData();
            dsT_CP_CHANGE_FIELD.ClearData();
            dsT_CP_CHANGE1.ClearData();
            dsT_CP_CHANGE2.ClearData();
            dsT_CP_CHANGE3.ClearData();
            dsT_CP_CHANGE4.ClearData();
            dsT_CP_PAYMASTER_BONUS.ClearData();
            dsT_CP_YEARLYBONUS.ClearData();

            //���Ϲ��� DataSet ����
            trT_CP_PAYMASTER.KeyValue = "tr02"
                                   + "(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER"         //��������
                                   + ",O:dsT_CP_CHANGE_FIELD=dsT_CP_CHANGE_FIELD"   //��Ÿ���� �׸�
                                   + ",O:dsT_CP_CHANGE1=dsT_CP_CHANGE1"             //��Ÿ����1
                                   + ",O:dsT_CP_CHANGE2=dsT_CP_CHANGE2"             //��Ÿ����2
                                   + ",O:dsT_CP_CHANGE3=dsT_CP_CHANGE3"             //��Ÿ����3
                                   + ",O:dsT_CP_CHANGE4=dsT_CP_CHANGE4"             //��Ÿ����4
                                   + ",O:dsT_CP_PAYMASTER_BONUS=dsT_CP_PAYMASTER_BONUS"//�󿩱�
                                   + ",O:dsT_CP_YEARLYBONUS=dsT_CP_YEARLYBONUS"     //����������
                                   + ")";
			trT_CP_PAYMASTER.action = dataClassName+params;
			trT_CP_PAYMASTER.post();

           fnc_ShowElement("imgPrint");


        }


        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {
            var ENO_NO_SHR         = document.getElementById("txtENO_NO_SHR").value;
            var APY_YMD_SHR        = document.getElementById("txtYMD_SHR").value;
      		var DATE_TERM          = document.getElementById("txtFROM_TO_YMD").value;
			var OCC_NM_SHR		   = document.getElementById("txtOCC_NM_SHR").value;
			var PAST_DAY1		   = document.getElementById("PAST_DAY1").innerHTML;
			var PAST_DAY2		   = document.getElementById("PAST_DAY2").innerHTML;
			var PAST_DAY3		   = document.getElementById("PAST_DAY3").innerHTML;
			var PAST_DAY4		   = document.getElementById("PAST_DAY4").innerHTML;
			
			var param = "";//��Ÿ���� �� �հ�
			
			for(i=0; i<dsT_CP_CHANGE_FIELD.CountRow; i++) {
                for(j=1, sum=0; j<=4; j++) {
                    param += "&ETC_AMT"+(i+1)+""+j+"="+document.getElementById("txtETC_AMT"+(i+1)+""+j).value.replace(",", "").replace(",", "").replace(",", "");
                }
                param += "&ETC_ROWSUM"+(i+1)+"="+document.getElementById("txtETC_ROWSUM"+(i+1)).value.replace(",", "").replace(",", "").replace(",", "");
			}
			
			for(i=dsT_CP_CHANGE_FIELD.CountRow; i<4; i++) {
                for(j=1, sum=0; j<=4; j++) {
                    param += "&ETC_AMT"+(i+1)+""+j+"=0";
                }			
                param += "&ETC_ROWSUM"+(i+1)+"=0";
			}
			
		    for(j=0; j<4; j++) {
		      param += "&ETC_COLSUM"+(j+1)+"="+document.getElementById("txtETC_COLSUM"+(j+1)).value.replace(",", "").replace(",", "").replace(",", "");
	        }
	              
            param += "&ETC_TOTSUM="+document.getElementById("txtETC_TOTSUM").value.replace(",", "").replace(",", "").replace(",", "");
            
            
            for(i=1; i<=4; i++) {
                param += "&SUB_COLSUM"+i+"="+document.getElementById("txtSUB_COLSUM"+i).value.replace(",", "").replace(",", "").replace(",", "");                                
            }
            
            param += "&SUB_TOTSUM="+document.getElementById("txtSUB_TOTSUM").value.replace(",", "").replace(",", "").replace(",", "");
            
            param += "&TOTAL="+document.getElementById("txtTOTAL").value.replace(",", "").replace(",", "").replace(",", "");

            if(ENO_NO_SHR == "") {
                alert("����� ������ �ּ���");
                txtENO_NO_SHR.focus();
                return;
            }

            if(APY_YMD_SHR == "" ){
                alert("������� �Է��Ͻʽÿ�.");
                txtYMD_SHR.focus();
                return;
            }
            

			var url = "insc010_PV.jsp?APY_YMD_SHR="+APY_YMD_SHR+"&ENO_NO_SHR=" + ENO_NO_SHR+"&DATE_TERM=" + DATE_TERM + "&OCC_NM_SHR=" + OCC_NM_SHR + "&PAST_DAY1=" + PAST_DAY1 + "&PAST_DAY2=" + PAST_DAY2 + "&PAST_DAY3=" + PAST_DAY3 + "&PAST_DAY4=" + PAST_DAY4 + param;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("����ӱݻ���", '', 225);
        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {
			 dsT_CP_PAYMASTER.ClearData();
             dsT_CP_CHANGE_FIELD.ClearData();
             dsT_CP_CHANGE1.ClearData();
             dsT_CP_CHANGE2.ClearData();
             dsT_CP_CHANGE3.ClearData();
             dsT_CP_CHANGE4.ClearData();
             dsT_CP_PAYMASTER_BONUS.ClearData();
             dsT_CP_YEARLYBONUS.ClearData();

	         fnc_OnLoadProcess();
			 document.getElementById("resultMessage").innerText = ' ';
             fncClearSearch();   //�˻� ���� �ʱ�ȭ
             fncClearData();     //���� �ʱ�ȭ
             fncClearDate();     //��¥ �ʱ�ȭ

             fncInitData();      //�ʱ� ���·�

            //����� ���� ���� �ٽ� �ʱ�ȭ
            fieldSum = new Array(0, 0, 0, 0);   //���������� �ʵ���� ��
            subTotal = 0;   //��[A]
            total = 0;      //�հ�[A+B+C]
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_PAYMASTER.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            fncInitData();

            document.getElementById("txtYMD_SHR").value = getToday();

             fnc_HiddenElement("imgPrint");
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /********************
         * ��Ÿ �Լ�  *
         *******************/

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup('txtENO_NO_SHR');

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmp();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');
            fnc_SearchEmp();
        }

        /**
         * �Է�â�� ������ ����.
         */
        function fncClearSearch() {
            //�ʱ�ȭ ��ų �Է�â
            var inputFields = new Array( "txtENO_NO_SHR"
                                        ,"txtENO_NM_SHR"
                                        ,"txtHIRG_YMD_SHR"
                                        ,"txtOCC_NM_SHR"
                                        ,"txtDPT_NM_SHR"
                                        ,"txtJOB_NM_SHR"
                                       // ,"txtYMD_SHR"
                                        ,"txtFROM_TO_YMD");
            for(i=0; i<inputFields.length; i++) {
                document.getElementById(inputFields[i]).value = "";
            }
        }

        /**
         * ��¥ ���� �ʱ�ȭ
         */
        function fncClearDate() {
            var obj = null;
            var value = null;
            var sum = 0;

            //�Ⱓ���� ����
            for(i=1; i<=4; i++) {
                obj = document.getElementById("WORKING_DATE"+i);//�ӱݰ��Ⱓ
                if(obj != null)
                    obj.innerHTML = "";
            }
            
            for(i=1; i<=4; i++) {
                obj = document.getElementById("PAST_DAY"+i);//���ϼ�
                if(obj != null)
                    obj.innerHTML =  "0";
            }
            
            document.getElementById("PAST_DAY_SUM").innerHTML = "0"; //�հ�
        }

        /**
         * �������� �� ����ӱ�, ����ӱ��� �ʱ�ȭ�Ѵ�.
         */
        function fncClearData() {
            var table = document.getElementById("CAL_TABLE");

            for(i=table.rows.length-1; i>=6; i--) {
                table.deleteRow(i-3);
            }

            document.getElementById("AVG_PAY1").innerHTML = ""; //����ӱ�
            document.getElementById("AVG_PAY2").innerHTML = ""; //����ӱ�
        }

        /**
         * �������� ���̺��� ������ ó�����·� �ʱ�ȭ ��Ų��.
         */
        function fncInitData() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            for(i=0; i<3; i++) {
                row = table.insertRow(3+i);

                //ó�������϶�
                if(i == 0) {
                    cell = row.insertCell();
                    cell.rowSpan = "3";
                    cell.className = "header";
                    cell.innerHTML = "��<br><br>��<br><br>��<br><br>��";

                    cell = row.insertCell();
                    cell.rowSpan = "2";
                    cell.className = "header";
                    cell.innerHTML = "��<br><br>��<br><br>��";

                    cell = row.insertCell();
                    cell.colSpan = "2";
                    cell.className = "header";
                    cell.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                }
                //�ι�°
                if(i == 1) {
                    cell = row.insertCell();
                    cell.className = "header";
                    cell.innerHTML = "��<br>Ÿ<br>��<br>��";

                    cell = row.insertCell();
                    cell.className = "header";
                    cell.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                }
                //����°
                if(i == 2) {
                    cell = row.insertCell();
                    cell.colSpan = "3";
                    cell.className = "header";
                    cell.innerHTML = "�� [A]";
                }


                //�ʵ� ȣ��
                for(j=1, sum=0; j<=5; j++) {
                    cell = row.insertCell();
                    cell.className = "content";
                    cell.innerHTML = "&nbsp;";
                }
            }
        }

        /**
         * �����Ⱓ �� ����
         */
        function fncChangeFromToYmd() {

            var selectYmd = document.getElementById("txtYMD_SHR").value;
            var fromToYmd = document.getElementById("txtFROM_TO_YMD");

            if(selectYmd.trim() != "") {
                var dateinfo = selectYmd.split("-");

                //from - to ��¥�� �����ϱ�
                var toDate = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);
                var fromDate = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);

                fromDate.setMonth(fromDate.getMonth()-3);
                fromDate.setDate(toDate.getDate()+1);

                //text �ֱ�
                fromToYmd.value = fromDate.format("yyyy-mm-dd")+" ~ "+toDate.format("yyyy-mm-dd");
            } else {
                fromToYmd.value = "";
            }
        }

        /**
         * ��¥ ���� ���� ���� ����
         */
        function bindingDate() {
            var selectYmd = document.getElementById("txtYMD_SHR").value;

            var obj = null;

            var fromTo = null;
            var pastDay = null;
            var sum = 0;
            var cnt = 0;

            var dateinfo = selectYmd.split("-");

            //from - to ��¥�� �����ϱ�
            var schDate = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);
            var strDate = null;
            var fromDate = null;

            if(fnc_covNumber(fnc_Lastday(schDate.getFullYear(), schDate.getMonth()+1)) == fnc_covNumber(schDate.format("dd"))
                    || fnc_covNumber(fnc_Lastday(schDate.getFullYear(), schDate.getMonth()+1)) == fnc_covNumber(schDate.format("dd"))+1  ) {
                cnt = 3;
                strDate = new Date(schDate.getFullYear(), schDate.getMonth()-2, "01");
                fromDate = new Date(schDate.getFullYear(), schDate.getMonth()-2, "01");
            } else {
                cnt = 4;
                strDate = new Date(schDate.getFullYear(), schDate.getMonth()-3, schDate.getDate()+1);
                fromDate = new Date(schDate.getFullYear(), schDate.getMonth()-3, schDate.getDate()+1);
            }

            //�Ⱓ���� ����
            for(i=1; i<=cnt; i++) {

                //ó���϶�
                if(i == 1) {
                    fromTo = fromDate.format("yyyy-mm-dd")+"\n"+fromDate.format("yyyy-mm-")+fnc_Lastday(fromDate.getFullYear(), fromDate.getMonth()+1);
                    pastDay = fnc_covNumber(fnc_Lastday(fromDate.getFullYear(), fromDate.getMonth()+1)) - fnc_covNumber(fromDate.format("dd")) +1;
                }

                //�������϶�
                else if(i == cnt) {
                    fromTo = fromDate.format("yyyy-mm-")+"01\n"+schDate.format("yyyy-mm-dd");
                    pastDay = fnc_covNumber(schDate.format("dd"));
                }

                //�ι�°, ����°�϶�
                else {
                    fromTo = fromDate.format("yyyy-mm-")+"01\n"+fromDate.format("yyyy-mm-")+fnc_Lastday(fromDate.getFullYear(), fromDate.getMonth()+1);
                    pastDay = fnc_covNumber(fnc_Lastday(fromDate.getFullYear(), fromDate.getMonth()+1));
                }

                obj = document.getElementById("WORKING_DATE"+i);
                obj.innerText = fromTo;

                obj = document.getElementById("PAST_DAY"+i);
                obj.innerText =  pastDay;

                sum += pastDay;
                fromDate = new Date(fromDate.getFullYear(), fromDate.getMonth()+1, fromDate.getDate());
            }
            //�����Ⱓ �� ����
            document.getElementById("txtFROM_TO_YMD").value = strDate.format("yyyy-mm-dd")+" ~ "+schDate.format("yyyy-mm-dd");
            //�ѱٹ��ϼ�
            document.getElementById("PAST_DAY_SUM").innerText = sum;
        }

        /**
         * ��������� ���� ���� ����
         */
        function bindingPay() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;
            var FIELD_NM_A = new Array( "�⺻��"
                                       ,"��å����"
                                       ,"�ð��ܼ���"
                                       ,"���������"
                                       ,"�ڱⰳ��"
                                       ,"�߱ټ���"
                                       ,"�������"
                                       ,"�ټӼ���"
                                       );

            var FIELD_NM_M = new Array( "�⺻��"
                                       ,"��������"
                                       ,"�ð��ܼ���"
                                       ,"�������"
                                       ,"�ù����"
                                       ,"����/�۾�����"
                                       ,"�ڱⰳ�ߺ�"
                                       ,"�ټӼ���"
                                       );

            var FIELD_CD = new Array  ( "BAS"
                                       ,"DUTY"
                                       ,"OT"
                                       ,"WEL"
                                       ,"OSE"
                                       ,"RUN"
                                       ,"MH"
                                       ,"LSEV"
                                       );

            var obj = null;
            FIELD_NM = null; //��������
            var value = null;
            var name = null;
            var sum = 0;

            //������ ��� ����
            if(OCC_CD == 'A') {
                FIELD_NM = FIELD_NM_A;
            } else {
                FIELD_NM = FIELD_NM_M;
            }

            for(i=0; i<FIELD_NM.length; i++) {
                row = table.insertRow(3+i);

                //ó�������϶�
                if(i == 0) {
                    cell = row.insertCell();
                    cell.rowSpan = 8+dsT_CP_CHANGE_FIELD.CountRow+5;
                    cell.className = "header";
                    cell.innerHTML = "��<br><br>��<br><br>��<br><br>��";

                                        cell = row.insertCell();
                    cell.rowSpan = 8+dsT_CP_CHANGE_FIELD.CountRow+2;
                    cell.className = "header";
                    cell.innerHTML = "��<br><br>��<br><br>��";
                }

                //�׸�� �ֱ�
                name = FIELD_NM[i];

                cell = row.insertCell();
                cell.className = "header";
                cell.colSpan = "2";
                cell.innerHTML = name;


                //�� ����
                for(j=1, sum=0; j<=4; j++) {
                    cell = row.insertCell();
                    cell.className = "textbox";
                    value = dsT_CP_PAYMASTER.nameValue(j, FIELD_CD[i]+"_AMT");

                    if(value == undefined) value = "0";
                    
                    //�����
                    cell.innerHTML = "<input id='txtFLD_AMT"+(i+1)+""+j+"' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(value)+"' readonly>";
                    sum += parseInt(value);
                    fieldSum[j-1] += parseInt(value);
                }
                
                cell = row.insertCell();
                cell.className = "textbox";
                
                //����� row��
                cell.innerHTML = "<input id='txtFLD_ROWSUM"+(i+1)+"' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(sum)+"' readonly>";
            }
        }

        /**
         * ��Ÿ���翡 ���� ���� ����
         */
        function bindingEtc() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            var objectDS = null;
            var value = null;
            var name = null;
            var sum = 0;

            var etcSum = new Array(0, 0, 0, 0);

            if(dsT_CP_CHANGE_FIELD.CountRow > 0) {
                for(i=0; i<dsT_CP_CHANGE_FIELD.CountRow; i++) {
                    row = table.insertRow(11+i);

                    if(i == 0) {
                        cell = row.insertCell();
                        cell.className = "header";
                        cell.rowSpan= dsT_CP_CHANGE_FIELD.CountRow+1;
                        cell.innerHTML = "��<br>Ÿ<br>��<br>��";
                    }

                    //�׸�� ����
                    name = dsT_CP_CHANGE_FIELD.nameValue(i+1, "SAL_NM");

                    cell = row.insertCell();
                    cell.className = "header";
                    cell.innerHTML = name;//�׸��

                    //�� ����
                    for(j=1, sum=0; j<=4; j++) {
                        objectDS = document.getElementById("dsT_CP_CHANGE"+j);

                        cell = row.insertCell();
                        cell.className = "textbox";
                        value = objectDS.nameValue(i+1, "AMOUNT");

                        if(value == undefined) value = "0";
                        
                        //��Ÿ���� �� �׸� ��
                        cell.innerHTML = "<input id='txtETC_AMT"+(i+1)+""+j+"' type='text' size='15' maxlength='10' style='ime-mode:disabled;text-align:right;' onkeypress='cfCheckNumber();' onfocusout='this.value=formatNumber(this.value)' onchange='fnc_allSum()' value='"+formatNumber(value)+"'>";
                        
                        sum += parseInt(value);
                        fieldSum[j-1] += parseInt(value);
                        etcSum[j-1] += parseInt(value);
                    }

                    //�� ���ϱ�
                    cell = row.insertCell();
                    cell.className = "textbox";
                    
                    //��Ÿ���� �� row �հ�
                    cell.innerHTML = "<input id='txtETC_ROWSUM"+(i+1)+"' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(sum)+"' readonly>";
                }

                sum = 0;

                //��Ÿ���� �Ұ� ��������
                row = table.insertRow(11+dsT_CP_CHANGE_FIELD.CountRow);
                cell = row.insertCell();
                cell.className = "header";
                cell.innerHTML = "��&nbsp;&nbsp;&nbsp;��";

                for(j=0; j<4; j++) {
                    cell = row.insertCell();
                    cell.className = "textbox";
                    //��Ÿ���� �� col �Ұ�
                    cell.innerHTML = "<input id='txtETC_COLSUM"+(j+1)+"' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(etcSum[j])+"' readonly>";
                    sum += parseInt(etcSum[j]);
                }

                cell = row.insertCell();
                cell.className = "textbox";
                //�հ��� �Ұ�
                cell.innerHTML = "<input id='txtETC_TOTSUM' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(sum)+"' readonly>";
            }
            //��Ÿ������ �ϳ��� ������
            else {
                row = table.insertRow(11);

                cell = row.insertCell();
                cell.className = "header";
                cell.rowSpan= dsT_CP_CHANGE_FIELD.CountRow+1;
                cell.innerHTML = "��<br>Ÿ<br>��<br>��";

                cell = row.insertCell();
                cell.className = "header";
                cell.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

                for(j=0; j<5; j++) {
                    cell = row.insertCell();
                    cell.className = "content";
                    cell.innerHTML = "0";
                }
            }
        }

        /**
         * �� �ʵ��� ���� ����
         */
        function bindingSubSum() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            var sum = 0;

            row = table.insertRow(12+dsT_CP_CHANGE_FIELD.CountRow);
            cell = row.insertCell();
            cell.colSpan = "2";
            cell.className = "header";
            cell.innerHTML = "��&nbsp;&nbsp;&nbsp;[A]";

            for(i=1; i<=4; i++) {
                cell = row.insertCell();
                cell.className = "textbox";
                cell.innerHTML = "<input id='txtSUB_COLSUM"+i+"' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(fieldSum[i-1])+"' readonly>";
                                
                sum += fieldSum[i-1];
            }

            cell = row.insertCell();
            cell.className = "textbox";
            cell.id = "SUB_TOTSUM";
            cell.innerHTML = "<input id='txtSUB_TOTSUM' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(sum)+"' readonly>";

            subTotal += sum;
            total += sum;
        }

        /**
         * �󿩱��� �����Ѵ�.
         */
        function bindingBonus() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            var sum = 0;
            var bonValue = dsT_CP_PAYMASTER_BONUS.nameValue(1, "BONUS");
            if(bonValue == undefined) bonValue = "0";

            row = table.insertRow(13+dsT_CP_CHANGE_FIELD.CountRow);
            cell = row.insertCell();
            cell.colSpan = "3";
            cell.className = "header";
            cell.innerHTML = "��&nbsp;��&nbsp;��&nbsp;[B]";

            cell = row.insertCell();
            cell.colSpan = "4";
            cell.className = "content2";
            cell.innerHTML = formatNumber(bonValue)+" �� x 3 / 12 = ";

            sum = parseInt(bonValue)*3/12;

            cell = row.insertCell();
            cell.className = "content";
            cell.id = "BONUS";
            cell.innerHTML = formatNumber(sum);

            total += sum;
        }

        /**
         * ������������ �����Ѵ�.
         */
        function bindingYearBonus() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            var sum = 0;
            var ymaValue = dsT_CP_YEARLYBONUS.nameValue(1, "YEAR_BONUS");
            if(ymaValue == undefined) ymaValue = "0";

            row = table.insertRow(14+dsT_CP_CHANGE_FIELD.CountRow);
            cell = row.insertCell();
            cell.colSpan = "3";
            cell.className = "header";
            cell.innerHTML = "����������[C]";

            cell = row.insertCell();
            cell.colSpan = "4";
            cell.className = "content2";
            cell.innerHTML = formatNumber(ymaValue)+" �� x 3 / 12 = ";

            sum = parseInt(ymaValue)*3/12;

            cell = row.insertCell();
            cell.className = "content";
            cell.id = "YEAR_BONUS";
            cell.innerHTML = formatNumber(sum);

            total += sum;
        }

        /**
         * [A+B+C] �հ踦 �����Ѵ�.
         */
        function bindingTotalSum() {
            var table = document.getElementById("CAL_TABLE");
            var row = null;
            var cell = null;

            row = table.insertRow(15+dsT_CP_CHANGE_FIELD.CountRow);
            cell = row.insertCell();
            cell.colSpan = "3";
            cell.className = "header";
            cell.innerHTML = "��&nbsp;&nbsp;��&nbsp;[A+B+C]";

            cell = row.insertCell();
            cell.colSpan = "4";
            cell.className = "content2";
            cell.innerHTML = "(���޿�)&nbsp;&nbsp;+&nbsp;&nbsp;(�󿩱�)&nbsp;&nbsp;+&nbsp;&nbsp;(����������)";

            cell = row.insertCell();
            cell.className = "textbox";
            cell.id = "TOTAL";
            cell.innerHTML = "<input id='txtTOTAL' type='text' size='15' style='ime-mode:disabled;text-align:right;border:0' value='"+formatNumber(total)+"' readonly>";
        }

        /**
         * ����ӱ��̶� ����ӱ��� �����Ѵ�.
         */
        function bindingAveragePay() {
            var AVG_PAY1 = document.getElementById("AVG_PAY1");
            var AVG_PAY2 = document.getElementById("AVG_PAY2");

            var totalDay = document.getElementById("PAST_DAY_SUM").firstChild.nodeValue;

            AVG_PAY1.innerHTML = "(���ӱݾ�)&nbsp;&nbsp;&nbsp;"+formatNumber(total)+"&nbsp;&nbsp;&nbsp;&nbsp;&divide;&nbsp;&nbsp;&nbsp;&nbsp;"+totalDay+"&nbsp;&nbsp;&nbsp;&nbsp;=&nbsp;&nbsp;&nbsp;"+formatNumber(Math.round(total/parseInt(totalDay)));
            AVG_PAY2.innerHTML = "( �� [A] )&nbsp;&nbsp;&nbsp;"+formatNumber(subTotal)+"&nbsp;&nbsp;&nbsp;&nbsp;&divide;&nbsp;&nbsp;&nbsp;&nbsp;"+totalDay+"&nbsp;&nbsp;&nbsp;&nbsp;=&nbsp;&nbsp;&nbsp;"+formatNumber(Math.round(subTotal/parseInt(totalDay)));
        }

        //��� �հ踦 �ٽ��Ѵ�.
        function fnc_allSum() {

            var sum = 0;
            var etcSum = new Array(0, 0, 0, 0);
        
            //�������� �ʱ�ȭ
            fieldSum = new Array(0, 0, 0, 0);   //���������� �ʵ���� ��
            subTotal = 0;   //��[A]S
            total = 0;      //�հ�[A+B+C]
            
            
            //�������
            sum = 0;
            var fldValue = 0;
            
            for(i=0; i<FIELD_NM.length; i++) {
                for(j=1, sum=0; j<=4; j++) {
                    fldValue = document.getElementById("txtFLD_AMT"+(i+1)+""+j).value.replace(",", "").replace(",", "").replace(",", "");
                    sum += parseInt(fldValue);
                    fieldSum[j-1] += parseInt(fldValue);
                }

                document.getElementById("txtFLD_ROWSUM"+(i+1)).value = formatNumber(sum);
            }            
            
            
            //��Ÿ����
            sum = 0;
            var etcValue = 0;
            
            if(dsT_CP_CHANGE_FIELD.CountRow > 0) {
            
                for(i=0; i<dsT_CP_CHANGE_FIELD.CountRow; i++) {
                
                    for(j=1, sum=0; j<=4; j++) {
                        etcValue = document.getElementById("txtETC_AMT"+(i+1)+""+j).value.replace(",", "").replace(",", "").replace(",", "");
                        sum += parseInt(etcValue);
                        fieldSum[j-1] += parseInt(etcValue);
                        etcSum[j-1] += parseInt(etcValue);                    
                    }
                    
                    //��Ÿ���� �� row �հ�
                    document.getElementById("txtETC_ROWSUM"+(i+1)).value = formatNumber(sum);
                }
                
                sum = 0;
                
                for(j=0; j<4; j++) {
                    //��Ÿ���� �� col �Ұ�
                    document.getElementById("txtETC_COLSUM"+(j+1)).value = formatNumber(etcSum[j]);
                    sum += parseInt(etcSum[j]);
                }
                
                //�հ��� �Ұ�
                document.getElementById("txtETC_TOTSUM").value = formatNumber(sum);
               
            }
            
            
            //���޿� ��
            sum = 0;
            
            for(i=1; i<=4; i++) {
                //�� col ��                                
                document.getElementById("txtSUB_COLSUM"+i).value = formatNumber(fieldSum[i-1]);
                sum += fieldSum[i-1];
            }
            
            document.getElementById("txtSUB_TOTSUM").value = formatNumber(sum);
            subTotal += sum;
            total += sum;
            
            
            //�󿩱�
            sum = 0;
            
            var bonValue = dsT_CP_PAYMASTER_BONUS.nameValue(1, "BONUS");
            if(bonValue == undefined) bonValue = "0";
            sum = parseInt(bonValue)*3/12;
            total += sum;
            
            
            //����������
            sum = 0;
            
            var ymaValue = dsT_CP_YEARLYBONUS.nameValue(1, "YEAR_BONUS");
            if(ymaValue == undefined) ymaValue = "0";
            sum = parseInt(ymaValue)*3/12;
            total += sum;
            
            //[A+B+C] �հ�
            document.getElementById("txtTOTAL").value = formatNumber(total);
            
            //����ӱ��̶� ����ӱ�
            bindingAveragePay();
            
        }
        
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                      |
    +------------------------------------------------------>
    <Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_CP_PAYMASTER                       |
    | 3. Table List : T_CP_PAYMASTER                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_CP_CHANGE_FIELD                  |
    | 3. Table List : T_CP_CHANGE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE_FIELD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_CP_CHANGE1                       |
    | 3. Table List : T_CP_CHANGE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_CP_CHANGE2                       |
    | 3. Table List : T_CP_CHANGE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_CP_CHANGE3                       |
    | 3. Table List : T_CP_CHANGE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CP_CHANGE4                      |
    | 3. Table List : T_CP_CHANGE                   |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE4" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                      |
    | 2. �̸� : dsT_CP_PAYMASTER_BONUS               |
    | 3. Table List : T_CP_PAYMASTER                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_BONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                      |
    | 2. �̸� : dsT_CP_YEARLYBONUS                   |
    | 3. Table List : T_CP_YEARLYBONUS               |
    +----------------------------------------------->
    <Object ID="dsT_CP_YEARLYBONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>



    <!-----------------------------------------------------+
    | 1. ���� �޺��� ���� DataSet - ��������                                         |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_V2"/>
       <jsp:param name="CODE_GUBUN"    value="V2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. ���� �޺��� ���� DataSet - �ٷα��б���                                         |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if(iCount >= 1) {
            OCC_CD = dsT_CM_PERSON.NameValue(1, "OCC_CD");
        }
    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        //����� ���� ���� �ٽ� �ʱ�ȭ
        fieldSum = new Array(0, 0, 0, 0);   //���������� �ʵ���� ��
        subTotal = 0;   //��[A]
        total = 0;      //�հ�[A+B+C]

        fncClearData();     //���� �ʱ�ȭ
        fncClearDate();     //��¥ �ʱ�ȭ

        bindingDate();          //��¥���� ����(�ӱݰ��Ⱓ, ���ϼ�)
        bindingPay();           //������� ����(�⺻�� �� �� �׸��� �� �Ⱓ���� �հ�)
        bindingEtc();           //��Ÿ���� ����
        bindingSubSum();        //�� �踦 ����
        bindingBonus();         //�󿩱��� ����
        bindingYearBonus();     //������������ ����
        bindingTotalSum();      //�հ踦 ����
        bindingAveragePay();    //����ӱ�,����ӱ��� ����

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CP_PAYMASTER event="OnFail()">
        cfErrorMsg(this);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����ӱݻ���</td>
					<td align="right" class="navigator">HOME/�����Ļ�/���纸��/<font color="#000000">����ӱݻ���</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="110"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�����ȣ</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" maxlength="12" style="width:70%" onkeypress="cfNumberCheck(); if(event.keyCode==13) fnc_SearchEmp()" onchange="fnc_SearchEmp()" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
                                </td>
                                <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                <td class="padding2423">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="14" onkeypress="if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                                </td>
                                <td align="right" class="searchState">��&nbsp;��&nbsp;��</td>
                                <td class="padding2423">
                                    <input id="txtHIRG_YMD_SHR" name="txtHIRG_YMD_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                            </tr>
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
                            <tr>
                                <td align="right" class="searchState">���������߻���</td>
                                <td class="padding2423">
                                    <input id="txtYMD_SHR" name="txtYMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();javascript:if(event.keyCode==13) fnc_SearchEmp();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtYMD_SHR','','130','155');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="right" class="searchState">�����Ⱓ</td>
                                <td class="padding2423" colspan="3">
                                    <input id="txtFROM_TO_YMD" name="txtFROM_TO_YMD" size="23" class="input_ReadOnly" readonly>
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

<!-- ��ȸ ���� ���̺� ���� -->
<table width="520" border="0" cellspacing="0" cellpadding="0">
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

<!-- �������� ���� -->
<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#999999" id="CAL_TABLE">

	<tr align="center">
		<td colspan="9" class="header">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��</td>
	</tr>
	
    <tr>
        <td class="header" colspan="4" height="22">�ӱݰ��Ⱓ</td>
        <td class="header" id="WORKING_DATE1" width="130"></td>
        <td class="header" id="WORKING_DATE2" width="130"></td>
        <td class="header" id="WORKING_DATE3" width="130"></td>
        <td class="header" id="WORKING_DATE4" width="130"></td>
        <td class="header" width="130">��&nbsp;&nbsp;&nbsp;��</td>
    </tr>
    
    <tr>
        <td class="header" colspan="4" height="22">��&nbsp;��&nbsp;��</td>
        <td class="content2" id="PAST_DAY1">0</td>
        <td class="content2" id="PAST_DAY2">0</td>
        <td class="content2" id="PAST_DAY3">0</td>
        <td class="content2" id="PAST_DAY4">0</td>
        <td class="content2" id="PAST_DAY_SUM">0</td>
    </tr>
    
    <tr>
        <td class="content2" colspan="9">&nbsp;</td>
    </tr>
    
    <tr>
        <td class="header" colspan="4">��&nbsp;��&nbsp;��&nbsp;��</td>
        <td class="content2" colspan="5" id="AVG_PAY1"></td>
    </tr>
    
    <tr>
        <td class="header" colspan="4">��&nbsp;��&nbsp;��&nbsp;��</td>
        <td class="content2" colspan="5" id="AVG_PAY2"></td>
    </tr>
</table>
<!-- �������� �� -->

</form>
<!-- form �� -->

</body>
</html>

    <!--**************************************************************************************
    *                                                                                        *
    *   ���ε� ������Ʈ                                                                             *
    *                                                                                        *
    ***************************************************************************************-->

    <!-- T_CM_PERSON ��ȸ�ؿ� ��� ������ â�� �ѷ��� -->
    <object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_CM_PERSON">
        <Param Name="BindInfo", Value='
            <C>Col=ENO_NO               Ctrl=txtENO_NO_SHR              Param=value     </C>
            <C>Col=ENO_NM               Ctrl=txtENO_NM_SHR              Param=value     </C>
            <C>Col=DPT_NM               Ctrl=txtDPT_NM_SHR              Param=value     </C>
            <C>Col=JOB_NM               Ctrl=txtJOB_NM_SHR              Param=value     </C>
            <C>Col=HIRG_YMD             Ctrl=txtHIRG_YMD_SHR            Param=value     </C>
            <C>Col=OCC_NM               Ctrl=txtOCC_NM_SHR              Param=value     </C>
        '>
    </object>

    <!-- T_CP_PAYMASTER ���� ���̺� -->
    <object id="bndT_CP_PAYMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_CP_PAYMASTER">
        <Param Name="BindInfo", Value="
            <C>Col=DPT_NM           Ctrl=txtDPT_NM          Param=value</C>
            <C>Col=JOB_NM           Ctrl=txtJOB_NM          Param=value</C>
            <C>Col=HIU_NO           Ctrl=txtHIU_NO          Param=value</C>
            <C>Col=GRD_PCT          Ctrl=txtGRD_PCT         Param=value</C>
        ">
    </object>