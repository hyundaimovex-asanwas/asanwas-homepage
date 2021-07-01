<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*=============================================================================
 - 시스템명 	     : 현장별 총투입내역
 - 프로그램ID 	 : PMS/co
 - J  S  P		     : co010s.jsp
 - 서 블 릿		 : Si010s
 - 작 성 자		 : 정영식
 - 작 성 일		 : 2014-04-02
 - 기능정의		 : 
 - [ 수정일자 ][수정자] 내용

 =============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>

<script language="javascript">
	var v_default_row = 1;
    var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_default"), "comn");  //grid 헤드색 
		fnInit();	
	}
	
    <%//초기작업 %>
    function fnInit() {

	    v_job ="S";
	    
        ds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	    ds_fdcode.Reset();   //지점 
        
       
        vt_fr_actdat.Text = "20070101";
        vt_to_actdat.Text = "<%=DateUtil.getCurrentDate(8)%>";
        
        return;
     
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CO%>Co010S_01",
            "JSP(O:DS_DEFAULT=ds_default)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
             tr_post(tr1);      
             
    }
    
    
    <%//메인 조회  %>
    function fnSelect() {
    	
    	//alert("gusrid::"+gusrid+"gfdcode::"+gfdcode);
    
        if(v_fr_costcd.value==""){
       		alert("원가는 필수항목입니다.");
       		return false;
        }
    
	    v_job="S";
	    
        var fr_date = vt_fr_actdat.Text.trim();
        var to_date = vt_to_actdat.Text.trim();

        if(fr_date.length!=8) {
            alert("출발일자(From)를 입력하시길 바랍니다.");
            return;
        }
        if(to_date.length!=8) {
            alert("출발일자(To)를 입력하시길 바랍니다.");
            return;
    	}
    	 
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                         + ",v_fdcode=" + lc_fdcode.bindcolval
                         + ",v_fr_actdat=" + vt_fr_actdat.text
                         + ",v_to_actdat =" + vt_to_actdat.text
                         + ",v_fr_costcd =" + v_fr_costcd.value 
                         + ",v_to_costcd =" + v_to_costcd.value ;
                  
                 
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CO%>Co010S_01",
            "JSP(O:DS_DEFAULT=ds_default)",
            param);
           // prompt('',param);
        tr_post(tr1);
		
    }    

    
    <%//원가 팝- 조회%>
    function fnSelCostPop_0(dirPath) {
        var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCostPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_fr_costnm.value = arrParam[1];	//NM
            v_fr_costcd.value = arrParam[0];	//SID
            v_to_costnm.value = arrParam[1];	//NM
            v_to_costcd.value = arrParam[0];	//SID
        } else {
			fnSelCostCleanup_0();
        }               
    }
    
    <%//원가 팝- 조회%>
    function fnSelCostPop_1(dirPath) {
        var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCostPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_to_costnm.value = arrParam[1];	//NM
            v_to_costcd.value = arrParam[0];	//SID
        } else {
			fnSelCostCleanup_1();
        }               
    }
   
    function fnSelCostCleanup_0(){
    	v_fr_costnm.value = "";
    	v_fr_costcd.value  = "";
    } 
	
    

    function fnSelCostCleanup_1(){
    	v_to_costnm.value = "";
    	v_to_costcd.value  = "";
    } 
	
    
    function fnExcel(){
    	if(ds_default.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:현장별 총투입내역; font-face:; font-size:20pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("현장별 총투입내역", "현장별 총투입내역.xls", 9); 
    }
    
    
    <%//출력%>
    function fnPrint() {
    
          //DataSet Head 설정 
          gs_rpt_mst.clearAll();

		  var s_temp = "TITLE:STRING,COSTNM:STRING,USRNAME:STRING,USEDATE:STRING";
		  gs_rpt_mst.SetDataHeader(s_temp);

		  
		  gs_rpt_mst.addrow();
		  gs_rpt_mst.namevalue(gs_rpt_mst.rowposition,"TITLE") = "현장별 총투입내역";
		  
		  gs_rpt_mst.namevalue(gs_rpt_mst.rowposition,"COSTNM")= "원가명:"+ds_default.namevalue(1,"COSTNM");
		  gs_rpt_mst.namevalue(gs_rpt_mst.rowposition,"USRNAME")= gusrnm;
		  gs_rpt_mst.namevalue(gs_rpt_mst.rowposition,"USEDATE")= "<%=DateUtil.getCurrentDate(8)%>"+ "<%=DateUtil.getCurrentTimeString()%>";
          
          //Data조회 
          gcrp_print.Preview();
 
    }
    
    
    
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

    
     	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("성공적으로 저장되었습니다.");
	}
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    
    alert("조회가 완료 되었습니다.");
</script>

<script language=JavaScript for=tr1 event=OnFail()>

	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>
 


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds_default event="OnLoadStarted()" >
    msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
</script>

<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
    msgTxt.innerHTML="조회가 완료 되었습니다.";

</script>


<script language=JavaScript  for=ds_fdcode event="OnLoadCompleted(row)" >

	ds_fdcode.insertrow(1);
	ds_fdcode.namevalue(1,"FDCODE") = "";
	ds_fdcode.namevalue(1,"FDNAME") = "전체";
	//gclx_fsdat.index = 0;
	
	lc_fdcode.index=0;

</script>

	
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--조회-->
    <param name="SyncLoad"  value="false">
    <param name=SubSumExpr  value="2:COSTNM, 1:GUBUNNM">
</object>

<object id=ds_fdcode classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 입력구분-->
    <param name="SyncLoad"  value="false">
</object>

