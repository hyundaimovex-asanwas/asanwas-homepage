<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ ½Ã ½º ÅÛ ¸í	:	±Þ¿©/±Þ¿©´ëÀå
+ ÇÁ·Î±×·¥ ID	: p020006.HTML
+ ±â ´É Á¤ ÀÇ	: Á¶È¸|Ãâ·Â
+ º¯ °æ ÀÌ ·Â	: 
+ ¼ö Á¤ ÀÌ ·Â	: ÀÌ¼ø¹Ì - 2005.08.02 - ¼Ò½º Á¤¸®
+ ¼ö Á¤ ÀÌ ·Â	: Á¤¿µ½Ä - 2005.08.17 - ±Þ¿©´ëÀå Ãâ·Â¹° °ü·Ã ¼öÁ¤
+ ¼ö Á¤ ÀÌ ·Â	: Á¤¿µ½Ä - 2005.09.05 - Á¤±â±Þ¿© ( ¼Ò±Þ, ÅðÁ÷, ÈÞÁ÷Æ÷ÇÔÇÔ)
---------------------------------------------------------------------------------
+ ¼ö Á¤ ³» ¿ë : ±Þ¿©´ëÀå °ú°Å µ¥ÀÌÅÍ Á¶È¸¸¦ À§ÇÏ¿© ±Þ¿©´ëÀå Ãâ·Â¹°ÀÇ »ó¼¼³»¿ë Äõ¸®¹® º¯°æ
                ( p020006_s9 ==> p020006_s91·Î º¯°æÇÔ )
+ ¼ö Á¤ ÀÏ ÀÚ : 2010.10.29 
+ ¼ö   Á¤  ÀÚ : Á¤  ¿µ  ½Ä 
---------------------------------------------------------------------------------
+ ¼­ ºí ¸´ ¸í	: p020006_s1, p020006_s2, p020006_s3
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>  
<title>±Þ¿©´ëÀå</title>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath º¯¼ö ¼³Á¤. %>

<!--------------------------------------------------------------¤©---------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
var gs_level;
var gs_treecd;
get_cookdata();
//lfn_init();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : ÆäÀÌÁö ·Îµù
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Æ®¸®ÃÊ±âÈ­ È£Ãâ

	gcem_app_yyyymm_1.Text = gs_date2;

	//Áö±Þ±¸ºÐ
	gcds_select_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1120"; 
	gcds_select_ec01az.Reset();

	//¼Ò¼ÓÁ¤º¸
  gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept.Reset();

	//Á÷±ºÁ¤º¸
	gcds_select_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2000"; 
	gcds_select_ec03az.Reset();

	//Á÷À§Á¤º¸
	gcds_select_ec04az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002"; 
	gcds_select_ec04az.Reset();

	//±Þ¿©Ç×¸ñ
	gcds_select_ec06az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1126"; 
	gcds_select_ec06az.Reset();

	//Á÷±ÞÁ¤º¸
	gcds_select_ec05az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2001"; 
	gcds_select_ec05az.Reset();

}

/******************************************************************************
	Description : ±âº»Á¶È¸
******************************************************************************/
function ln_Query(){ //»ç¿øº°´ëÀå ÅÇ Á¶È¸
	var str1 = "";// fn_trim(gcem_jigubil_1.Text);				//Áö±ÞÀÏÀÚ
	var str2 = fn_trim(gcem_app_yyyymm_1.Text);						//Àû¿ë³â¿ù
	var str3 = fn_trim(gclx_select_ec01az.BindColVal);		//Áö±Þ±¸ºÐ
	var str4 = fn_trim(gclx_select_ec02az.BindColVal);		//¼Ò¼Ó
	var str5 = fn_trim(gclx_select_ec03az.BindColVal);		//Á÷±º
	var str6 = fn_trim(gcem_emo_1.Text);									//»ç¹øºÎÅÍ
	var str7 =fn_trim( gcem_emo_2.Text);									//»ç¹ø±îÁö
	var str8 =fn_trim( txt_empnm.value);									//¼º¸í
	var str9 =fn_trim( gclx_select_ec04az.BindColVal);		//Á÷À§
	var str10 =fn_trim( gclx_select_ec05az.BindColVal);		//Á÷±Þ

	gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020006_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7
									 + "&v_str8=" + str8
									 + "&v_str9=" + str9
									 + "&v_str10=" + str10
									 + "&v_str11=" + gs_level
									 + "&v_str12=" + gs_treecd;
 // prompt("",gcds_grid_ec01az.DataID);
	gcds_grid_ec01az.Reset(); //±×¸®µå
	gcds_grid_ec01az.rowposition=1;

}

/******************************************************************************
	Description : º¸°í¼­ Á¶È¸ - Á¤±â±Þ¿©
******************************************************************************/
function ln_Query2(){ //»ç¿øº°´ëÀå ÅÇ Á¶È¸
	var str1 = "";//fn_trim(gcem_jigubil_1.Text);       //Áö±ÞÀÏÀÚ
	var str2 = fn_trim(gcem_app_yyyymm_1.Text);         //Àû¿ë³â¿ù
	var str3 = fn_trim(gclx_select_ec01az.BindColVal);  //Áö±Þ±¸ºÐ
	var str4 = fn_trim(gclx_select_ec02az.BindColVal);  //¼Ò¼Ó
	var str5 = fn_trim(gclx_select_ec03az.BindColVal);  //Á÷±º
	var str6 = fn_trim(gcem_emo_1.Text);                //»ç¹øºÎÅÍ
	var str7 =fn_trim( gcem_emo_2.Text);                //»ç¹ø±îÁö
	var str8 =fn_trim( txt_empnm.value);                //¼º¸í
	var str9 =fn_trim( gclx_select_ec04az.BindColVal);  //Á÷À§
	var str10 =fn_trim( gclx_select_ec05az.BindColVal);  //Á÷±Þ

//2008.08.18 ÀçÅÃ ÀÚ ¶§¹®¿¡ ¸·À½.
//	gcds_grid_ec02az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020006_s2?"
//2010.10.29 JYS ¼öÁ¤
//gcds_grid_ec02az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020006_s9?"

 gcds_grid_ec02az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020006_s91?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7
									 + "&v_str8=" + str8
									 + "&v_str9=" + str9
									 + "&v_str10=" + str10;
  //prompt("p020006_s91",gcds_grid_ec02az.text);
	gcds_grid_ec02az.Reset(); //±×¸®µå
	gcds_grid_ec02az.rowposition=1;

}

/******************************************************************************
	Description : Áö±ÞÇ×¸ñ¸í
******************************************************************************/
function ln_Query_title(){
  var str1 = '2030039' //ÀÓÀÇÀÇ »ç¶÷ ÁöÁ¤
	var str2 = gcem_app_yyyymm_1.Text;//gs_date2;
	var str3 = fn_trim(gclx_select_ec01az.BindColVal);
	gcds_rpt_title.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020006_s4?v_str1="+str1 
																														 +"&v_str2="+str2
																														 +"&v_str3="+str3;
	//prompt(this,gcds_rpt_title.DataID);
	gcds_rpt_title.Reset();
}

