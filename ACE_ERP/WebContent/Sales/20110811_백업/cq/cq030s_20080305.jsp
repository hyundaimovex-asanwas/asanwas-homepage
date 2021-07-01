<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * ½Ã½ºÅÛ¸í 	: °ü±¤ÁõÃâ·Â
 * ÇÁ·Î±×·¥ID 	: CQ030S
 * J  S  P		: cq030s
 * ¼­ ºí ¸´		: Cq030S
 * ÀÛ ¼º ÀÚ		: ±¸ÀÚÇå
 * ÀÛ ¼º ÀÏ		: 2006-06-28
 * ±â´ÉÁ¤ÀÇ		: °ü±¤Áõ Á¶È¸,Ãâ·Â
 * ¼ö Á¤ ÀÚ		: ½Éµ¿Çö
 * ¼öÁ¤³»¿ë		: À§Ä¡ ¹× µðÅ×ÀÏ ¼öÁ¤
 * ¼öÁ¤³»¿ë		: ¿Ü±¹ÀÎ¿ë °ü±¤Áõ Ãß°¡
 * ÃÖÁ¾¼öÁ¤ÀÏÀÚ       : 2006-10-31
 * [¼ö  Á¤   ÀÏ  ÀÚ][¼öÁ¤ÀÚ] ³»¿ë
 * [2007-09-12][½Éµ¿Çö] »õ ¸Þ´ºÆ®¸® Àû¿ë
 * [2007-12-11][½Éµ¿Çö] ÀÌ¸§ ÆùÆ® º¼µå Àû¿ë, »çÀÌÁî Å©°Ô
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ½ÃÀÛ
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath º¯¼ö ¼³Á¤.
	String dirPath = request.getContextPath(); //HDASan
	
   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
   String firstday = m_today.format(date.getTime());		   
%>

<!-- HTML ½ÃÀÛ-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

