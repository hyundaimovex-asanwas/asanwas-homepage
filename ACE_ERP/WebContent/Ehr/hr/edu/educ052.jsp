<!--
*****************************************************
* @source       : educ052.jsp
* @description : �μ�����������
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2011/04/29      ������        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�μ�����������(educ052)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">

<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >
    var nscp = (navigator.appName == "Netscape")

    var btnList = 'TFTTFFTT';
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem(yy, mm) {
            var f = document.form1;
            var REG_Y = yy;
            var REG_M;

            if ( mm.length != "1" || mm.length != "2" ){
                mm = String(mm);
            }

            if ( mm.length == "1"){
                REG_M = "0"+mm;
            }else{
                REG_M = mm;
            }

            var REG_YMD = REG_Y+REG_M;
            var DPT_CD  = f.txtDPT_CD_SHR.value;

           // document.getElementById("txtDPT_CD_SHR").value
			if(!cfDateExpr(REG_YMD)){
				alert(REG_YMD + " �� �������� ��¥ Ÿ���� �ƴմϴ�.\ �ٽ� �Է��Ͻʽÿ�");
				return false;
			}

            trT_DI_HOLIDAY.KeyValue = "JSP(O:DS_ONE=dsT_DI_HOLIDAY, O:DS_TWO=dsT_DI_HOLIDAY2)";
            trT_DI_HOLIDAY.Action   = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna201.cmd.GUNA201CMD&S_MODE=SHR&REG_YMD="+REG_YMD+"&DPT_CD_SHR="+DPT_CD;
            trT_DI_HOLIDAY.post();

            if ( dsT_DI_HOLIDAY.CountRow != null || dsT_DI_HOLIDAY.CountRow != 0 || dsT_DI_HOLIDAY.CountRow != "0" )
            {
                var countRow        = dsT_DI_HOLIDAY.OrgValue(1,6);  // �Ѵ��� ���� ����
                var start_day_num   = dsT_DI_HOLIDAY.OrgValue(1,5);  // ���ۿ��ϱ��м���(�޷¿����� j�� ���� ����Ÿ���� row_num�� ���ؿ� �� �ִ�.)
                var k               = 8 - start_day_num;
                f.countRow.value    = countRow;
                f.dept.value        = start_day_num;
                f.hid_REG_YMD.value = REG_YMD;

                if ( countRow == 5 ) biz.style.display = "none";
                else                 biz.style.display = "";      // 6������ ���ϰ�� �������� ���̺� Ȱ��ȭ

				//fnc_SearchDiligence();
//                alert(dsT_DI_HOLIDAY.OrgValue(3,2));
                if ( start_day_num == 7)
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";
                    cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = "";
                    cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = "";
                    cal4_1[0].innerText = ""; cal4_2[0].innerText = ""; cal4_3[0].innerText = "";
                    cal5_1[0].innerText = ""; cal5_2[0].innerText = ""; cal5_3[0].innerText = "";
                    cal6_1[0].innerText = ""; cal6_2[0].innerText = ""; cal6_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                }
                else if ( start_day_num == 6 )
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";
                    cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = "";
                    cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = "";
                    cal4_1[0].innerText = ""; cal4_2[0].innerText = ""; cal4_3[0].innerText = "";
                    cal5_1[0].innerText = ""; cal5_2[0].innerText = ""; cal5_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7)
                }
                else if ( start_day_num == 5 )
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";
                    cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = "";
                    cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = "";
                    cal4_1[0].innerText = ""; cal4_2[0].innerText = ""; cal4_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(3,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7)

                    cal5_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal5_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal5_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal5_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal5_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7)
                }
                else if ( start_day_num == 4 )
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";
                    cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = "";
                    cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(4,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(3,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7)

                    cal5_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal5_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal5_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal5_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal5_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7)

                    cal4_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal4_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal4_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal4_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal4_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                }
                else if ( start_day_num == 3 )
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";
                    cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(5,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(4,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7)

                    cal5_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,1);
                    cal5_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(3,2);
                    cal5_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,3);
                    cal5_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);
                    cal5_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7)

                    cal4_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal4_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal4_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal4_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal4_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);

                    cal3_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal3_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal3_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal3_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal3_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7)
                }
                else if ( start_day_num == 2 )
                {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = "";

                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(6,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(6,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(6,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(5,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7)

                    cal5_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,1);
                    cal5_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(4,2);
                    cal5_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,3);
                    cal5_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7);
                    cal5_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7)

                    cal4_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,1);
                    cal4_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(3,2);
                    cal4_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,3);
                    cal4_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);
                    cal4_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);

                    cal3_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal3_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal3_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal3_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal3_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);

                    cal2_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal2_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal2_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal2_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal2_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                }
                else if ( start_day_num == 1 )
                {
                    cal7_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(7,1);
                    cal7_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(7,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(7,2);
                    cal7_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(7,3);
                    cal7_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(7,7);
                    cal7_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(7,7);

                    cal6_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,1);
                    cal6_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(6,2);
                    cal6_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(6,3);
                    cal6_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(6,7);
                    cal6_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(6,7);

                    cal5_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,1);
                    cal5_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(5,2);
                    cal5_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(5,3);
                    cal5_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7);
                    cal5_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(5,7)

                    cal4_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,1);
                    cal4_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(4,2);
                    cal4_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(4,3);
                    cal4_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7);
                    cal4_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(4,7)

                    cal3_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,1);
                    cal3_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(3,2);
                    cal3_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(3,3);
                    cal3_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);
                    cal3_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(3,7);

                    cal2_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,1);
                    cal2_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(2,2);
                    cal2_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(2,3);
                    cal2_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);
                    cal2_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(2,7);

                    cal1_1[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,1);
                    cal1_2[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(1,2);
                    cal1_3[0].innerText   = dsT_DI_HOLIDAY.OrgValue(1,3);
                    cal1_1[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                    cal1_2[0].style.color = dsT_DI_HOLIDAY.OrgValue(1,7);
                }
                for ( var i=1; i<countRow-1 ;i++ )
                {
                    k++;
                    cal1_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal1_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal1_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal1_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal1_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal2_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal2_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal2_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal2_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal2_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal3_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal3_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal3_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal3_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal3_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal4_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal4_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal4_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal4_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal4_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal5_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal5_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal5_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal5_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal5_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal6_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal6_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal6_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal6_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal6_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);

                    k++;
                    cal7_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                    cal7_2[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,2)=="����"?"":dsT_DI_HOLIDAY.OrgValue(k,2);
                    cal7_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3);
                    cal7_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                    cal7_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7);
                }
                k++;

                cal1_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "����" )
                    cal1_2[i].innerText = "";
                else cal1_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal1_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal1_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal1_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal2_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "����" )
                    cal2_2[i].innerText = "";
                else cal2_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal2_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal2_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal2_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal3_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "����" )
                    cal3_2[i].innerText = "";
                else cal3_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal3_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal3_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal3_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal4_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "����" )
                    cal4_2[i].innerText = "";
                else cal4_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal4_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal4_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal4_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal5_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "����" )
                    cal5_2[i].innerText = "";
                else cal5_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal5_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal5_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal5_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal6_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "����" )
                    cal6_2[i].innerText = "";
                else cal6_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal6_3[i].innerText  = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal6_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal6_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                k++;
                cal7_1[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,1)==null?"":dsT_DI_HOLIDAY.OrgValue(k,1);
                if ( dsT_DI_HOLIDAY.OrgValue(k,2) == null || dsT_DI_HOLIDAY.OrgValue(k,2) == "����" )
                    cal7_2[i].innerText = "";
                else cal7_2[i].innerText = dsT_DI_HOLIDAY.OrgValue(k,2);
                cal7_3[i].innerText   = dsT_DI_HOLIDAY.OrgValue(k,3)==null?"":dsT_DI_HOLIDAY.OrgValue(k,3);
                cal7_1[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);
                cal7_2[i].style.color = dsT_DI_HOLIDAY.OrgValue(k,7)==null?"":dsT_DI_HOLIDAY.OrgValue(k,7);

                var pre_i = document.form1.i.value;      //���� Ŭ���޴� ��¥ĭ�� ��� �� ��ȣ
                var pre_j = document.form1.col_num.value;

                if ( pre_j == 1 ) td_index_1[pre_i].style.background = "white"; //���� Ŭ���޴� ��¥ĭ�� ��� �� ��ȣ��
                if ( pre_j == 2 ) td_index_2[pre_i].style.background = "white";
                if ( pre_j == 3 ) td_index_3[pre_i].style.background = "white";
                if ( pre_j == 4 ) td_index_4[pre_i].style.background = "white";
                if ( pre_j == 5 ) td_index_5[pre_i].style.background = "white";
                if ( pre_j == 6 ) td_index_6[pre_i].style.background = "white";
                if ( pre_j == 7 ) td_index_7[pre_i].style.background = "white";

                if ( document.form1.cmbREG_Y_SHR.length > 3 )
                {
                    for( var i = dsT_DI_HOLIDAY2.CountRow; i >= 0; i-- ) {
                        oOption       = document.createElement("OPTION");
                        oOption.value = dsT_DI_HOLIDAY2.NameValue(i,"REG_YMD");
                        oOption.text  = dsT_DI_HOLIDAY2.NameValue(i,"REG_YMD");
                        document.getElementById("cmbREG_Y_SHR").remove(oOption);
                    }
                }
                for( var i = 1; i <= dsT_DI_HOLIDAY2.CountRow; i++ ) {
                    oOption       = document.createElement("OPTION");
                    oOption.value = dsT_DI_HOLIDAY2.NameValue(i,"REG_YMD");
                    oOption.text  = dsT_DI_HOLIDAY2.NameValue(i,"REG_YMD");
                    document.getElementById("cmbREG_Y_SHR").add(oOption);
			    }

                document.form1.hid_REG_YMD.value  = "";
                document.form1.row_num.value      = "";
                document.form1.col_num.value      = "";
                document.form1.dept.value         = "";
                document.form1.countRow.value     = "";
                document.form1.cmbREG_Y_SHR.value = REG_Y;
                document.form1.cmbREG_M_SHR.value = mm;
            }
        }