/******************************************************************************
	Description : Ãâ·Â
******************************************************************************/
function ln_Print(){
	if (gcds_grid_ec01az.countrow<1) {
		alert("Ãâ·ÂÇÏ½Ç Á¤º¸°¡ ¾ø½À´Ï´Ù");
	} else {
	   
		if (gclx_select_ec01az.BindColVal=='1') {	//Áö±Þ±¸ºÐ-±Þ¿©´ëÀå[1]

			ln_Query_title();
			ln_Query2();
			
			var ls_temp = "CUDATE:STRING,CTITLE:STRING,PR0020:STRING,PR0030:STRING,PR0040:STRING,BR0020:STRING,BR0030:STRING,BR0040:STRING";
			
			gcds_report0.SetDataHeader(ls_temp);
			gcds_report0.Addrow();
			gcds_report0.namevalue(1,"CUDATE")=gs_date;

			//REPORT TITLE START--------------------------------------------------------------------------------------
			var str_yyyymm = gcem_app_yyyymm_1.Text;
			var str_paydiv1 = fn_trim(gclx_select_ec01az.text);
			var str_paydiv2 = fn_trim(gclx_select_ec01az.BindcolVal);

			if (str_paydiv2 == '1') { 
				gcds_report0.namevalue(1,"CTITLE")= str_paydiv1.substring(2,4) + " ´ëÀå ["
																					+ str_yyyymm.substring(0,4) + "³â"
																					+ str_yyyymm.substring(4,6) + "¿ù]";
			}else { 
				gcds_report0.namevalue(1,"CTITLE")=str_paydiv1.substring(0,2) + " ´ëÀå ["
																					+ str_yyyymm.substring(0,4) + "³â"
																					+ str_yyyymm.substring(4,6) + "¿ù]";
			}
			//REPORT TITLE END----------------------------------------------------------------------------------------

			if (gcds_rpt_title.namevalue(1,"PR0020") != '' || gcds_rpt_title.namevalue(1,"PR0020") != '0') {
				gcds_report0.namevalue(1,"PR0020") = gcds_rpt_title.namevalue(1,"PR0020"); 
			} else { gcds_report0.namevalue(1,"PR0020") = ''; }

			if (gcds_rpt_title.namevalue(1,"PR0030") != '' || gcds_rpt_title.namevalue(1,"PR0030") != '0') {
				gcds_report0.namevalue(1,"PR0030") = gcds_rpt_title.namevalue(1,"PR0030"); 
			} else { gcds_report0.namevalue(1,"PR0030") = ''; }

			if (gcds_rpt_title.namevalue(1,"PR0040") != '' || gcds_rpt_title.namevalue(1,"PR0040") != '0') {
				gcds_report0.namevalue(1,"PR0040") = gcds_rpt_title.namevalue(1,"PR0040"); 
			} else { gcds_report0.namevalue(1,"PR0040") = ''; }

			if (gcds_rpt_title.namevalue(1,"BR0020") != '' || gcds_rpt_title.namevalue(1,"BR0020") != '0') {
				gcds_report0.namevalue(1,"BR0020") = gcds_rpt_title.namevalue(1,"BR0020"); 
			} else { gcds_report0.namevalue(1,"BR0020") = ''; }

			if (gcds_rpt_title.namevalue(1,"BR0030") != '' || gcds_rpt_title.namevalue(1,"BR0030") != '0') {
				gcds_report0.namevalue(1,"BR0030") = gcds_rpt_title.namevalue(1,"BR0030"); 
			} else { gcds_report0.namevalue(1,"BR0030") = ''; }

			if (gcds_rpt_title.namevalue(1,"BR0040") != '' || gcds_rpt_title.namevalue(1,"BR0040") != '0') {
				gcds_report0.namevalue(1,"BR0040") = gcds_rpt_title.namevalue(1,"BR0040"); 
			} else { gcds_report0.namevalue(1,"BR0040") = ''; }

			gcrp_print.preview();		//±Þ¿©´ëÀå
	
	} else if(gclx_select_ec01az.BindColVal=='5'){	//Áö±Þ±¸ºÐ-»ó¿©´ëÀå[5]
			
			ln_Query_title();
			ln_Query2();
			var ls_temp = "CUDATE:STRING,CTITLE:STRING,PR0020:STRING,PR0030:STRING,PR0040:STRING,BR0020:STRING,BR0030:STRING,BR0040:STRING";
			gcds_report0.SetDataHeader(ls_temp);
			gcds_report0.Addrow();
			gcds_report0.namevalue(1,"CUDATE")=gs_date;

			//REPORT TITLE START--------------------------------------------------------------------------------------
			var str_yyyymm = gcem_app_yyyymm_1.Text;
			var str_paydiv1 = fn_trim(gclx_select_ec01az.text);
			var str_paydiv2 = fn_trim(gclx_select_ec01az.BindcolVal);

			if (str_paydiv2 == '1') { 
				gcds_report0.namevalue(1,"CTITLE")= str_paydiv1.substring(2,4) + " ´ëÀå ["
																					+ str_yyyymm.substring(0,4) + "³â"
																					+ str_yyyymm.substring(4,6) + "¿ù]";
			}else { 
				gcds_report0.namevalue(1,"CTITLE")=str_paydiv1.substring(0,4) + " ´ëÀå ["
																					+ str_yyyymm.substring(0,4) + "³â"
																					+ str_yyyymm.substring(4,6) + "¿ù]";
			}
			//REPORT TITLE END----------------------------------------------------------------------------------------

			if (gcds_rpt_title.namevalue(1,"PR0020") != "" || gcds_rpt_title.namevalue(1,"PR0020") != '0') {
				gcds_report0.namevalue(1,"PR0020") = gcds_rpt_title.namevalue(1,"PR0020");                        	
			} else { gcds_report0.namevalue(1,"PR0020") = ""; }

			if (gcds_rpt_title.namevalue(1,"PR0030") != "" || gcds_rpt_title.namevalue(1,"PR0030") != '0') {
				gcds_report0.namevalue(1,"PR0030") = gcds_rpt_title.namevalue(1,"PR0030");                               
			} else { gcds_report0.namevalue(1,"PR0030") = ""; }

			if (gcds_rpt_title.namevalue(1,"PR0040") != "" || gcds_rpt_title.namevalue(1,"PR0040") != '0') {
				gcds_report0.namevalue(1,"PR0040") = gcds_rpt_title.namevalue(1,"PR0040");                                
			} else { gcds_report0.namevalue(1,"PR0040") = ""; }

			if (gcds_rpt_title.namevalue(1,"BR0020") != "" || gcds_rpt_title.namevalue(1,"BR0020") != '0') {
				gcds_report0.namevalue(1,"BR0020") = gcds_rpt_title.namevalue(1,"BR0020"); 
			} else { gcds_report0.namevalue(1,"BR0020") = "";}

			if (gcds_rpt_title.namevalue(1,"BR0030") != "" || gcds_rpt_title.namevalue(1,"BR0030") != '0') {
				gcds_report0.namevalue(1,"BR0030") = gcds_rpt_title.namevalue(1,"BR0030"); 
			} else { gcds_report0.namevalue(1,"BR0030") = ""; }

			if (gcds_rpt_title.namevalue(1,"BR0040") != "" || gcds_rpt_title.namevalue(1,"BR0040") != '0') {
				gcds_report0.namevalue(1,"BR0040") = gcds_rpt_title.namevalue(1,"BR0040"); 
			} else { gcds_report0.namevalue(1,"BR0040") = ""; }
                       
 			gcrp_print2.preview();		//À¯º¸±Þ¿©
		} else {	//Áö±Þ±¸ºÐ-À¯º¸´ëÀå[7]
			
			ln_Query_title();
			ln_Query2();
			var ls_temp = "CUDATE:STRING,CTITLE:STRING,PR0020:STRING,PR0030:STRING,PR0040:STRING,BR0020:STRING,BR0030:STRING,BR0040:STRING";
			gcds_report0.SetDataHeader(ls_temp);
			gcds_report0.Addrow();
			gcds_report0.namevalue(1,"CUDATE")=gs_date;

			//REPORT TITLE START--------------------------------------------------------------------------------------
			var str_yyyymm = gcem_app_yyyymm_1.Text;
			var str_paydiv1 = fn_trim(gclx_select_ec01az.text);
			var str_paydiv2 = fn_trim(gclx_select_ec01az.BindcolVal);

			if (str_paydiv2 == '1') { 
				gcds_report0.namevalue(1,"CTITLE")= str_paydiv1.substring(2,4) + " ´ëÀå ["
																					+ str_yyyymm.substring(0,4) + "³â"
																					+ str_yyyymm.substring(4,6) + "¿ù]";
			}else { 
				gcds_report0.namevalue(1,"CTITLE")=str_paydiv1.substring(0,4) + " ´ëÀå ["
																					+ str_yyyymm.substring(0,4) + "³â"
																					+ str_yyyymm.substring(4,6) + "¿ù]";
			}
			//REPORT TITLE END----------------------------------------------------------------------------------------

			if (gcds_rpt_title.namevalue(1,"PR0020") != "" || gcds_rpt_title.namevalue(1,"PR0020") != '0') {
				gcds_report0.namevalue(1,"PR0020") = gcds_rpt_title.namevalue(1,"PR0020");                        	
			} else { gcds_report0.namevalue(1,"PR0020") = ""; }

			if (gcds_rpt_title.namevalue(1,"PR0030") != "" || gcds_rpt_title.namevalue(1,"PR0030") != '0') {
				gcds_report0.namevalue(1,"PR0030") = gcds_rpt_title.namevalue(1,"PR0030");                               
			} else { gcds_report0.namevalue(1,"PR0030") = ""; }

			if (gcds_rpt_title.namevalue(1,"PR0040") != "" || gcds_rpt_title.namevalue(1,"PR0040") != '0') {
				gcds_report0.namevalue(1,"PR0040") = gcds_rpt_title.namevalue(1,"PR0040");                                
			} else { gcds_report0.namevalue(1,"PR0040") = ""; }

			if (gcds_rpt_title.namevalue(1,"BR0020") != "" || gcds_rpt_title.namevalue(1,"BR0020") != '0') {
				gcds_report0.namevalue(1,"BR0020") = gcds_rpt_title.namevalue(1,"BR0020"); 
			} else { gcds_report0.namevalue(1,"BR0020") = "";}

			if (gcds_rpt_title.namevalue(1,"BR0030") != "" || gcds_rpt_title.namevalue(1,"BR0030") != '0') {
				gcds_report0.namevalue(1,"BR0030") = gcds_rpt_title.namevalue(1,"BR0030"); 
			} else { gcds_report0.namevalue(1,"BR0030") = ""; }

			if (gcds_rpt_title.namevalue(1,"BR0040") != "" || gcds_rpt_title.namevalue(1,"BR0040") != '0') {
				gcds_report0.namevalue(1,"BR0040") = gcds_rpt_title.namevalue(1,"BR0040"); 
			} else { gcds_report0.namevalue(1,"BR0040") = ""; }
                       
 			gcrp_print3.preview();		//±Þ¿©´ëÀå
		}
	}
}


