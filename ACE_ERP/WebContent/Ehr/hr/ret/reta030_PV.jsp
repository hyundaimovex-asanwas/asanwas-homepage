<!--
***********************************************************************
* @source      : reta030_PV.jsp
* @description : 퇴직금계산처리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11      김학수        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%

    String eno_no    = request.getParameter("eno_no");
    String eno_nm =  request.getParameter("eno_nm");

    String occ_cd    = request.getParameter("occ_cd");
    String dpt_nm    = request.getParameter("dpt_nm");
    String job_nm    = request.getParameter("job_nm");
    String hirg_ymd  = request.getParameter("hirg_ymd");
    String ret_ymd   = request.getParameter("ret_ymd");
    String oriYmd    = request.getParameter("oriYmd");
    String ymd       = request.getParameter("ymd");
    String normal_pay  = request.getParameter("normal_pay");           //월통상임금
    String ret_lee_yy  = request.getParameter("ret_lee_yy");           //근속년수
    String ret_lse_mm  = request.getParameter("ret_lse_mm");           //근속월수
    String ret_lse_dd  = request.getParameter("ret_lse_dd");           //근속일수
    String ret_lse_per = request.getParameter("ret_lse_per");          //근속비율
    String avg_pay     = request.getParameter("avg_pay");              //평균임금
    String sub_bon     = request.getParameter("sub_bon");              //산입액
    String ret_pay     = request.getParameter("ret_pay");              //퇴직금기산일
    String asd_amt     = request.getParameter("asd_amt");              //퇴직금기산일
    String tot_amt     = request.getParameter("tot_amt");              //퇴직금기산일
    String year_bonus  = request.getParameter("year_bonus");           //지급액 (연월차수당)
    String tun_dd      = request.getParameter("tun_dd");               //미사용일수

    String str_ymd1 = request.getParameter("str_ymd1");
    String str_ymd2 = request.getParameter("str_ymd2");
    String str_ymd3 = request.getParameter("str_ymd3");
    String str_ymd4 = request.getParameter("str_ymd4");
    String end_ymd1 = request.getParameter("end_ymd1");
    String end_ymd2 = request.getParameter("end_ymd2");
    String end_ymd3 = request.getParameter("end_ymd3");
    String end_ymd4 = request.getParameter("end_ymd4");
    String ymd_val  = request.getParameter("ymd_val");
    String TYPE  = request.getParameter("TYPE");

    //str_ymd1 = str_ymd1.substring(0,4) + "/" + str_ymd1.substring(4,2) + "/" + str_ymd1.substring(6,2);

    String param1 = "[:eno_no]="+eno_no+"[:eno_nm]="+eno_nm+"[:occ_cd]="+occ_cd+"[:dpt_nm]="+dpt_nm+"[:job_nm]="+job_nm+"[:hirg_ymd]="+hirg_ymd+"[:ret_ymd]="+ret_ymd+"[:ymd]="+ymd;
    String param2 = "[:normal_pay]="+normal_pay+"[:ret_lee_yy]="+ret_lee_yy+"[:ret_lse_mm]="+ret_lse_mm+"[:ret_lse_dd]="+ret_lse_dd+"[:ret_lse_per]="+ret_lse_per+"[:avg_pay]="+avg_pay+"[:sub_bon]="+sub_bon+"[:ret_pay]="+ret_pay+"[:asd_amt]="+asd_amt+"[:tot_amt]="+tot_amt+"[:year_bonus]="+year_bonus+"[:tun_dd]="+tun_dd;
    String param3 = "[:str_ymd1]="+str_ymd1+"[:str_ymd2]="+str_ymd2+"[:str_ymd3]="+str_ymd3+"[:str_ymd4]="+str_ymd4+"[:end_ymd1]="+end_ymd1+"[:end_ymd2]="+end_ymd2+"[:end_ymd3]="+end_ymd3+"[:end_ymd4]="+end_ymd4+"[:ymd_val]="+ymd_val+"[:TYPE]="+TYPE;
    String param  = param1 + param2 + param3;

  //  System.out.println("param  ="+param  );


/*
    System.out.println("eno_no  ="+eno_no  );
    System.out.println("eno_nm  ="+eno_nm  );
    System.out.println("occ_cd  ="+occ_cd  );
    System.out.println("dpt_nm  ="+dpt_nm  );
    System.out.println("job_nm  ="+job_nm  );
    System.out.println("hirg_ymd="+hirg_ymd);
    System.out.println("ret_ymd ="+ret_ymd );

    System.out.println("normal_pay ="+normal_pay );
    System.out.println("ret_lee_yy ="+ret_lee_yy );
    System.out.println("ret_lse_mm ="+ret_lse_mm );
    System.out.println("ret_lse_dd ="+ret_lse_dd );
    System.out.println("ret_lse_per="+ret_lse_per);
    System.out.println("avg_pay    ="+avg_pay    );
    System.out.println("sub_bon    ="+sub_bon    );
    System.out.println("ret_pay    ="+ret_pay    );
    System.out.println("asd_amt    ="+asd_amt    );
    System.out.println("tot_amt    ="+tot_amt    );
    System.out.println("year_bonus ="+year_bonus );
    System.out.println("tun_dd     ="+tun_dd     );

    System.out.println("str_ymd1="+str_ymd1);
    System.out.println("str_ymd2="+str_ymd2);
    System.out.println("str_ymd3="+str_ymd3);
    System.out.println("str_ymd4="+str_ymd4);
    System.out.println("end_ymd1="+end_ymd1);
    System.out.println("end_ymd2="+end_ymd2);
    System.out.println("end_ymd3="+end_ymd3);
    System.out.println("end_ymd4="+end_ymd4);
*/

//System.out.println("eno_nm  ="+eno_nm  );
//System.out.println("TYPE  ="+TYPE  );


%>
<html>
<head>
<title>미리보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--

/*  화면 종료(닫기)  */
function fnc_Exit() {
    window.close();
}

function goclick(x) {
	if( !document.form1.aaa.RunButton(x) ) {
        alert("개체가 없습니다.");
	}
}
function winclose() {
    window.close();
}


//-->
</SCRIPT>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="form1">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="25">
<tr>
    <td bgcolor="#75B543" height="3"></td>
</tr><tr>
    <td bgcolor="#EAEAEA" valign="middle" align="right">
        <table border="1" cellspacing="0" cellpadding="0">
        <tr>

            <td width="">
				<!-- input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'" -->
                <!-- input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'" -->

                <!-- input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'" -->
                <!-- input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'"></td -->
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
<!--여기서부터 코딩입니다//-->
<comment id="__NSID__">
              <object id="aaa" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="reta030.hnw">
              <param name="initvalue" VALUE=<%=param%>>
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
</comment><script> __ShowEmbedObject(__NSID__); </script>
<!--여기까지 코딩입니다//-->
			</td>
		</tr>
	</table>
</form>
</body>
</html>