 <!--
*****************************************************
* @source      : reta080.jsp
* @description : ���꼼��/�����ݰ���/�����ݰ��ó��
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/09      ����ȣ                   �����ۼ�
* 2007/04/11      ���м�                   �μ�κ� �߰�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%@ page import="com.shift.gef.configuration.Configuration" %>




<html>
<head>
<title>�����ݰ��ó�� (DC��)</title>
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
        padding-right : 6px;
        background-color: #ffffff;
        text-align: right;
    }
    .content2 {
        padding: 1px;
        background-color: #ffffff;
        text-align: center;
    }
    .content3 {
        padding: 1px;
        background-color: #ffffff;
        text-align: left;
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
                    + "T"   //����
                    + "T"   //���
                    + "F"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.a.reta080.cmd.RETA080CMD";
        var params = null;

        var oriEnoNo = "";//�˻������� ���
        var oriType = ""; //�˻������� ����
        var oriYmd = "";//�˻������� ������

        //�˻� Input, Select Element�� ID
        var ExceptionList = new Array ( "txtENO_NO_SHR"
                                       ,"txtENO_NM_SHR"
                                       ,"txtHIRG_YMD_SHR"
                                       ,"txtHIRR_YMD_SHR"
                                       ,"txtOCC_NM_SHR"
                                       ,"txtOCC_CD_SHR"
                                       ,"txtDPT_NM_SHR"
                                       ,"txtJOB_NM_SHR"
                                       ,"cmbTYPE_SHR"
                                       ,"hidRET_YMD_ORI"
                                       ,"hidHIR_YMD_ORI"
                                       ,"hidRAM_YMD_ORI"
                                       ,"txtRET_YMD_SHR"
                                       ,"txtRAM_YMD_SHR"
                                       ,"txtRAM_YMD2_SHR"
                                       ,"txtRAM_YMD3_SHR"
                                       ,"txtRETP_YMD_SHR"
                                       ,"txtMID_YMD1_SHR"
                                       ,"txtMID_YMD2_SHR"
                                       ,"txtMID_YMD3_SHR"
                                       ,"hidHIR_YMD_SHR"
                                       ,"txtHIRG_YMD"
                                       ,"txtRET_YMD");

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            //�˻�����
            var oENO_NO         = document.getElementById("txtENO_NO_SHR");
            var oOCC_CD         = document.getElementById("txtOCC_CD_SHR");
            var oTYPE           = document.getElementById("cmbTYPE_SHR");
            var oHIRG_YMD       = document.getElementById("txtHIRG_YMD");
            var oRET_YMD        = document.getElementById("txtRET_YMD");
            var oYMD_VAL        = null;

            if(oENO_NO.value == "") {
                alert("����� ������ �ּ���");
                oENO_NO.focus();
                return;
            }

            if(oTYPE.value == "" ){
                alert("������ ������ �ּ���.");
                oTYPE.focus();
                return;
            }

            //������ ���п� ���� �˻� ��¥�� ������
            if(oTYPE.value == "0") {
                oYMD_VAL = document.getElementById("txtRETP_YMD_SHR").value;
            } else if(oTYPE.value == "1") {
                oYMD_VAL = document.getElementById("txtMID_YMD1_SHR").value;
            } else if(oTYPE.value == "2") {
                oYMD_VAL = document.getElementById("txtMID_YMD2_SHR").value;
            } else if(oTYPE.value == "3") {
                oYMD_VAL = document.getElementById("txtMID_YMD3_SHR").value;
            }

            //�����Ⱓ�� ����
            bindingTenure();

            //������ �� �̸� ������ ����
            document.getElementById("hidRAM_YMD_ORI").value = oYMD_VAL;
            document.getElementById("hidHIR_YMD_ORI").value = oHIRG_YMD.value;
            document.getElementById("hidRET_YMD_ORI").value = oRET_YMD.value;


            //�˻� ��¥(�����, �߰�������)�� ������ ����
            if(oYMD_VAL == "") {
                alert("������ ��� ����ڰ� �ƴմϴ�.");

                //DataSet�� �ʱ�ȭ ��Ŵ
                dsT_AC_RETPAY.ClearData();
                dsT_AC_RETBONUS.ClearData();
                dsT_CP_YEARLYBONUS.ClearData();
                dsT_AC_TENURE.ClearData();
                dsT_AC_RETMASTER.ClearData();
                dsT_AC_RETNORMALPAY.ClearData();

                document.getElementById("resultMessage").innerText = ' ';
                fncClearDate(); //��¥ �ʱ�ȭ
                fnc_ClearInputFieldAll(ExceptionList); //��� �Է�â�� �ʱ�ȭ

                document.form1.print_flag.value = "N";

                return;
            }
            if(oHIRG_YMD.value == "") {
                //alert("�Ի����� ��� �ֽ��ϴ�.");
                return;
            }
            if(oRET_YMD.value == "") {
                //alert("������� ��� �ֽ��ϴ�.");
                return;
            }
            //�˻������� �ش� ���� ����
            oriEnoNo = oENO_NO.value;
            oriType = oTYPE.value;
            oriYmd = oYMD_VAL;


            params = "&S_MODE=SHR"
                   + "&ENO_NO="+oENO_NO.value
                   + "&SEQ_NO="+oTYPE.value
                   + "&OCC_CD="+oOCC_CD.value
                   + "&YMD="+oYMD_VAL
                   + "&HIRG_YMD="+oHIRG_YMD.value
                   + "&RET_YMD="+oRET_YMD.value;


            //DataSet�� �ʱ�ȭ ��Ŵ
            dsT_AC_RETPAY.ClearData();
            dsT_AC_RETBONUS.ClearData();
            dsT_CP_YEARLYBONUS.ClearData();
            dsT_AC_TENURE.ClearData();
            dsT_AC_RETMASTER.ClearData();
			dsT_AC_RETNORMALPAY.ClearData();

            //���Ϲ��� DataSet ����
            trT_AC_RETPAY.KeyValue = "tr02"
                                   + "(O:dsT_AC_RETPAY=dsT_AC_RETPAY"                   //��������
                                   + ",O:dsT_AC_RETPAY2=dsT_AC_RETPAY2"                   //��������
                                   + ",O:dsBIND_DATE=dsBIND_DATE"                       //�ٹ��Ⱓ
                                   + ",O:dsT_AC_RETBONUS=dsT_AC_RETBONUS"               //�󿩱�
                                   + ",O:dsT_CP_YEARLYBONUS=dsT_CP_YEARLYBONUS"         //����������
                                   + ",O:dsT_AC_TENURE=dsT_AC_TENURE"                   //�ټӱⰣ, �ټӺ���
                                   + ",O:dsT_AC_RETMASTER=dsT_AC_RETMASTER"             //������ �޿� ����
                                   + ",O:dsT_AC_RETNORMALPAY=dsT_AC_RETNORMALPAY)";     //����ӱ�

			trT_AC_RETPAY.action = dataClassName+params;
			trT_AC_RETPAY.post();

            //�Ⱥг����� ��ȸ
            //fnc_SearchProp();
        }



        /**
         * �����Ⱓ, �ټӱⰣ, �ټӺ����� ������
         */
        function fnc_SearchYear() {
            var oHIRG_YMD = document.getElementById("txtHIRG_YMD");
            var oRET_YMD = document.getElementById("txtRET_YMD");

            if(oHIRG_YMD.value == "") {
                //alert("�Ի����� ��� �ֽ��ϴ�.");
                return;
            }
            if(oRET_YMD.value == "") {
                //alert("������� ��� �ֽ��ϴ�.");
                return;
            }

            //�˻������� �������� �̸� ������� ����
            document.getElementById("hidRET_YMD_ORI").value = oRET_YMD.value;

            params = "&S_MODE=SHR_YEAR"
                   + "&HIRG_YMD=" + oHIRG_YMD.value
                   + "&RET_YMD="  + oRET_YMD.value;

            //���Ϲ��� DataSet ����
            trT_AC_TENURE.KeyValue = "tr02"
                                   + "(O:dsT_AC_TENURE=dsT_AC_TENURE)";

            trT_AC_TENURE.action = dataClassName+params;
            trT_AC_TENURE.post();
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
            if(dsT_AC_RETMASTER.CountColumn == 0) {
                alert("��ȸ�� ���� ���ּ���.");
                return;
            }
            if(oriEnoNo == "") {
                alert("����� ������ �ּ���");
                return;
            }
            if(oriType == "" ){
                alert("������ ������ �ּ���.");
                return;
            }
            if(document.getElementById("hidRET_YMD_ORI").value == "") {
                alert("�ش� �ڷᰡ �������� �ʽ��ϴ�.");
                return;
            }

            //DS ���¸� �Է� ���·� �ٲ�
            dsT_AC_RETMASTER.UseChangeInfo = false;
            dsT_AC_RETPAY.UseChangeInfo = false;
            dsT_AC_RETBONUS.UseChangeInfo = false;


            //DS�� Row�� ���� ��� +1 �����ش�.
            if(dsT_AC_RETMASTER.CountRow < 1) {
                dsT_AC_RETMASTER.AddRow();
            }

            //������ ������ �����ͼ� DS �� �����Ѵ�.
            dsT_AC_RETMASTER.nameValue(1,"ENO_NO")      = oriEnoNo;
            dsT_AC_RETMASTER.nameValue(1,"SEQ_NO")      = oriType;

            dsT_AC_RETMASTER.nameValue(1,"HIRG_YMD")    = document.getElementById("hidHIR_YMD_ORI").value;      //������
            dsT_AC_RETMASTER.nameValue(1,"RET_YMD")     = document.getElementById("hidRET_YMD_ORI").value;      //����(�߰�����) ��
            dsT_AC_RETMASTER.nameValue(1,"RAM_YMD")     = document.getElementById("hidRAM_YMD_ORI").value;      //����(�߰�����) �����

            dsT_AC_RETMASTER.nameValue(1,"RTR_AMT")     = document.getElementById("txtRET_PAY").value.replace(/,/g,'');
            dsT_AC_RETMASTER.nameValue(1,"ASD_AMT")     = document.getElementById("txtASD_AMT").value.replace(/,/g,'');
            dsT_AC_RETMASTER.nameValue(1,"AVG_AMT")     = document.getElementById("txtAVG_PAY").value.replace(/,/g,'');
            dsT_AC_RETMASTER.nameValue(1,"DAY_AVG_AMT")     = "0";
            //dsT_AC_RETMASTER.nameValue(1,"PAY_DAY")     = document.getElementById("txtED_DAY").value.replace(/,/g,'');
           // dsT_AC_RETMASTER.nameValue(1,"BON_AVG")     = document.getElementById("txtSUB_BON").value.replace(/,/g,'');
            dsT_AC_RETMASTER.nameValue(1,"LSE_YY")      = document.getElementById("txtRET_LSE_YY").value.replace(/,/g,'');
            dsT_AC_RETMASTER.nameValue(1,"LSE_MM")      = document.getElementById("txtRET_LSE_MM").value.replace(/,/g,'');
            dsT_AC_RETMASTER.nameValue(1,"LSE_DD")      = document.getElementById("txtRET_LSE_DD").value.replace(/,/g,'');
            dsT_AC_RETMASTER.nameValue(1,"LSE_PER")     = document.getElementById("txtRET_LSE_PER").value.replace(/,/g,'');
            dsT_AC_RETMASTER.nameValue(1,"MNOR_WAG")    = document.getElementById("txtNORMAL_PAY").value.replace(/,/g,'');
            //dsT_AC_RETMASTER.nameValue(1,"TUN_DD")      = document.getElementById("txtTUN_DD").value.replace(/,/g,'');
            //dsT_AC_RETMASTER.nameValue(1,"PAY_AMT")     = document.getElementById("txtYEAR_BONUS").value.replace(/,/g,'');
            /*
            if(document.getElementById("chkSUB_BON").checked) {
                dsT_AC_RETMASTER.nameValue(1,"YN_TAG")  = "Y";
            } else {
                dsT_AC_RETMASTER.nameValue(1,"YN_TAG")  = "N";
            }
*/
            params = "&S_MODE=SAV"
                   + "&ENO_NO="+oriEnoNo
                   + "&SEQ_NO="+oriType
                   + "&YMD="+oriYmd;

            //������ ��¥������ ������ �´�.
            for(i=1; i<=4; i++) {
                params += "&STR_YMD"+i+"="+document.getElementById("txtSTR_YMD"+i).value;
                params += "&END_YMD"+i+"="+document.getElementById("txtEND_YMD"+i).value;
            }

            //���Ϲ��� DataSet ����
            trT_AC_RETPAY_SAV.KeyValue = "TR_SAV"
                                   + "(I:dsT_AC_RETMASTER=dsT_AC_RETMASTER"         //������ ����
                                   + ",I:dsT_AC_RETPAY=dsT_AC_RETPAY"           //�޿�
                                   + ",I:dsT_AC_RETBONUS=dsT_AC_RETBONUS"           //�󿩱�
                                   + ")";//�Ⱥг���

            trT_AC_RETPAY_SAV.action = dataClassName+params;
            trT_AC_RETPAY_SAV.post();
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
            if(dsT_AC_RETMASTER.CountColumn == 0) {
                alert("��ȸ�� ���� ���ּ���.");
                return;
            }
            if(dsT_AC_RETMASTER.CountRow == 0) {
                alert("������ �ڷᰡ �����ϴ�.");
                return;
            }

            if(dsT_AC_RETMASTER.NameString(dsT_AC_RETMASTER.RowPosition, "SEQ_NO") == "0"
                    && dsT_AC_RETMASTER.NameString(dsT_AC_RETMASTER.RowPosition, "IS_PROC") == "Y") {
                alert("������ó���� �̹� �������ϴ�.\n�ش��ڷḦ �����Ͻ� �� �����ϴ�.");
                return;
            }

            if(!confirm("������ ��� ������ ������ ���� �Ͻðڽ��ϱ�?"))
                return;

            //DS ���¸� �Է� ���·� �ٲ�
            dsT_AC_RETMASTER.UseChangeInfo = false;

            params = "&S_MODE=DEL"
                   + "&ENO_NO="+oriEnoNo
                   + "&SEQ_NO="+oriType;

            //���Ϲ��� DataSet ����
            trT_AC_RETPAY_DEL.KeyValue = "TR_SAV"
                                       + "(I:dsT_AC_RETMASTER=dsT_AC_RETMASTER"         //������ ����
                                       + ")";

            trT_AC_RETPAY_DEL.action = dataClassName+params;
            trT_AC_RETPAY_DEL.post();
        }



        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {
            var f = document.form1;

            if ( f.print_flag.value == "Y" ) {
                var eno_no = f.txtENO_NO_SHR.value;
                var eno_nm = f.txtENO_NM_SHR.value;
                var occ_cd = f.txtOCC_CD_SHR.value;
                var dpt_nm = f.txtDPT_NM_SHR.value;
                var job_nm = f.txtJOB_NM_SHR.value;
                //var seq_no = document.getElementById("cmbTYPE_SHR");

                var hirg_ymd;        // �Ի糯¥
                var ret_ymd;         // ������¥
                var type = parseInt(document.getElementById("cmbTYPE_SHR").value);

                var elementName = new Array(    "txtHIRR_YMD_SHR"   //�Ի���
                                               ,"txtRAM_YMD_SHR"   //�߰�������1
                                               ,"txtRAM_YMD2_SHR"   //�߰�������2
                                               ,"txtRAM_YMD3_SHR"   //�߰�������3
                                               ,"txtRET_YMD_SHR");  //�����
                var element = null;

                //���� �Ⱓ ���
                //-������ ��� : �Ի���(�߰�������)~������
                //-�߰������� ��� : �ش� �߰� ������~���� �߰� ������(������)
                if(type == 0) {
                    //�Ի���(�߰�������)
                    for(i=0; i<4; i++) {
                       // element = document.getElementById(elementName[i]);
                        element = document.getElementById(elementName[0]);
                        if(element.value != "") {
                            hirg_ymd = element.value;
                        } else {
                            break;
                        }
                    }
                    //�����
                    ret_ymd = document.getElementById(elementName[elementName.length-1]).value;
                }
                //-�߰������� ��� : �Ի���(�ش� �� �߰� ������)~�ش� ������
                else {
                    //�Ի���(�߰�������)
                    for(i=0; i<type; i++) {
                        element = document.getElementById(elementName[0]);
                        if(element.value != "") {
                            hirg_ymd = element.value;
                        } else {
                            break;
                        }
                    }
                    //�߰�������
                    ret_ymd = document.getElementById(elementName[type]).value;
                }
                var oTYPE = document.getElementById("cmbTYPE_SHR");
                if(oTYPE.value == "0") {
                    oYMD_VAL = document.getElementById("txtRET_YMD_SHR").value;
                } else if(oTYPE.value == "1") {
                    oYMD_VAL = document.getElementById("txtRAM_YMD_SHR").value;
                } else if(oTYPE.value == "2") {
                    oYMD_VAL = document.getElementById("txtRAM_YMD2_SHR").value;
                } else if(oTYPE.value == "3") {
                    oYMD_VAL = document.getElementById("txtRAM_YMD3_SHR").value;
                }

                var param1 = "eno_no="+eno_no+"&eno_nm="+eno_nm+"&occ_cd="+occ_cd+"&dpt_nm="+dpt_nm+"&job_nm="+job_nm+"&hirg_ymd="+hirg_ymd+"&ret_ymd="+ret_ymd+"&oriYmd="+oriYmd+"&ymd="+oYMD_VAL;

                var normal_pay  = f.hidNORMAL_PAY.value;
                var ret_lee_yy  = f.hidRET_LSE_YY.value;
                var ret_lse_mm  = f.hidRET_LSE_MM.value;
                var ret_lse_dd  = f.hidRET_LSE_DD.value;
                var ret_lse_per = f.hidRET_LSE_PER.value;
                var avg_pay     = f.hidAVG_PAY.value;
                var sub_bon     = f.hidSUB_BON.value;
                var ret_pay     = f.hidRET_PAY.value;
                var asd_amt     = f.hidASD_AMT.value;
                var tot_amt     = f.hidTOT_AMT.value;

                var year_bonus  = f.hidYEAR_BONUS.value;
                //var tun_dd      = f.hidTUN_DD.value;

                var param2 = "&normal_pay="+normal_pay+"&ret_lee_yy="+ret_lee_yy+"&ret_lse_mm="+ret_lse_mm+"&ret_lse_dd="+ret_lse_dd+"&ret_lse_per="+ret_lse_per+"&avg_pay="+avg_pay+"&sub_bon="+sub_bon+"&ret_pay="+ret_pay+"&asd_amt="+asd_amt+"&tot_amt="+tot_amt+"&year_bonus="+year_bonus+"&tun_dd=";

                var str_ymd1 = f.txtSTR_YMD1.value;
                var str_ymd2 = f.txtSTR_YMD2.value;
                var str_ymd3 = f.txtSTR_YMD3.value;
                var str_ymd4 = f.txtSTR_YMD4.value;
                var end_ymd1 = f.txtEND_YMD1.value;
                var end_ymd2 = f.txtEND_YMD2.value;
                var end_ymd3 = f.txtEND_YMD3.value;
                var end_ymd4 = f.txtEND_YMD4.value;

                var ymd_val = hirg_ymd.substr(0,4) + "/" + hirg_ymd.substr(5,2) + "/" + hirg_ymd.substr(8,2) + "-" + ret_ymd.substr(0,4) + "/" + ret_ymd.substr(5,2) + "/" + ret_ymd.substr(8,2) + "(" + ret_lee_yy + "��" + ret_lse_mm + "��" + ret_lse_dd + "��)";
                var param3 = "&str_ymd1="+str_ymd1+"&str_ymd2="+str_ymd2+"&str_ymd3="+str_ymd3+"&str_ymd4="+str_ymd4+"&end_ymd1="+end_ymd1+"&end_ymd2="+end_ymd2+"&end_ymd3="+end_ymd3+"&end_ymd4="+end_ymd4+"&ymd_val="+ymd_val+"&TYPE="+type;

                var url = "reta080_PV.jsp?"+param1+param2+param3;

                window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

                return;
            } else if ( f.print_flag.value == "S" ) {
                alert("������ �μ��Ͻñ� �ٶ��ϴ�.");
            } else if ( f.print_flag.value == "N" ) {
                alert("��ȸ�� �μ��Ͻñ� �ٶ��ϴ�.");
            }
        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

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
            //DataSet�� �ʱ�ȭ ��Ŵ
            dsT_AC_RETPAY.ClearData();
            dsT_AC_RETBONUS.ClearData();
            dsT_CP_YEARLYBONUS.ClearData();
            dsT_AC_TENURE.ClearData();
            dsT_AC_RETMASTER.ClearData();
            //dsT_AC_RETPROPORTIONAL.ClearData();
			dsT_AC_RETNORMALPAY.ClearData();

			document.getElementById("resultMessage").innerText = ' ';
            fncClearDate(); //��¥ �ʱ�ȭ
            fnc_ClearInputFieldAll(new Array("txtENO_NO_SHR")); //��� �Է�â�� �ʱ�ȭ
            document.getElementById("txtENO_NO_SHR").value = "";

            oriEnoNo = "";  //�˻������� ���
            oriType = "";   //�˻������� ����
            oriYmd = "";    //�˻������� ������

            document.form1.print_flag.value = "N";
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_AC_RETPAY.IsUpdated)  {

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
            cfStyleGrid(form1.grdT_AC_RETPAY,0,"true","false");      // Grid Style ����
            //cfStyleGrid(form1.grdT_AC_RETPROPORTIONAL,0,"false","false");      // Grid Style ����
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}




        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "1", "");

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
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "1", "");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "1", "");

            if(document.getElementById("txtENO_NO_SHR").value != "") {
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
                document.getElementById("txtHIRG_YMD_SHR").value    = obj.hir_ymd;
                document.getElementById("txtOCC_NM_SHR").value      = obj.occ_cd+" "+obj.occ_nm;
                document.getElementById("txtOCC_CD_SHR").value      = obj.occ_cd;
                document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;
                document.getElementById("txtRET_YMD_SHR").value     = obj.ret_ymd;
                document.getElementById("txtRAM_YMD_SHR").value     = obj.ram_ymd;
                document.getElementById("txtRAM_YMD2_SHR").value    = obj.ram_ymd2;
                document.getElementById("txtRAM_YMD3_SHR").value    = obj.ram_ymd3;
                document.getElementById("txtHIRR_YMD_SHR").value    = obj.hirr_ymd;

                document.getElementById("txtRETP_YMD_SHR").value    = obj.retp_ymd;
                document.getElementById("txtMID_YMD1_SHR").value    = obj.mid_ymd1;
                document.getElementById("txtMID_YMD2_SHR").value    = obj.mid_ymd2;
                document.getElementById("txtMID_YMD3_SHR").value    = obj.mid_ymd3;

                document.getElementById("hidHIR_YMD_SHR").value     = obj.hir_ymd;


                //�⺻���� �������� �����ϱ�
                document.getElementById("cmbTYPE_SHR").value = "0";
            } else {
                document.getElementById("txtENO_NM_SHR").value      = "";
                document.getElementById("txtHIRG_YMD_SHR").value    = "";
                document.getElementById("txtOCC_NM_SHR").value      = "";
                document.getElementById("txtOCC_CD_SHR").value      = "";
                document.getElementById("txtDPT_NM_SHR").value      = "";
                document.getElementById("txtJOB_NM_SHR").value      = "";
                document.getElementById("txtRET_YMD_SHR").value     = "";
                document.getElementById("txtRAM_YMD_SHR").value     = "";
                document.getElementById("txtRAM_YMD2_SHR").value    = "";
                document.getElementById("txtRAM_YMD3_SHR").value    = "";
                document.getElementById("txtHIRR_YMD_SHR").value    = "";

                document.getElementById("txtRETP_YMD_SHR").value    = "";
                document.getElementById("txtMID_YMD1_SHR").value    = "";
                document.getElementById("txtMID_YMD2_SHR").value    = "";
                document.getElementById("txtMID_YMD3_SHR").value    = "";

                document.getElementById("hidHIR_YMD_SHR").value     = "";
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
                obj = document.getElementById("WORKING_DATE"+i);
                if(obj != null)
                    obj.innerHTML = "";
            }
            for(i=1; i<=4; i++) {
                obj = document.getElementById("PAST_DAY"+i);
                if(obj != null)
                    obj.innerHTML =  "0";
            }
            document.getElementById("txtPAST_DAY_SUM").value = "0";
        }

        /**
         * �������� �� ����ӱ�, ����ӱ��� �ʱ�ȭ�Ѵ�.
         */
        function fncClearData() {
            var table = document.getElementById("CAL_TABLE");

            for(i=table.rows.length-1; i>=2; i--) {
                table.deleteRow(i);
            }
        }

        /**
         * ���� �Ⱓ�� �����Ѵ�.
         */
        function bindingTenure() {
            var oHIRG_YMD   = document.getElementById("txtHIRG_YMD");
            var oRET_YMD    = document.getElementById("txtRET_YMD");
            var type        = parseInt(document.getElementById("cmbTYPE_SHR").value);

            var elementNames = new Array(   "txtRET_YMD_SHR"    //����������
                                           ,"txtRAM_YMD_SHR"    //�߰����������1
                                           ,"txtRAM_YMD2_SHR"   //�߰����������2
                                           ,"txtRAM_YMD3_SHR"   //�߰����������3
                                        );

            oHIRG_YMD.value = document.getElementById("txtHIRR_YMD_SHR").value; //���������
            oRET_YMD.value  = document.getElementById(elementNames[type]).value; //���������
        }

        /**
         * ���Ծ��� ����� ���ε� ��Ŵ
         */
        function bindingSubBonus() {
            //���� �հ�
            //var isCheck = document.getElementById("chkSUB_BON").checked;
            //var oSUB_BON = document.getElementById("txtSUB_BON");
            //var oBON_TOT = document.getElementById("txtBON_TOT");

            var totSalt_amt = dsT_AC_RETBONUS.NameSum("SALT_AMT", 0, 0);
            var yma_amt = 0;
            var subBon = 0;

            //�� �հ�
            //oBON_TOT.value = formatNumber(totSalt_amt);

            //���� ������ ������ �����´�.
            for(var i=1; i<=dsT_AC_RETBONUS.CountRow; i++) {
                if(dsT_AC_RETBONUS.NameString(i, "SAL_GBN") == "4") yma_amt += parseInt(dsT_AC_RETBONUS.NameString(i, "SALT_AMT"));
            }

            //���Ծ�
            /*
            if(isCheck) {
                subBon = Math.ceil((totSalt_amt-yma_amt)/9 + yma_amt/12);
            } else {
                subBon = Math.ceil(totSalt_amt/12);
            }
            */
            //oSUB_BON.value = formatNumber(subBon);

            bindingAveragePay();
        }

        /**
         * ����ӱ��� ���ؼ� ���ε� ��Ŵ
         */
        function bindingAveragePay() {
            var pastDay     = "12";	//�ϼ�

            var oAVG_PAY    = document.getElementById("txtAVG_PAY");
            var oDAY_AVG_PAY    = document.getElementById("txtDAY_AVG_PAY");
            var oNORMAL_PAY = document.getElementById("txtNORMAL_PAY");
            var oRET_PAY = document.getElementById("txtRET_PAY");

            var oBAS_AMT = document.getElementById("hidBAS_AMT");
            var oRET_LSE_PER = document.getElementById("txtRET_LSE_PER");

            //var oSUB_BON    = document.getElementById("txtSUB_BON");        //���Ծ�

            var subBon      = 0;    //���Ծ�
            var subTotal    		 = 0;    //3���� ������ ��
            var avgPay      		 = 0;    //����ӱ�
            var dayAvgPay      = 0;    //������ӱ�
            var normalPay   = 0;    //����ӱ�
            var retLsePer = 0;
            var basAmt = 0;
            var  retPay  = 0;

            //���Ծ� �ʱ�ȭ
            //subBon          = fnc_covNumber(oSUB_BON.value);

            //����ӱ� �ʱ�ȭ
            normalPay       = fnc_covNumber(oNORMAL_PAY.value);
            avgPay       = fnc_covNumber(oBAS_AMT.value);
            retLsePer       = oRET_LSE_PER.value;
            basAmt		= fnc_covNumber(oBAS_AMT.value);
			retPay = basAmt/12;
			retPay = Math.roundPrecision(retPay,0);


            //input box�� ���ε�

            oAVG_PAY.value = oBAS_AMT.value;
            oDAY_AVG_PAY.value = formatNumber(avgPay/retLsePer/12);
            oRET_PAY.value = formatNumber(retPay);



            //oNORMAL_PAY.value = formatNumber(normalPay);

            //������ ���� ����
            //bindingRetPay();
            //�����޳��������
            bindingMonthPay();
        }

		/**
         * ��������ġ���� �ݿø�
         */