/******************************************************************************
	Description : Ãß°¡
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ÀúÀå
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : »èÁ¦
******************************************************************************/
function ln_Delete() {
	
}

/******************************************************************************
	Description : Ãë¼Ò
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ¿¢¼¿
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : ÀÔ·Â°ª Ã¼Å©
******************************************************************************/
function ln_Valchk(){

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_pyo" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_pyo2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- Áö±Þ±¸ºÐ DataSet-->
  <PARAM NAME="SortExpr" VALUE="+MINORCD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ¼Ò¼Ó±¸ºÐ DataSet-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec03az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- Á÷±º DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec04az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- Á÷À§ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec05az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- Á÷±Þ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec06az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ±Þ¿©Ç×¸ñ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- Á¶È¸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec02az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SubsumExpr   value="1:SEQ">
	<PARAM NAME="SyncLoad" VALUE="true"><!-- REPORTÁ¶È¸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rpt_title classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_select_ec01az" event="OnLoadStarted()">
	window.status="µ¥ÀÌÅ¸ Á¶È¸ÁßÀÔ´Ï´Ù..Àá½Ã¸¸ ±â´Ù·Á ÁÖ½Ê½Ã¿À.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec01az" event="onloadCompleted(row,colid)">
	//document.all.LowerFrame.style.visibility="visible";
	//gcds_select_ec01az.InsertRow(1);
	//gcds_select_ec01az.NameValue(1,"MINORCD")="";
	//gcds_select_ec01az.NameValue(1,"MINORNM")="ÀüÃ¼";
	  gcds_select_ec01az.DeleteRow(2);
	  gcds_select_ec01az.DeleteRow(2);
  gcds_select_ec01az.DeleteRow(2);
//  gcds_select_ec01az.DeleteRow(4);
  gcds_select_ec01az.DeleteRow(5);
	gclx_select_ec01az.index=0; //Áö±Þ±¸ºÐ
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="ÀüÃ¼";
	gclx_select_ec02az.index=0; //¼Ò¼Ó±¸ºÐ
</script>

<script language="javascript" for="gcds_select_ec03az" event="onloadCompleted(row,colid)">
	gcds_select_ec03az.InsertRow(1);
	gcds_select_ec03az.NameValue(1,"MINORCD")="";
	gcds_select_ec03az.NameValue(1,"MINORNM")="ÀüÃ¼";
	gclx_select_ec03az.index=0; //Á÷±º±¸ºÐ
</script>

<script language="javascript" for="gcds_select_ec04az" event="onloadCompleted(row,colid)">
	gcds_select_ec04az.InsertRow(1);
	gcds_select_ec04az.NameValue(1,"MINORCD")="";
	gcds_select_ec04az.NameValue(1,"MINORNM")="ÀüÃ¼";
	gclx_select_ec04az.index=0;  //Á÷À§±¸ºÐ
</script>

<script language="javascript" for="gcds_select_ec06az" event="onloadCompleted(row,colid)">
	gcds_select_ec06az.InsertRow(1);
	gcds_select_ec06az.NameValue(1,"MINORCD")="";
	gcds_select_ec06az.NameValue(1,"MINORNM")="ÀüÃ¼";
	//gclx_select_ec06az.index=0;
</script>

<script language="javascript" for="gcds_select_ec05az" event="onloadCompleted(row,colid)">
	gcds_select_ec05az.InsertRow(1);
	gcds_select_ec05az.NameValue(1,"MINORCD")="";
	gcds_select_ec05az.NameValue(1,"MINORNM")="ÀüÃ¼";
	gclx_select_ec05az.index=0;

	//document.all.LowerFrame.style.visibility="hidden";
	window.status="Á¶È¸°¡ ¿Ï·á µÇ¾ú½À´Ï´Ù.";
</script>

<script language="javascript" for="gcds_select_ec07az" event="onloadCompleted(row,colid)">
	gcds_select_ec07az.InsertRow(1);
	gcds_select_ec07az.NameValue(1,"MINORCD")="";
	gcds_select_ec07az.NameValue(1,"MINORNM")="ÀüÃ¼";
	gclx_select_iche.index=0;
</script>

<script language="javascript" for="gcds_select_ec08az" event="onloadCompleted(row,colid)">
	gcds_select_ec08az.InsertRow(1);
	gcds_select_ec08az.NameValue(1,"MINORCD")="";
	gcds_select_ec08az.NameValue(1,"MINORNM")="ÀüÃ¼";
	gclx_select_bank.index=0;
	window.status="Á¶È¸°¡ ¿Ï·á µÇ¾ú½À´Ï´Ù.";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt1.innerText="µ¥ÀÌÅ¸ Á¶È¸ÁßÀÔ´Ï´Ù.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "Á¶È¸°Ç¼ö : " + row + " °Ç";
	window.status="Á¶È¸°¡ ¿Ï·á µÇ¾ú½À´Ï´Ù.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec01az.countrow <=0)
			alert("Á¶È¸µÈ µ¥ÀÌÅ¸°¡ ¾ø½À´Ï´Ù.");
</script>

<script language="javascript" for="gcds_grid_ec02az" event="onloadcompleted(row,colid)">
	for (i=1; i<= row ; i++) {
		gcds_grid_ec02az.namevalue(i,"SENUM")  =  gcds_grid_ec02az.namevalue(i,"P23002") +"-"
					 +  gcds_grid_ec02az.namevalue(i,"P23003") +"-"
					 +  gcds_grid_ec02az.namevalue(i,"P23004") +"-"
					 +  gcds_grid_ec02az.namevalue(i,"P23005") +"-"
					 +  gcds_grid_ec02az.namevalue(i,"P23006") ;
	}
</script>

<script language="javascript" for="gcds_rpt_title" event="OnLoadStarted()">
	window.status="µ¥ÀÌÅ¸ Á¶È¸ÁßÀÔ´Ï´Ù..Àá½Ã¸¸ ±â´Ù·Á ÁÖ½Ê½Ã¿À.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_rpt_title" event="onloadcompleted(row,colid)">
	window.status="Á¶È¸°¡ ¿Ï·á µÇ¾ú½À´Ï´Ù.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript for=gcrp_print event=OnError()>

alert("Error Code = " + gcrp_print.ErrorCode + "\n" + "Error Message = " + gcrp_print.ErrorMsg);

</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_select_ec02az event=onSelChange()>
		gs_level = '';
		gs_treecd ='';
		gs_level = gclx_select_ec02az.ValueOfIndex ("level", gclx_select_ec02az.Index);
		gs_treecd = gclx_select_ec02az.ValueOfIndex ("treecd", gclx_select_ec02az.Index);
		gs_treecd = fn_treecd(gs_level, gs_treecd);
	</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<body bgcolor="#FFFFFF" topmargin="0" marginheight="0" leftmargin="0" marginwidth="0" >

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif" ><img src="../img/p020006_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<nobr>	    
			 <img id=com_b_print src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()"> 
			 <img id=com_b_query src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()"> 
			&nbsp;</nobr>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	<table  cellpadding="0" cellspacing="0" border="0">
    <tr><td width=140 valign=top><nobr><DIV ID="gcgd_create1_1" STYLE="display:block;">
			<table  cellpadding="0" cellspacing="0" border="0" style='width:877px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;Àû¿ë³â¿ù&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-top-width:0px;"><nobr>
						<comment id="__NSID__"><object id=gcem_app_yyyymm_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:±¼¸²; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=8>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>	
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;Áö±Þ±¸ºÐ&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-top-width:0px;"><nobr><comment id="__NSID__"><object id=gclx_select_ec01az  name="gclx_select_ec01az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 
						style="position:relative;left:8px;top:2px;font-size:12px;width:75px;height:200px;">
						<param name=ComboDataID			value=gcds_select_ec01az>
						<param name=SearchColumn		value="MINORCD^MINORNM">
						<param name=Sort            value="TRUE">
						<param name=SortColumn			value="MINORCD">
						<param name=ListExprFormat	value="MINORNM">
						<param name=BindColumn			value="MINORCD">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>	
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;¼Ò¼Ó&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>	
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-top-width:0px;"><nobr><comment id="__NSID__"><object id=gclx_select_ec02az  name="gclx_select_ec02az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
						<param name=ComboDataID			value=gcds_dept>
						<param name=SearchColumn		value="DEPTCD^DEPTNM">
						<param name=Sort            value="false">
						<param name=SortColumn			value="DEPTCD">
						<param name=ListExprFormat	value="DEPTNM^0^130">
						<param name=BindColumn			value="DEPTCD">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
					<td width="0" align=lefT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr >&nbsp;Á÷±º&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;"><nobr><comment id="__NSID__"><object id=gclx_select_ec03az  name="gclx_select_ec03az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 
						style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
						<param name=ComboDataID			value=gcds_select_ec03az>
						<param name=SearchColumn		value="MINORCD^MINORNM">
						<param name=Sort            value="TRUE">
						<param name=SortColumn			value="MINORCD">
						<param name=ListExprFormat	value="MINORNM">
						<param name=BindColumn			value="MINORCD">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
							<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#ffffff" ><nobr>&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-top-width:0px;" colspan=3>&nbsp;</td>
					<td width="100%" style="height:30px;border:0 solid #708090;border-top-width:0px;" align=RIGHT >&nbsp;&nbsp;</td>
				</tr>
        <tr> 
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;»ç¿ø¹øÈ£&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-top-width:1px;"><nobr><table cellpadding=0 cellspacing=0 width=150><tr><td>
						<comment id="__NSID__"><object id=gcem_emo_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:8px;top:0px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="0000000">
							<param name=MaxLength     value=13>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Readonly  value=false>
						</object></comment><script>__ws__(__NSID__);</script>
					</td><td>~</td>
					<td>
						<comment id="__NSID__"><object id=gcem_emo_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:8px;top:0px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="0000000">
							<param name=MaxLength     value=13>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Readonly  value=false>
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table></nobr></td>	
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;¼º¸í&nbsp;</nobr></td>	
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-top-width:1px;"><nobr><input type="text" id=txt_empnm style="width:70px;" class="txt11" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;&nbsp;</nobr></td>
				<td width="0" align=lefT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;Á÷À§&nbsp;</nobr></td>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;"><nobr>
					<comment id="__NSID__"><object id=gclx_select_ec04az  name="gclx_select_ec04az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
						<param name=ComboDataID			value=gcds_select_ec04az>
						<param name=SearchColumn		value="MINORCD^MINORNM">
						<param name=Sort            value="TRUE">
						<param name=SortColumn			value="MINORCD">
						<param name=ListExprFormat	value="MINORNM">
						<param name=BindColumn			value="MINORCD">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
				<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;" bgcolor="#eeeeee" ><nobr>&nbsp;Á÷±Þ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
				<td style="height:30px;border:0 solid #708090;border-top-width:1px;" colspan=3>
					<comment id="__NSID__"><object id=gclx_select_ec05az  name="gclx_select_ec05az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:8px;top:0px;font-size:12px;width:100px;height:200px;">
						<param name=ComboDataID			value=gcds_select_ec05az>
						<param name=SearchColumn		value="MINORCD^MINORNM">
						<param name=Sort            value="TRUE">
						<param name=SortColumn			value="MINORCD">
						<param name=ListExprFormat	value="MINORNM">
						<param name=BindColumn			value="MINORCD">
					</object></comment><script>__ws__(__NSID__);</script></td>
				
				<td width="100%" style="height:30px;border:0 solid #708090;border-top-width:1px;" COLSPAN=3 align=RIGHT >&nbsp;&nbsp;</td>
					</tr>
			</table>
</div></nobr>
		</td>
	 </tr>
 </table>
		</td>
  </tr>
  <tr> <td colspan="2" height=3>
  </td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:340px" valign=top>
						<comment id="__NSID__"><OBJECT id=gcgd_create1_2 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH: 875px; HEIGHT: 380px;border:1 solid #777777" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_grid_ec01az">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="viewSummary" VALUE="1">
              <PARAM NAME="ColSizing"		VALUE="true">
              <PARAM NAME="SortView"		VALUE="left">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="
			          <C> Name='¼Ò¼Ó'       ID=DEPTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=LEFT SumText='ÇÕ°è' SumBgColor=#C3D0DB sort=true  </C>
								<C> Name='»ç¹ø'				ID=EMPNO			HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center SumText='' SumBgColor=#C3D0DB sort=true </C>
								<C> Name='¼º¸í'				ID=EMPNMK			HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=center SumText='' SumBgColor=#C3D0DB sort=true </C>
								<C> Name='Á÷À§'				ID=PAYGRDNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=LEFT SumText='' SumBgColor=#C3D0DB sort=true </C> 
								<C> Name='Áö±ÞÇÕ°è'		ID=S91000  		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	 align=right SumText=@sum SumBgColor=#C3D0DB  </C> 
								<C> Name='°øÁ¦ÇÕ°è'		ID=S93000			HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=right SumText=@sum  SumBgColor=#C3D0DB </C>
								<C> Name='Â÷ÀÎÁö±Þ'		ID=S94000			HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=right SumText=@sum  SumBgColor=#C3D0DB </C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
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
			R E P O R T   D E F I N I T I O N   -   #### Á¤ ±â ±Þ ¿© ####
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"	    value="gcds_grid_ec02az">
	<PARAM NAME="PaperSize"					VALUE="A3">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="80">
	<PARAM NAME="Format" VALUE="
<B>id=Header ,left=0,top=0 ,right=4101 ,bottom=180 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CTITLE', left=1405, top=56, right=2474, bottom=143, face='HYÁß°íµñ', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000, Dec=0</C>
	<T>id='´ÜÀ§ : ¿ø' ,left=3784 ,top=122 ,right=4001 ,bottom=180 ,align='right' ,face='±¼¸²' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=3784, top=61, right=4001, bottom=119, align='right' ,mask='XXXX.XX.XX', face='±¼¸²', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='Print Date:' ,left=3485 ,top=61 ,right=3781 ,bottom=122 ,align='right' ,face='±¼¸²' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4101 ,bottom=262 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=3998 ,top=3 ,right=24 ,bottom=3 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=614 ,top=3 ,right=614 ,bottom=249 </L>
	<L> left=254 ,top=3 ,right=254 ,bottom=249 </L>
	<T>id='¹èºÎÀÚÀå°æ' ,left=2580 ,top=13 ,right=2831 ,bottom=71 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±âº»±Þ' ,left=638 ,top=13 ,right=849 ,bottom=71 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=3 ,right=24 ,bottom=246 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2553 ,top=5 ,right=2553 ,bottom=249 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=3 ,right=4003 ,bottom=246 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='Á÷±Þ' ,left=275 ,top=191 ,right=574 ,bottom=249 ,align='left' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#FFFBF0 ,backcolor=#FFFFFF</T>
	<T>id='Á÷Ã¥¼ö´ç' ,left=638 ,top=74 ,right=849 ,bottom=127 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='È£ºÀ°è' ,left=635 ,top=191 ,right=849 ,bottom=249 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='½Ã°£¿Ü' ,left=638 ,top=130 ,right=849 ,bottom=188 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Áö¿ª±Ù¹«¼ö´ç' ,left=1389 ,top=191 ,right=1648 ,bottom=249 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±Ù¼Ó¼ö´ç' ,left=902 ,top=13 ,right=1114 ,bottom=71 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='½Ä´ë' ,left=1662 ,top=191 ,right=1921 ,bottom=249 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÈÞÀÏ±Ù¹«¼ö´ç' ,left=1947 ,top=74 ,right=2201 ,bottom=127 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PR0030,,±âÅ¸Áö±Þ2,PR0030)}', left=2254, top=74, right=2529, bottom=130, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PR0040,,±âÅ¸Áö±Þ3,PR0040)}', left=2254, top=130, right=2529, bottom=188, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Áö±Þ°è' ,left=2254 ,top=191 ,right=2529 ,bottom=249 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PR0020,,±âÅ¸Áö±Þ1,PR0020)}', left=2254, top=16, right=2529, bottom=71, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Àü¿ù¼Ò±Þ' ,left=1971 ,top=13 ,right=2201 ,bottom=71 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÇöÀåÁ÷Ã¥¼ö´ç' ,left=1662 ,top=130 ,right=1921 ,bottom=185 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÇÐÀÚ±Ý' ,left=1699 ,top=74 ,right=1921 ,bottom=127 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='°³ÀÎ¿¬±Ý' ,left=1699 ,top=13 ,right=1921 ,bottom=71 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Æ¯¼öÁö¼ö´ç' ,left=1389 ,top=130 ,right=1648 ,bottom=185 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='»çÀå´Ü¼ö´ç' ,left=1389 ,top=74 ,right=1648 ,bottom=127 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='³²ºÏ°æÇù¼ö´ç' ,left=1389 ,top=13 ,right=1648 ,bottom=71 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÀÚ°Ý¼ö´ç' ,left=1162 ,top=196 ,right=1373 ,bottom=249 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¿¬Àå¼ö´ç' ,left=1162 ,top=130 ,right=1373 ,bottom=191 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¿îÀü¼ö´ç' ,left=1162 ,top=77 ,right=1373 ,bottom=135 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ãâ³³' ,left=1162 ,top=16 ,right=1373 ,bottom=74 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÀÚ±â°è¹ßºñ' ,left=902 ,top=74 ,right=1114 ,bottom=127 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='°¡Á·ºÎ¾çºñ' ,left=902 ,top=130 ,right=1114 ,bottom=185 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Â÷·®À¯Áöºñ' ,left=902 ,top=191 ,right=1114 ,bottom=249 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='½Ç¼ö·É¾×' ,left=3778 ,top=191 ,right=3990 ,bottom=249 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¼Ò¼Ó' ,left=275 ,top=13 ,right=553 ,bottom=71 ,align='left' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=249 ,right=4006 ,bottom=249 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='»ç¹ø' ,left=37 ,top=13 ,right=249 ,bottom=71 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Á÷À§' ,left=37 ,top=130 ,right=249 ,bottom=185 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±ÞÈ£' ,left=37 ,top=191 ,right=249 ,bottom=249 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¼º¸í' ,left=37 ,top=74 ,right=249 ,bottom=127 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÃÖÁ¾º¯µ¿ÀÏ' ,left=275 ,top=74 ,right=556 ,bottom=127 ,align='left' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¿¬Â÷¼ö´ç' ,left=1947 ,top=130 ,right=2201 ,bottom=185 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¼Òµæ¼¼' ,left=2580 ,top=74 ,right=2831 ,bottom=127 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÁÖ¹Î¼¼' ,left=2580 ,top=130 ,right=2831 ,bottom=185 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±¹¹Î¿¬±Ý' ,left=2836 ,top=21 ,right=3135 ,bottom=71 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BR0030,,±âÅ¸°øÁ¦2,BR0030)}', left=3461, top=74, right=3709, bottom=127, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='°øÁ¦°è' ,left=3778 ,top=130 ,right=3990 ,bottom=185 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Á¤»êÁÖ¹Î¼¼' ,left=3778 ,top=74 ,right=3990 ,bottom=130 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Á¤»ê¼Òµæ¼¼' ,left=3778 ,top=21 ,right=3990 ,bottom=77 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='°øÁ¶È¸´ëÃâ' ,left=3461 ,top=21 ,right=3709 ,bottom=71 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BR0040,,±âÅ¸°øÁ¦3,BR0040)}', left=3461, top=130, right=3709, bottom=183, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BR0020,,±âÅ¸°øÁ¦1,BR0020)}', left=3461, top=188, right=3709, bottom=241, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='º¸Áõº¸Çè' ,left=3175 ,top=130 ,right=3424 ,bottom=191 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='°øÁ¶È¸ºñ' ,left=3175 ,top=188 ,right=3424 ,bottom=238 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='»ç³»´ëÃâ' ,left=3175 ,top=21 ,right=3424 ,bottom=77 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='°³ÀÎ¿¬±Ý' ,left=3175 ,top=77 ,right=3424 ,bottom=130 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='°í¿ëº¸Çè' ,left=2836 ,top=130 ,right=3135 ,bottom=183 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='°Ç°­º¸Çè' ,left=2836 ,top=74 ,right=3135 ,bottom=132 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¿©Á÷¿øÈ¸ºñ' ,left=2836 ,top=188 ,right=3135 ,bottom=241 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=4101 ,bottom=225 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=159 ,right=857 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3752 ,top=161 ,right=3995 ,bottom=220 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3752 ,top=101 ,right=3995 ,bottom=156 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2207 ,top=159 ,right=2527 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=614 ,top=0 ,right=614 ,bottom=222 </L>
	<L> left=2556 ,top=0 ,right=2556 ,bottom=222 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=0 ,right=4003 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=254 ,top=0 ,right=254 ,bottom=222 </L>
	<C>id='{decode(P21000,0,,P21000)}', left=878, top=0, right=1114, bottom=50, align='right', supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P25000,0,,P25000)}', left=1135, top=0, right=1373, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P29000,0,,P29000)}', left=1394, top=0, right=1646, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P37000,0,,P37000)}', left=1672, top=0, right=1921, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P39000,0,,P39000)}', left=1953, top=0, right=2199, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PX0020,0,,PX0020)}', left=2278, top=0, right=2527, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SENUM', left=2580, top=0, right=2831, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P22000,0,,P22000)}', left=878, top=56, right=1114, bottom=106, align='right', supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P26000,0,,P26000)}', left=1138, top=56, right=1373, bottom=103, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P30000,0,,P30000)}', left=1394, top=56, right=1646, bottom=103, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P36000,0,,P36000)}', left=1672, top=56, right=1921, bottom=103, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PX0010,0,,PX0010)}', left=1953, top=56, right=2199, bottom=103, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P23000,0,,P23000)}', left=876, top=106, right=1114, bottom=156, align='right', supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P27000,0,,P27000)}', left=1135, top=106, right=1373, bottom=156, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P31000,0,,P31000)}', left=1389, top=106, right=1643, bottom=156, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P38000,0,,P38000)}', left=1667, top=106, right=1916, bottom=156, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P24000,0,,P24000)}', left=878, top=159, right=1114, bottom=212, align='right', supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P28000,0,,P28000)}', left=1138, top=159, right=1373, bottom=212, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P32000,0,,P32000)}', left=1394, top=159, right=1646, bottom=212, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P35000,0,,P35000)}', left=1672, top=159, right=1921, bottom=212, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PX0030,0,,PX0030)}', left=2278, top=56, right=2527, bottom=106, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PX0040,0,,PX0040)}', left=2278, top=106, right=2527, bottom=156, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(S91000,0,,S91000)}', left=2217, top=159, right=2524, bottom=209, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<L> left=24 ,top=225 ,right=4003 ,bottom=225 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=24 ,top=0 ,right=24 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,,EMPNO)}', left=37, top=0, right=249, bottom=50, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,EMPNMK)}', left=37, top=56, right=249, bottom=103, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'¼Ò °è\',PAYGRDNM)}', left=37, top=106, right=249, bottom=156, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,PAYSEQNM)}', left=37, top=161, right=249, bottom=217, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P10000,0,,P10000)}', left=627, top=0, right=852, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P12000,0,,P12000)}', left=627, top=106, right=852, bottom=156, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{P10000+P11000+P12000}', left=627, top=159, right=852, bottom=212, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{decode(P11000,0,,P11000)}', left=627, top=56, right=852, bottom=103, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,subcount(empno)-1,)}', left=267, top=111, right=476, bottom=161, align='right', supplevel=1 ,mask='XXXX/XX/XX', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,CHAGDT)}', left=267, top=61, right=524, bottom=108, align='left', supplevel=1 ,mask='XXXX/XX/XX', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,DEPTNM)}', left=267, top=13, right=614, bottom=58, align='left', supplevel=1, face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Multiline=true</C>
	<C>id='{decode(curlevel,1,¸í)}', left=495, top=111, right=540, bottom=161, align='left', supplevel=1, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P34000,0,,P34000)}', left=1953, top=106, right=2199, bottom=153, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(T12000,0,,T12000)}', left=2580, top=108, right=2831, bottom=161, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(T11000,0,,T11000)}', left=2580, top=56, right=2831, bottom=106, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B12000,0,,B12000)}', left=2839, top=0, right=3135, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(BX0030,0,,BX0030)}', left=3474, top=56, right=3707, bottom=106, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(S94000,0,,S94000)}', left=3757, top=161, right=3993, bottom=217, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(T22000,0,,T22000)}', left=3760, top=56, right=3993, bottom=106, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(T21000,0,,T21000)}', left=3760, top=0, right=3993, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(S93000,0,,S93000)}', left=3757, top=103, right=3993, bottom=159, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(BX0020,0,,BX0020)}', left=3474, top=169, right=3707, bottom=220, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(BX0040,0,,BX0040)}', left=3474, top=108, right=3707, bottom=159, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(APLAMT+APLRAT,0,,APLAMT+APLRAT)}', left=3175, top=0, right=3424, bottom=53, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B15000,0,,B15000)}', left=3175, top=56, right=3424, bottom=106, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(BX0010,0,,BX0010)}', left=3175, top=108, right=3424, bottom=159, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B16000,0,,B16000)}', left=3175, top=167, right=3424, bottom=217, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B13000,0,,B13000)}', left=2839, top=108, right=3135, bottom=159, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B11000,0,,B11000)}', left=2839, top=56, right=3135, bottom=108, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B14000,0,,B14000)}', left=2839, top=167, right=3135, bottom=217, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(COAAMT+COLAMT,0,,COAAMT+COLAMT)}', left=3474, top=0, right=3707, bottom=53, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=Tail ,left=0,top=0 ,right=4101 ,bottom=262 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=4003 ,top=0 ,right=4003 ,bottom=249 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='ÃÑ¿ø' ,left=278 ,top=130 ,right=423 ,bottom=180 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÇÕ °è' ,left=50 ,top=130 ,right=222 ,bottom=180 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='Count' ,left=394 ,top=130 ,right=516 ,bottom=180 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<L> left=4006 ,top=0 ,right=29 ,bottom=0 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='¸í' ,left=521 ,top=130 ,right=574 ,bottom=180 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{SUM(P22000)}' ,left=889 ,top=87 ,right=1130 ,bottom=135 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P23000)}' ,left=889 ,top=143 ,right=1130 ,bottom=191 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P24000)}' ,left=889 ,top=201 ,right=1130 ,bottom=246 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P12000)}' ,left=651 ,top=148 ,right=868 ,bottom=198 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P11000)}' ,left=651 ,top=93 ,right=868 ,bottom=146 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P27000)}' ,left=1151 ,top=146 ,right=1392 ,bottom=196 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P28000)}' ,left=1151 ,top=198 ,right=1392 ,bottom=249 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P26000)}' ,left=1151 ,top=87 ,right=1392 ,bottom=143 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P32000)}' ,left=1418 ,top=196 ,right=1670 ,bottom=246 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P31000)}' ,left=1418 ,top=143 ,right=1670 ,bottom=193 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P30000)}' ,left=1418 ,top=87 ,right=1670 ,bottom=140 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P38000)}' ,left=1688 ,top=138 ,right=1937 ,bottom=188 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{Sum(P34000)}', left=1955, top=151, right=2204, bottom=204, align='right', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{SUM(PX0040)}', left=2217, top=138, right=2529, bottom=188, align='right', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{Sum(T12000)}' ,left=2580 ,top=140 ,right=2831 ,bottom=191 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(T11000)}' ,left=2580 ,top=82 ,right=2831 ,bottom=132 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<X>left=2215 ,top=185 ,right=2535 ,bottom=235 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3747 ,top=143 ,right=3998 ,bottom=191 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3747 ,top=196 ,right=3998 ,bottom=243 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=2553 ,top=0 ,right=2553 ,bottom=249 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=614 ,top=0 ,right=614 ,bottom=249 </L>
	<L> left=254 ,top=0 ,right=254 ,bottom=249 </L>
	<L> left=24 ,top=0 ,right=24 ,bottom=249 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<S>id='{SUM(S91000)}' ,left=2225 ,top=188 ,right=2529 ,bottom=238 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<X>left=630 ,top=196 ,right=876 ,bottom=246 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='{SUM(P10000)+SUM(P11000)+SUM(P12000)}', left=646, top=198, right=868, bottom=243, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<S>id='{SUM(S94000)}' ,left=3752 ,top=193 ,right=3993 ,bottom=243 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{SUM(S93000)}' ,left=3752 ,top=140 ,right=3993 ,bottom=188 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{Sum(T22000)}' ,left=3752 ,top=90 ,right=3993 ,bottom=140 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(T21000)}' ,left=3752 ,top=26 ,right=3993 ,bottom=77 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(BX0020)}' ,left=3469 ,top=193 ,right=3709 ,bottom=243 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(BX0030)}' ,left=3469 ,top=90 ,right=3709 ,bottom=140 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(BX0040)}' ,left=3469 ,top=146 ,right=3709 ,bottom=196 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(APLAMT)+SUM(APLRAT)}', left=3159, top=26, right=3408, bottom=77, align='right', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{SUM(B15000)}' ,left=3159 ,top=90 ,right=3408 ,bottom=140 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{Sum(BX0010)}', left=3159, top=146, right=3408, bottom=196, align='right', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{Sum(B16000)}' ,left=3159 ,top=196 ,right=3408 ,bottom=246 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(B12000)}' ,left=2839 ,top=26 ,right=3135 ,bottom=77 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(B11000)}' ,left=2839 ,top=82 ,right=3135 ,bottom=132 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(B13000)}' ,left=2839 ,top=140 ,right=3135 ,bottom=191 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(B14000)}' ,left=2839 ,top=196 ,right=3135 ,bottom=246 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<L> left=4003 ,top=254 ,right=26 ,bottom=254 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=24 ,top=262 ,right=4006 ,bottom=262 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<S>id='{Sum(P10000)}' ,left=638 ,top=32 ,right=868 ,bottom=82 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(P21000)}' ,left=886 ,top=32 ,right=1130 ,bottom=82 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P25000)}' ,left=1151 ,top=29 ,right=1392 ,bottom=87 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P29000)}' ,left=1418 ,top=32 ,right=1670 ,bottom=82 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P36000)}' ,left=1688 ,top=87 ,right=1937 ,bottom=140 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P37000)}' ,left=1688 ,top=26 ,right=1937 ,bottom=90 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P35000)}' ,left=1688 ,top=196 ,right=1937 ,bottom=246 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{Sum(PX0010)}', left=1955, top=90, right=2204, bottom=146, align='right', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<S>id='{SUM(P39000)}' ,left=1953 ,top=32 ,right=2204 ,bottom=87 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<C>id='{SUM(PX0030)}', left=2217, top=85, right=2529, bottom=135, align='right', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{SUM(PX0020)}', left=2217, top=29, right=2529, bottom=85, align='right', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{SUM(COAAMT)+SUM(COLAMT)}', left=3469, top=26, right=3709, bottom=77, align='right', face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=Footer ,left=0 ,top=2761 ,right=4101 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=34 ,top=19 ,right=4006 ,bottom=98 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Common/img/icon.jpg' ,left=3596 ,top=8 ,right=3977 ,bottom=108</I>
