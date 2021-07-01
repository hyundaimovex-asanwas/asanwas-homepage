<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�   : ���밴�� ��ȸ-���� 
 * ���α׷�ID    : RM311S
 * J  S  P      : rm311s
 * �� �� ��     : RM311S
 * �� �� ��     : ���ؼ�
 * �� �� ��     : 2006-06-27
 * �������      : ���밴����ȸ(��ȸ)
 * 				      �޼����� �߼��ϴ� �������� �ܺ�SMS ��� ó���� ���� windwos������ ASP�� �Ǿ� ����.
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-04-16][�ɵ���] ���� �����ο� 300������ �������(��������)
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   String firstday = m_today.format(date.getTime());
   date.set(java.util.Calendar.HOUR_OF_DAY, 120);
   String lastday = m_today.format(date.getTime());

   HDCookieManager cookie = new HDCookieManager(request, response);

   String c_sid = cookie.getCookieValue("c_sid",request);
   String c_cd = cookie.getCookieValue("c_cd",request);
   String c_nm = cookie.getCookieValue("c_nm",request);
   String c_title = cookie.getCookieValue("c_title", request);
   String user_id = cookie.getCookieValue("user_id",request);
   String user_name = cookie.getCookieValue("user_name", request);
   String user_isfrom = cookie.getCookieValue("user_from", request);
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

<%
/*=============================================================================
            Developer Java Script
=============================================================================*/
%>
   <script language="javascript">
        var v_job = "H";
        var div='';
   /*
    * �������ε�
    */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
	}
   /*
    * ����ȸ
    */
   function fnInit(){
      sBgnDate.text='<%=firstday%>';
      sEndDate.text='<%=lastday%>';

      div='init';
      v_job = "H";
      cfStyleGrid(getObjectFirst("gr1"), "comn");
      cfStyleGrid(getObjectFirst("gr2"), "comn");
      gr1.TitleHeight = "35";
      gr2.TitleHeight = "35";

      window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";

	  ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
      ds3.Reset(); //�����ڵ�
   }

   /*
    * ������ȸ
    */
    function fnSelect() {
      if (ds1.isUpdated || ds2.IsUpdated ) {
         alert("�������� ���� �ֽ��ϴ�.");
      } else {
         if ( sBgnDate.text.trim() == '' || sEndDate.text.trim() == '' ) {
            alert("������ڸ� �Է��� �ּ���.");
            return;
         }

         if (fnDayCap(sBgnDate.text, sEndDate.text) > 6) {
            alert("�Ⱓ�� �ִ� 5�ϱ��� �����մϴ�.");
            return;
         }

         if (sBgnDate.text > sEndDate.text) {
            alert("�Ⱓ�� ��Ȯ�� �Է��Ͻʽÿ�.");
            return;
         }

           v_job = "S";
            window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
           var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
               + "sBgnDate=" + sBgnDate.text + ","
               + "sEndDate=" + sEndDate.text + ","
               + "sSaupSid=" + ds3.namevalue(ds3.rowposition,"saup_sid") + ","
               + "sUpjangSid=" + ds4.namevalue(ds4.rowposition,"upjang_sid") + ","
               + "sRoomTypeSid=" + ds5.namevalue(ds5.rowposition,"room_type_sid");

           ln_TRSetting(tr1,
               "<%=dirPath%><%=HDConstant.PATH_RM%>Rm311S",
               "JSP(O:DS1=ds1)",
               param);
           tr_post(tr1);
        }
    }

   /*
    * ��������ȸ
    */
    function fnSelectDS2() {
      if ( ds1.isUpdated || ds2.IsUpdated ) {
         alert("�������� ���� �ֽ��ϴ�.");
      } else {
         v_job = "S";
         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
                   + "sBgnDate="       + sBgnDate.text + ","
                   + "sEndDate="       + sEndDate.text + ","
                   + "sSaupSid="       + ds3.namevalue(ds3.rowposition,"saup_sid") + ","
                   + "sUpjangSid="     + ds4.namevalue(ds4.rowposition,"upjang_sid") + ","
                   + "sRoomTypeSid="   + ds5.namevalue(ds5.rowposition,"room_type_sid");

         ln_TRSetting(tr1,
             "<%=dirPath%><%=HDConstant.PATH_RM%>Rm311S",
             "JSP(O:DS2=ds2)",
             param);
         tr_post(tr1);
      }
    }

   /*
    * ������ ��ȸ
    */
   function fnSelectDs4() {
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds3.namevalue(ds3.rowposition,"saup_sid");
        ln_TRSetting(tr2,
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm311S",
            "JSP(O:DS4=ds4)",
            param);
        tr_post(tr2);
   }
   /*
    * ����Ÿ�� ��ȸ
    */
   function fnSelectDs5() {
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sUpjangSid=" + ds4.namevalue(ds4.rowposition,"upjang_sid");
        ln_TRSetting(tr3,
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm311S",
            "JSP(O:DS5=ds5)",
            param);
        tr_post(tr3);
   }
   /*
    * ����
    */
   function fnExcelDs1() {
      gr1.runexcelsheet("���밴�� ��ȸ");
      gr2.runexcelsheet("���밴�� ��ȸ");
   }

   /* �ϼ� ���� */
   function fnDayCap(Date1, Date2) {
      nDate1 = new Date(Date1.substring(0, 4), Date1.substring(4, 6), Date1.substring(6, 8));
      nDate2 = new Date(Date2.substring(0, 4), Date2.substring(4, 6), Date2.substring(6, 8));

      tDate1 = nDate1.getTime();
      tDate2 = nDate2.getTime();

      Cnt = tDate2 - tDate1;

      Cnt = Math.ceil(Cnt/(24*3600*1000));
      return Cnt;
   }
   </script>

