<!--*************************************************************************
* @source      : eisc010.jsp                                                *
* @description : ȭ�������� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/05/02            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.upload.pds");
	String SESSION_HEADCD = box.getString("SESSION_HEADCD");         //����ڵ�
	String SESSION_ROLE_CD = box.getString("SESSION_ROLE_CD");         //���ڵ�
	String SESSION_DUTYCD = box.getString("SESSION_DUTYCD");         //��å�ڵ�
	String SESSION_DPTCD = box.getString("SESSION_DPTCD");         //�μ��ڵ�
%>

<html>
<head>
    <title>ȭ��������(eisc010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
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
                    + "F"   //����(ó��)
                    + "T"   //���
                    + "F"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.eis.c.eisc010.cmd.EISC010CMD";
        var params = null;


        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            params = "&S_MODE=SHR"
                   + "&DEPTH_NO="+depth_no
                   + "&ENO_NO="+selectENO_NO
                   + "&COUNT_REM="+selectCOUNT_REM
                   + "&DPT_CD="+selectDPT_CD
                   + "&HEAD_CD="+selectHEAD_CD
                   + "&TEAM_CD="+selectTEAM_CD;
			//alert(params);
            trT_CM_PERSON.KeyValue = "SHR"
                                   + "(O:dsT_CM_PERSON=dsT_CM_PERSON"
                                   + ",O:dsT_CM_PERSON2=dsT_CM_PERSON2"
                                   + ")";
            trT_CM_PERSON.action = dataClassName+params;
            trT_CM_PERSON.post();
        }

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {

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

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CM_PERSON.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_CM_PERSON.GridToExcel("ȭ��������", '', 225);
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
            dsT_CM_PERSON.ClearData();
            dsT_CM_PERSON2.ClearData();

            //ȭ�������� ���� Depth 1(����)���� ����
            depth_no = 1;

            //ȭ������������ �� Depth�� ����� ���� ���� ����
            depth_eno_no = new Array();
            depth_count_rem = new Array();

            selectENO_NO = "";
            selectDPT_CD = "";
            selectCOUNT_REM = "";
            selectHEAD_CD = "";
            selectTEAM_CD = "";

            fnc_SearchList();
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CM_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {
            //�����ϸ鼭 ����Ʈ�� ��ȸ�� ��
            fnc_SearchList();
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

        //ȭ�������� ���� Depth 1(����)���� ����
        var depth_no = 1;

        //ȭ������������ �� Depth�� ����� ���� ���� ����
        var depth_eno_no = new Array();
        var depth_count_rem = new Array();

        var selectENO_NO = "";
        var selectDPT_CD = "";
        var selectCOUNT_REM = "";
        var selectHEAD_CD = "";
        var selectTEAM_CD = "";


        /*************************************************************************
         * ������ ���ε� ���丮�� �̹����� �ѷ��ִ� User Defined Object
         * - usage : var obj = new Image(�̹����ױ���ID);
         *               obj.setImage("������ �̹��������� ��ġ�� ���ϸ�");
         *************************************************************************/
        function Image(imgTag) {
            var imgTag = imgTag;
            var action = "/servlet/JspChannelSVL?cmd=com.shift.gef.generic.cmd.RetrieveGenericImageCMD";
            var imgUrl = "";
            this.setImage = function(imgBox) {
                imgUrl = imgBox;
                imgTag.src = action + "&IMAGE=" +imgUrl;
            }

        }

        /**
         * �Ѵܰ� ���� �ö󰥶� ���
         */
        function upperEno_box() {
            if(depth_no > 1) {
                depth_no--;

                selectENO_NO    = depth_eno_no[depth_no-1];
                selectCOUNT_REM = depth_count_rem[depth_no-1];

                fnc_SearchList();
            }
        }

        /**
         * �Ѵܰ� ���� ���� ���
         */
        function lowerEno_box() {

            //�ʿ��� �������� ������� (ENO_NO, DPT_CD, COUNT_REM, DUTY_CD, HEAD_CD, TEAM_CD)
            var eno_params = this.name.split(":");


/*
			if(depth_no == "2"){
				if( "1001" == "<%=SESSION_ROLE_CD%>" || "1002" == "<%=SESSION_ROLE_CD%>" || "<%=SESSION_DUTYCD%>" == "B0" || "<%=SESSION_DUTYCD%>" == "B1" || "<%=SESSION_DUTYCD%>" == "B2" || "<%=SESSION_DUTYCD%>" == "B5" || "<%=SESSION_HEADCD%>" ==eno_params[4]){

				}else{
					alert("���� ���μҼ� �ο��� ��ȸ�Ҽ��ֽ��ϴ�");
					return ;
				}

			}


			if(depth_no == "2"){
				if( eno_params[3] == "04" ){
					if( eno_params[0] != "2090012" ){
						alert("����߿��Դϴ�. �������� Ŭ���ؾ� �μ����� ��ȸ�Ҽ��ֽ��ϴ�");
						return ;
					}
				}
			}
			*/
			//alert(depth_no);
			//alert(eno_params[1]);

			if(depth_no == "3" && eno_params[2] == "A600"){
				if( eno_params[0] == "1990027" || eno_params[0] == "1990099" || eno_params[0] == "1990030" ||
					eno_params[0] == "2030003" || eno_params[0] == "1990072" || eno_params[0] == "1990036" ||
					eno_params[0] == "1990041" || eno_params[0] == "1990104" || eno_params[0] == "2030009"){
					return ;
				}
			}else if(depth_no == "3" && eno_params[1] == "A490"){
				if( eno_params[0] == "2040026" || eno_params[0] == "2130006" || eno_params[0] == "2150006" || eno_params[0] == "2030032"||
					eno_params[0] == "2070016" || eno_params[0] == "2110005"  || eno_params[0] == "2050023"){
						return ;
					}
			}else if(depth_no == "3" && (eno_params[1] == "E760"||eno_params[1] == "E770" ||eno_params[1] == "I500" ||eno_params[1] == "E400" ||
					eno_params[1] == "I900" ) ){

						return ;

			}else if(depth_no == "4" && ( eno_params[1] == "J000" ||eno_params[1] == "G230" ||eno_params[1] == "C100"||eno_params[1] == "C180"||eno_params[1] == "C200"||eno_params[1] == "C280"||eno_params[1] == "C800"||
					eno_params[1] == "E700" ||eno_params[1] == "I600" ||eno_params[1] == "G240" ||eno_params[1] == "G250"||eno_params[1] == "I730"||eno_params[1] == "I600") ){

						return ;

			}


			//alert("���� [" + eno_params.length + "]");
            //������ 1�� ��츸 depth array �ʱ�ȭ
            if(depth_no == 1) {
                depth_eno_no[depth_no-1]    = dsT_CM_PERSON.NameString(1, "ENO_NO");
                depth_count_rem[depth_no-1] = dsT_CM_PERSON.NameString(1, "COUNT_REM");
            }

            //4�� �� ������ �� ���� �� �� ����
			//alert("depth_no [" + depth_no + "]");
            if(depth_no < 5 || (depth_no == 5 && eno_params[2] == "L5")) {
                //�Ѵܰ� �ö󰡱� ���� ��� ����
                depth_eno_no[depth_no]    = eno_params[0];
                depth_count_rem[depth_no] = eno_params[1];

                depth_no++;

                selectENO_NO    = eno_params[0];
                selectDPT_CD   = eno_params[1];
                selectCOUNT_REM = eno_params[2];
                selectHEAD_CD  = eno_params[4];
                selectTEAM_CD   = eno_params[5];

                fnc_SearchList();
            }

        }

        /**
         * �̹��� �ε尡 ���� ���� ��� �߻� �̺�Ʈ
         */
        function imgError() {
            this.src = "/images/common/none.jpg";
        }

        /**
         * �̹��� �ڽ����̺��� �������� ��ȯ
         * @param dataset - DB ���� ��ȸ�� �� ���
         * @param row - ��� ����Ʈ�� �ش� ��� row count
         * @param type - �̹����� ���ý� �ö󰥰����� ������������ ���� (upper, lower)
         */
        function createEno_box(dataset, row, type) {
            var oTable = document.createElement("table");
            var oRow;
            var oCell;
            var oImg;
            var oBtn;
            var imgBox;

            //box table ����
            oTable.width        = "160";
            oTable.border       = "1";
            oTable.cellSpacing  = "0";
            oTable.cellPadding  = "0";
            oTable.borderColor  = "#999999";
            oTable.style.borderCollapse = "collapse";

            //first Row Img
            oRow  = oTable.insertRow();
            oCell = oRow.insertCell();
            oCell.align     = "center"
            oCell.height    = "180";
            oCell.colSpan   = "2";

            //�̹����� ����ô�.
            oImg = document.createElement("img");


            //�̹����� DB���� ������
            var FILEURL = "<%=FILEURL%>" + "/" + dataset.NameString(row, "ENO_NO") + ".jpg";
            imgBox = new Image(oImg);
            imgBox.setImage(FILEURL)

            //�̹����� �Ӽ��� setImage����Ʒ��ʿ� �־�� ����ȴ�.
            oImg.width      = "125"
            oImg.height     = "167"
            oImg.border     = "0";


			//alert(dataset.NameString(row, "COUNT_REM"));

            //�ʿ��� ������ name �Ӽ��� �о� �ִ´�.
            oImg.name = dataset.NameString(row, "ENO_NO")
                      + ":" + dataset.NameString(row, "DPT_CD")
                      + ":" + dataset.NameString(row, "COUNT_REM")
                      + ":" + dataset.NameString(row, "DUTY_CD")
                      + ":" + dataset.NameString(row, "HEAD_CD")
                      + ":" + dataset.NameString(row, "TEAM_CD");

            //link event ����
            if(type == "upper") oImg.onclick = upperEno_box;
            else                oImg.onclick = lowerEno_box;

            oImg.onerror = imgError;

            oCell.appendChild(oImg);

            //�� ���� ��������
            var colNames = new Array("ENO_NM","DPT_NM","TEAM_NM","DUTY_NM");
            var colDesc  = new Array("��&nbsp;&nbsp;��","��&nbsp;&nbsp;��","��&nbsp;&nbsp;��","��&nbsp;&nbsp;å");
            var isHEAD_NM = false;
            for(var i=0; i<colNames.length; i++) {
                oRow  = oTable.insertRow();
                oCell = oRow.insertCell();
                oCell.width = "50";
                oCell.align = "center";
                oCell.className = "creamBold";
                oCell.innerHTML = colDesc[i];

                oCell = oRow.insertCell();
                oCell.className = "padding2423";
                oCell.innerHTML = dataset.NameString(row, colNames[i]);
            }



		//������ IT�̰ų� ����������, �������� ����� �λ����� ��� ��ȸ
		<%
		    if(box.getString("SESSION_ROLE_CD").equals("1001") || box.getString("SESSION_ROLE_CD").equals("1002")
		    		|| box.getString("SESSION_ROLE_CD").equals("2021"))  {
		%>


            //�λ����� ���� ���� ��ư �����
            oRow  = oTable.insertRow();
            oCell = oRow.insertCell();
            oCell.colSpan   = "2";

            oBtn = document.createElement("input");
            oBtn.type   = "button";
            oBtn.value  = "�λ���������";
            oBtn.name   = dataset.NameString(row, "ENO_NO");   //name �Ӽ��� ����� ����
            oBtn.style.width = "160px";
            oBtn.onclick = viewEnoInfo;

            oCell.appendChild(oBtn);


		<%
		    }
		%>


		//������ �μ����� ����� �μ����� �λ����� ��ȸ
		<%
		    if(box.getString("SESSION_ROLE_CD").equals("2022"))  {
		%>


		if(dataset.NameString(row, "DPT_CD") ==  "<%=SESSION_DPTCD%>"){

            //�μ����� �λ����� ���� ���� ��ư �����
            oRow  = oTable.insertRow();
            oCell = oRow.insertCell();
            oCell.colSpan   = "2";

            oBtn = document.createElement("input");
            oBtn.type   = "button";
            oBtn.value  = "�μ�����������";
            oBtn.name   = dataset.NameString(row, "ENO_NO");   //name �Ӽ��� ����� ����
            oBtn.dpt   = dataset.NameString(row, "DPT_CD");   //name �Ӽ��� �Ҽ��� ����
            oBtn.style.width = "160px";
            oBtn.onclick = viewEnoInfo_Dpt;

            oCell.appendChild(oBtn);

			}

		<%
		    }
		%>

            return oTable;
        }

        /**
         * �ش� �Ҽ��� �Ҽӻ�� ����Ʈ�� ��ȸ��
         * @param oTarget - ������ Object
         * @param dataset - DB ���� ��ȸ�� �� ��� ����Ʈ
         */
        function fnc_BindingEno_box(oTarget, dataset) {
            var oTable = document.createElement("table");
            var oRow;
            var oCell;

            oTarget.appendChild(oTable);

            //box table ����
            oTable.border       = "0";
            oTable.cellSpacing  = "0";
            oTable.cellPadding  = "10";

            oRow  = oTable.insertRow();

            for(var i=1; i<dataset.CountRow; i++) {
                oCell = oRow.insertCell();
                oCell.vAlign = "top";
                oCell.appendChild(createEno_box(dataset, i, "lower"));
            }
        }

        /**
         * �λ����� ���� Event Handler
         */
        function viewEnoInfo() {
            var url = "";
            var data = new String();

            data.eno_no     = this.name;
            data.mode       = "read";
            url = "/hr/pir/pirc010.jsp";

            window.showModalDialog(url, data, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        }

        /**
         * �μ��� �λ����� ���� Event Handler
         */
        function viewEnoInfo_Dpt() {

            var url = "";
            var data = new String();

            data.eno_no     = this.name;
            data.dpt_cd     = this.dpt;
            data.mode       = "read";

            //dsT_CM_PERSON_DPT.DataId = "/servlet/GauceChannelSVL?cmd=hr.eis.c.eisc010.cmd.EISC010CMD&S_MODE=SHR_DPT&ENO_NO="+data.eno_no+"&DPT_CD="+data.dpt_cd;
			//prompt(this, dsT_CM_PERSON_DPT.DataId);
            //dsT_CM_PERSON_DPT.Reset();

			if(data.dpt_cd != "<%=SESSION_DPTCD%>"){
				alert("�Ҽ� �μ��� �ο� ������ �������ϴ�.");
				return false;
			}

            url = "/hr/pir/pirc010.jsp";

            window.showModalDialog(url, data, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>

    <Object ID="dsT_CM_PERSON2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>

    <Object ID="dsT_CM_PERSON_DPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>
    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                      |
    +------------------------------------------------------>
    <Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        var target = document.getElementById("TARGET_ENO");
        fnc_RemoveChild(target);//�ش� Element�� Child Node�� ��� ����
        target.appendChild(createEno_box(dsT_CM_PERSON, 1, "upper"));
    </Script>

    <Script For=dsT_CM_PERSON2 Event="OnLoadCompleted(iCount)">
        var target = document.getElementById("TARGET_ENO_LIST");
        fnc_RemoveChild(target);//�ش� Element�� Child Node�� ��� ����
        fnc_BindingEno_box(target, dsT_CM_PERSON2)
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                          |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                             |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnFail()">
        cfErrorMsg(this);
    </script>




    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- ���� ������ ���� -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">ȭ��������</td>
                    <td align="right" class="navigator">HOME/�濵����/�ο���Ȳ(EIS)/<font color="#000000">ȭ��������</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- ����� �����ֱ� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="250" align="center" valign="top">
                <table width="90%" border="3" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <tr>
                    <td><b>[ȭ������������]</b><br>
                    &nbsp;�ش��ϴ� ����� ������ Ŭ���ϸ� ���� Ȥ�� ���� �Ҽ��� ���� ������ ��ȸ�Ͻ� �� �ֽ��ϴ�.
                    </td>
                </tr>
                </table>
            </td>
            <td align="center" id="TARGET_ENO">

            </td>
            <td width="250"></td>
        </tr>
    </table>
    <!-- ����� �����ֱ� -->

    <br>

    <!-- ����ڿ� ���� �ִ� ����� �����ֱ� -->
    <div id="TARGET_ENO_LIST" style="width:800px; height:340; z-index:1; overflow-x:auto;" align="center">
    </div>
    <!-- ����ڿ� ���� �ִ� ����� �����ֱ� -->

    </form>
    <!-- form �� -->

</body>
</html>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->