</B>


">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### »ó ¿© ±Þ ¿© ####
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print2  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param NAME="DetailDataID"			VALUE="gcds_grid_ec02az">
	<PARAM NAME="PaperSize"					VALUE="A3">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="80">
	<PARAM NAME="Format"						VALUE="
<B>id=Header ,left=0,top=0 ,right=4101 ,bottom=181 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CTITLE', left=1406, top=56, right=2475, bottom=144, face='HYÁß°íµñ', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000</C>
	<T>id='´ÜÀ§ : ¿ø' ,left=3784 ,top=122 ,right=4000 ,bottom=181 ,align='right' ,face='±¼¸²' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=3784, top=62, right=4000, bottom=119, align='right' ,mask='XXXX.XX.XX', face='±¼¸²', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=3484 ,top=62 ,right=3781 ,bottom=122 ,align='right' ,face='±¼¸²' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4101 ,bottom=250 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=3997 ,top=3 ,right=25 ,bottom=3 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=613 ,top=3 ,right=613 ,bottom=250 </L>
	<L> left=253 ,top=3 ,right=253 ,bottom=250 </L>
	<T>id='ÀÔ»çÀÏ' ,left=3738 ,top=12 ,right=3969 ,bottom=72 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¹èºÎÀÚÀå°æ' ,left=2581 ,top=12 ,right=2831 ,bottom=72 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±âº»±Þ' ,left=638 ,top=12 ,right=850 ,bottom=72 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±×·ìÀÔ»çÀÏ' ,left=3738 ,top=75 ,right=3969 ,bottom=128 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='°©±Ù¼¼' ,left=2581 ,top=131 ,right=2831 ,bottom=184 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='°í¿ëº¸Çè' ,left=2834 ,top=131 ,right=3134 ,bottom=184 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÁÖ¹Î¼¼' ,left=2581 ,top=191 ,right=2831 ,bottom=247 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=3734 ,top=191 ,right=3966 ,bottom=247 ,align='left' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=25 ,top=3 ,right=25 ,bottom=244 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2556 ,top=6 ,right=2556 ,bottom=250 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=3 ,right=4003 ,bottom=244 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='Á÷Ã¥¼ö´ç' ,left=638 ,top=75 ,right=850 ,bottom=128 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='È£ºÀ°è' ,left=634 ,top=191 ,right=850 ,bottom=247 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='½Ã°£¿Ü' ,left=638 ,top=131 ,right=850 ,bottom=187 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±Ù¼Ó¼ö´ç' ,left=903 ,top=12 ,right=1113 ,bottom=72 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(PR0030,'','',PR0030)}, left=2253, top=75, right=2531, bottom=131, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(PR0040,'','',PR0040)}, left=2253, top=131, right=2531, bottom=187, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
        <T>id='Áö±Þ°è' ,left=2253 ,top=191 ,right=2531 ,bottom=247 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(PR0020,'','³âÂ÷¼ö´ç',PR0020)}, left=2253, top=16, right=2531, bottom=72, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
        <T>id='³²ºÏ°æÇù¼ö´ç' ,left=1391 ,top=12 ,right=1647 ,bottom=72 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÀÚ±â°è¹ßºñ' ,left=903 ,top=75 ,right=1113 ,bottom=128 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(BR0020,'','',BR0020)}, left=3147, top=191, right=3425, bottom=247, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
        <T>id='½Ç¼ö·É¾×' ,left=3500 ,top=191 ,right=3709 ,bottom=247 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(BR0030,'','Á¤»ê¼Òµæ¼¼',BR0030)}, left=3434, top=12, right=3709, bottom=69, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
        <T>id='°øÁ¦°è' ,left=3500 ,top=131 ,right=3709 ,bottom=184 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(BR0040,'','Á¤»êÁÖ¹Î¼¼',BR0040)}, left=3434, top=75, right=3709, bottom=128, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
        <T>id='¼Ò¼Ó' ,left=272 ,top=12 ,right=553 ,bottom=72 ,align='left' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=25 ,top=250 ,right=4006 ,bottom=250 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='»ç¹ø' ,left=38 ,top=12 ,right=250 ,bottom=72 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Á÷À§' ,left=38 ,top=131 ,right=250 ,bottom=184 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±ÞÈ£' ,left=38 ,top=191 ,right=250 ,bottom=247 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¼º¸í' ,left=38 ,top=75 ,right=250 ,bottom=128 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Áö±ÞÀ²' ,left=272 ,top=75 ,right=556 ,bottom=128 ,align='left' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Àü¿ù¼Ò±Þ' ,left=1944 ,top=12 ,right=2194 ,bottom=72 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=Default ,left=0,top=0 ,right=4101 ,bottom=225 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=159 ,right=856 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3469 ,top=162 ,right=3713 ,bottom=219 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3469 ,top=100 ,right=3713 ,bottom=156 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2206 ,top=159 ,right=2528 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=613 ,top=0 ,right=613 ,bottom=222 </L>
	<L> left=2556 ,top=0 ,right=2556 ,bottom=222 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=0 ,right=4003 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=253 ,top=0 ,right=253 ,bottom=222 </L>
	<C>id={decode(P21000,0,'',P21000)}, left=878, top=0, right=1113, bottom=50, align='right', supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(P29000,0,'',P29000)}, left=1394, top=0, right=1647, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SENUM', left=2581, top=0, right=2831, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='STRTDT', left=3738, top=0, right=3969, bottom=50, align='right' ,mask='XXXX/XX/XX', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(P22000,0,'',P22000)}, left=878, top=56, right=1113, bottom=106, align='right', supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GRSTRTDT', left=3738, top=56, right=3969, bottom=109, align='right' ,mask='XXXX/XX/XX', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(T11000,0,'',T11000)}, left=2581, top=106, right=2831, bottom=156, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(B13000,0,'',B13000)}, left=2838, top=106, right=3134, bottom=156, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
        <C>id={decode(S91000,0,'',S91000)}, left=2216, top=159, right=2525, bottom=209, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id={decode(T12000,0,'',T12000)}, left=2581, top=159, right=2831, bottom=212, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=3738, top=159, right=3969, bottom=209, align='left' ,mask='XXXX/XX/XX', face='±¼¸²', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(S94000,0,'',S94000)}, left=3475, top=162, right=3709, bottom=216, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id={decode(S93000,0,'',S93000)}, left=3472, top=100, right=3706, bottom=156, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=25 ,top=225 ,right=4003 ,bottom=225 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=25 ,top=0 ,right=25 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<C>id={decode(curlevel,1,'',EMPNO)}, left=38, top=0, right=250, bottom=50, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(curlevel,1,'',EMPNMK)}, left=38, top=56, right=250, bottom=103, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(curlevel,1,'¼Ò °è',PAYGRDNM)}, left=38, top=106, right=250, bottom=156, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(curlevel,1,'',PAYSEQNM)}, left=38, top=162, right=250, bottom=216, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(P10000,0,'',P10000)}, left=628, top=0, right=853, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(P12000,0,'',P12000)}, left=628, top=106, right=853, bottom=156, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={P10000+P11000+P12000}, left=628, top=159, right=853, bottom=212, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id={decode(P11000,0,'',P11000)}, left=628, top=56, right=853, bottom=103, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(curlevel,1,subcount(empno)-1,'')}, left=266, top=112, right=475, bottom=162, align='right', supplevel=1 ,mask='XXXX/XX/XX', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(SANGRAT,0,'',SANGRAT)}, left=266, top=62, right=525, bottom=109, align='left', supplevel=1 ,mask='XXX %', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(curlevel,1,,DEPTNM)}, left=266, top=12, right=613, bottom=59, align='left', supplevel=1, face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id={decode(curlevel,1,'¸í')}, left=494, top=112, right=541, bottom=162, align='left', supplevel=1, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(P39000,0,'',P39000)}, left=1944, top=0, right=2197, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
        
        <C>id={decode(PX0020,0,'',PX0020)}, left=2278, top=0, right=2528, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>        
       	<C>id={decode(PX0030,0,'',PX0030)}, left=2278, top=56, right=2528, bottom=106, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
        <C>id={decode(PX0040,0,'',PX0040)}, left=2278, top=106, right=2528, bottom=156, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
        <C>id={decode(BX0020,0,'',BX0020)}, left=3188, top=169, right=3425, bottom=219, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
       	<C>id={decode(BX0040,0,'',BX0040)}, left=3469, top=53, right=3706, bottom=97, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(BX0030,0,'',BX0030)}, left=3469, top=0, right=3706, bottom=47, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
        