<object id=gs_rpt_mst classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--출력물-->
    <param name="SyncLoad"  value="false">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"         value="">
    <param name="KeyValue"     value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                         	<img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:hand" onclick="fnPrint()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"      style="cursor:hand"  onclick="fnExcel()">
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    			<tr>
                                    <td align="center" class="text" width="70">지점</td>                                                                     
                                    <td bgcolor="#FFFFFF"   width="360" >&nbsp;
                                        <%=HDConstant.COMMENT_START%>
			                            <object id=lc_fdcode classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100  width=100 border="0" align=absmiddle>
			                                <param name=ComboDataID      value=ds_fdcode>
											<param name=BindColumn       value="FDCODE">
											<param name=BindColVal       value="FDCODE">
											<param name=ListExprFormat   value="FDNAME^0^90">
											<param name=Enable           value="true">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
                                    </td>
                                    <td align="center" class="text" width="70">회계일자</td>
                                    <td bgcolor="#FFFFFF" width="300">&nbsp;
                                        <%=HDConstant.COMMENT_START%>
			                            <object id=vt_fr_actdat classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="YYYY-MM-DD">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>&nbsp;~&nbsp;
			                            <object id=vt_to_actdat     classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="YYYY-MM-DD">
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
                    			</tr>
                                <tr>
			                        <td align=left class="text"  width="70">원가</td>
			                        <td align=left bgcolor="#ffffff" colspan=3>&nbsp;
			                         	<input type="text"    name='v_fr_costnm'    id="v_fr_costnm" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop_0('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_fr_costcd'    id='v_fr_costcd'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostPop_0('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostCleanup_0();" alt="값 지우기">
			                            &nbsp;~&nbsp;
			                            <input type="text"    name='v_to_costnm'    id="v_to_costnm" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop_1('<%=dirPath%>');" readOnly="readonly">                                        
			                            <input type="hidden"  name='v_to_costcd'    id='v_to_costcd'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostPop_1('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostCleanup_1();" alt="값 지우기">
			                                                                              
			                        </td>   
			              		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="845px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='540px' border='1'>
                                <param name="DataID"         value="ds_default">
                                <param name=SuppressOption   value="1">
                                <param name="Format"         value="
                                     <C> Name='LV'			   ID=CurLevel		       Width=28 	align=center    SumBgColor=#C3D0DB sumtext=''      Value={CurLevel} show = false  </C>
                                     <C> name='원가명'          ID='COSTNM'       	   width=250 	align=left 		SUPPRESS=2 </C>
                                     <C> name='구분'	          ID='GUBUNNM'    	       width=100 	align=CENTER	SUPPRESS=1 Value={Decode(CurLevel,2,'총계',0,GUBUNNM)}</C>
                                     <C> name='계정코드'	   	  ID='ATCODE' 		       width=80 	align=CENTER	Value={Decode(CurLevel,1,'소계',0,ATCODE)} </C>
									 <C> name='계정명' 		  ID='ATKORNAM'            width=230 	align=left       </C>
									 <C> name='누계금액' 		  ID='JANAMT'    	       width=150 	align=right    	 </C>
                                 ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>                      
                    </tr>
                </table>
			</td>
        </tr>
        
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        

    </table>

<%
/*=============================================================================
	Report 
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcrp_print  classid=<%=HDConstant.CT_REPORT_CLSID%> VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gs_rpt_mst">
	<param name="DetailDataID"          value="ds_default"> 
	<PARAM NAME="PaperSize"				VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE=false>
    <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<param name=NullRecordFlag			value=false>
	<param name="SaveToFileShowButton"  value="true">
	<param name="SuppressColumns"	    value="1:GUBUNNM"> 		
	<PARAM NAME="Format" VALUE="

<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=344 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='비고' ,left=1524 ,top=288 ,right=1823 ,bottom=344 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='누계금액' ,left=979 ,top=286 ,right=1278 ,bottom=344 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계정과목' ,left=458 ,top=286 ,right=757 ,bottom=344 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TITLE', left=423, top=66, right=1601, bottom=153, face='굴림', size=18, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COSTNM', left=42, top=214, right=1873, bottom=262, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<L> left=34 ,top=280 ,right=1945 ,bottom=280 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1365 ,top=294 ,right=1365 ,bottom=344 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=34 ,top=349 ,right=1945 ,bottom=344 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='구분' ,left=37 ,top=294 ,right=336 ,bottom=344 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=341 ,top=291 ,right=341 ,bottom=344 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=900 ,top=291 ,right=900 ,bottom=344 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=56 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=341 ,top=3 ,right=341 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=900 ,top=0 ,right=900 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1365 ,top=0 ,right=1365 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='GUBUNNM', left=40, top=8, right=339, bottom=56, supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'                                  소계\',ATKORNAM)}', left=352, top=8, right=900, bottom=56, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JANAMT', left=913, top=8, right=1357, bottom=56, align='right', MargineX=3</C>
	<L> left=344 ,top=0 ,right=1945 ,bottom=0 </L>
	<L> left=34 ,top=0 ,right=344 ,bottom=0 ,supplevel=1 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=34 ,top=0 ,right=1945 ,bottom=0 </L>
</B>
<B>id=Footer ,left=0 ,top=2767 ,right=2000 ,bottom=2870 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='출 력 자 :' ,left=37 ,top=5 ,right=206 ,bottom=53 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='USRNAME', left=204, top=5, right=410, bottom=53, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='출력일자:' ,left=37 ,top=56 ,right=206 ,bottom=103 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='USEDATE', left=206, top=56, right=929, bottom=103, align='left' ,mask='XXXX.XX.XX XX:XX:XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=836 ,top=11 ,right=1201 ,bottom=58 ,align='left', MargineX=3</T>
	<I>id='../../Common/img/icon.jpg' ,left=1503 ,top=19 ,right=1926 ,bottom=95</I>
	<L> left=34 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>


">
<%=HDConstant.COMMENT_END%>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		