Math.roundPrecision = function(val, precision) {
 var p = this.pow(10, precision);
 return this.round(val * p) / p;
}




        /**
         * �����޳���������� ����ؼ� ���ε� ��Ŵ
         */
        function bindingMonthPay() {
            //var oTUN_DD = document.getElementById("txtTUN_DD");
            //var oYEAR_BONUS = document.getElementById("txtYEAR_BONUS");
            var oNORMAL_PAY = document.getElementById("txtNORMAL_PAY");

            var normalPay   = fnc_covNumber(oNORMAL_PAY.value); //����ӱ�
            //var tun_dd      = fnc_covNumber(oTUN_DD.value);     //�̻���ϼ�

            //���ޱݾ� = �����ǿø�((����ӱ�*�ѹ̻���ϼ�*8)/226)
            /*
            if(tun_dd != 0)
                oYEAR_BONUS.value = formatNumber(Math.ceil(normalPay * tun_dd * 8 / 226 + 0.9));
            else
                oYEAR_BONUS.value = 0;
                */
        }

        /**
         * �������� ����ؼ� ���ε� ��Ŵ
         */
        function bindingRetPay() {
            var oRET_PAY    = document.getElementById("txtRET_PAY");
            var oAVG_PAY    = document.getElementById("txtAVG_PAY");
            var oAVG_PAY    = document.getElementById("txtDAY_AVG_PAY");

            var lse_yy      = parseInt(document.getElementById("txtRET_LSE_YY").value);
            var lse_mm      = parseInt(document.getElementById("txtRET_LSE_MM").value);
            var lse_dd      = parseInt(document.getElementById("txtRET_LSE_DD").value);


            var lse_per     = parseFloat(document.getElementById("txtRET_LSE_PER").value);

            var avgPay      = fnc_covNumber(oAVG_PAY.value);
            var retPay      = 0;
            var oAVG_PAY    = document.getElementById("txtAVG_PAY");					//����ӱ�
            var oDAY_AVG_PAY    = document.getElementById("txtDAY_AVG_PAY");	//������ӱ�
			var pastDay     = parseInt(document.getElementById("txtPAST_DAY_SUM").value);	//�ϼ�

            var subTotal    = 0;    //3���� ������ ��
            var avgPay      = 0;    //����ӱ�
            var dayAvgPay      = 0;    //������ӱ�
            var normalPay   = 0;    //����ӱ�

            subTotal = dsT_AC_RETPAY.NameSum("COL_1", 0, 0)
                     + dsT_AC_RETPAY.NameSum("COL_2", 0, 0)
                     + dsT_AC_RETPAY.NameSum("COL_3", 0, 0)
                     + dsT_AC_RETPAY.NameSum("COL_4", 0, 0);

            dayAvgPay = subTotal/pastDay;
			dayAvgPay = Math.roundPrecision(dayAvgPay,2);
			avgPay = dayAvgPay*30;
			avgPay = Math.roundPrecision(avgPay,2);

            //�ټӺ����� ������ ������ ��� (�ټӺ���*����ӱ�)���� �ƴϸ� ���� ��� ���
            //�ټӺ����� ���� ���
            if(lse_per == "") {
                if(lse_yy == 0) lse_yy = 1;
                if(lse_mm == 0) lse_mm = 12;
                if(lse_dd == 0) lse_dd = 365;

                retPay = avgPay * (lse_yy + (lse_mm / 12) + (lse_dd / 365));
            }
            //�ټӺ����� ���� ���
            else {
                retPay = avgPay * lse_per;
            }

            oRET_PAY.value = formatNumber(Math.ceil(retPay));
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
    <Object ID="trT_AC_RETPAY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <Object ID="trT_AC_RETPAY_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <Object ID="trT_AC_RETPAY_DEL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��()                |
    | 3. ���Ǵ� Table List()                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_TENURE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETPROPORTIONAL)                |
    | 3. ���Ǵ� Table List(T_AC_RETPROPORTIONAL)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETPROPORTIONAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_AC_RETPAY                       |
    | 3. Table List : T_AC_RETPAY                 |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETPAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <Param Name="SubsumExpr"      Value="RET_DIV">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_AC_RETPAY2                       |
    | 3. Table List : T_AC_RETPAY                 |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETPAY2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <Param Name="SubsumExpr"      Value="RET_DIV">
    </Object>
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_AC_RETBONUS                       |
    | 3. Table List : T_AC_RETPAY                 |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETBONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_CP_YEARLYBONUS                       |
    | 3. Table List : T_CP_YEARLYBONUS                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_YEARLYBONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_AC_TENURE                       |
    | 3. Table List : none                 |
    +----------------------------------------------->
    <Object ID="dsT_AC_TENURE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_AC_RETMASTER                       |
    | 3. Table List : none                 |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_AC_RETNORMALPAY                       |
    | 3. Table List : none                 |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETNORMALPAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsBIND_DATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_AC_RETPAY Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETPAY Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_AC_RETPAY Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_AC_RETPAY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        var f = document.form1;
        fncClearDate();     //��¥ �ʱ�ȭ
        //�˻� ������ ������ �Է�â �ʱ�ȭ
        fnc_ClearInputFieldAll(ExceptionList);

        //�����Ⱓ ������ ��������
        var past_day_sum = 0;
        for(var i=1; i<=dsBIND_DATE.CountRow; i++) {
            document.getElementById("WORKING_DATE"+i).innerText = dsBIND_DATE.NameString(i, "WORKING_DATE");
            document.getElementById("PAST_DAY"+i).innerText     = dsBIND_DATE.NameString(i, "PAST_DAY");

            document.getElementById("txtSTR_YMD"+i).value       = dsBIND_DATE.NameString(i, "STR_YMD");
            document.getElementById("txtEND_YMD"+i).value       = dsBIND_DATE.NameString(i, "END_YMD");

            past_day_sum += fnc_covNumber(dsBIND_DATE.NameString(i, "PAST_DAY"));
        }
        document.getElementById("txtPAST_DAY_SUM").value = past_day_sum;//�� �ٹ� �ϼ� ��������
		//document.getElementById("PAST_DAY5").innerText     =past_day_sum;

        if(dsT_AC_RETMASTER == null || dsT_AC_RETMASTER.CountRow == 0) {
			document.getElementById("hidBAS_AMT").value    = formatNumber(dsT_AC_RETPAY2.nameValue(1,"COL_1"));


            //�ټӱⰣ�� �ټӺ����� ��������
            if(dsT_AC_TENURE.CountRow == 1) {
                document.getElementById("txtRET_LSE_YY").value     = dsT_AC_TENURE.NameString(1, "LSE_YY");
                document.getElementById("txtRET_LSE_MM").value     = dsT_AC_TENURE.NameString(1, "LSE_MM");
                document.getElementById("txtRET_LSE_DD").value     = dsT_AC_TENURE.NameString(1, "LSE_DD");
                document.getElementById("txtRET_LSE_PER").value    = dsT_AC_TENURE.NameString(1, "LSE_PER");
            }
            //�̻�� �ް� �ϼ��� ������
            /*
            if(document.getElementById("cmbTYPE_SHR").value == "0")
                document.getElementById("txtTUN_DD").value = dsT_CP_YEARLYBONUS.nameValue(1, "TUN_DD");
            else
                document.getElementById("txtTUN_DD").value = 0;
*/
            //����ӱ�
            document.getElementById("txtNORMAL_PAY").value = formatNumber(dsT_AC_RETNORMALPAY.nameValue(1, "NORMAL_PAY"));
            //document.getElementById("txtED_DAY").value = 0; //�޿��ϼ� ����

            //dsT_AC_RETMASTER ���� ������ ���� ����ؼ� ���ε� ��Ŵ
            bindingSubBonus();
            f.print_flag.value = "S";

        } else {
            document.getElementById("txtHIRG_YMD").value    = dsT_AC_RETMASTER.nameValue(1, "HIRG_YMD");;
            document.getElementById("txtRET_YMD").value     = dsT_AC_RETMASTER.nameValue(1, "RET_YMD");;
            document.getElementById("hidHIR_YMD_ORI").value = dsT_AC_RETMASTER.nameValue(1, "HIRG_YMD");;
            document.getElementById("hidRET_YMD_ORI").value = dsT_AC_RETMASTER.nameValue(1, "RET_YMD");;

            document.getElementById("txtRET_PAY").value         = formatNumber(dsT_AC_RETMASTER.nameValue(1,"RTR_AMT"));        //�����ݱ����
            document.getElementById("txtASD_AMT").value         = formatNumber(dsT_AC_RETMASTER.nameValue(1,"ASD_AMT"));        //�������α�
            document.getElementById("txtAVG_PAY").value         = formatNumber(dsT_AC_RETMASTER.nameValue(1,"AVG_AMT"));        //����ӱ�
            document.getElementById("txtDAY_AVG_PAY").value         ="0";        //����ӱ�

            //document.getElementById("txtED_DAY").value          = dsT_AC_RETMASTER.nameValue(1,"PAY_DAY");                      //�޿��ϼ�����
            //document.getElementById("txtSUB_BON").value         = formatNumber(dsT_AC_RETMASTER.nameValue(1,"BON_AVG"));        //���Ծ�
            document.getElementById("txtRET_LSE_YY").value      = dsT_AC_RETMASTER.nameValue(1,"LSE_YY");                       //�ټӳ��
            document.getElementById("txtRET_LSE_MM").value      = dsT_AC_RETMASTER.nameValue(1,"LSE_MM");                       //�ټӿ���
            document.getElementById("txtRET_LSE_DD").value      = dsT_AC_RETMASTER.nameValue(1,"LSE_DD");                       //�ټ��ϼ�
            document.getElementById("txtRET_LSE_PER").value     = dsT_AC_RETMASTER.nameValue(1,"LSE_PER");                      //�ټӺ���
            document.getElementById("txtNORMAL_PAY").value      = formatNumber(dsT_AC_RETMASTER.nameValue(1,"MNOR_WAG"));       //������ӱ�
            //document.getElementById("txtTUN_DD").value          = dsT_AC_RETMASTER.nameValue(1,"TUN_DD");                       //�̻���ϼ�
            //document.getElementById("txtYEAR_BONUS").value      = formatNumber(dsT_AC_RETMASTER.nameValue(1,"PAY_AMT"));        //���޾� (����������)
            if(dsT_AC_RETMASTER.nameValue(1,"YN_TAG") == "Y") {
                //document.getElementById("chkSUB_BON").checked   = true;
            }
            //document.getElementById("txtBON_TOT").value         = formatNumber(dsT_AC_RETBONUS.NameSum("SALT_AMT", 0, 0));      //�� �հ�


            f.hidNORMAL_PAY.value   = formatNumber(dsT_AC_RETMASTER.nameValue(1,"MNOR_WAG"));       //������ӱ�
            f.hidRET_LSE_YY.value   = dsT_AC_RETMASTER.nameValue(1,"LSE_YY");                       //�ټӳ��
            f.hidRET_LSE_MM.value   = dsT_AC_RETMASTER.nameValue(1,"LSE_MM");                       //�ټӿ���
            f.hidRET_LSE_DD.value   = dsT_AC_RETMASTER.nameValue(1,"LSE_DD");                       //�ټ��ϼ�
            f.hidRET_LSE_PER.value  = dsT_AC_RETMASTER.nameValue(1,"LSE_PER");                      //�ټӺ���
            f.hidAVG_PAY.value      = formatNumber(dsT_AC_RETMASTER.nameValue(1,"AVG_AMT"));        //����ӱ�
            f.hidDAY_AVG_PAY.value      = formatNumber(dsT_AC_RETMASTER.nameValue(1,"DAY_AVG_AMT"));        //����ӱ�
            f.hidSUB_BON.value      = formatNumber(dsT_AC_RETMASTER.nameValue(1,"BON_AVG"));        //���Ծ�
            f.hidRET_PAY.value      = formatNumber(dsT_AC_RETMASTER.nameValue(1,"RTR_AMT"));        //�����ݱ����
            f.hidASD_AMT.value      = formatNumber(dsT_AC_RETMASTER.nameValue(1,"ASD_AMT"));        //�������α�
            f.hidYEAR_BONUS.value   = formatNumber(dsT_AC_RETMASTER.nameValue(1,"PAY_AMT"));        //���޾� (����������)
          //  f.hidTUN_DD.value       = dsT_AC_RETMASTER.nameValue(1,"TUN_DD");                       //�̻���ϼ�
            f.hidTOT_AMT.value      = formatNumber(dsT_AC_RETMASTER.nameValue(1,"RTR_AMT") + dsT_AC_RETMASTER.nameValue(1,"ASD_AMT"));
            f.print_flag.value = "Y";
        }
    </script>

    <script for=trT_AC_RETPAY_SAV event="OnSuccess()">
        alert("������ �Ϸ� �Ǿ����ϴ�.");
        document.getElementById("resultMessage").innerText = "������ �Ϸ� �Ǿ����ϴ�.";

        //ó���Ϸ��� �ٽ� �ڷ� ��ȸ
        fnc_SearchList();
    </script>

    <script for=trT_AC_RETPAY_DEL event="OnSuccess()">
        alert("������ �Ϸ� �Ǿ����ϴ�.");
        document.getElementById("resultMessage").innerText = "������ �Ϸ� �Ǿ����ϴ�.";

        //������ ����� ������ ��� ���� ����

        //DataSet�� �ʱ�ȭ ��Ŵ
        dsT_AC_RETPAY.ClearData();
        dsT_AC_RETBONUS.ClearData();
        dsT_CP_YEARLYBONUS.ClearData();
        dsT_AC_TENURE.ClearData();
        dsT_AC_RETMASTER.ClearData();
        //dsT_AC_RETPROPORTIONAL.ClearData();
        dsT_AC_RETNORMALPAY.ClearData();

        fncClearDate(); //��¥ �ʱ�ȭ
        fnc_ClearInputFieldAll(ExceptionList); //��� �Է�â �ʱ�ȭ
        document.getElementById("txtRET_YMD").value = "";

        document.form1.print_flag.value = "N";  //����Ʈ�� ���� ���� ����
    </script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_AC_TENURE event="OnSuccess()">
        //�ټӱⰣ�� �ټӺ����� ��������
        if(dsT_AC_TENURE.CountRow == 1) {
            document.getElementById("txtRET_LSE_YY").value     = dsT_AC_TENURE.NameString(1, "LSE_YY");
            document.getElementById("txtRET_LSE_MM").value     = dsT_AC_TENURE.NameString(1, "LSE_MM");
            document.getElementById("txtRET_LSE_DD").value     = dsT_AC_TENURE.NameString(1, "LSE_DD");
            document.getElementById("txtRET_LSE_PER").value    = dsT_AC_TENURE.NameString(1, "LSE_PER");
        }

        //�ټӱⰣ�� �ټӺ����� ���� �������� �޶���
        bindingRetPay();
    </script>

    <script for=trT_AC_RETPROPORTIONAL event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_AC_RETPAY event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_AC_RETPROPORTIONAL event="OnFail()">
        cfErrorMsg(this);
    </script>



    <!--------------------------+
    | Event ó��  |
    +--------------------------->
    <script language=JavaScript for=grdT_AC_RETPAY event=OnKillFocus()>

        //�����Ҷ� ����ϰ� ����
        //bindingAveragePay();

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����ݰ��ó�� (DC��)</td>
					<td align="right" class="navigator">HOME/���꼼��/�����ݰ���/<font color="#000000">�����ݰ��ó�� (DC��)</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"   ><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"       ><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"    ><img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"     ><img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"   ><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"       ><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                <td class="padding2423">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                                </td>

                                <td align="right" class="searchState">��&nbsp;��&nbsp;��</td>
                                <td class="padding2423">
                                    <input id="txtHIRG_YMD_SHR" name="txtHIRG_YMD_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                            </tr>
                            <tr>
                            	<td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                            	<td class="padding2423">
                                    <select id="cmbTYPE_SHR" name="cmbTYPE_SHR">
                                        <option value="">�������ּ���</option>
                                        <option value="0">����</option>
                                    </select>
                                     <input id="txtOCC_NM_SHR" name="txtOCC_NM_SHR" size="14" class="input_ReadOnly" type="hidden">
                                    <input id="txtOCC_CD_SHR" name="txtOCC_CD_SHR" type="hidden">
                                    <input id="hidRAM_YMD_ORI" name="hidRAM_YMD_ORI" type="hidden">
                                    <input id="hidRET_YMD_ORI" name="hidRET_YMD_ORI" type="hidden">
                                    <input id="hidHIR_YMD_ORI" name="hidHIR_YMD_ORI" type="hidden">

                                    <input id="txtRET_YMD_SHR" name="txtRET_YMD_SHR" type="hidden">
                                    <input id="txtRAM_YMD_SHR" name="txtRAM_YMD_SHR" type="hidden">
                                    <input id="txtRAM_YMD2_SHR" name="txtRAM_YMD2_SHR" type="hidden">
                                    <input id="txtRAM_YMD3_SHR" name="txtRAM_YMD3_SHR" type="hidden">
                                    <input id="txtHIRR_YMD_SHR" name="txtHIRR_YMD_SHR" type="hidden">

                                    <input id="txtRETP_YMD_SHR" name="txtRETP_YMD_SHR" type="hidden">
                                    <input id="txtMID_YMD1_SHR" name="txtMID_YMD1_SHR" type="hidden">
                                    <input id="txtMID_YMD2_SHR" name="txtMID_YMD2_SHR" type="hidden">
                                    <input id="txtMID_YMD3_SHR" name="txtMID_YMD3_SHR" type="hidden">
                                    <input id="txtHIR_YMD_SHR" name="txtHIR_YMD_SHR" type="hidden">

                                    <input id="hidHIR_YMD_SHR" name="hidHIR_YMD_SHR" type="hidden">

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
<table widht="800"  border="0" cellspacing="1" cellpadding="0">
    <tr>
        <td colspan="2">