</B>
<B>id=Tail ,left=0,top=0 ,right=2000 ,bottom=325 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=3463 ,top=180 ,right=3713 ,bottom=227 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3463 ,top=127 ,right=3713 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2215 ,top=180 ,right=2535 ,bottom=230 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=25 ,top=0 ,right=25 ,bottom=227 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2555 ,top=0 ,right=2555 ,bottom=227 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=253 ,top=0 ,right=253 ,bottom=227 </L>
	<L> left=4003 ,top=0 ,right=4003 ,bottom=227 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='ÃÑ¿ø' ,left=280 ,top=130 ,right=423 ,bottom=180 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÇÕ °è' ,left=50 ,top=130 ,right=220 ,bottom=180 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='Count' ,left=395 ,top=130 ,right=515 ,bottom=180 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<L> left=4005 ,top=0 ,right=30 ,bottom=0 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<S>id='{SUM(S91000)}' ,left=2220 ,top=177 ,right=2528 ,bottom=227 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{SUM(S94000)}' ,left=3465 ,top=177 ,right=3705 ,bottom=227 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<T>id='¸í' ,left=520 ,top=130 ,right=573 ,bottom=180 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=613 ,top=0 ,right=613 ,bottom=227 </L>
	<S>id='{Sum(P25000)}' ,left=1130 ,top=12 ,right=1373 ,bottom=62 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P29000)}' ,left=1398 ,top=15 ,right=1648 ,bottom=62 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P37000)}' ,left=1670 ,top=15 ,right=1920 ,bottom=62 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P39000)}' ,left=1945 ,top=15 ,right=2195 ,bottom=62 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(P36000)}' ,left=1670 ,top=62 ,right=1920 ,bottom=115 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P38000)}' ,left=1670 ,top=120 ,right=1920 ,bottom=170 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P35000)}' ,left=1670 ,top=172 ,right=1920 ,bottom=222 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P30000)}' ,left=1398 ,top=70 ,right=1648 ,bottom=122 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P31000)}' ,left=1398 ,top=125 ,right=1648 ,bottom=175 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P32000)}' ,left=1398 ,top=177 ,right=1648 ,bottom=227 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P26000)}' ,left=1130 ,top=65 ,right=1373 ,bottom=120 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P27000)}' ,left=1130 ,top=122 ,right=1373 ,bottom=172 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P28000)}' ,left=1130 ,top=175 ,right=1373 ,bottom=225 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P24000)}' ,left=870 ,top=185 ,right=1110 ,bottom=230 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P23000)}' ,left=870 ,top=127 ,right=1110 ,bottom=175 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P22000)}' ,left=870 ,top=72 ,right=1110 ,bottom=120 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P21000)}' ,left=870 ,top=20 ,right=1110 ,bottom=65 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(PX0020)}', left=2215, top=15, right=2528, bottom=65, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{SUM(S93000)}' ,left=3465 ,top=127 ,right=3705 ,bottom=175 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<C>id='{Sum(BX0020)}', left=3163, top=177, right=3410, bottom=227, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{Sum(T21000)}', left=3473, top=12, right=3705, bottom=62, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{Sum(T22000)}', left=3473, top=72, right=3705, bottom=122, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{Sum(PX0010)}', left=1945, top=65, right=2195, bottom=120, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{Sum(P34000)}', left=1945, top=122, right=2195, bottom=175, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<S>id='{Sum(T11000)}' ,left=2578 ,top=120 ,right=2828 ,bottom=170 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(T12000)}' ,left=2578 ,top=172 ,right=2828 ,bottom=220 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(PX0040)}', left=2215, top=122, right=2528, bottom=172, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{SUM(PX0030)}', left=2215, top=70, right=2528, bottom=120, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{SUM(B13000)}' ,left=2830 ,top=120 ,right=3135 ,bottom=170 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(B15000)}' ,left=2830 ,top=65 ,right=3135 ,bottom=115 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(B12000)}' ,left=2830 ,top=15 ,right=3135 ,bottom=70 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(B14000)}' ,left=2830 ,top=172 ,right=3135 ,bottom=220 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(B16000)}' ,left=3173 ,top=15 ,right=3410 ,bottom=70 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(BX0030)}' ,left=3173 ,top=72 ,right=3410 ,bottom=122 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(APLAMT)+SUM(APLRAT)}', left=3160, top=125, right=3410, bottom=175, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{Sum(P12000)}' ,left=630 ,top=132 ,right=850 ,bottom=182 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P11000)}' ,left=630 ,top=75 ,right=850 ,bottom=127 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P10000)}' ,left=630 ,top=15 ,right=850 ,bottom=70 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<X>left=628 ,top=182 ,right=863 ,bottom=232 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='{SUM(P10000)+SUM(P11000)+SUM(P12000)}', left=635, top=187, right=855, bottom=222, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=4001 ,top=238 ,right=24 ,bottom=238 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2762 ,right=4101 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=34 ,top=19 ,right=4006 ,bottom=98 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Common/img/icon.jpg' ,left=3596 ,top=8 ,right=3977 ,bottom=108</I>
	<L> left=24 ,top=5 ,right=4006 ,bottom=5 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### À¯ º¸ ±Þ ¿© ####
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print3  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"	    value="gcds_grid_ec02az">
	<PARAM NAME="PaperSize"					VALUE="A3">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="80">
	<PARAM NAME="Format" VALUE="