/*
		function fnc_SearchDiligence() {

			for(var j = 1; j <= dsT_DI_HOLIDAY.CountRow; j++){
				var DAY_VAL = dsT_DI_HOLIDAY.OrgNameValue(j,"DAY_VAL");
				var REMARK_VAL = dsT_DI_HOLIDAY.OrgNameValue(j,"REMARK_VAL");
				for(var i = 1; i <= dsT_DI_DILIGENCE.CountRow; i++){
					var TEMP = dsT_DI_DILIGENCE.OrgNameValue(i,"ENO_NM") + " " +  dsT_DI_DILIGENCE.OrgNameValue(i,"COL_NEW");
					var LV   = dsT_DI_DILIGENCE.OrgNameValue(i,"LV");
					if(DAY_VAL == LV){

						dsT_DI_HOLIDAY.NameValue(j,"REMARK_VAL") +=  TEMP;
					}

				}
			}
				for(var i = 1; i <= dsT_DI_DILIGENCE.CountRow; i++){
					alert(dsT_DI_HOLIDAY.NameValue(i,"REMARK_VAL"));
				}

		}
*/
        /******************"C:/project000/MASA(back_up)/�ҽ�/data2/htdocs2/PMSL/js/comFunction.js"
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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

      // ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
      // �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

      //�̰��� �ش� �ڵ��� �Է� �ϼ���

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
            var yy = document.form1.cmbREG_Y_SHR.value;         // ���� Ŭ���ߴ� ��¥ĭ�� ��,�� ��ȣ
            var mm = document.form1.cmbREG_M_SHR.value;

            fnc_SearchItem(yy,mm);
//          dsT_DI_HOLIDAY.ClearAll();
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

          if (dsT_DI_HOLIDAY.IsUpdated)  {

            if (!fnc_ExitQuestion()) return;

          }

          frame = window.external.GetFrame(window);
          frame.CloseFrame();

       }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

      //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        function fnc_SaveItemCheck_01() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var date = new Date();

            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var day = date.getDate();
            var s_year  = String(year);
            var s_month = String(month);

			document.getElementById("txtDPT_CD_SHR").value = "<%= box.get("SESSION_DPTCD")%>";// �Ҽ��ڵ�
			document.getElementById("txtDPT_NM_SHR").value = "<%= box.get("SESSION_DPTNM")%>";// �ҼӸ�

            fnc_SearchItem(s_year,s_month);


         }

    /********************
         * 15. ����Ű ó��  *
         *******************/
    function fnc_HotKey() {

      fnc_HotKey_Process(btnList, event.keyCode);

    }
    /********************
         * 15. ����Ű ó��  *
         *******************/
    //�ϰ�����
    function fnc_CreateBatch() {

    }

    /********************
       * 16. ��
         *******************/



    /****** ������ ��ư ******/
    function fnc_Next_month(year, month) {
        var next_year;
        var next_month;
        var now_year  = document.form1.cmbREG_Y_SHR.value;
        var now_month = document.form1.cmbREG_M_SHR.value;
        if ( now_month == "12" ) {
            next_year  = Number(now_year) + 1;
            next_month = "1";
        } else {
            next_year  = now_year;
            next_month = Number(now_month) + 1;
        }
//        alert("next_month="+next_month);
        fnc_SearchItem(next_year, next_month);
    }

    /****** ������ ��ư ******/
    function fnc_Pre_month(){
    var pre_year;
        var pre_month;
        var now_year  = document.form1.cmbREG_Y_SHR.value;
        var now_month = document.form1.cmbREG_M_SHR.value;
        if ( now_month == "1" || now_month == "0" ) {
            if ( now_month == "1" ) pre_year  = Number(now_year) - 1;
            pre_month = "12";
        } else {
            pre_year  = now_year;
            pre_month = Number(now_month) - 1;
        }
//        alert("pre_month="+pre_month);
        fnc_SearchItem(pre_year, pre_month);
    }

    /****** ��¥ĭ�� ���� ���콺���� ******/
    function doTrans_color(i,j) {   // ���콺 �����϶� ��¥ĭ �� ����
        fnc_tdColor(i,j,"#EBFEE7");

        var pre_i = document.form1.i.value;      //���� Ŭ���޴� ��¥ĭ�� ��� �� ��ȣ
        var pre_j = document.form1.col_num.value;
        if ( pre_i == i )
        {
            fnc_tdColor(pre_i,pre_j,"#FEE2E0");
        }
    }

    function fnc_SearchItem_Y(M_SHR_VAL) {
       form1.cmbREG_M_SHR.value = 0;
    }
    /****** ���콺 �̵��� ���� �ִ� ��¥ĭ�� ���� �Ͼ������. ******/
    function rollback_color(i,j) {

        var pre_i = document.form1.i.value;      //���� Ŭ���޴� ��¥ĭ�� ��� �� ��ȣ
        var pre_j = document.form1.col_num.value;
        if ( pre_i != i || pre_j != j )
        {
            fnc_tdColor(i,j,"white");
        }
    }

    /****** ��¥ Ŭ���� bind ******/
    function fnc_bind2(i,cal_num,j){
        var f = document.form1;
        //Ŭ���� ���� dataset�� row �ѹ��� �ǵ���. cal_num�� �޷��� ���� ùĭ���� �ٿ��� �Ϸù�ȣ
        var row_num = cal_num - dsT_DI_HOLIDAY.OrgValue(1,5) + 1;
        if ( row_num == 0 ) row_num = -1;

        var space;
        var flag           = dsT_DI_HOLIDAY.NameValue(row_num,"REG_YMD");
        var txtREG_YMD_val = dsT_DI_HOLIDAY.NameValue(row_num,"DAY_VAL");
        var cmbHOL_GBN_val = dsT_DI_HOLIDAY.NameValue(row_num,"HOL_GUB");
        var txtREMARK_val  = dsT_DI_HOLIDAY.NameValue(row_num,"REMARK_VAL");

        if ( flag == "" || flag == null ){
            f.txtREG_YMD_UPT.value    = "";
            f.cmbHOL_GBN_UPT.value    = "";
            f.txtREMARK_UPT.value     = "";
            f.cmbHOL_GBN_UPT.disabled = true;
            f.txtREMARK_UPT.disabled  = true;
        } else {
            f.cmbHOL_GBN_UPT.disabled = false;
            f.txtREMARK_UPT.disabled  = false;

            f.txtREG_YMD_UPT.value = f.cmbREG_Y_SHR.value + "��" + f.cmbREG_M_SHR.value + "��" + txtREG_YMD_val + "��";
            if ( cmbHOL_GBN_val == "" || cmbHOL_GBN_val == null ) f.cmbHOL_GBN_UPT.value = 0;
            else                                                  f.cmbHOL_GBN_UPT.value = cmbHOL_GBN_val;
            f.txtREMARK_UPT.value = txtREMARK_val;
        }
        f.row_num.value = row_num;
        f.i.value       = i;
        f.col_num.value = j;
    }

    /****** ��ư Ŭ���� �ش糯¥ �� ���� ******/
    function fnc_bind(i,cal_num,j) {
        fnc_tdColor(i,j,"#FEE2E0");

        if ( document.form1.i.value != null || document.form1.i.value != "" )
        {
            var pre_i = document.form1.i.value;         // ���� Ŭ���ߴ� ��¥ĭ�� ��,�� ��ȣ
            var pre_j = document.form1.col_num.value;
            if ( pre_i != i || pre_j != j )
            {
                fnc_tdColor(pre_i,pre_j,"white");
            }
        }
        fnc_bind2(i,cal_num,j);
    }

    function fnc_tdColor(i,j,color_val) {
        if ( j == 1 ) td_index_1[i].style.background = color_val;
        if ( j == 2 ) td_index_2[i].style.background = color_val;
        if ( j == 3 ) td_index_3[i].style.background = color_val;
        if ( j == 4 ) td_index_4[i].style.background = color_val;
        if ( j == 5 ) td_index_5[i].style.background = color_val;
        if ( j == 6 ) td_index_6[i].style.background = color_val;
        if ( j == 7 ) td_index_7[i].style.background = color_val;
    }


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_DI_HOLIDAY                      |
    | 3. Table List : T_DI_HOLIDAY                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_HOLIDAY2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>



    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_HOLIDAY)		|
    | 3. ���Ǵ� Table List(T_CM_PERSON, T_DI_HOLIDAY) |
    +--------------------------------------------------->
    <Object ID ="trT_DI_HOLIDAY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">