<!-- �������� ���� -->
            <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#999999">
                <tr>
                    <td class="header" width="60">�����Ⱓ</td>
                    <td class="content2" width="205">
                        <input type="text" id="txtHIRG_YMD" name="txtHIRG_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" >
                        ~
                        <input type="text" id="txtRET_YMD" name="txtRET_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtRET_YMD','','188','215');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>
                    <td class="header" width="60">�ټӱⰣ</td>
                    <td class="content2" width="140">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="10"></td>
                                <td><input id="txtRET_LSE_YY" name="txtRET_LSE_YY" type="text" size="2" >��</td>
                                <td><input id="txtRET_LSE_MM" name="txtRET_LSE_MM" type="text" size="2" >��</td>
                                <td><input id="txtRET_LSE_DD" name="txtRET_LSE_DD" type="text" size="2" >��</td>
                                <td width="10"></td>
                            </tr>
                        </table>
                    </td>
                    <td class="header" width="60">�ټӺ���</td>
                    <td class="content2" align="left">
                        <input id="txtRET_LSE_PER" name="txtRET_LSE_PER" type="text" size="10" >
                        &nbsp;
                        <img src="/images/button/btn_recalculationOn.gif" border="0" align="absmiddle" name="imgRecalculation" id="imgRecalculation" onclick="fnc_SearchYear()" style="cursor:hand;"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRecalculation','','/images/button/btn_recalculationOver.gif',1)">
                        &nbsp;
                        <img src="/images/button/btn_ConductOn.gif" border="0" align="absmiddle" name="imgConduct" id="imgConduct" onclick="bindingSubBonus()" style="cursor:hand;"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)">
                        &nbsp;
                    </td>
                </tr>
            </table>
