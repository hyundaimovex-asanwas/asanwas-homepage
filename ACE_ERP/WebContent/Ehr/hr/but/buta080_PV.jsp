<!--
***********************************************************************
* @source      : buta050_PV.jsp
* @description : �����������Ȳǥ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/05   �漮ȣ        �����ۼ�.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String user_name     = request.getParameter("user_name").replaceAll(" ", "");
    String user_no       = request.getParameter("user_no");
    String cd_gbn_val    = request.getParameter("cd_gbn_val");
    String cd_gbn        = request.getParameter("cd_gbn");
    String seq           = request.getParameter("seq");
    String ymd_val       = request.getParameter("ymd_val");
    String today_ymd     = request.getParameter("today_ymd");
    String today_ymd_val = request.getParameter("today_ymd_val");
    String ymd1_ins      = request.getParameter("ymd1_ins");
    String str_city1     = request.getParameter("str_city1");
    String end_city1     = request.getParameter("end_city1");
    String kor_type1_val = request.getParameter("kor_type1_val");
    String str_code1     = request.getParameter("str_code1");
    String end_code1     = request.getParameter("end_code1");
    String kor_type1     = request.getParameter("kor_type1");
    String ymd2_ins      = request.getParameter("ymd2_ins");
    String str_city2     = request.getParameter("str_city2");
    String end_city2     = request.getParameter("end_city2");
    String str_code2     = request.getParameter("str_code2");
    String end_code2     = request.getParameter("end_code2");
    String kor_type2     = request.getParameter("kor_type2");
    String kor_type2_val = request.getParameter("kor_type2_val");

    String param = "[:user_name]="+user_name+"[:user_no]="+user_no+"[:cd_gbn_val]="+cd_gbn_val+"[:cd_gbn]="+cd_gbn+"[:ymd_val]="+ymd_val+"[:today_ymd]="+today_ymd+"[:ymd1_ins]="+ymd1_ins+"[:ymd2_ins]="+ymd2_ins+"[:str_city1]="+str_city1+"[:end_city1]="+end_city1+"[:ymd_val]="+ymd_val+"[:kor_type1_val]="+kor_type1_val+"[:str_city2]="+str_city2+"[:end_city2]="+end_city2+"[:kor_type2_val]="+kor_type2_val;
	System.out.println("param = "+param);
%>
<html>
<head>
<title>�̸�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--

/*  ȭ�� ����(�ݱ�)  */
function fnc_Exit() {
    window.close();
}

function goclick(x) {
	if( !document.form1.aaa.RunButton(x) ) {
        alert("��ü�� �����ϴ�.");

	}else{

	    if (dsT_DI_BUSINESSTRIP_KORAIL.CountColumn == 0) {
	        dsT_DI_BUSINESSTRIP_KORAIL.setDataHeader("CD_GBN_VAL:STRING:KEYVALUETYPE, SEQ:STRING:KEYVALUETYPE, TODAY_YMD_VAL:STRING, YMD1_INS_VAL:STRING, STR_CODE1:STRING, END_CODE1:STRING, KOR_TYPE1:STRING, YMD2_INS_VAL:STRING, STR_CODE2:STRING, END_CODE2:STRING, KOR_TYPE2:STRING, USER_NAME:STRING, USER_NO:STRING");
	    }

	    dsT_DI_BUSINESSTRIP_KORAIL.AddRow();
	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"CD_GBN_VAL")="<%=cd_gbn_val%>";         // ǰ�ǹ�ȣ
	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"SEQ")="<%=seq%>";                    	// �Ϸù�ȣ
	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"TODAY_YMD_VAL")="<%=today_ymd_val%>";   // ������

	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"YMD1_INS_VAL")="<%=ymd1_ins%>";         // ������1
	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"STR_CODE1")="<%=str_code1%>";
	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"END_CODE1")="<%=end_code1%>";
	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"KOR_TYPE1")="<%=kor_type1%>";

	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"YMD2_INS_VAL")="<%=ymd2_ins%>";
	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"STR_CODE2")="<%=str_code2%>";
	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"END_CODE2")="<%=end_code2%>";
	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"KOR_TYPE2")="<%=kor_type2%>";

	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"USER_NAME")="<%=user_name%>";           // �Է���
	    dsT_DI_BUSINESSTRIP_KORAIL.NameValue(1,"USER_NO")="<%=user_no%>";

	    trT_DI_BUSINESSTRIP_KORAIL.KeyValue = "tr01(I:SAV=dsT_DI_BUSINESSTRIP_KORAIL)";
	    trT_DI_BUSINESSTRIP_KORAIL.action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta080.cmd.BUTA080CMD&S_MODE=SAV";
	    trT_DI_BUSINESSTRIP_KORAIL.post();
    }

    window.close();

}

function winclose() {
    window.close();
}


//-->
</SCRIPT>
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

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP_KORAIL)		|
    | 3. ���Ǵ� Table List(T_CM_PERSON, T_DI_BUSINESSTRIP_KORAIL)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_KORAIL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_BUSINESSTRIP_KORAIL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
          //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
          //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
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
        //fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_KORAIL event="OnFail()">
        cfErrorMsg(this);
    </script>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="form1">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="25">
<tr>
    <td bgcolor="#75B543" height="3"></td>
</tr><tr>
    <td bgcolor="#EAEAEA" valign="middle" align="left">
        <table border="1" cellspacing="0" cellpadding="0">
        <tr>
<!--
            <td width="">

				<input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
                <input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">

                <input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
                <input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'"></td>
                -->
            <!-- td width="8" align="center"></td -->
            <td width="">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)">
                    <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle"  onclick="goclick('Print');"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">
                    <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle"  onclick="fnc_Exit()"></a></td>
        </tr>
        </table>
    </td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
<!--���⼭���� �ڵ��Դϴ�//-->
<comment id="__NSID__">
              <object id="aaa" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="buta080.hnw">
              <param name="initvalue" VALUE=<%=param%>>
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
 </comment><script> __ShowEmbedObject(__NSID__); </script>
<!--������� �ڵ��Դϴ�//-->
			</td>
		</tr>
	</table>
</form>
</body>
</html>