/*
        if (iCount < 1)    {

          alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
          fnc_Message(document.getElementById("resultMessage"), "MSG_02");
   //       document.form1.txtENO_NO_SHR.focus();

        } else {

          fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
   //       document.form1.grdT_DI_HOLIDAY.focus();
        }
*/
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAY Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_HOLIDAY event="OnSuccess()">
 //       fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_HOLIDAY event="OnFail()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�μ�����������</td>
                    <td align="right" class="navigator">HOME/��������/�μ�����������/<font color="#000000">�μ�����������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchItem(cmbREG_Y_SHR.value, cmbREG_M_SHR.value)"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
    </td>
  </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� �� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">

                <tr>
                    <td align="center" class="creamBold">�Ҽ�</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD_SHR" size="3" maxlength="2" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
		                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->
<table><tr><td height=5></td></tr>
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width=540 align="right"  class="paddingTop8">&nbsp;
            <input type="button" name="btnREG_pre_SHR" value="<< ������" style="background:white;cursor:hand" onClick="fnc_Pre_month()" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <select id="cmbREG_Y_SHR" name="cmbREG_Y_SHR" style="WIDTH: 9%" onkeypress="javascript:if(event.keyCode==13) fnc_HOL_GBN();" onChange="fnc_SearchItem(this.value,form1.cmbREG_M_SHR.value)">
            </select>&nbsp;��
            <select id="cmbREG_M_SHR" name="cmbREG_M_SHR" style="WIDTH: 7%" onkeypress="javascript:if(event.keyCode==13) fnc_HOL_GBN();" onChange="fnc_SearchItem(form1.cmbREG_Y_SHR.value, this.value)" bgcolor=#E8F5FF>
               <option value='1'>1</option>
               <option value='2'>2</option>
               <option value='3'>3</option>
               <option value='4'>4</option>
               <option value='5'>5</option>
               <option value='6'>6</option>
               <option value='7'>7</option>
               <option value='8'>8</option>
               <option value='9'>9</option>
               <option value='10'>10</option>
               <option value='11'>11</option>
               <option value='12'>12</option>
            </select>&nbsp;��
            <input type="button" name="btnREG_nxt_SHR" value="������ >>" style="background:white;cursor:hand" onClick="fnc_Next_month(cmbREG_Y_SHR.value,cmbREG_M_SHR.value)" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
        </td>
    </tr>