<!-- �������� ���� -->

        </td>
    </tr>
    <tr>
        <td colspan="2" height="5"></td>
    </tr>
    <tr>
        <td width="500" valign="bottom">
            <input type="hidden" name="txtSTR_YMD1" id="txtSTR_YMD1">
            <input type="hidden" name="txtSTR_YMD2" id="txtSTR_YMD2">
            <input type="hidden" name="txtSTR_YMD3" id="txtSTR_YMD3">
            <input type="hidden" name="txtSTR_YMD4" id="txtSTR_YMD4">
            <input type="hidden" name="txtEND_YMD1" id="txtEND_YMD1">
            <input type="hidden" name="txtEND_YMD2" id="txtEND_YMD2">
            <input type="hidden" name="txtEND_YMD3" id="txtEND_YMD3">
            <input type="hidden" name="txtEND_YMD4" id="txtEND_YMD4">

<!-- �޿� ���� ���� -->
            <table width="480" border="0" cellspacing="1" cellpadding="0" bgcolor="#999999" id="CAL_TABLE">
                <tr>
                    <td class="header" height="30">�ӱݰ��Ⱓ</td>
                    <td class="header" id="WORKING_DATE1" width="80"></td>
                    <td class="header" id="WORKING_DATE2" width="80"></td>
                    <td class="header" id="WORKING_DATE3" width="80"></td>
                    <td class="header" id="WORKING_DATE4" width="99"></td>
                </tr>
                <tr>
                    <td class="header" height="22">��&nbsp;��&nbsp;��<input type="hidden" id="txtPAST_DAY_SUM" name="txtPAST_DAY_SUM"></td>
                    <td class="content2" id="PAST_DAY1">0</td>
                    <td class="content2" id="PAST_DAY2">0</td>
                    <td class="content2" id="PAST_DAY3">0</td>
                    <td class="content2" id="PAST_DAY4">0</td>
                </tr>
            </table>


            <comment id="__NSID__">
            <object id="grdT_AC_RETPAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:100%;height:248px;">
                <param name="DataID" value="dsT_AC_RETPAY">
                <param name="Editable" value="false">
                <param name="DragDropEnable" value="true">
                <param name="SortView" value="Left">
                <param name=ViewHeader  value="false">
                <param name="Format" value='
                    <C> id=COL_NMAE     width=112       align=center    Edit=none   SubSumText="��   ��"</C>
                    <C> id=COL_1        width=83        align=right     Edit=Numeric    rightmargin=10          </C>
                    <C> id=COL_2        width=83        align=right     Edit=Numeric    rightmargin=10          </C>
                    <C> id=COL_3        width=83        align=right     Edit=Numeric    rightmargin=10          </C>
                    <C> id=COL_4        width=102       align=right     Edit=Numeric    rightmargin=10          </C>
                '>
            </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>

        </td>
        <td width="250" valign="top">