<%
/****************************************************************************
				»ç¿ëÀÚ ½ºÅ©¸³Æ®
******************************************************************************/
%>		
	<script language="javascript">
        var v_job = "H";
        var div='';
	/*
	 * Description 	:  ÆäÀÌÁö ·Îµù 
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Æ®¸®ÃÊ±âÈ­ È£Ãâ

		txt_depart_date.text='<%=firstday%>';
		fnInit();
	}

	/*
	 * Description : ÃÊ±âÈ­
	 * °í°´Á¤º¸¸¦ ¾ò¾î¿Â´Ù
	 */
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";   
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_SAUP_DS=ds2,O:DS5=ds5,O:COUNTRY=ds8)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ¸ÞÀÎÁ¶È¸
// Parameter 	: 
%>
	function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("¼öÁ¤ÁßÀÎ ÇàÀÌ ÀÖ½À´Ï´Ù."); 
		} else {        
			if ( txt_depart_date.text.trim() == '' ) {
				alert("Ãâ¹ßÀÏÀÚ¸¦ ÀÔ·ÂÇØÁÖ¼¼¿ä.");
				return;
			}			
	        v_job = "S";
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        document.all.LowerFrame.style.visibility="visible";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
				+ "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
				+ "sDepartDate=" + txt_depart_date.text + ","
				+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + ","
				+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
				+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
				+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + ","
				+ "sCountryGu=" + drp_country_cd.ValueOfIndex("detail",drp_country_cd.Index) + ","
				+ "sManageNo=" + txt_manage_no.value;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq030S",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
	}

	/*
	 * Ãâ°æ½Ã°£, »óÇ°Á¶È¸
	 */		
	function fnSelectDs3() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + txt_depart_date.text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_DEPART_TIME_DS=ds3,O:S_GOODS_DS=ds4)",
            param);
        tr_post(tr2);
	}	
	/*
	 * ¹ÝÁ¶È¸
	 */		
	function fnSelectDs6() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + txt_depart_date.text + ","	            
			+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time");			
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS6=ds6)",
            param);
        tr_post(tr3);
	}	  

	/*
	 * Á¶ Á¶È¸
	 */		
	function fnSelectDs7() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
        	+ "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
            + "sDepartDate=" + txt_depart_date.text + ","	
           	+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time", drp_depart_time.Index) + "," 
            + "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","     
            + "sClass=" + ds6.namevalue(ds6.rowposition,"class");
        ln_TRSetting(tr4, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS7=ds7)",
            param);
        tr_post(tr4);
	}		

	function fnExcel() {
		if(ds1.RowCount==0){
	            alert("µ¥ÀÌÅÍ¸¦ ¸ÕÀú Á¶È¸ÇÏ½Ã±æ ¹Ù¶ø´Ï´Ù.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:°ü±¤Áõ Ãâ·Â¸í´Ü; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("°ü±¤Áõ Ãâ·Â¸í´Ü","°ü±¤Áõ Ãâ·Â¸í´Ü.xls", 8);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ÇàÃß°¡ (±×¸®µåº°)
// Parameter 	: 
%>
	function fnAddRow() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  Çà»èÁ¦ (±×¸®µåº°)
// Parameter 	: 
%>
	function fnDeleteRow() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  Àû¿ë 
// Parameter 	: 
%>
	function fnApply() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  Ãë¼Ò
%>
	function fnCancel() {

	}		
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ÀÎ¼â
%>
	function fnPrint() {
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2,"
			+ "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
			+ "sDepartDate=" + txt_depart_date.text + ","
			+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + ","
			+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
			+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
			+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + ","
			+ "sCountryGu=" + drp_country_cd.ValueOfIndex("detail",drp_country_cd.Index) + ","
			+ "sManageNo=" + txt_manage_no.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq030S",
            "JSP(O:DEFAULT=ds9)",
            param);
		 fnOnProgressStart();
        tr_post(tr1);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description : ¿¢¼¿ (»ç¿ë¾ÈÇÔ)
%>
	function fnExcelDs1() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ºÐ·ù¸í ÆË¾÷ (»ç¿ë¾ÈÇÔ)
%>
	function fnPopup() {
		
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ÀÔ·Â°ª Ã¼Å© 
%>
	function fnCheck() {
	
	}	
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  È­ÀÏ¸í Ã¼Å©
%>
	function fnDivide(str, delim){

	}

<%
//////////////////////////////////////////////////////////////////////////////
//	Description : Dataset Head ¼³Á¤
%>
	function fnSetDataHeader() {

	}

	</script>
	
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=txt_depart_date event=OnKillFocus()>
		if ( div != 'init' ) {	//Ãâ¹ßÀÏÀÚ
			if ( txt_depart_date.Modified ) {
				div = 'init';
				fnSelectDs3();			
			}
		}				
	</script>

	<script language=JavaScript for=drp_saup_sid event=OnSelChange()>
		if ( div != 'init' ) {	//Áö¿ª
			div = 'init';			
			fnSelectDs3();
		}
	</script>	
<script language=JavaScript for=drp_goods_sid event=OnSelChange()>
		if ( div != 'init' ) {	//»óÇ° 
			div = 'init';
			fnSelectDs6();		
		}
	</script>	
	<script language=JavaScript for=drp_depart_time event=OnSelChange()>
	//	if ( div != 'init' ) {	//Ãâ°æ½Ã°£
	//		div = 'init';
	//		fnSelectDs6();		
	//	}
	</script>	

	<script language=JavaScript for=drp_class event=OnSelChange()>
		if ( div != 'init' ) {	//¹Ý
			div = 'init';					
			fnSelectDs7();		
		}
	</script>		
	
	<script language=JavaScript  for=ds8 event="OnLoadCompleted(row)"> <!-- ±¹Àû -->
			div.value = '';
			ds8.deleteRow(1);
			ds8.deleteRow(1);
			drp_country_cd.Index = 0;
	</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ÀÛ¾÷¼º°ø
%>
	<script language="javascript" for="tr1" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ÀÛ¾÷½ÇÆÐ
%>
	<script language="javascript" for="tr1" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ÀÛ¾÷¼º°ø
%>
	<script language="javascript" for="tr2" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ÀÛ¾÷½ÇÆÐ
%>
	<script language="javascript" for="tr2" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ÀÛ¾÷¼º°ø
%>
	<script language="javascript" for="tr3" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ÀÛ¾÷½ÇÆÐ
%>
	<script language="javascript" for="tr3" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ÀÛ¾÷¼º°ø
%>
	<script language="javascript" for="tr4" event="onsuccess()">
		div='';
        document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ÀÛ¾÷½ÇÆÐ
%>
	<script language="javascript" for="tr4" event="onfail()">
		div='';	
        document.all.LowerFrame.style.visibility="hidden";	                	
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>		

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  Á¶È¸Áß 
%>
<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	fnSelectDs3();
</script>

<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	//fnSelectDs6();
</script>
<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)"> 
	fnSelectDs6();
</script>
<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
	fnSelectDs7();
</script>

<script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
	div='';
</script>

<script language=JavaScript  for=ds9 event="OnLoadCompleted(row)">
	//ds9.namevalue(ds9.rowposition,"depart_date")=txt_depart_date.text;
	//ds9.namevalue(ds9.rowposition,"arrive_date")=txt_arrive_date.value;
	//°ü±¤Áõ ±¸ºÐ Ãâ·Â - 2006-10-31 ½Éµ¿Çö
	var sCountryGu= drp_country_cd.ValueOfIndex("detail",drp_country_cd.Index);	 

	if(sCountryGu=='10'){
		pr1.preview();	//³»±¹ÀÎ¿ë
	} else if(sCountryGu=='20'||sCountryGu=='30'||sCountryGu=='40'||sCountryGu=='50'){
		pr2.preview();	//¿µÁÖ±Ç/½Ã¹Î±Ç/¿Ü±¹ÀÎ¿ë/Á¶¼±
	}
</script>

<%
/*=============================================================================
			DataSet Components(DS) ¼±¾ð
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
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--±¹Àû±¸ºÐ--%>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--·¹Æ÷Æ®--%>
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
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>


</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- ÄÚµù ºÎºÐ ½ÃÀÛ ------------------------------->		

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="840px"  cellpadding="0" cellspacing="0">
				<tr>
					<td align="right" colspan="2">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:hand" align=absmiddle onclick="fnPrint()">
									<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
                                    <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onClick="fnExcel();">&nbsp;&nbsp;
									
					 			</td>
							</tr>	
						</table>
					</td>											
				</tr>
				<tr>
					<td align="left"  colspan='2' width="845px">
						<table width="840px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="840px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d">
											<td align="center" width="80px" class="text">Áö¿ª</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
		                             			<%=HDConstant.COMMENT_START%>
												<object id=drp_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds2>
		                                        	<param name=SearchColumn    value="saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^200">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">Ãâ¹ßÀÏÀÚ</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
					                 			<%=HDConstant.COMMENT_START%>
					             				<object id=txt_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='70px' align='absmiddle' class='textbox'>            
						               				<param name=Format      value="YYYY-MM-DD">
					                   				<PARAM NAME=InputFormat value="YYYYMMDD">
					                 				<param name=Alignment   value=1>
				                    				<param name=ClipMode    value=true>
						               				<param name=Border      value=false>
						              			</object>&nbsp;
												<object id=drp_depart_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds3>
   							                     	<param name=SearchColumn    value="depart_time_nm">
													<param name=ListExprFormat  value="depart_time_nm^0^200">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text" >»óÇ°Á¤º¸</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=drp_goods_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds4>
          							              	<param name=SearchColumn    value="goods_nm">
													<param name=ListExprFormat  value="goods_nm^0^200">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">¹Ý/Á¶</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=drp_class classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds6>
                						        	<param name=SearchColumn    value="class_nm">
													<param name=ListExprFormat  value="class_nm^0^200">
												</object>
												<object id=drp_teams classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds7>
          							              	<param name=SearchColumn    value="teams_nm">
													<param name=ListExprFormat  value="teams_nm^0^200">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>																				
			            				</tr>
			                            <tr bgcolor="#6f7f8d">
											<td align="center" width="80px" class="text">±¹Àû±¸ºÐ</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
		                             			<%=HDConstant.COMMENT_START%>
												<object id=drp_country_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds8>
		                                        	<param name=SearchColumn    value="detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^200">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">ÁÖ¹Î/¿©±Ç¹øÈ£</td>
											<td align="left" bgcolor="#ffffff" colspan="5"><nobr>&nbsp;
												<input type="text" name="txt_manage_no" size="11" maxlength="20" class="textbox">
												&nbsp;</nobr>
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
					<td width="840px" colspan='2'>
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="840px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=840px; height:410px" border="1">
									    <param name="DataID"            value="ds1">
									    <param name="BorderStyle"       value="0">
									    <!-- param name="Fillarea"          value="true"-->
									    <param name="ColSizing"         value="true">
									    <param name="editable"          value="true">
										<param name=ViewSummary     value=1>
                                        <param name="Format"            value="
                                            <C> name='No.'           ID='{CURROW}'              Width=40  align=center edit=none SumText='ÃÑ°è'</C>
                                            <C> name='¹Ý'           ID='class'              Width=60  align=center edit=none SumText=@count</C>
									        <C> name='Á¶'           ID='teams'          	Width=60  align=center edit=none</C>
									         <C> name='°ü±¤Áõ'         ID='tour_no'            Width=40  align=center edit=none</C>
									        <C> name='¼º¸í'         ID='cust_nm'        	Width=100  align=left edit=none</C>
									        <C> name='¼ºº°'      	ID='sex'            	Width=60  align=center edit=none</C>
									        <C> name='»ý³â¿ùÀÏ'     ID='birthday'       	Width=75  align=center edit=none mask=XXXX.XX.XX</C>
									        <C> name='Á÷Àå/Á÷À§'    ID='company_nm'            Width=100  align=left edit=none</C>
                                            <C> name='»ç´Â°÷'       ID='address1'           Width=145  align=Left edit=none</C>
									        <C> name='±¹Àû/¹ÎÁ·'    ID='country_cd'       	Width=80  align=left edit=none</C>
									        <C> name='¿©±Ç¹øÈ£'     ID='pass_no'        	Width=100  align=left edit=none</C>
									        <C> name='nk'     ID='tag_nk'        	Width=100  align=left edit=none</C>
									    ">
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
</table>

<!-----------------------------------------------------------------------------
Ãâ·Â¹° Á¤ÀÇºÎºÐ - °³¼º - ³»±¹ÀÎ¿ë : pr21
				¡Ø ÀÌ¹ÌÁö »ðÀÔÇÒ ¶§, jpg ¾Æ´Ï¸é ¾Èº¸ÀÎ´Ù!!!
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr21" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="MasterDataID"			VALUE="ds9">
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="true">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">	
		<PARAM NAME="Format"                VALUE="

<B>id=default ,left=0,top=0 ,right=2870 ,bottom=1961 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='nights_days1', left=1959, top=92, right=2305, bottom=134, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=1959, top=132, right=2305, bottom=174, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=940, top=343, right=1286, bottom=372, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=2567, top=438, right=2767, bottom=480, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=2355, top=438, right=2556, bottom=480, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=2144, top=438, right=2342, bottom=480, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=1959, top=337, right=2305, bottom=348, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=940, top=132, right=1286, bottom=174, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=940, top=92, right=1286, bottom=134, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='work_no', left=338, top=860, right=758, bottom=902, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=399 ,top=1031 ,right=721 ,bottom=1448</I>
	<C>id='sex', left=906, top=1561, right=982, bottom=1606, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=338, top=1640, right=982, bottom=1682, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fr_to_date', left=338, top=1893, right=982, bottom=1935, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=338, top=1811, right=982, bottom=1856, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='work_no', left=2234, top=1334, right=2540, bottom=1376, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=2234 ,top=925 ,right=2559 ,bottom=1329</I>
	<C>id='unity_no', left=2234, top=1917, right=2556, bottom=1962, face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2078, top=1830, right=2688, bottom=1864, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2078, top=1864, right=2688, bottom=1893, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2078, top=1798, right=2688, bottom=1830, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2313, top=343, right=2741, bottom=372, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2313, top=372, right=2741, bottom=401, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1283, top=385, right=1708, bottom=414, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1283, top=356, right=1708, bottom=385, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=251, top=266, right=597, bottom=306, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=251, top=303, right=597, bottom=348, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=251, top=343, right=597, bottom=372, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=251, top=385, right=597, bottom=427, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=940, top=303, right=1286, bottom=348, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=940, top=385, right=1286, bottom=427, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=412, top=451, right=584, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=594, top=451, right=768, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=1959, top=277, right=2305, bottom=319, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=1959, top=356, right=2305, bottom=401, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=1138, top=451, right=1312, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1349, top=451, right=1524, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=1561, top=451, right=1735, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='accept_no', left=2065, top=609, right=2437, bottom=651, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=2065, top=570, right=2437, bottom=612, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='accept_no', left=1046, top=609, right=1444, bottom=651, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=1046, top=570, right=1444, bottom=612, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=372, top=570, right=768, bottom=612, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='accept_no', left=372, top=609, right=768, bottom=651, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=1957, top=185, right=2305, bottom=229, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=940, top=185, right=1286, bottom=229, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=251, top=185, right=597, bottom=229, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=251, top=132, right=597, bottom=174, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=251, top=92, right=597, bottom=134, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=1389, top=185, right=1735, bottom=229, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=1389, top=92, right=1735, bottom=134, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='ÀÌ      ¸§' ,left=132 ,top=1561 ,right=296 ,bottom=1603 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=320 ,top=1614 ,right=753 ,bottom=1614 </L>
	<T>id='¼ºº°' ,left=782 ,top=1561 ,right=863 ,bottom=1603 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=890 ,top=1614 ,right=980 ,bottom=1614 </L>
	<L> left=320 ,top=1693 ,right=980 ,bottom=1693 </L>
	<L> left=320 ,top=1772 ,right=980 ,bottom=1772 </L>
	<L> left=322 ,top=1946 ,right=982 ,bottom=1946 </L>
	<L> left=322 ,top=1864 ,right=982 ,bottom=1864 </L>
	<T>id='»ý³â¿ùÀÏ' ,left=132 ,top=1640 ,right=296 ,bottom=1682 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Á÷ÀåÁ÷À§' ,left=132 ,top=1719 ,right=296 ,bottom=1761 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='»ç ´Â °÷' ,left=132 ,top=1811 ,right=296 ,bottom=1856 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±â      °£' ,left=132 ,top=1893 ,right=296 ,bottom=1935 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¼ºº°' ,left=2572 ,top=1403 ,right=2651 ,bottom=1445 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex', left=2672, top=1403, right=2773, bottom=1445, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2213 ,top=1455 ,right=2561 ,bottom=1455 </L>
	<L> left=2659 ,top=1455 ,right=2738 ,bottom=1455 </L>
	<T>id='¹ø      È£' ,left=132 ,top=860 ,right=296 ,bottom=902 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=320 ,top=912 ,right=758 ,bottom=912 </L>
	<C>id='arrive_date', left=2421, top=185, right=2767, bottom=229, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=2421, top=92, right=2767, bottom=134, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comment2' ,left=2089 ,top=1759 ,right=2736 ,bottom=1798 ,align='left' ,face='±¼¸²' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
	<C>id='comment1' ,left=2046 ,top=1722 ,right=2736 ,bottom=1761 ,align='left' ,face='±¼¸²' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
	<L> left=2213 ,top=1719 ,right=2738 ,bottom=1719 </L>
	<L> left=2213 ,top=1521 ,right=2738 ,bottom=1521 </L>
	<L> left=2213 ,top=1587 ,right=2738 ,bottom=1587 </L>
	<L> left=2213 ,top=1653 ,right=2738 ,bottom=1653 </L>
	<C>id='birthday', left=2218, top=1469, right=2773, bottom=1511, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=2218, top=1600, right=2773, bottom=1643, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fr_to_date', left=2218, top=1666, right=2773, bottom=1709, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='»ý³â¿ùÀÏ' ,left=2039 ,top=1469 ,right=2197 ,bottom=1511 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Á÷ÀåÁ÷À§' ,left=2039 ,top=1535 ,right=2197 ,bottom=1577 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='»ç ´Â °÷' ,left=2039 ,top=1600 ,right=2197 ,bottom=1643 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±â      °£' ,left=2039 ,top=1666 ,right=2197 ,bottom=1709 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÀÌ      ¸§' ,left=2039 ,top=1403 ,right=2197 ,bottom=1445 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='upjang_eng_nm', left=132, top=451, right=409, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=819, top=451, right=1135, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=1841, top=438, right=2144, bottom=480, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARKS', left=2575, top=925, right=2773, bottom=1076, align='left', face='±¼¸²', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARKS', left=766, top=1031, right=977, bottom=1181, align='left', face='±¼¸²', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_nm', left=338, top=1719, right=1273, bottom=1761, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_nm', left=2218, top=1535, right=2860, bottom=1577, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='TAG_NK', left=132, top=1031, right=312, bottom=1211</I>
	<I>id='TAG_NK', left=2050, top=925, right=2230, bottom=1105</I>
	<C>id='cust_nm', left=338, top=1550, right=758, bottom=1603, align='left', face='±¼¸²', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=2218, top=1390, right=2561, bottom=1445, align='left', face='±¼¸²', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>




	">
	</object> 

<%=HDConstant.COMMENT_END%>  

<!-----------------------------------------------------------------------------
Ãâ·Â¹° Á¤ÀÇºÎºÐ - °³¼º - ¿µÁÖ±Ç/½Ã¹Î±Ç/¿Ü±¹ÀÎ¿ë °ü±¤Áõ
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr22" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="MasterDataID"			VALUE="ds9">
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="true">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">	
		<PARAM NAME="Format"                VALUE="

<B>id=default ,left=0,top=0 ,right=2870 ,bottom=1961 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='nights_days1', left=1965, top=92, right=2313, bottom=134, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=1965, top=132, right=2313, bottom=174, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=943, top=343, right=1289, bottom=372, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=2575, top=438, right=2775, bottom=480, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=2363, top=438, right=2564, bottom=480, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=2149, top=438, right=2350, bottom=480, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=943, top=132, right=1289, bottom=174, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=943, top=92, right=1289, bottom=134, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no', left=2242, top=1917, right=2564, bottom=1962, face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2321, top=343, right=2749, bottom=372, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2321, top=372, right=2749, bottom=401, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1286, top=385, right=1714, bottom=414, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1286, top=356, right=1714, bottom=385, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=251, top=266, right=599, bottom=306, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=251, top=303, right=599, bottom=348, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=251, top=343, right=599, bottom=372, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=251, top=385, right=599, bottom=427, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=943, top=303, right=1289, bottom=348, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=943, top=385, right=1289, bottom=427, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=412, top=451, right=586, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=597, top=451, right=771, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=1965, top=277, right=2313, bottom=319, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=1141, top=451, right=1315, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1352, top=451, right=1529, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=1566, top=451, right=1740, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='accept_no', left=2070, top=609, right=2445, bottom=651, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=2070, top=570, right=2445, bottom=612, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=1048, top=570, right=1450, bottom=612, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=372, top=570, right=771, bottom=612, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='accept_no', left=372, top=609, right=771, bottom=651, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=1962, top=185, right=2313, bottom=229, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=943, top=185, right=1289, bottom=229, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=251, top=185, right=599, bottom=229, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=251, top=132, right=599, bottom=174, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=251, top=92, right=599, bottom=134, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=1394, top=185, right=1740, bottom=229, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=1394, top=92, right=1740, bottom=134, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=2429, top=185, right=2775, bottom=229, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=2429, top=92, right=2775, bottom=134, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=132, top=451, right=409, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=821, top=451, right=1138, bottom=493, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=1846, top=438, right=2149, bottom=480, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=1967, top=343, right=2313, bottom=372, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=322 ,top=1920 ,right=985 ,bottom=1920 </L>
	<C>id='accept_no', left=1048, top=609, right=1450, bottom=651, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='ÀÌ      ¸§' ,left=132 ,top=1371 ,right=296 ,bottom=1413 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<C>id='sex', left=908, top=1371, right=985, bottom=1416, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=980 ,top=1672 ,right=768 ,bottom=1672 </L>
	<L> left=549 ,top=1669 ,right=320 ,bottom=1669 </L>
	<C>id='PASS_NO', left=774, top=1627, right=1001, bottom=1669, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='±¹Àû/¹ÎÁ·' ,left=132 ,top=1540 ,right=320 ,bottom=1582 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COUNTRY_NM', left=338, top=1540, right=1273, bottom=1579, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Nationality/Ethnic Background' ,left=132 ,top=1590 ,right=515 ,bottom=1619 ,align='left' ,face='±¼¸²' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=320 ,top=1585 ,right=982 ,bottom=1585 </L>
	<C>id='COUNTRY_EFNM', left=523, top=1590, right=1334, bottom=1622, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='±â      °£' ,left=132 ,top=1867 ,right=296 ,bottom=1917 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='fr_to_date', left=338, top=1875, right=985, bottom=1917, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=338, top=1793, right=985, bottom=1838, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='»ç ´Â °÷' ,left=132 ,top=1793 ,right=296 ,bottom=1838 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¼ºº°' ,left=784 ,top=1371 ,right=869 ,bottom=1413 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Á÷ÀåÁ÷À§' ,left=132 ,top=1711 ,right=296 ,bottom=1753 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='company_nm', left=338, top=1711, right=1495, bottom=1753, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Type of Passport' ,left=132 ,top=1674 ,right=349 ,bottom=1703 ,align='left' ,face='±¼¸²' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Passport No.' ,left=576 ,top=1674 ,right=739 ,bottom=1703 ,face='±¼¸²' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=320 ,top=1759 ,right=982 ,bottom=1759 </L>
	<L> left=893 ,top=1421 ,right=982 ,bottom=1421 </L>
	<L> left=320 ,top=1419 ,right=755 ,bottom=1419 </L>
	<T>id='Name' ,left=132 ,top=1426 ,right=296 ,bottom=1453 ,face='±¼¸²' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='cust_enm', left=338, top=1426, right=760, bottom=1453, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Sex' ,left=784 ,top=1426 ,right=866 ,bottom=1453 ,face='±¼¸²' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex_ENM', left=911, top=1426, right=990, bottom=1453, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=320 ,top=1508 ,right=982 ,bottom=1508 </L>
	<C>id='birthday', left=338, top=1461, right=985, bottom=1503, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='»ý³â¿ùÀÏ' ,left=132 ,top=1461 ,right=296 ,bottom=1503 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Date of Birth' ,left=132 ,top=1508 ,right=296 ,bottom=1537 ,face='±¼¸²' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Occupation' ,left=132 ,top=1759 ,right=296 ,bottom=1788 ,face='±¼¸²' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Address' ,left=132 ,top=1840 ,right=296 ,bottom=1869 ,face='±¼¸²' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Duration of Stay' ,left=132 ,top=1927 ,right=354 ,bottom=1956 ,align='left' ,face='±¼¸²' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       YY   MM   DD                 YY   MM   DD' ,left=356 ,top=1927 ,right=1062 ,bottom=1956 ,align='left' ,face='±¼¸²' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¿©±Ç¹øÈ£' ,left=568 ,top=1627 ,right=755 ,bottom=1669 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¿©±Ç Á¾·ù' ,left=132 ,top=1627 ,right=320 ,bottom=1669 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PASS_TYPE', left=338, top=1627, right=565, bottom=1666, align='left', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=1965, top=385, right=2313, bottom=430, align='left', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_enm', left=338, top=1761, right=1495, bottom=1790, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1enm', left=338, top=1840, right=1495, bottom=1869, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=322 ,top=1838 ,right=985 ,bottom=1838 </L>
	<C>id='company_enm', left=2234, top=1606, right=2836, bottom=1635, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Á÷ÀåÁ÷À§' ,left=2036 ,top=1558 ,right=2200 ,bottom=1600 ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Occupation' ,left=2036 ,top=1603 ,right=2200 ,bottom=1632 ,face='±¼¸²' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='company_nm', left=2234, top=1558, right=2725, bottom=1600, align='left', face='±¼¸²', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2738 ,top=1606 ,right=2218 ,bottom=1606 </L>
	<T>id='Nationality/Ethnic Background' ,left=2036 ,top=1440 ,right=2369 ,bottom=1469 ,face='±¼¸²' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PASS_TYPE', left=2231, top=1477, right=2390, bottom=1516, align='left', face='±¼¸²', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=2234, top=1271, right=2580, bottom=1297, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2749 ,top=1358 ,right=2218 ,bottom=1358 </L>
	<T>id='Date of Birth' ,left=2036 ,top=1350 ,right=2200 ,bottom=1379 ,face='±¼¸²' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='»ý³â¿ùÀÏ' ,left=2036 ,top=1305 ,right=2200 ,bottom=1347 ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex_ENM', left=2680, top=1271, right=2757, bottom=1303, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Sex' ,left=2583 ,top=1271 ,right=2662 ,bottom=1300 ,face='±¼¸²' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Name' ,left=2036 ,top=1271 ,right=2200 ,bottom=1300 ,face='±¼¸²' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2678 ,top=1266 ,right=2767 ,bottom=1266 </L>
	<C>id='sex', left=2680, top=1218, right=2757, bottom=1263, align='left', face='±¼¸²', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='¼ºº°' ,left=2583 ,top=1218 ,right=2664 ,bottom=1260 ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2218 ,top=1266 ,right=2575 ,bottom=1266 </L>
	<T>id='ÀÌ      ¸§' ,left=2036 ,top=1218 ,right=2200 ,bottom=1260 ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±¹Àû/¹ÎÁ·' ,left=2036 ,top=1387 ,right=2223 ,bottom=1429 ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COUNTRY_NM', left=2234, top=1387, right=2757, bottom=1429, align='left', face='±¼¸²', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2205 ,top=1432 ,right=2765 ,bottom=1432 </L>
	<C>id='COUNTRY_EFNM', left=2377, top=1440, right=2773, bottom=1471, align='left', face='±¼¸²', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2384 ,top=1521 ,right=2237 ,bottom=1521 </L>
	<L> left=2773 ,top=1521 ,right=2567 ,bottom=1521 </L>
	<T>id='Type of Passport' ,left=2036 ,top=1521 ,right=2221 ,bottom=1550 ,face='±¼¸²' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Passport No.' ,left=2392 ,top=1521 ,right=2556 ,bottom=1550 ,face='±¼¸²' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¿©±Ç¹øÈ£' ,left=2392 ,top=1474 ,right=2556 ,bottom=1516 ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PASS_NO', left=2572, top=1474, right=2799, bottom=1516, align='left', face='±¼¸²', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='¿©±Ç Á¾·ù' ,left=2036 ,top=1474 ,right=2223 ,bottom=1516 ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='address1', left=2231, top=1640, right=2733, bottom=1685, align='left', face='±¼¸²', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Address' ,left=2036 ,top=1687 ,right=2200 ,bottom=1717 ,face='±¼¸²' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='»ç ´Â °÷' ,left=2036 ,top=1640 ,right=2200 ,bottom=1685 ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2221 ,top=1687 ,right=2746 ,bottom=1687 </L>
	<C>id='address1enm', left=2231, top=1690, right=2833, bottom=1719, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Duration of Stay' ,left=2036 ,top=1775 ,right=2221 ,bottom=1804 ,face='±¼¸²' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2221 ,top=1767 ,right=2749 ,bottom=1767 </L>
	<T>id='       YY   MM   DD                 YY   MM   DD' ,left=2231 ,top=1775 ,right=2746 ,bottom=1804 ,align='left' ,face='±¼¸²' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±â      °£' ,left=2036 ,top=1722 ,right=2200 ,bottom=1764 ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='fr_to_date', left=2231, top=1722, right=2738, bottom=1764, align='left', face='±¼¸²', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2083, top=1877, right=2696, bottom=1906, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2083, top=1848, right=2696, bottom=1883, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2083, top=1817, right=2696, bottom=1848, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=2234, top=1310, right=2746, bottom=1353, align='left', face='±¼¸²', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=2284 ,top=910 ,right=2524 ,bottom=1213</I>
	<T>id='¹ø      È£' ,left=132 ,top=786 ,right=296 ,bottom=841 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='work_no', left=338, top=799, right=760, bottom=841, align='left', face='±¼¸²', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=320 ,top=844 ,right=760 ,bottom=844 </L>
	<C>id='WORK_ENO', left=338, top=849, right=998, bottom=883, align='left', face='±¼¸²', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(No.)' ,left=132 ,top=849 ,right=296 ,bottom=883 ,face='±¼¸²' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='picture_info' ,left=399 ,top=920 ,right=724 ,bottom=1337</I>
	<C>id='REMARKS', left=2575, top=925, right=2773, bottom=1076, align='left', face='±¼¸²', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARKS', left=766, top=1031, right=977, bottom=1181, align='left', face='±¼¸²', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='TAG_NK', left=132, top=1031, right=312, bottom=1211</I>
	<I>id='TAG_NK', left=2050, top=925, right=2230, bottom=1105</I>
	<C>id='cust_nm', left=338, top=1358, right=760, bottom=1416, align='left', face='±¼¸²', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=2234, top=1210, right=2580, bottom=1266, align='left', face='±¼¸²', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


	">
	</object> 

<%=HDConstant.COMMENT_END%>     

<!--------------------------------- ÄÚµù ºÎºÐ ³¡ -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