</table>
<table><tr><td height=10></td></tr>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center">

            <table  border="1" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="40"><div align="center" class="style1"><b>��</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>��</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>ȭ</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>��</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>��</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>��</b></div></td>
                    <td height="40"><div align="center" class="style1"><b>��</b></div></td>
                </tr>
<%
            int cal_num = 0;   //dataset�� row�ѹ��� ���ϱ�����.
            for ( int i=0; i<5; i++ ) {
%>
                <tr>
                    <td onmouseover="doTrans_color(<%=i%>,1)" onmouseout="rollback_color(<%=i%>,1)" id="td_index_1" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal1_1" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal1_2" align="left">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td width="140"><div id="cal1_3" align="left"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(<%=i%>,2)" onmouseout="rollback_color(<%=i%>,2)" id="td_index_2" style="cursor:hand" valign="top"><div align="right" id="bbcol">
                        <table border="0" height="51" style='table-layout:fixed' valign="top">
                            <tr>
                                <td height="17" width="140" ><div id="cal2_1" align="right" ></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal2_2" align="left">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td width="140"><div id="cal2_3" align="left"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(<%=i%>,3)" onmouseout="rollback_color(<%=i%>,3)" id="td_index_3" style="cursor:hand"  valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal3_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal3_2" align="left">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td width="140"><div id="cal3_3" align="left" style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(<%=i%>,4)" onmouseout="rollback_color(<%=i%>,4)" id="td_index_4" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal4_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal4_2" align="left">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td width="140"><div id="cal4_3" align="left"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(<%=i%>,5)" onmouseout="rollback_color(<%=i%>,5)" id="td_index_5" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal5_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal5_2" align="left">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td width="140"><div id="cal5_3" align="left"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(<%=i%>,6)" onmouseout="rollback_color(<%=i%>,6)" id="td_index_6" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal6_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal6_2" align="left">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td width="140"><div id="cal6_3" align="left"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(<%=i%>,7)" onmouseout="rollback_color(<%=i%>,7)" id="td_index_7" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal7_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal7_2" align="left">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td width="140"><div id="cal7_3" align="left"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
<%
            }