<!-- �޿� ���� ���� -->
            <table width="230" border="0" cellspacing="1" cellpadding="0" bgcolor="#999999" id="CAL_TABLE">
                <tr>
                    <td class="header" height="55">��</td>
                </tr>
            </table>
			<comment id="__NSID__">
            <object id="grdT_AC_RETPAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:100%;height:247px;">
                <param name="DataID" value="dsT_AC_RETPAY2">
                <param name="Editable" value="false">
                <param name="DragDropEnable" value="true">
                <param name="SortView" value="Left">
                <param name=ViewHeader  value="false">
                <param name="Format" value='
                    <C> id=COL_NMAE     width=127       align=center    Edit=none   SubSumText="��   ��"</C>
                    <C> id=COL_1        width=83        align=right     Edit=Numeric    rightmargin=10          </C>
                '>
            </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
		</td>
    </tr>
    <tr>
        <td colspan="2" height="5"></td>
    </tr>
    <tr>
        <td colspan="2">
            <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#999999">
            	<tr>
                	<td class="header" width="100" height="22" colspan="6">�߰��δ�� ����</td>
               	</tr>
                <tr>
                	<td class="header" width="100" height="22">����ӱ�</td>
                    <td class="content3" width="120">&nbsp;&nbsp;<input id="txtDAY_AVG_PAY" name="txtDAY_AVG_PAY" type="text" size="14" style="ime-mode:disabled;text-align:right;" onkeypress="cfCheckNumber();" onfocusout="this.value=formatNumber(this.value)" onchange="bindingRetPay()"></td>
                    <td class="header" width="80" height="22">�����ޱ޿�</td>
                    <td class="content3" width="120">&nbsp;&nbsp;<input id="txtAVG_PAY" name="txtAVG_PAY" type="text" size="14" style="ime-mode:disabled;text-align:right;" onkeypress="cfCheckNumber();" onfocusout="this.value=formatNumber(this.value)" onchange="bindingRetPay()"></td>
                	<td class="header" width="80">�߰��δ��</td>
                    <td class="content3" >
                        &nbsp;&nbsp;<input id="txtRET_PAY" name="txtRET_PAY" size="14" style="ime-mode:disabled;text-align:right;" onkeypress="cfCheckNumber();" onfocusout="this.value=formatNumber(this.value)"></td>
                </tr>
            </table>
<!-- �޿� ���� ���� -->
		</td>
	</tr>
</table>
<!-- �������� �� -->
<input  type="hidden"  id="txtASD_AMT" name="txtASD_AMT" size="14" >

<input id="txtNORMAL_PAY" type="hidden"  name="txtNORMAL_PAY" >

<input type="hidden" name="hidBAS_AMT">
<input type="hidden" name="hidNORMAL_PAY">
<input type="hidden" name="hidRET_LSE_YY">
<input type="hidden" name="hidRET_LSE_MM">
<input type="hidden" name="hidRET_LSE_DD">
<input type="hidden" name="hidRET_LSE_PER">
<input type="hidden" name="hidAVG_PAY">
<input type="hidden" name="hidDAY_AVG_PAY">
<input type="hidden" name="hidSUB_BON">
<input type="hidden" name="hidRET_PAY">
<input type="hidden" name="hidASD_AMT">
<input type="hidden" name="hidTOT_AMT">
<input type="hidden" name="hidYEAR_BONUS">
<input type="hidden" name="hidTUN_DD">

<input type="hidden" name="print_flag" value="N">
</form>
<!-- form �� -->

</body>
</html>