<%
/*=============================================================================
         Gauce Components Event Scripts
=============================================================================*/
%>
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
			for ( i=1;i<=ds2.CountRow;i++ ) {
				if ( ds1.namevalue(ds1.rowposition,"upjang_sid") == ds2.namevalue(i,"upjang_sid") && ds1.namevalue(ds1.rowposition,"use_date") == ds2.namevalue(i,"use_date") ) {
					ds2.rowposition=i;
					ds2.namevalue(i,"select_div") = 'Y';
				} else {
					ds2.namevalue(i,"select_div") = 'N';
				}
			}
			ds2.ResetStatus();
		</script>

		<script language=JavaScript for=ds1 event=OnRowPosChanged>
			for ( i=1;i<=ds2.CountRow;i++ ) {
				if ( ds1.namevalue(ds1.rowposition,"upjang_sid") == ds2.namevalue(i,"upjang_sid") && ds1.namevalue(ds1.rowposition,"use_date") == ds2.namevalue(i,"use_date") ) {
					ds2.rowposition=i;
					ds2.namevalue(i,"select_div") = 'Y';
				} else {
					ds2.namevalue(i,"select_div") = 'N';
				}
			}
			ds2.ResetStatus();
		</script>

		<script language="javascript"  for=gr2 event=OnColumnPosChanged(row,colid)>
			if ( colid == 'rsv_close_date' || colid == 'use_date' || colid == 'yoil_nm' || colid == 'room_type_cd' ) {
				if ( ds2.namevalue(row,"select_div") == 'Y' ) {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";
				} else {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";
				}
			} else if ( colid == 'use_cnt2' ) {
				if ( ds2.namevalue(row,"use_yn2") == 'N' ) {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";
				} else {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";
				}
			} else if ( colid == 'use_cnt1' ) {
				if ( ds2.namevalue(row,"use_yn1") == 'N' ) {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";
				} else {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";
				}
			} else {
				gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
				gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
				gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
				gr2.SelectionColorProp("EditCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("EditRow", "BgColor") = "";
				gr2.SelectionColorProp("CurCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("CurRow", "BgColor") = "";
				gr2.SelectionColorProp("SelRow", "BgColor") = "";
			}
		</script>

      <script language=JavaScript for= lc1 event=OnSelChange()>
         if ( div!='init')
            fnSelectDs4()
      </script>

      <script language=JavaScript for= lc2 event=OnSelChange()>
         if ( div!='init')
            fnSelectDs5()
      </script>

       <script language=JavaScript for=sBgnDate event=OnKillFocus()>
           if( sBgnDate.Modified == true )
            sEndDate.text = sBgnDate.text;
       </script>

<%
/*=============================================================================
         Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �۾�����
%>
   <script language="javascript" for="tr1" event="onsuccess()">
      if(v_job=="I") {
          window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
          fnSelect();
      }  else if(v_job == "H" || v_job=="S")
          window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
   </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �۾�����
%>
   <script language="javascript" for="tr1" event="onfail()">
      window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
   </script>
<%
/*=============================================================================
         DataSet Component's Event Message Scripts
=============================================================================*/
%>
   <script language=JavaScript  for=ds1 event="OnLoadStarted()">
      window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
   </script>

   <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
        if (ds1.CountRow > 0)
            fnSelectDS2();
   </script>

   <script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
      fnSelectDs4();
   </script>
   <script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
      fnSelectDs5();
      div='';
   </script>
<%
/*=============================================================================
         DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
      <td>
         <table border="0" width="845px"  cellpadding="0" cellspacing="0">
            <tr>
               <td align="right" colspan="2">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                     <tr bgcolor="#ffffff">
                        <td align="right" height="30px">
                           <img src="<%=dirPath%>/Sales/images/refer.gif"     style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
                           <img src="<%=dirPath%>/Sales/images/excel.gif"     style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnExcelDs1()">
                        </td>
                     </tr>
                     <tr height="25px">
                        <td>
                           <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align=left>
                              <tr bgcolor="#6f7f8d" height=25>
                                 <td class="text" width="100">�������</td>
                                 <td align=left bgcolor="#ffffff">&nbsp;
                                    <%=HDConstant.COMMENT_START%>
                                    <object id=sBgnDate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">
                                       <param name=Alignment   value=1>
                                       <param name=Format      value="YYYY-MM-DD">
                                       <param name=InputFormat value="YYYYMMDD">
                                       <param name=Cursor      value="iBeam">
                                       <param name=Border      value="false">
                                       <param name=InheritColor      value="true">
                                       <param name=ReadOnly    value="false">
                                       <param name=SelectAll   value="true">
                                       <param name=SelectAllOnClick    value="true">
                                       <param name=SelectAllOnClickAny   value=false>
                                    </object> ~
                                    <object id=sEndDate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">
                                       <param name=Alignment   value=1>
                                       <param name=Format      value="YYYY-MM-DD">
                                       <param name=InputFormat value="YYYYMMDD">
                                       <param name=Cursor      value="iBeam">
                                       <param name=Border      value="false">
                                       <param name=InheritColor      value="true">
                                       <param name=ReadOnly    value="false">
                                       <param name=SelectAll   value="true">
                                       <param name=SelectAllOnClick    value="true">
                                       <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                 </td>
                                 <td align=left width=70 class="text">&nbsp;����</td>
                                 <td align=left bgcolor="#ffffff">&nbsp;
                                    <%=HDConstant.COMMENT_START%>
                                    <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                       <param name=ComboDataID       value=ds3>
                                       <param name=BindColumn        value="saup_sid">
                                       <param name=BindColVal        value="saup_sid">
                                       <param name=EditExprFormat    value="%,%;saup_sid,saup_nm">
                                       <param name=ListExprFormat    value="saup_nm^0^120">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                 </td>
                                 <td align=left width=70 class="text">&nbsp;ȣ�ڸ�</td>
                                 <td align=left bgcolor="#ffffff">&nbsp;
                                 <%=HDConstant.COMMENT_START%>
                                 <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID       value=ds4>
                                    <param name=BindColumn        value="upjang_sid">
                                    <param name=BindColVal        value="upjang_sid">
                                    <param name=EditExprFormat    value="%,%;upjang_sid,upjang_nm">
                                    <param name=ListExprFormat    value="upjang_nm^0^120">
                                 </object>
                                 <%=HDConstant.COMMENT_END%>
                                 </td>
                                 <td align=left width=70 class="text">&nbsp;����Ÿ��</td>
                                 <td align=left bgcolor="#ffffff">&nbsp;
                                    <%=HDConstant.COMMENT_START%>
                                    <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                       <param name=ComboDataID       value=ds5>
                                       <param name=BindColumn        value="room_type_sid">
                                       <param name=BindColVal        value="room_type_sid">
                                       <param name=EditExprFormat    value="%,%;room_type_sid,room_type_cd">
                                       <param name=ListExprFormat    value="room_type_cd^0^120">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                 </td>
                              </tr>
                           </table>
                        </td>
                     </tr>
                  </table>
               </td>
            </tr>
            <tr>
               <td height='5px'></td>
            </tr>
            <tr>
               <td width="850px" colspan='2'>
                  <table  border="0" cellpadding="0" cellspacing="0" >
                     <tr valign="top"">
                        <td align="left" width="845px" bordercolor="#000000">
                           <%=HDConstant.COMMENT_START%>
                           <object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=490px; height:365" border="1" >
                              <param name="DataID"    value="ds1">
                              <param name="BorderStyle"   value="0">
                              <param name=ColSizing       value="true">
                              <param name="editable"      value="false">
                              <param name=UsingOneClick     value="1">
                              <param Name="AllShowEdit"   value="True">
                              <param name="SortView"      value="Right">
                              <param name=SuppressOption value=1>
                              <param name=SelectionColor    value="<SC>Type='FocusEditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
                                 <SC>Type='EditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
                                 <SC>Type='FocusEditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
                                 <SC>Type='EditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
                                 <SC>Type='FocusCurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
                                 <SC>Type='CurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
                                 <SC>Type='FocusCurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
                                 <SC>Type='CurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
                                 <SC>Type='FocusSelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
                                 <SC>Type='SelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
                              ">
                              <param name="Format" value="
                                 <C> name='������'       ID='rsv_close_date'  width=70 align=left editlimit=8 show=true mask=XXXX-XX-XX suppress=1</C>
                                 <C> name='�����'       ID='use_date'        fontstyle=bold  width=80 align=left editlimit=8 show=true mask=XXXX-XX-XX suppress=2</C>
                                 <C> name='����'         ID='yoil_nm'         width=30 align=center editlimit=10 show=true suppress=3</C>
                                 <C> name='ȣ��'         ID='upjang_nm'       width=140 align=left editlimit=50 show=true suppress=4</C>
                                 <C> name='�'         ID='open_goods_nm'   width=30  align=center editlimit=20 show=true suppress=5</C>
                                 <C> name='����\\(2��)'  ID='use_cnt2'        fontstyle=bold   width=40 align=right editlimit=33 show=true</C>
                                 <C> name='����\\(1��)'  ID='use_cnt1'        fontstyle=bold   width=40 align=right editlimit=33 show=true</C>
                                 <C> name='����SID'      ID='upjang_sid'      align=left editlimit=12 show=false</C>
                                 <C> name='����\\(��)'  ID='naekum_cnt'        width=40 align=right edit=none show=true suppress=1</C>
                              ">
                           </object>
                           <%=HDConstant.COMMENT_END%>
                        </td>
                        <td>&nbsp;</td>
                        <td align="left" width="845px" bordercolor="#000000">
                           <%=HDConstant.COMMENT_START%>
                           <object id=gr2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=350px; height:365" border="1" >
                              <param name="DataID"    value="ds2">
                              <param name="BorderStyle"     value="0">
                              <param name=ColSizing         value="true">
                              <param name="editable"        value="true">
                              <param name=UsingOneClick     value="1">
                              <param Name="AllShowEdit"     value="True">
                              <param name="SortView"        value="Right">
                              <param name=MultiRowSelect    value=true>
                              <param name=SuppressOption    value=1>
                              <param name=SelectionColor    value="<SC>Type='FocusEditCol', BgColor='', TextColor='Black'</SC>
                                 <SC>Type='EditCol',        BgColor='', TextColor='Black'</SC>
                                 <SC>Type='FocusEditRow',   BgColor='', TextColor='Black'</SC>
                                 <SC>Type='EditRow',        BgColor='', TextColor='Black'</SC>
                                 <SC>Type='FocusCurCol',    BgColor='', TextColor='Black'</SC>
                                 <SC>Type='CurCol',         BgColor='', TextColor='Black'</SC>
                                 <SC>Type='FocusCurRow',    BgColor='', TextColor='Black'</SC>
                                 <SC>Type='CurRow',         BgColor='', TextColor='Black'</SC>
                                 <SC>Type='FocusSelRow',    BgColor='', TextColor='Black'</SC>
                                 <SC>Type='SelRow',         BgColor='', TextColor='Black'</SC>
                              ">
                              <param name="Format"  value="
                                 <C> name='�����'         ID='use_date'     bgColor={IF(select_div='Y','#E0CFE4','#fefec0')}fontstyle=bold  width=80  align=left editlimit=8 edit=none show=true mask=XXXX-XX-XX suppress=2</C>
                                 <C> name='����'           ID='room_type_cd' bgColor={IF(select_div='Y','#E0CFE4','#fefec0')} width=55 align=left editlimit=5 edit=none show=true suppress=4</C>
                                 <C> name='���Ǹ�'         ID='room_type_nm' bgColor={IF(select_div='Y','#E0CFE4','#fefec0')} width=85 align=left editlimit=5 edit=none show=true suppress=4</C>
                                 <C> name='����\\(2��)'    ID='use_cnt2'    fontstyle=bold  width=40 align=right editlimit=5 edit=none show=true</C>
                                 <C> name='����\\(1��)'    ID='use_cnt1'    fontstyle=bold  width=40 align=right editlimit=5 edit=none show=true</C>
                                 <C> name='����SID'        ID='upjang_sid'  align=left editlimit=12 edit=none show=false</C>
                                 <C> name='���ÿ���'       ID='select_div'  Width=60  align=center edit=none show=false </C>
                              ">
                           </object>
                           <%=HDConstant.COMMENT_END%>
                        </td>
                     </tr>
                  </table>
               </td>
            </tr>
            <tr>
              <td><br>���� 2�� ������ <b>[300��/��]</b>�� ���ѵǾ� �ְ�, <b>[����Ϻ� �ܿ� �ο���]</b>�� ǥ�õ˴ϴ�.
              </td>
            </tr>
            
         </table>
      </td>
   </tr>
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

