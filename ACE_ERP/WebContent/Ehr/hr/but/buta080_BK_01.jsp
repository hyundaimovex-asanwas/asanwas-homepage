<!--
*****************************************************
* @source       : buta080.jsp
* @description : ö���̿������ν�û PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/02/21      ���м�        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>ö���̿������ν�û(buta080)</title>
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
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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
          var f = document.form1;
          if ( f.flag.value == "Y" ) 
          {
              var CD_GBN = "7771-110";
              var CD_GBN_VAL;
      //        dsT_DI_BUSINESSTRIP_KORAIL.SetDataHeader("partno:STRING(3)");
      //        dsT_DI_BUSINESSTRIP_KORAIL.ImportData('22');
              var today_ymd_val = f.today_ymd_val.value;           // ������
              var ymd1_ins_val = f.ymd1_ins_val.value;               // ������1
              var str_code1 = f.str_code1.value;                         // ��߱����ڵ尪1
              var end_code1 = f.end_code1.value;                     // ���������ڵ尪1
              var kor_type1 = f.kor_type1.value;                          // ����1
              var ymd2_ins_val = f.ymd2_ins_val.value;              // ������2
              var str_code2 = f.str_code2.value;                        // ��߱����ڵ尪2
              var end_code2 = f.end_code2.value;                    // ���������ڵ尪2
              var kor_type2 = f.kor_type2.value;                         // ����2
              var user_name = f.user_name.value;                   // �Է���
              var user_no = f.user_no.value;  
              var gubun2_flag = f.gubun2_flag.value;
              
              var param_dao = "&today_ymd_val="+today_ymd_val+"&ymd1_ins_val="+ymd1_ins_val+"&str_code1="+str_code1+"&end_code1="+end_code1+"&kor_type1="+kor_type1+"&ymd2_ins_val="+ymd2_ins_val+"&str_code2="+str_code2+"&end_code2="+end_code2+"&kor_type2="+kor_type2+"&user_name="+user_name+"&user_no="+user_no+"&gubun2_flag="+gubun2_flag;
    /*  
              dsT_DI_BUSINESSTRIP_KORAIL.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta080.cmd.BUTA080CMD&S_MODE=SHR&CD_GBN=" + CD_GBN + param_dao;
              dsT_DI_BUSINESSTRIP_KORAIL.reset();
             
              if(!fnc_SaveItemCheck()) return;
      */ 
              trT_DI_BUSINESSTRIP_KORAIL.KeyValue = "tr01(O:DS_ONE=dsT_DI_BUSINESSTRIP_KORAIL)";
              trT_DI_BUSINESSTRIP_KORAIL.action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta080.cmd.BUTA080CMD&S_MODE=SHR&CD_GBN=" + CD_GBN + param_dao;
              trT_DI_BUSINESSTRIP_KORAIL.post();
              
              CD_GBN_VAL = dsT_DI_BUSINESSTRIP_KORAIL.NameValue(0,"ORD_NO") + 1;
              if ( String(CD_GBN_VAL).length == "1" ) {
                  CD_GBN_VAL = "00" + CD_GBN_VAL;
              } else if (String(CD_GBN_VAL).length == "2" ) {
                  CD_GBN_VAL = "0" + CD_GBN_VAL;
              }
              CD_GBN = CD_GBN + "-" + CD_GBN_VAL;
    //          alert(CD_GBN_VAL);
              fnc_report(CD_GBN, CD_GBN_VAL);
              form1.aaa.RunButton('print_go');
    //          goclick('print');
          }
          else
          {
              alert("�̸����� ȭ���� Ŭ���Ͽ�, ��¹��� Ȯ�� �� �μ��Ͻ� �� �ֽ��ϴ�.");
          }
        }
        
        function goclick(x) {
           if( !form1.aaa.RunButton(x) ) {	
               alert("��ü�� �����ϴ�.");
           }
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
           var f = document.form1;
           obj1 = getObj("imgYMD_TRUE"); 
           obj2 = getObj("imgSTR_TRUE"); 
           obj3 = getObj("imgEND_TRUE"); 
  
           f.txtBUT_YMD2_INS.readOnly  = true;
           f.cmbKOR_TYPE2_INS.disabled  = true;
  
           obj1.visibility = "hidden";
           obj2.visibility = "hidden";
           obj3.visibility = "hidden";
           f.txtBUT_YMD2_INS.value = "";
           f.txtSTR_CITY2_INS.value = "";
           f.txtEND_CITY2_INS.value = "";
           f.chkGUBUN_INS2.checked = false;
           f.txtBUT_YMD1_INS.value = "";
           f.txtSTR_CITY1_INS.value = "";
           f.txtEND_CITY1_INS.value = "";
           f.flag.value = "N";
           document.form1.aaa.OpenHnw("/hr/but/buta080.hnw","");
           f.flag.value = "N";
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

          if (dsT_DI_BUSINESSTRIP_KORAIL.IsUpdated)  {
    
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

          if (!dsT_DI_BUSINESSTRIP_KORAIL.IsUpdated) {
                    alert("������ �ڷᰡ �����ϴ�.");
                    fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                    return false;
          }
          return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

 //         cfStyleGrid(form1.grdT_DI_BUSINESSTRIP_KORAIL,15,"false","right")      // Grid Style ����

//          document.form1.txtDPT_CD_SHR.focus();

         }

    /********************
     * 15. ����Ű ó��        *
     *******************/
    function fnc_HotKey() {

      fnc_HotKey_Process(btnList, event.keyCode);

    }

    /********************************************
    * ��¥ ���� ��ȿ�� üũ                           			     *
    ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return; 
            if(!cfDateExpr(obj.value)) { 
                alert('��ȿ�� ��¥�� �ƴմϴ�.'); 
                obj.focus();
            }
        }
    /********************************************
    * ez-gen (�̸�����)                          			     *
    ********************************************/
        function fnc_report(CD_GBN, CD_GBN_VAL) {
            var f = document.form1;
            var param = "";
            var param1 = "";
            var param2 = "";
            var param3 = "";
            
            var user_name = "<%=box.get("SESSION_ENONM")%>";   // ����̸�
            var user_no = "<%=box.get("SESSION_ENONO")%>";    // �����ȣ
            
            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var day = date.getDate();
            var s_year  = String(year);
            var s_month = String(month);
            var s_day = String(day);
            var s_month_val = "";
            var s_day_val = "";
            
            if ( s_month.length == "1") s_month_val = "0"+s_month;
            else s_month_val = s_month;
            if ( s_day.length == "1") s_day_val = "0"+s_day;
            else s_day_val = s_day;
            
            var CDay = new Date(s_year, 6, 30, 18, 0, 0);
            
            var ymd_val;
            var today_ymd_val = s_year + s_month_val + s_day_val;
            var today_ymd = s_year + "�� " + s_month + "�� " + s_day + "��";
            
            var CDay_sec =  CDay.getTime();
            var date_sec = date.getTime(); 
            
            if ( date_sec <= CDay_sec )
                ymd_val = s_year + "�� 1�� 1�� ~ 6�� 30�� ������";
            else 
                ymd_val = s_year + "�� 7�� 1�� ~ 12�� 31�� ������";
//            alert(ymd_val);
            param3 = "[@InitPage]=Page1[:cd_gbn]=" + CD_GBN + "[:cd_gbn_val]=" + CD_GBN_VAL + "[:user_name]=" + user_name + "[:user_no]=" + user_no+ "[:today_ymd]=" + today_ymd+"[:ymd_val]=" + ymd_val;
            var ymd1_ins = f.txtBUT_YMD1_INS.value;
            var ymd1_ins_val = ymd1_ins.substr(0,4) + ymd1_ins.substr(5,2) + ymd1_ins.substr(8,2);
            var str_city1 = f.txtSTR_CITY1_INS.value;
            var end_city1 = f.txtEND_CITY1_INS.value;
            var kor_type1 = f.cmbKOR_TYPE1_INS.value;
            var kor_type1_val;
            if ( kor_type1 == "0" ) kor_type1_val = "KTX";
            else if ( kor_type1 == "1" ) kor_type1_val = "������ȣ";
            else if ( kor_type1 == "2" ) kor_type1_val = "����ȭȣ";
            
            //-------------------------------------------------------------- ö���̿�-1
            if ( f.txtBUT_YMD1_INS.value == "" || f.txtBUT_YMD1_INS.value == null ) {
                alert("�̿����ڸ� �Է��� �ֽʽÿ�!");
                f.txtBUT_YMD1_INS.focus();
                return false;
            }
            if ( f.txtSTR_CITY1_INS.value == "" || f.txtSTR_CITY1_INS.value == null ) {
                alert("�������� �Է��� �ֽʽÿ�!");
                f.txtSTR_CITY1_INS.focus();
                return false;
            }
            if ( f.txtEND_CITY1_INS.value == "" || f.txtEND_CITY1_INS.value == null ) {
                alert("�������� �Է��� �ֽʽÿ�!");
                f.txtEND_CITY1_INS.focus();
                return false;
            }
            param1 = "[:ymd1_ins]=" + ymd1_ins + "[:str_city1]=" + str_city1+ "[:end_city1]=" + end_city1+"[:kor_type1_val]=" + kor_type1_val;
            
            //-------------------------------------------------------------- ö���̿�-2
            if ( f.chkGUBUN_INS2.checked == true ) {   
                var ymd2_ins = f.txtBUT_YMD2_INS.value;
                var ymd2_ins_val = ymd2_ins.substr(0,4) + ymd2_ins.substr(5,2) + ymd2_ins.substr(8,2);
                var str_city2 = f.txtSTR_CITY2_INS.value;
                var end_city2 = f.txtEND_CITY2_INS.value;
                var kor_type2 = f.cmbKOR_TYPE2_INS.value;
                var kor_type2_val;
                if ( kor_type2 == "0" ) kor_type2_val = "KTX";
                else if ( kor_type2 == "1" ) kor_type2_val = "������ȣ";
                else if ( kor_type2 == "2" ) kor_type2_val = "����ȭȣ";
                
                if ( f.txtBUT_YMD2_INS.value == "" || f.txtBUT_YMD2_INS.value == null ) {
                    alert("�̿����ڸ� �Է��� �ֽʽÿ�!");
                    f.txtBUT_YMD2_INS.focus();
                    return false;
                }
                if ( f.txtSTR_CITY2_INS.value == "" || f.txtSTR_CITY2_INS.value == null ) {
                    alert("�������� �Է��� �ֽʽÿ�!");
                    f.txtSTR_CITY2_INS.focus();
                    return false;
                }
                if ( f.txtEND_CITY2_INS.value == "" || f.txtEND_CITY2_INS.value == null ) {
                    alert("�������� �Է��� �ֽʽÿ�!");
                    f.txtEND_CITY2_INS.focus();
                    return false;
                }
                
                param2 = "[:ymd2_ins]=" + ymd2_ins + "[:str_city2]=" + str_city2 + "[:end_city2]=" + end_city2 +"[:kor_type2_val]=" + kor_type2_val;
                f.gubun2_flag.value = "Y";
                f.ymd2_ins_val.value = ymd2_ins_val;                       // ������2
                f.str_code2.value = f.txtSTR_CODE2_INS.value;         // ��߱����ڵ尪2
                f.end_code2.value = f.txtEND_CODE2_INS.value;       // ���������ڵ尪2
                f.kor_type2.value = kor_type2;                                    // ����2
            } else {
                f.gubun2_flag.value = "";
                f.ymd2_ins_val.value = "";    // ������2
                f.str_code2.value = "";         // ��߱����ڵ尪2
                f.end_code2.value = "";       // ���������ڵ尪2
                f.kor_type2.value = "";                                    // ����2
            }
            //-------------------------------------------------------------------
            param = param3 + param1 + param2;
            
            f.today_ymd_val.value = today_ymd_val;                   // ������
            f.ymd1_ins_val.value = ymd1_ins_val;                       // ������1
            f.str_code1.value = f.txtSTR_CODE1_INS.value;         // ��߱����ڵ尪1
            f.end_code1.value = f.txtEND_CODE1_INS.value;       // ���������ڵ尪1
            f.kor_type1.value = kor_type1;                                    // ����1
            
            f.user_name.value = user_name;                              // �Է���
            f.user_no.value = user_no;
 
            f.flag.value = "Y";
            if ( CD_GBN == "" )
            {
                document.form1.aaa.OpenHnw("/hr/but/buta080.hnw",param);
            } else {
                document.form1.aaa.SetValues("[:cd_gbn]=" + CD_GBN);
                document.form1.aaa.SetValues("[:cd_gbn_val]=" + CD_GBN_VAL);
            }
            
        }
    
     /********************************************
    * ö���̿�-2 ���ý� Ȱ��, ��Ȱ��ȭ                			     *
    ********************************************/    
        function fnc_GUBUN(gb) {
            var f = document.form1;
            obj1 = getObj("imgYMD_TRUE"); 
            obj2 = getObj("imgSTR_TRUE"); 
            obj3 = getObj("imgEND_TRUE"); 
            if ( gb == true ) {
                f.txtBUT_YMD2_INS.readOnly  = false;
                f.cmbKOR_TYPE2_INS.disabled  = false;

                obj1.visibility = "visible";
                obj2.visibility = "visible";
                obj3.visibility = "visible";
            } else if ( gb == false ) {
                f.txtBUT_YMD2_INS.readOnly  = true;
                f.cmbKOR_TYPE2_INS.disabled  = true;

                obj1.visibility = "hidden";
                obj2.visibility = "hidden";
                obj3.visibility = "hidden";
                f.txtBUT_YMD2_INS.value = "";
                f.txtSTR_CITY2_INS.value = "";
                f.txtEND_CITY2_INS.value = "";
            }
        }
        
        function getObj(obj) { 
            if (nscp) { 
                compLayr = document.layers[obj] 
            }else{ 
                compLayr = eval("document.all." + obj + ".style") 
            } 
            return compLayr 
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
    | 2. �̸� : dsT_DI_BUSINESSTRIP_KORAIL                      |
    | 3. Table List : VI_T_CM_PERSON, T_DI_BUSINESSTRIP_KORAIL, T_CM_DEPT                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_KORAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet(copy)									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP_KORAIL_CP)			   |
    | 3. ���Ǵ� Table List(dsT_DI_BUSINESSTRIP_KORAIL, ) 				   |
    +------------------------------------------------------>
    <Object ID="dsT_DI_BUSINESSTRIP_KORAIL_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP_KORAIL)		|
    | 3. ���Ǵ� Table List(T_CM_PERSON, T_DI_BUSINESSTRIP_KORAIL)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_KORAIL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_DI_BUSINESSTRIP_KORAIL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

          alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
          fnc_Message(document.getElementById("resultMessage"), "MSG_02");
   //       document.form1.txtENO_NO_SHR.focus();

        } else {

          fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
 //         document.form1.grdT_DI_BUSINESSTRIP_KORAIL.focus();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_KORAIL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_KORAIL Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_KORAIL event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_KORAIL event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | Grid �̺�Ʈ ó��  |
    +--------------------------->

    
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">ö���̿������ν�û</td>
                    <td align="right" class="navigator">HOME/���°���/�������/<font color="#000000">ö���̿������ν�û</font></td>
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
            <!--  a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a -->
            <!--  a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!--  a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>-->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<table border="0"><tr><td height="10"></td></tr></table>

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="800" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">   
                <tr>
                    <td align="center" class="creamBold" width="100">��    ��</td>
                    <td class="padding2423" align="center" width="350">
                        <input type="checkbox" name="chkGUBUN_INS1" border="0" checked>ö���̿�-1
                    </td>
                    <td class="padding2423" align="center" width="350">
                        <input type="checkbox" name="chkGUBUN_INS2" border="0" onClick="fnc_GUBUN(this.checked)">ö���̿�-2
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" width="100">�̿�����</td>
                    <td class="padding2423" align="center" width="350">
                        <input type="text" id="txtBUT_YMD1_INS" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_INS1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtBUT_YMD1_INS','','108','113');">
                        <img src="/images/button/btn_HelpOn.gif" name="img_YMD_INS1" width="21" height="20" border="0" align="absmiddle">
                        </a>
                    </td>
                    <td class="padding2423" align="center" width="350">
                        <input type="text" id="txtBUT_YMD2_INS" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" readOnly>
                        <span id="imgYMD_TRUE" style="position:absolute; z-index:1; visibility: hidden">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_INS1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtBUT_YMD2_INS','','108','113');">
                            <img src="/images/button/btn_HelpOn.gif" name="img_YMD_INS1" width="21" height="20" border="0" align="absmiddle">
                            </a>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��    ��</td>
                    <td class="padding2423" align="center">
                        <input type="hidden" id=txtSTR_CODE1_INS name=txtSTR_CODE1_INS>
                        <input id=txtSTR_CITY1_INS name=txtSTR_CITY1_INS size="10" class="input_ReadOnly" readonly> 
                        <img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSTR_CODE1_INS','txtSTR_CITY1_INS','����','T5')" style="cursor:hand">
                        &nbsp;->
                        <input type="hidden" id=txtEND_CODE1_INS name=txtEND_CODE1_INS>
                        <input id=txtEND_CITY1_INS name=txtEND_CITY1_INS size="10" class="input_ReadOnly" readonly> 
                        <img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEND_CODE1_INS','txtEND_CITY1_INS','����','T5')" style="cursor:hand">
               
                    </td>
                    <td class="padding2423" align="center">
                        <input type="hidden" id=txtSTR_CODE2_INS name=txtSTR_CODE2_INS>
                        <input id=txtSTR_CITY2_INS name=txtSTR_CITY2_INS size="10" class="input_ReadOnly" readonly> 
                        <span id="imgSTR_TRUE" style="position:absolute; z-index:1; visibility: hidden">
                            <img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSTR_CODE2_INS','txtSTR_CITY2_INS','����','T5')" style="cursor:hand">
                        </span>
                        &nbsp;->
                        <input type="hidden" id=txtEND_CODE2_INS name=txtEND_CODE2_INS>
                        <input id=txtEND_CITY2_INS name=txtEND_CITY2_INS size="10" class="input_ReadOnly" readonly> 
                        <span id="imgEND_TRUE" style="position:absolute; z-index:1; visibility: hidden">
                            <img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEND_CODE2_INS','txtEND_CITY2_INS','����','T5')" style="cursor:hand">
                        </span>
                    </a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��    ��</td>
                    <td class="padding2423" align="center">
                        <select id="cmbKOR_TYPE1_INS" name="cmbKOR_TYPE1_INS" style="WIDTH: 50%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                            <option value='0'>KTX</option>
                            <option value='1'>������ȣ</option>
                            <option value='2'>����ȭȣ</option>
                        </select>
                    </td>
                    <td class="padding2423" align="center">
                        <select id="cmbKOR_TYPE2_INS" name="cmbKOR_TYPE2_INS" style="WIDTH: 50%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" disabled>
                            <option value='0'>KTX</option>
                            <option value='1'>������ȣ</option>
                            <option value='2'>����ȭȣ</option>
                        </select>
                    </td>
                 </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->
<table width="800" height="10" border="0" cellspacing="0" cellpadding="0">
    <tr><td>&nbsp;</td></tr>
</table>
<center>
<table width="600" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="padding2423">
            1. ö���� �̿��� ����� ö����� ���ν�û���� ����ϸ� ����Ͻñ� �ٶ��ϴ�.<br>
            &nbsp;&nbsp;&nbsp;( ������ : ���� 20% �ָ� 5% )<br>
            2. �������� ���� ��� ���κ��� ��û���� ����ϸ� ����Ͽ��� �մϴ�.<br>
            3. ��û�� 1�忡 �պ��Է� ���������� 3ȸ�̻� ö���̿�ÿ��� �߰��� �Է��Ͽ� ����Ͻñ� �ٶ��ϴ�.<br>
            4. <font color=blue><b>�μ�</b></font> ��ư�� ������ �ڵ���� �ǿ��� ��¹��� Ȯ���� ���ñ� �ٶ��ϴ�.<br>
            &nbsp;&nbsp;&nbsp;(<font color=blue><b> �̸�����</b></font> ��ư�� Ŭ���Ͽ� ��¹��� �̸� Ȯ���� ���� �� �ֽ��ϴ�. )
            
        </td>
    </tr>
    <tr><td height="10"></td></tr>
    <tr>
        <td align="center">
            <input type="button" name="btnREPORT" value="�̸�����" style="background:white;cursor:hand" onClick="fnc_report('','')" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">&nbsp;&nbsp;
        </td>
    </tr>
</table>
</center>
<!--************************************************************** ezgen -->
<table border=0>
    <tr height="150">
        <td width="800">
            <table border="00" bordercolordark="white" bordercolorlight="gray" bordercolor="gray">
              <comment id="__NSID__">
              <object id="aaa" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <!-- param name="hnwsrc"    VALUE="buta080.hnw" -->
              <param name="initvalue" VALUE="[@InitPage]=Page1[:aaa]=aa[:bbb]=aa">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
              </comment><script> __ShowEmbedObject(__NSID__); </script>
           </table>
        </td>
    </tr>
</table>
<!--************************************************************** ezgen -->
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

<input type="hidden" name="txtDOC_AUTHO" value="1">
<input type="hidden" name="flag">

<input type="hidden" name="today_ymd_val">
<input type="hidden" name="ymd1_ins_val">
<input type="hidden" name="str_code1">
<input type="hidden" name="end_code1">
<input type="hidden" name="kor_type1">
<input type="hidden" name="gubun2_flag">
<input type="hidden" name="ymd2_ins_val">
<input type="hidden" name="str_code2">
<input type="hidden" name="end_code2">
<input type="hidden" name="kor_type2">
<input type="hidden" name="user_name">
<input type="hidden" name="user_no">


</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