<B>id=Header ,left=0,top=0 ,right=4099 ,bottom=179 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CTITLE', left=1406, top=55, right=2475, bottom=142, face='HYÁß°íµñ', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000</C>
	<T>id='´ÜÀ§ : ¿ø' ,left=3783 ,top=121 ,right=4002 ,bottom=179 ,align='right' ,face='±¼¸²' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=3783, top=61, right=4002, bottom=119, align='right' ,mask='XXXX.XX.XX', face='±¼¸²', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=3486 ,top=61 ,right=3781 ,bottom=121 ,align='right' ,face='±¼¸²' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4099 ,bottom=261 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=3999 ,top=3 ,right=24 ,bottom=3 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=613 ,top=3 ,right=613 ,bottom=248 </L>
	<L> left=253 ,top=3 ,right=253 ,bottom=248 </L>
	<T>id='±×·ìÀÔ»çÀÏ' ,left=3739 ,top=74 ,right=3970 ,bottom=127 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¼ö½ÀÀû¿ë' ,left=3736 ,top=129 ,right=3965 ,bottom=185 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=3736 ,top=190 ,right=3965 ,bottom=248 ,align='left' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=3 ,right=24 ,bottom=245 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2554 ,top=5 ,right=2554 ,bottom=248 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4002 ,top=3 ,right=4002 ,bottom=245 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='Á÷±Þ' ,left=274 ,top=190 ,right=574 ,bottom=248 ,align='left' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#FFFBF0 ,backcolor=#FFFFFF</T>
	<T>id='±Þ¿©À¯º¸' ,left=637 ,top=74 ,right=848 ,bottom=127 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='»ó¿©À¯º¸' ,left=1161 ,top=76 ,right=1372 ,bottom=134 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¼Ò¼Ó' ,left=274 ,top=13 ,right=553 ,bottom=71 ,align='left' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=248 ,right=4007 ,bottom=248 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='»ç¹ø' ,left=37 ,top=13 ,right=250 ,bottom=71 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Á÷À§' ,left=37 ,top=129 ,right=250 ,bottom=185 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='±ÞÈ£' ,left=37 ,top=190 ,right=250 ,bottom=248 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¼º¸í' ,left=37 ,top=74 ,right=250 ,bottom=127 ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÃÖÁ¾º¯µ¿ÀÏ' ,left=274 ,top=74 ,right=556 ,bottom=127 ,align='left' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¼Òµæ¼¼' ,left=2580 ,top=74 ,right=2830 ,bottom=127 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÁÖ¹Î¼¼' ,left=2580 ,top=129 ,right=2830 ,bottom=185 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='°í¿ëº¸Çè' ,left=2836 ,top=74 ,right=3136 ,bottom=127 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Áö±Þ°è' ,left=2254 ,top=74 ,right=2530 ,bottom=132 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÇØ¿Ü±Þ»ó¿©À¯º¸' ,left=1661 ,top=74 ,right=1990 ,bottom=127 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='°øÁ¦°è' ,left=3528 ,top=129 ,right=3710 ,bottom=185 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='½Ç¼ö·É¾×' ,left=3499 ,top=190 ,right=3710 ,bottom=248 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÀÔ»çÀÏ' ,left=3739 ,top=13 ,right=3970 ,bottom=71 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¹èºÎÀÚÀå°æ' ,left=2580 ,top=13 ,right=2830 ,bottom=71 ,align='right' ,face='HYÁß°íµñ' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BR0030,,±âÅ¸°øÁ¦2,BR0030)}', left=3267, top=137, right=3502, bottom=190, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BR0040,,±âÅ¸°øÁ¦3,BR0040)}', left=3267, top=195, right=3502, bottom=248, align='right', face='HYÁß°íµñ', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=4099 ,bottom=224 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=3470 ,top=161 ,right=3712 ,bottom=219 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3470 ,top=100 ,right=3712 ,bottom=156 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2206 ,top=158 ,right=2527 ,bottom=211 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=613 ,top=0 ,right=613 ,bottom=221 </L>
	<L> left=2556 ,top=0 ,right=2556 ,bottom=221 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4002 ,top=0 ,right=4002 ,bottom=221 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=253 ,top=0 ,right=253 ,bottom=221 </L>
	<C>id='STRTDT', left=3739, top=0, right=3970, bottom=50, align='right' ,mask='XXXX/XX/XX', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PX0030,0,,PX0030)}', left=1137, top=55, right=1372, bottom=103, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PX0040,0,,PX0040)}', left=1672, top=55, right=1922, bottom=103, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GRSTRTDT', left=3739, top=55, right=3970, bottom=108, align='right' ,mask='XXXX/XX/XX', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{IF(TRAINYN=1,¼ö½À,)}', left=3733, top=105, right=3965, bottom=156, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(S91000,0,,S91000)}', left=2217, top=158, right=2525, bottom=208, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='', left=3739, top=158, right=3970, bottom=208, align='left' ,mask='XXXX/XX/XX', face='±¼¸²', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(S94000,0,,S94000)}', left=3475, top=161, right=3710, bottom=216, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{decode(S93000,0,,S93000)}', left=3470, top=100, right=3707, bottom=156, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=24 ,top=224 ,right=4002 ,bottom=224 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=24 ,top=0 ,right=24 ,bottom=221 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<C>id='{decode(PX0020,0,,PX0020)}', left=627, top=55, right=853, bottom=103, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(T12000,0,,T12000)}', left=2580, top=108, right=2830, bottom=161, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(T11000,0,,T11000)}', left=2580, top=55, right=2830, bottom=105, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(B13000,0,,B13000)}', left=2838, top=55, right=3136, bottom=105, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BX0020,0,,BX0020)}', left=3175, top=55, right=3425, bottom=108, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BX0030,0,,BX0030)}', left=3170, top=108, right=3425, bottom=158, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,DEPTNM)}', left=266, top=13, right=613, bottom=58, align='left', supplevel=1, face='±¼¸²', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='{decode(curlevel,1,,CHAGDT)}', left=266, top=61, right=524, bottom=108, align='left', supplevel=1 ,mask='XXXX/XX/XX', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,¸í)}', left=495, top=111, right=540, bottom=161, align='left', supplevel=1, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,subcount(empno)-1,)}', left=266, top=111, right=477, bottom=161, align='right', supplevel=1 ,mask='XXXX/XX/XX', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,PAYSEQNM)}', left=37, top=161, right=250, bottom=216, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'¼Ò °è\',PAYGRDNM)}', left=37, top=105, right=250, bottom=156, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,EMPNMK)}', left=37, top=55, right=250, bottom=103, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,EMPNO)}', left=37, top=0, right=250, bottom=50, supplevel=2, face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SENUM', left=2580, top=0, right=2830, bottom=50, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BX0040,0,,BX0040)}', left=3170, top=169, right=3425, bottom=219, align='right', face='±¼¸²', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Tail ,left=0,top=0 ,right=4099 ,bottom=255 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=4002 ,top=0 ,right=4002 ,bottom=248 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='ÃÑ¿ø' ,left=279 ,top=129 ,right=424 ,bottom=179 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ÇÕ °è' ,left=50 ,top=129 ,right=221 ,bottom=179 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='Count' ,left=395 ,top=129 ,right=516 ,bottom=179 ,align='right' ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=4007 ,top=0 ,right=29 ,bottom=0 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='¸í' ,left=521 ,top=129 ,right=574 ,bottom=179 ,face='±¼¸²' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='Sum(PX0030)' ,left=1151 ,top=87 ,right=1393 ,bottom=142 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(PX0040)' ,left=1688 ,top=87 ,right=1938 ,bottom=140 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{SUM(B13000)}' ,left=2830 ,top=90 ,right=3136 ,bottom=140 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(T12000)}' ,left=2580 ,top=140 ,right=2830 ,bottom=190 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(T11000)}' ,left=2580 ,top=82 ,right=2830 ,bottom=132 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<X>left=2214 ,top=185 ,right=2535 ,bottom=235 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3470 ,top=142 ,right=3720 ,bottom=190 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<S>id='{SUM(S93000)}' ,left=3470 ,top=140 ,right=3710 ,bottom=187 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</S>
	<S>id='Sum(BX0030)' ,left=3159 ,top=142 ,right=3407 ,bottom=192 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<X>left=3470 ,top=195 ,right=3720 ,bottom=243 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<S>id='{SUM(S94000)}' ,left=3475 ,top=192 ,right=3715 ,bottom=243 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</S>
	<L> left=3999 ,top=256 ,right=24 ,bottom=253 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2554 ,top=0 ,right=2554 ,bottom=248 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=613 ,top=0 ,right=613 ,bottom=248 </L>
	<L> left=253 ,top=0 ,right=253 ,bottom=248 </L>
	<L> left=24 ,top=0 ,right=24 ,bottom=248 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<S>id='{SUM(S91000)}' ,left=2225 ,top=187 ,right=2530 ,bottom=237 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</S>
	<S>id='Sum(PX0020)' ,left=650 ,top=92 ,right=869 ,bottom=145 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BX0020)' ,left=3159 ,top=90 ,right=3399 ,bottom=140 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BX0040)' ,left=3159 ,top=192 ,right=3407 ,bottom=243 ,align='right' ,face='±¼¸²' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
</B>
<B>id=Footer ,left=0 ,top=2762 ,right=4099 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=34 ,top=18 ,right=4007 ,bottom=98 ,face='±¼¸²' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Common/img/icon.jpg' ,left=3596 ,top=8 ,right=3978 ,bottom=108</I>
	<L> left=24 ,top=5 ,right=4007 ,bottom=5 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>


">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>