%>

                <tr id="biz"  style="display:none">
                    <td onmouseover="doTrans_color(5,1)" onmouseout="rollback_color(5,1)" id="td_index_1" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal1_1" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal1_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td  width="140"><div id="cal1_3" align="right"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(5,2)" onmouseout="rollback_color(5,2)" id="td_index_2" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal2_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal2_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td  width="140"><div id="cal2_3" align="right"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(5,3)" onmouseout="rollback_color(5,3)" id="td_index_3" style="cursor:hand" valign="top"><div align="right">
                        <table border="0"v>
                            <tr>
                                <td height="17" width="140"><div id="cal3_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal3_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td  width="140"><div id="cal3_3" align="right"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(5,4)" onmouseout="rollback_color(5,4)" id="td_index_4" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal4_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal4_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td  width="140"><div id="cal4_3" align="right"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(5,5)" onmouseout="rollback_color(5,5)" id="td_index_5" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal5_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal5_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td  width="140"><div id="cal5_3" align="right"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(5,6)" onmouseout="rollback_color(5,6)" id="td_index_6" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal6_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal6_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td  width="140"><div id="cal6_3" align="right"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                    <td onmouseover="doTrans_color(5,7)" onmouseout="rollback_color(5,7)" id="td_index_7" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="17" width="140"><div id="cal7_1" align="right"></div></td>
                            </tr>
                            <tr>
                                <td height="17" width="140"><div id="cal7_2" align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td width="140"><div id="cal7_3" align="right"  style='font-size:11px'>&nbsp;</div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </div>
    <input type="hidden" name="i">
    <input type="hidden" name="hid_REG_YMD">
    <input type="hidden" name="row_num">
    <input type="hidden" name="col_num">

    <input type="hidden" name="dept">
    <input type="hidden" name="countRow">

        </td>
    </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

<br> *��) �系 ���� ��ǥ��



</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!----------------------------------------------+
| 1. ���� �� ��ȸ�� Bind                                               |
| 2. �̸� : bndT_DI_HOLIDAY                         |
| 3. Table List : T_DI_HOLIDAY                                |
+----------------------------------------------->


